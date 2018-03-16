using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using WebApplication1.Aplicativo.ControlesDeUsuario;

namespace WebApplication1.Aplicativo
{
    public partial class recordatorios : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["Perfil"].ToString() != "Administrador")
                {
                    MessageBox.Show(this, "Usted no tiene permiso para acceder a esta página", MessageBox.Tipo_MessageBox.Danger, "Acceso restringido", "../default.aspx");
                }

                ObtenerTesinas();
            }
        }

        private void ObtenerTesinas()
        {
            Automatizacion auto = new Aplicativo.Automatizacion();
            List<Tesina> tesinas = auto.Obtener_tesinas_por_notificar();
            List<itemgrilla_tesina> tesinas_tema_recortado = (from t in tesinas
                                                              select new itemgrilla_tesina
                                                              {
                                                                  tesis_id = t.tesina_id,
                                                                  tesista = t.Tesista.Persona.persona_nomyap,
                                                                  tema_recortado = t.tesina_tema.Length > 20 ? t.tesina_tema.Substring(0, 20) + "..." : t.tesina_tema,
                                                                  tema_completo = t.tesina_tema,
                                                                  estado = t.Estado.estado_tesina_estado,
                                                                  prioridad_orden = Obtener_prioridad(t.Estado.estado_tesina_estado),
                                                                  fecha_fin = t.tesina_plan_fch_presentacion.AddMonths(t.tesina_plan_duracion_meses)
                                                              }).OrderBy(ii => ii.prioridad_orden).ToList();
            if (tesinas_tema_recortado.Count > 0)
            {
                gv_tesinas.DataSource = tesinas_tema_recortado;
                gv_tesinas.DataBind();
                lbl_sin_tesinas.Visible = false;
            }
            else
            {
                lbl_sin_tesinas.Visible = true;
                gv_tesinas.DataSource = null;
                gv_tesinas.DataBind();
                btn_enviar_correos.Visible = false;
            }

            //no muestro la columna prioridad
            gv_tesinas.Columns[0].Visible = false;

            lbl_no_existe_tesina.InnerHtml = "<strong> Buen trabajo!</strong> No existen Tesistas por notificar.";
        }

        struct itemgrilla_tesina
        {
            public int tesis_id { get; set; }
            public string tesista { get; set; }
            public string director { get; set; }
            public string tema_recortado { get; set; }
            public string tema_completo { get; set; }
            public string estado { get; set; }
            public int prioridad_orden { get; set; }
            public DateTime fecha_fin { get; set; }
        }

        private int Obtener_prioridad(string estado)
        {
            int ret = 99;

            switch (estado)
            {
                case "Prorrogar":
                    ret = 0;
                    break;
                case "Lista para presentar":
                    ret = 1;
                    break;
                case "Iniciada":
                    ret = 2;
                    break;
                case "Entregada":
                    ret = 3;
                    break;
                case "Observada":
                    ret = 4;
                    break;
                case "Vencida":
                    ret = 5;
                    break;
                case "Aprobada":
                    ret = 6;
                    break;
                case "Desaprobada":
                    ret = 7;
                    break;
                default:
                    break;
            }

            return ret;
        }

        protected void gv_tesinas_PreRender(object sender, EventArgs e)
        {
            if (gv_tesinas.Rows.Count > 0)
            {
                gv_tesinas.HeaderRow.TableSection = TableRowSection.TableHeader;
            }

            if (gv_historial.Rows.Count > 0)
            {
                gv_historial.HeaderRow.TableSection = TableRowSection.TableHeader;
            }
        }

        protected void btn_ver_ServerClick(object sender, EventArgs e)
        {
            int id_tesina = Convert.ToInt32(((HtmlButton)sender).Attributes["data-id"]);

            if (id_tesina != 0)
            {
                using (HabProfDBContainer cxt = new HabProfDBContainer())
                {
                    hidden_tesina_id.Value = id_tesina.ToString();
                    Tesina tesina = cxt.Tesinas.FirstOrDefault(tt => tt.tesina_id == id_tesina);

                    lbl_alta.Text = tesina.tesina_plan_fch_presentacion.ToShortDateString();
                    lbl_calificacion.Text = tesina.tesina_calificacion == null ? "-" : tesina.tesina_calificacion.ToString();
                    lbl_calificacion_director.Text = tesina.tesina_calificacion_director == null ? "-" : tesina.tesina_calificacion_director.ToString();
                    lbl_calificacion_codirector.Text = tesina.tesina_calificacion_codirector == null ? "-" : tesina.tesina_calificacion_codirector.ToString();
                    lbl_descripcion.Text = tesina.tesina_descripcion;
                    lbl_director.Text = tesina.Director.Persona.persona_nomyap;
                    lbl_codirector.Text = tesina.Codirector != null ? tesina.Codirector.Persona.persona_nomyap : " - ";
                    lbl_duracion.Text = tesina.tesina_plan_duracion_meses.ToString() + " meses.";
                    lbl_estado.Text = tesina.Estado.estado_tesina_estado;
                    lbl_observaciones_estado.Text = tesina.Historial_estados.FirstOrDefault(hhee => hhee.historial_tesina_id == tesina.Historial_estados.Max(hist => hist.historial_tesina_id)).historial_tesina_descripcion;
                    lbl_periodo_notificaciones.Text = tesina.tesina_plan_aviso_meses.ToString() + " meses.";
                    lbl_tema.Text = tesina.tesina_tema;
                    lbl_tesista.Text = tesina.Tesista.Persona.persona_nomyap;
                    string archivo = Server.MapPath("~/Archivos/Tesinas/" + hidden_tesina_id.Value + "/presentado.pdf");
                    string archivo1 = Server.MapPath("~/Archivos/Tesinas/" + hidden_tesina_id.Value + "/presentado.doc");
                    string archivo2 = Server.MapPath("~/Archivos/Tesinas/" + hidden_tesina_id.Value + "/presentado.docx");
                    if (File.Exists(archivo))
                    {
                        lbl_archivo_subido.HRef = "~/Archivos/Tesinas/" + hidden_tesina_id.Value + "/presentado.pdf";
                        lbl_archivo_subido.InnerText = "Archivo presentado";
                        lbl_archivo_subido.Target = "_blank";
                    }
                    else
                    {
                        if (File.Exists(archivo1))
                        {
                            lbl_archivo_subido.HRef = "~/Archivos/Tesinas/" + hidden_tesina_id.Value + "/presentado.doc";
                            lbl_archivo_subido.InnerText = "Archivo presentado";
                            lbl_archivo_subido.Target = "_blank";
                        }
                        else
                        {
                            if (File.Exists(archivo2))
                            {
                                lbl_archivo_subido.HRef = "~/Archivos/Tesinas/" + hidden_tesina_id.Value + "/presentado.docx";
                                lbl_archivo_subido.InnerText = "Archivo presentado";
                                lbl_archivo_subido.Target = "_blank";
                            }
                            else
                            {
                                lbl_archivo_subido.HRef = "#";
                                lbl_archivo_subido.InnerText = "Sin presentaciones";
                                lbl_archivo_subido.Target = "_self";
                            }
                        }
                    }

                    foreach (Jurado jurado in tesina.Jueces)
                    {
                        lbl_jueces_tesina_visualizacion.Text = lbl_jueces_tesina_visualizacion.Text + jurado.Persona.persona_nomyap + "; ";
                    }

                    var historial = (from he in tesina.Historial_estados
                                     select new
                                     {
                                         fecha = he.historial_tesina_fecha,
                                         estado = he.Estado.estado_tesina_estado,
                                         observacion_completa = he.historial_tesina_descripcion
                                     }).OrderByDescending(hhee => hhee.fecha).ToList();

                    var historial_con_observacion_recortada = (from he in historial
                                                               select new
                                                               {
                                                                   fecha = he.fecha,
                                                                   estado = he.estado,
                                                                   observacion_completa = he.observacion_completa,
                                                                   observacion_recortada = he.observacion_completa.Length > 40 ? he.observacion_completa.Substring(0, 40) + "..." : he.observacion_completa
                                                               }).ToList();

                    gv_historial.DataSource = historial_con_observacion_recortada;
                    gv_historial.DataBind();

                    string script = "<script language=\"javascript\"  type=\"text/javascript\">$(document).ready(function() { $('#panel_ver_tesina').modal('show')});</script>";
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "ShowPopUp", script, false);

                }
            }

        }

        protected void btn_enviar_correos_ServerClick(object sender, EventArgs e)
        {
            Automatizacion auto = new Aplicativo.Automatizacion();
            auto.Enviar_correos_notificacion_automatica();
            ObtenerTesinas();
            MessageBox.Show(this, "Se han enviado correctamente las notificaciones");
        }
    }
}