using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using WebApplication1.Aplicativo.ControlesDeUsuario;

namespace WebApplication1.Aplicativo
{
    public partial class admin_tesinas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["Perfil"].ToString() != "Administrador" &&
                    Session["Perfil"].ToString() != "Director")
                {
                    MessageBox.Show(this, "Usted no tiene permiso para acceder a esta página", MessageBox.Tipo_MessageBox.Danger, "Acceso restringido", "../default.aspx");
                }

                ObtenerTesinas();
            }
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
        }
        private void ObtenerTesinas()
        {
            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                Persona usuario_logueado = Session["UsuarioLogueado"] as Persona;
                List<Tesina> tesinas = new List<Tesina>();

                if (Session["Perfil"].ToString() == "Administrador")
                {//administrador: obtengo todas las tesinas

                    tesinas = (from t in cxt.Tesinas
                                select t
                               ).ToList();
                }
                else
                {//director: obtengo las tesinas asociadas al director
                    Director dire = cxt.Personas.FirstOrDefault(pp => pp.persona_id == usuario_logueado.persona_id).Director;
                    tesinas = (from t in cxt.Tesinas
                               where t.director_id == dire.director_id
                               select t
                               ).ToList();

                    btn_agregar_tesina.Visible = false;
                    lbl_small_titulo.Text = "Listado de Tesinas bajo su supervición";
                }

                List<itemgrilla_tesina> tesinas_tema_recortado = (from t in tesinas
                                                                  select new itemgrilla_tesina
                                                                  {
                                                                      tesis_id = t.tesina_id,
                                                                      tesista = t.Tesista.Persona.persona_nomyap,
                                                                      director = t.Director.Persona.persona_nomyap,
                                                                      tema_recortado = t.tesina_tema.Length > 20 ? t.tesina_tema.Substring(0, 20) + "..." : t.tesina_tema,
                                                                      tema_completo = t.tesina_tema,
                                                                      estado = t.Estado.estado_tesina_estado,
                                                                      prioridad_orden = Obtener_prioridad(t.Estado.estado_tesina_estado)
                                                                  }).ToList();

                if (tesinas_tema_recortado.Count > 0)
                {
                    gv_tesinas.DataSource = tesinas_tema_recortado;
                    gv_tesinas.DataBind();
                    lbl_sin_tesinas.Visible = false;
                }
                else
                {
                    lbl_sin_tesinas.Visible = true;
                }
            }
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
                case "A corregir":
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

        protected void btn_aceptar_eliminacion_Click(object sender, EventArgs e)
        {
            int id_tesina = Convert.ToInt32(id_item_por_eliminar.Value);

            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                Tesina tesina = cxt.Tesinas.FirstOrDefault(tt => tt.tesina_id == id_tesina);

                if (tesina.Estado.estado_tesina_estado == "Iniciada")
                {

                    cxt.Historial_estados.RemoveRange(tesina.Historial_estados);
                    cxt.Tesinas.Remove(tesina);
                    cxt.SaveChanges();
                    MessageBox.Show(this, "Se ha eliminado correctamente la tesina.", MessageBox.Tipo_MessageBox.Success);
                    ObtenerTesinas();
                }
                else
                {
                    MessageBox.Show(this, "No se puede eliminar una tesina cuyo estado sea posterior al de iniciada");
                }
            }

            ObtenerTesinas();
        }

        protected void btn_ver_ServerClick(object sender, EventArgs e)
        {
            int id_tesina = Convert.ToInt32(((HtmlButton)sender).Attributes["data-id"]);

            if (id_tesina != 0)
            {
                using (HabProfDBContainer cxt = new HabProfDBContainer())
                {
                    Tesina tesina = cxt.Tesinas.FirstOrDefault(tt => tt.tesina_id == id_tesina);

                    lbl_alta.Text = tesina.tesina_plan_fch_presentacion.ToShortDateString();
                    lbl_calificacion.Text = tesina.tesina_calificacion == 0 ? "Sin calificación" : tesina.tesina_calificacion.ToString();
                    lbl_calificacion_director.Text = tesina.tesina_calificacion_director == 0 ? "Sin calificación" : tesina.tesina_calificacion_director.ToString();
                    lbl_descripcion.Text = tesina.tesina_descripcion;
                    lbl_director.Text = tesina.Director.Persona.persona_nomyap;
                    lbl_duracion.Text = tesina.tesina_plan_duracion_meses.ToString() + " meses.";
                    lbl_estado.Text = tesina.Estado.estado_tesina_estado;
                    lbl_periodo_notificaciones.Text = tesina.tesina_plan_aviso_meses.ToString() + " meses.";
                    lbl_tema.Text = tesina.tesina_tema;
                    lbl_tesista.Text = tesina.Tesista.Persona.persona_nomyap;


                    var historial = (from he in tesina.Historial_estados
                                     select new
                                     {
                                         fecha = he.historial_tesina_fecha,
                                         estado = he.Estado.estado_tesina_estado,
                                         observacion_completa = he.historial_tesina_descripcion
                                     }).ToList();

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

        protected void btn_editar_ServerClick(object sender, EventArgs e)
        {
            string id_tesina = ((HtmlButton)sender).Attributes["data-id"];
            Response.Redirect("~/Aplicativo/admin_tesina.aspx?t=" + id_tesina);
        }

        protected void btn_agregar_tesina_ServerClick(object sender, EventArgs e)
        {
            Response.Redirect("~/Aplicativo/admin_tesina.aspx");
        }
    }
}