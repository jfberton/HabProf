using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
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
                        tesina_a_editar_o_agregar.tesina_palabras_clave = "Ingrese las palabras clave para la tesina";
                        tesina_a_editar_o_agregar.Estado = cxt.Estados_tesinas.FirstOrDefault(ee => ee.estado_tesina_estado == "Presentada");
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
            lbl_tema_tesina.Text = tesina_a_editar_o_agregar.tesina_tema;
            tb_estado.Text = tesina_a_editar_o_agregar.Estado.estado_tesina_estado;
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

        protected void cv_tesina_tema_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = Verificar_tema_tesina(tb_nuevo_tema_tesina.Value);

            btn_guardar_tema_tesis.Visible = false;
            btn_guardar_tema_de_todos_modos.Visible = true;
        }


        private bool Verificar_tema_tesina(string value)
        {
            //voy agregando las tesinas que contienen esa palabra
            List<Tesina> tesinas_encontradas = new List<Tesina>();
            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                string[] palabras_tema = tb_nuevo_tema_tesina.Value.Split(' ');
                List<Tesina> tesinas = cxt.Tesinas.ToList();

                foreach (Tesina tesina in tesinas)
                {
                    Buscar b = new Buscar(palabras_tema, tesina.tesina_tema);

                    if (b.Hubo_coincidencia)
                    {
                        tesinas_encontradas.Add(tesina);
                    }

                }
            }

            return tesinas_encontradas.Count() == 0;
        }

        protected void btn_guardar_tema_tesina_ServerClick(object sender, EventArgs e)
        {
            string script = "<script language=\"javascript\"  type=\"text/javascript\">$(document).ready(function() { $('#modificar_tema_tesina').modal('show')});</script>";
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "ShowPopUp", script, false);
        }

        protected void btn_guardar_tema_de_todos_modos_ServerClick(object sender, EventArgs e)
        {
            Tesina tesina = Session["Tesina"] as Tesina;
            tesina.tesina_tema = tb_nuevo_tema_tesina.Value;
            Session["Tesina"] = tesina;
            Mostrar_datos_tesina();
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
            Response.Redirect("~/Aplicativo/admin_tesina.aspx");
        }

        protected void gv_historial_PreRender(object sender, EventArgs e)
        {
            if (gv_historial.Rows.Count > 0)
            {
                gv_historial.HeaderRow.TableSection = TableRowSection.TableHeader;
            }
        }

        protected void btn_tesina_ver_historial_ServerClick(object sender, EventArgs e)
        {
            Cargar_historial_estados();

            string script = "<script language=\"javascript\"  type=\"text/javascript\">$(document).ready(function() { $('#ver_historial_de_estados').modal('show')});</script>";
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "ShowPopUp", script, false);
        }

       
    }
}