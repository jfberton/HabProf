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
                Tesis tesis = Session["Tesina"] as Tesis;

                //si es nulo es porque seleccionó agregar tesis
                using (HabProfDBContainer cxt = new HabProfDBContainer())
                {
                    if (tesis != null)
                    {
                        ddl_estados.Items.Clear();
                        tesis_a_editar_o_agregar = cxt.Tesinas.Include("Estado").Include("Historial_estados").FirstOrDefault(tt => tt.tesis_id == tesis.tesis_id);
                        Session["Tesina"] = tesis_a_editar_o_agregar;

                        List<Estado_tesis> estados = cxt.Estados_tesis.ToList();
                        foreach (Estado_tesis estado in estados)
                        {
                            ddl_estados.Items.Add(new ListItem() { Text = estado.estado_estado, Value = estado.estado_tesis_id.ToString() });
                        }
                    }
                    else
                    {
                        tesis_a_editar_o_agregar = new Tesis();
                        tesis_a_editar_o_agregar.tesis_tema = "Ingrese el tema de la tesina";
                        tesis_a_editar_o_agregar.tesis_palabras_clave = "Ingrese las palabras clave para la tesina";
                        tesis_a_editar_o_agregar.Estado = cxt.Estados_tesis.FirstOrDefault(ee => ee.estado_estado == "Presentada");
                        div_estado.Visible = false;
                        Session["Tesina"] = tesis_a_editar_o_agregar;
                    }
                }

                Mostrar_datos_tesis();
            }

        }

        private Tesis tesis_a_editar_o_agregar = null;

        private void Mostrar_datos_tesis()
        {
            tesis_a_editar_o_agregar = Session["Tesina"] as Tesis;
            lbl_bread_last_page.Text = tesis_a_editar_o_agregar.tesis_id != 0 ? "Modificar Tesina" : "Agregar Tesina";
            lbl_tema_tesina.Text = tesis_a_editar_o_agregar.tesis_tema;
            tb_estado.Text = tesis_a_editar_o_agregar.Estado.estado_estado;
            Cargar_historial_estados();
        }

        private void Cargar_historial_estados()
        {
            tesis_a_editar_o_agregar = Session["Tesina"] as Tesis;
            if (tesis_a_editar_o_agregar.tesis_id != 0)
            {
                var historial = (from he in tesis_a_editar_o_agregar.Historial_estados
                                 select new
                                 {
                                     fecha = he.historial_fecha,
                                     estado = he.Estado.estado_estado,
                                     observacion_completa = he.historial_descripcion
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

        protected void cv_tesis_tema_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = Verificar_tema_tesis(tb_nuevo_tema_tesina.Value);

            btn_guardar_tema_tesis.Visible = false;
            btn_guardar_tema_de_todos_modos.Visible = true;
        }


        private bool Verificar_tema_tesis(string value)
        {
            //voy agregando las tesinas que contienen esa palabra
            List<Tesis> tesinas_encontradas = new List<Tesis>();
            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                string[] palabras_tema = tb_nuevo_tema_tesina.Value.Split(' ');
                List<Tesis> tesinas = cxt.Tesinas.ToList();

                foreach (Tesis tesina in tesinas)
                {
                    Buscar b = new Buscar(palabras_tema, tesina.tesis_tema);

                    if (b.Hubo_coincidencia)
                    {
                        tesinas_encontradas.Add(tesina);
                    }

                }
            }

            return tesinas_encontradas.Count() == 0;
        }

        protected void btn_guardar_tema_tesis_ServerClick(object sender, EventArgs e)
        {
            string script = "<script language=\"javascript\"  type=\"text/javascript\">$(document).ready(function() { $('#modificar_tema_tesina').modal('show')});</script>";
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "ShowPopUp", script, false);
        }

        protected void btn_guardar_tema_de_todos_modos_ServerClick(object sender, EventArgs e)
        {
            Tesis tesina = Session["Tesina"] as Tesis;
            tesina.tesis_tema = tb_nuevo_tema_tesina.Value;
            Session["Tesina"] = tesina;
            Mostrar_datos_tesis();
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
            Response.Redirect("~/Aplicativo/admin_tesis.aspx");
        }

        protected void gv_historial_PreRender(object sender, EventArgs e)
        {
            if (gv_historial.Rows.Count > 0)
            {
                gv_historial.HeaderRow.TableSection = TableRowSection.TableHeader;
            }
        }

        protected void btn_tesis_ver_historial_ServerClick(object sender, EventArgs e)
        {
            Cargar_historial_estados();

            string script = "<script language=\"javascript\"  type=\"text/javascript\">$(document).ready(function() { $('#ver_historial_de_estados').modal('show')});</script>";
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "ShowPopUp", script, false);
        }

       
    }
}