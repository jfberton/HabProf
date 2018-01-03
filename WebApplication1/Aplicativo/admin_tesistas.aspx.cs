using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebApplication1.Aplicativo.ControlesDeUsuario;

namespace WebApplication1.Aplicativo
{
    public partial class admin_tesistas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["Perfil"].ToString() != "Admin")
                {
                    MessageBox.Show(this, "Usted no tiene permiso para acceder a esta página", MessageBox.Tipo_MessageBox.Danger, "Acceso restringido", "../default.aspx");
                }

                ObtenerTesistas();
            }
        }

        private void ObtenerTesistas()
        {
            using (HabProfDBContainer cxt = new Aplicativo.HabProfDBContainer())
            {
                List<Tesista> tesistas = (from t in cxt.Personas.OfType<Tesista>() where t.persona_fecha_baja == null select t).ToList();
                if (tesistas.Count() > 0)
                {
                    gv_tesistas.DataSource = tesistas;
                    gv_tesistas.DataBind();
                    lbl_sin_tesistas.Visible = false;
                }
                else
                {
                    lbl_sin_tesistas.Visible = true;
                    gv_tesistas.DataSource = null;
                    gv_tesistas.DataBind();
                }

            }
        }

        protected void btn_aceptar_eliminacion_Click(object sender, EventArgs e)
        {
            int id_tesista = Convert.ToInt32(id_item_por_eliminar.Value);

            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                Tesista tesista = cxt.Personas.OfType<Tesista>().FirstOrDefault(pp => pp.persona_id == id_tesista);
                cxt.Personas.Remove(tesista);

                cxt.SaveChanges();
            }

            ObtenerTesistas();
        }

        protected void btn_ver_ServerClick(object sender, EventArgs e)
        {

        }

        protected void gv_tesistas_PreRender(object sender, EventArgs e)
        {
            if (gv_tesistas.Rows.Count > 0)
            {
                gv_tesistas.HeaderRow.TableSection = TableRowSection.TableHeader;
            }
        }

        protected void btn_guardar_ServerClick(object sender, EventArgs e)
        {
            Persona usuario = Session["UsuarioLogueado"] as Persona;
            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                Tesista tesista = cxt.Personas.OfType<Tesista>().FirstOrDefault(pp => pp.persona_dni == tb_dni_tesista.Value);

                if (tesista == null)
                {
                    //no existe hago un insert
                    tesista = new Tesista()
                    {
                        licenciatura_id = usuario.licenciatura_id,
                        persona_nomyap = tb_nombre_tesista.Value,
                        persona_dni = tb_dni_tesista.Value,
                        persona_email = tb_email.Value,
                        persona_domicilio = tb_domicilio.Value,
                        persona_telefono = tb_telefono.Value,
                        persona_usuario = "",
                        persona_clave = "",
                        persona_estilo = "Sandstone",
                        tesista_legajo = tb_legajo.Value,
                        tesista_sede = tb_sede.Value
                    };
                    cxt.Personas.Add(tesista);
                }
                else
                {
                    //existe hago un update
                    tesista.licenciatura_id = usuario.licenciatura_id;
                    tesista.persona_nomyap = tb_nombre_tesista.Value;
                    tesista.persona_dni = tb_dni_tesista.Value;
                    tesista.persona_email = tb_email.Value;
                    tesista.persona_domicilio = tb_domicilio.Value;
                    tesista.persona_telefono = tb_telefono.Value;
                    tesista.persona_usuario = "";
                    tesista.persona_clave = "";
                    tesista.persona_estilo = "Sandstone";
                    tesista.tesista_legajo = tb_legajo.Value;
                    tesista.tesista_sede = tb_sede.Value;
                }

                try
                {
                    
                    cxt.SaveChanges();

                    tb_dni_tesista.Value = string.Empty;
                    tb_domicilio.Value = string.Empty;
                    tb_email.Value = string.Empty;
                    tb_legajo.Value = string.Empty;
                    tb_nombre_tesista.Value = string.Empty;
                    tb_sede.Value = string.Empty;
                    tb_telefono.Value = string.Empty;

                    MessageBox.Show(this, "Se guardó correctamente el tesista!", MessageBox.Tipo_MessageBox.Success, "Exito!");
                }
                catch (Exception ex)
                {
                    MessageBox.Show(this, ex.Message, MessageBox.Tipo_MessageBox.Danger);
                }
            }


            ObtenerTesistas();
        }

        protected void btn_buscar_dni_ServerClick(object sender, EventArgs e)
        {
            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                Tesista tesista = cxt.Personas.OfType<Tesista>().FirstOrDefault(pp => pp.persona_dni == tb_dni_tesista.Value);
                if (tesista != null)
                {
                    tb_domicilio.Value = tesista.persona_domicilio;
                    tb_email.Value = tesista.persona_email;
                    tb_legajo.Value = tesista.tesista_legajo;
                    tb_nombre_tesista.Value = tesista.persona_nomyap;
                    tb_sede.Value = tesista.tesista_sede;
                    tb_telefono.Value = tesista.persona_telefono;

                    string script = "<script language=\"javascript\"  type=\"text/javascript\">$(document).ready(function() { $('#agregar_tesista').modal('show')});</script>";
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "ShowPopUp", script, false);
                }
                else
                {
                    string script = "<script language=\"javascript\"  type=\"text/javascript\">$(document).ready(function() { $('#agregar_tesista').modal('show')});</script>";
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "ShowPopUp", script, false);
                    MessageBox.Show(this, "No se encontró persona con este DNI", MessageBox.Tipo_MessageBox.Success, "Resultado búsqueda");
                }
            }
        }
    }
}