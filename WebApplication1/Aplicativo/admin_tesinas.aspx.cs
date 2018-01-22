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
                if (Session["Perfil"].ToString() != "Admin")
                {
                    MessageBox.Show(this, "Usted no tiene permiso para acceder a esta página", MessageBox.Tipo_MessageBox.Danger, "Acceso restringido", "../default.aspx");
                }

                ObtenerTesinas();
            }
        }

        private void ObtenerTesinas()
        {
            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                var tesinas = (from t in cxt.Tesinas
                               where t.tesina_fecha_cierre == null
                               select new
                               {
                                   tesis_id = t.tesina_id,
                                   tesista = t.Tesista.Persona.persona_nomyap,
                                   director = t.Director.Persona.persona_nomyap,
                                   tema = t.tesina_tema,
                                   estado = t.Estado.estado_tesina_estado
                               }
                               ).ToList();

                var tesinas_tema_recortado = (from t in tesinas
                                              select new
                                              {
                                                  tesis_id = t.tesis_id,
                                                  tesista = t.tesista,
                                                  director = t.director,
                                                  tema = t.tema.Length > 20 ? t.tema.Substring(0, 20) + "..." : t.tema,
                                                  tema_completo = t.tema,
                                                  estado = t.estado
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

        protected void btn_aceptar_eliminacion_Click(object sender, EventArgs e)
        {
            //int id_tesina = Convert.ToInt32(id_item_por_eliminar.Value);

            //using (HabProfDBContainer cxt = new HabProfDBContainer())
            //{
            //    Tesina tesina = cxt.Tesinas.FirstOrDefault(tt=>tt.tesina_id == id_tesina);
                
            //    tesina.tesina_fecha_cierre = DateTime.Today;

            //    cxt.SaveChanges();
            //    MessageBox.Show(this, "Se ha eliminado correctamente la tesina del tesista" + tesina.persona_nomyap, MessageBox.Tipo_MessageBox.Success);
            //}

            //ObtenerTesinas();
        }

        protected void btn_ver_ServerClick(object sender, EventArgs e)
        {
            int id_tesina = Convert.ToInt32(((HtmlButton)sender).Attributes["data-id"]);

            if (id_tesina != 0)
            {
                using (HabProfDBContainer cxt = new HabProfDBContainer())
                {
                    Tesina tesina = cxt.Tesinas.FirstOrDefault(tt => tt.tesina_id == id_tesina);

                    lbl_alta.Text = tesina.tesina_plan_fch_presentacion.ToString();
                    lbl_calificacion.Text = tesina.tesina_calificacion == 0 ? "Sin calificación" : tesina.tesina_calificacion.ToString();
                    lbl_calificacion_director.Text = tesina.tesina_calificacion_director == 0 ? "Sin calificación" : tesina.tesina_calificacion_director.ToString();
                    lbl_descripcion.Text = tesina.tesina_descripcion;
                    lbl_director.Text = tesina.Director.Persona.persona_nomyap;
                    lbl_duracion.Text = tesina.tesina_plan_duracion_meses.ToString() + " meses.";
                    lbl_estado.Text = tesina.Estado.estado_tesina_estado;
                    lbl_periodo_notificaciones.Text = tesina.tesina_plan_duracion_meses.ToString() + " meses.";
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
            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                int id_tesina = Convert.ToInt32(((HtmlButton)sender).Attributes["data-id"]);

                Tesina tesina = cxt.Tesinas.FirstOrDefault(pp => pp.tesina_id == id_tesina);
                if (tesina != null)
                {
                    Session["Tesina"] = tesina;
                    Response.Redirect("~/Aplicativo/admin_tesina.aspx");
                }
            }
        }


        protected void btn_agregar_tesina_ServerClick(object sender, EventArgs e)
        {
            Session["Tesina"] = null;
            Response.Redirect("~/Aplicativo/admin_tesina.aspx");
        }
    }
}