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
    public partial class admin_tesina : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Tesina tesina = Session["Tesina"] as Tesina;

                //si es nulo es porque seleccionó agregar tesina
                using (HabProfDBContainer cxt = new HabProfDBContainer())
                {
                    if (tesina != null)
                    {
                        ddl_estados.Items.Clear();
                        tesina_a_editar_o_agregar = cxt.Tesinas.Include("Estado").Include("Historial_estados").FirstOrDefault(tt => tt.tesina_id == tesina.tesina_id);
                        Session["Tesina"] = tesina_a_editar_o_agregar;

                        List<Estado_tesina> estados = cxt.Estados_tesinas.ToList();
                        foreach (Estado_tesina estado in estados)
                        {
                            ddl_estados.Items.Add(new ListItem() { Text = estado.estado_tesina_estado, Value = estado.estado_tesina_id.ToString() });
                        }
                    }
                    else
                    {
                        tesina_a_editar_o_agregar = new Tesina();
                        tesina_a_editar_o_agregar.tesina_tema = "Ingrese el tema de la tesina";
                        tesina_a_editar_o_agregar.tesina_descripcion = "Ingrese las palabras clave para la tesina";
                        div_estado.Visible = false;
                        Session["Tesina"] = tesina_a_editar_o_agregar;
                    }
                }

                Mostrar_datos_tesina();
            }

        }

        private Tesina tesina_a_editar_o_agregar = null;

        private void Mostrar_datos_tesina()
        {
            tesina_a_editar_o_agregar = Session["Tesina"] as Tesina;
            lbl_bread_last_page.Text = tesina_a_editar_o_agregar.tesina_id != 0 ? "Modificar Tesina" : "Agregar Tesina";
            tb_tema.Value = tesina_a_editar_o_agregar.tesina_tema;
            tb_estado.Text = tesina_a_editar_o_agregar.Estado != null ? tesina_a_editar_o_agregar.Estado.estado_tesina_estado : "Ninguno";
            Cargar_historial_estados();
        }

        private void Cargar_historial_estados()
        {
            tesina_a_editar_o_agregar = Session["Tesina"] as Tesina;
            if (tesina_a_editar_o_agregar.tesina_id != 0)
            {
                var historial = (from he in tesina_a_editar_o_agregar.Historial_estados
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
            }
        }

        protected void btn_guardar_tesina_ServerClick(object sender, EventArgs e)
        {

        }


        protected void btn_guardar_tema_tesina_ServerClick(object sender, EventArgs e)
        {
            string script = "<script language=\"javascript\"  type=\"text/javascript\">$(document).ready(function() { $('#modificar_tema_tesina').modal('show')});</script>";
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "ShowPopUp", script, false);
        }


        protected void btn_modificar_estado_ServerClick(object sender, EventArgs e)
        {
            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {

            }
        }

        protected void btn_cancelar_ServerClick(object sender, EventArgs e)
        {
            Session["Tesina"] = null;
            Response.Redirect("~/Aplicativo/admin_tesinas.aspx");
        }

        protected void gv_PreRender(object sender, EventArgs e)
        {
            if (gv_historial.Rows.Count > 0)
            {
                gv_historial.HeaderRow.TableSection = TableRowSection.TableHeader;
            }

            if (gv_tesistas.Rows.Count > 0)
            {
                gv_tesistas.HeaderRow.TableSection = TableRowSection.TableHeader;
            }

            if (gv_directores.Rows.Count > 0)
            {
                gv_directores.HeaderRow.TableSection = TableRowSection.TableHeader;
            }
        }

        protected void btn_tesina_ver_historial_ServerClick(object sender, EventArgs e)
        {
            Cargar_historial_estados();

            string script = "<script language=\"javascript\"  type=\"text/javascript\">$(document).ready(function() { $('#ver_historial_de_estados').modal('show')});</script>";
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "ShowPopUp", script, false);
        }

        protected void cv_fecha_inicio_ServerValidate(object source, ServerValidateEventArgs args)
        {
            DateTime fecha;
            if (DateTime.TryParse(tb_fecha_inicio.Value, out fecha))
            {
                args.IsValid = true;
            }
            else
            {
                args.IsValid = false;
            }
        }

        protected void btn_buscar_tesista_ServerClick(object sender, EventArgs e)
        {
            using (HabProfDBContainer cxt = new Aplicativo.HabProfDBContainer())
            {
                var tesistas = (
                    from t in cxt.Tesistas
                    where t.Persona.persona_fecha_baja == null && t.Tesina.Where(tt => tt.tesina_fecha_cierre == null).Count() == 0
                    select new
                    {
                        tesista_id = t.tesista_id,
                        persona_nomyap = t.Persona.persona_nomyap,
                        persona_dni = t.Persona.persona_dni,
                        persona_email = t.Persona.persona_email,
                        tesista_legajo = t.tesista_legajo,
                        tesista_sede = t.tesista_sede
                    }).ToList();

                if (tesistas.Count() > 0)
                {
                    lbl_sin_tesistas_habilitados.Visible = false;
                    gv_tesistas.DataSource = tesistas;
                    gv_tesistas.DataBind();
                }
                else
                {
                    lbl_sin_tesistas_habilitados.Visible = true;
                    gv_tesistas.DataSource = null;
                    gv_tesistas.DataBind();
                }

            }

            string script = "<script language=\"javascript\"  type=\"text/javascript\">$(document).ready(function() { $('#buscar_tesista').modal('show')});</script>";
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "ShowPopUp", script, false);
        }

        protected void btn_buscar_director_ServerClick(object sender, EventArgs e)
        {
            using (HabProfDBContainer cxt = new Aplicativo.HabProfDBContainer())
            {
                var directores = (from d in cxt.Directores
                                  where d.Persona.persona_fecha_baja == null
                                  select d).ToList();

                var directores_con_tesina_a_cargo = (from d in directores
                                                     select new
                                                     {
                                                         director_id = d.director_id,
                                                         persona_nomyap = d.Persona.persona_nomyap,
                                                         persona_dni = d.Persona.persona_dni,
                                                         persona_email = d.Persona.persona_email,
                                                         director_calificacion = d.Calificacion_general
                                                     }).ToList();


                if (directores_con_tesina_a_cargo.Count() > 0)
                {
                    gv_directores.DataSource = directores_con_tesina_a_cargo;
                    gv_directores.DataBind();
                    lbl_sin_directores.Visible = false;
                }
                else
                {
                    lbl_sin_directores.Visible = true;
                    gv_directores.DataSource = null;
                    gv_directores.DataBind();
                }

            }

            string script = "<script language=\"javascript\"  type=\"text/javascript\">$(document).ready(function() { $('#buscar_director').modal('show')});</script>";
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "ShowPopUp", script, false);
        }

        protected void btn_seleccionar_tesista_Click(object sender, EventArgs e)
        {
            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                int id_tesista = Convert.ToInt32(((HtmlButton)sender).Attributes["data-id"]);

                Tesista tesista = cxt.Tesistas.FirstOrDefault(pp => pp.tesista_id == id_tesista);
                if (tesista != null)
                {
                    tb_tesista.Value = tesista.Persona.persona_nomyap;
                    hidden_tesista_id.Value = tesista.tesista_id.ToString();
                }
            }
        }

        protected void btn_seleccionar_director_ServerClick(object sender, EventArgs e)
        {
            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                int id_director = Convert.ToInt32(((HtmlButton)sender).Attributes["data-id"]);

                Director director = cxt.Directores.FirstOrDefault(pp => pp.director_id == id_director);
                if (director != null)
                {
                    tb_director.Value = director.Persona.persona_nomyap;
                    hidden_director_id.Value = director.director_id.ToString();
                }
            }
        }
    }
}