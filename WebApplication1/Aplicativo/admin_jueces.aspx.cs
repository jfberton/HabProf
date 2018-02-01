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
    public partial class admin_jueces : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["Perfil"].ToString() != "Administrador")
                {
                    MessageBox.Show(this, "Usted no tiene permiso para acceder a esta página", MessageBox.Tipo_MessageBox.Danger, "Acceso restringido", "../default.aspx");
                }

                ObtenerJueces();
            }
        }

        private void ObtenerJueces()
        {
            lbl_agregar_actualizar_juez.Text = "Agregar "; //seteo el encabezado del popup porque el boton agregar levanta el popup desde html sin venir hasta el servidor
            hidden_id_juez_editar.Value = "0";
            using (HabProfDBContainer cxt = new Aplicativo.HabProfDBContainer())
            {
                var jueces = (from d in cxt.Jueces
                                  where d.juez_fecha_baja == null
                                  select d).ToList();

                var jueces_con_tesina_a_cargo = (from d in jueces
                                                     select new
                                                     {
                                                         juez_id = d.juez_id,
                                                         persona_nomyap = d.Persona.persona_nomyap,
                                                         persona_dni = d.Persona.persona_dni,
                                                         persona_email = d.Persona.persona_email
                                                     }).ToList();


                if (jueces_con_tesina_a_cargo.Count() > 0)
                {

                    gv_jueces.DataSource = jueces_con_tesina_a_cargo;
                    gv_jueces.DataBind();
                    lbl_sin_jueces.Visible = false;
                }
                else
                {
                    lbl_sin_jueces.Visible = true;
                    gv_jueces.DataSource = null;
                    gv_jueces.DataBind();
                }

            }
        }

        protected void btn_aceptar_eliminacion_Click(object sender, EventArgs e)
        {
            int id_juez = Convert.ToInt32(id_item_por_eliminar.Value);

            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                Juez juez = cxt.Jueces.FirstOrDefault(pp => pp.juez_id == id_juez);
                juez.juez_fecha_baja = DateTime.Today;
                if (
                    (juez.Persona.Administrador == null || juez.Persona.Administrador.administrador_fecha_baja != null) && //no tiene el perfil o esta dado de baja
                    (juez.Persona.Tesista == null || juez.Persona.Tesista.tesista_fecha_baja != null) && //no tiene el perfil o esta dado de baja
                    (juez.Persona.Director == null || juez.Persona.Director.director_fecha_baja != null)  //no tiene el perfil o esta dado de baja
                    )
                {
                    juez.Persona.persona_usuario = "";
                    juez.Persona.persona_clave = "";
                }

                cxt.SaveChanges();
                MessageBox.Show(this, "Se ha eliminado correctamente al juez " + juez.Persona.persona_nomyap, MessageBox.Tipo_MessageBox.Success);
            }

            ObtenerJueces();
        }

        protected void gv_jueces_PreRender(object sender, EventArgs e)
        {
            if (gv_jueces.Rows.Count > 0)
            {
                gv_jueces.HeaderRow.TableSection = TableRowSection.TableHeader;
            }
        }

        protected void btn_guardar_ServerClick(object sender, EventArgs e)
        {
            if (this.IsValid)
            {
                Persona usuario = Session["UsuarioLogueado"] as Persona;
                int id_juez = Convert.ToInt32(hidden_id_juez_editar.Value);

                Persona p_juez = null;
                Juez juez = null;

                using (HabProfDBContainer cxt = new HabProfDBContainer())
                {
                    int dni = 0;
                    int.TryParse(tb_dni_juez.Value, out dni);
                    if (id_juez != 0)
                    {
                        //abrio por editar juez y cambio el DNI, obtengo el juez a editar
                        juez = cxt.Jueces.Include("Persona").FirstOrDefault(pp => pp.juez_id == id_juez);
                        p_juez = juez.Persona;
                    }
                    else
                    {
                        p_juez = cxt.Personas.FirstOrDefault(pp => pp.persona_dni == dni);
                        if (p_juez != null)
                        {
                            juez = p_juez.Juez;
                        }

                    }

                    //agrego o actualizo el juez
                    if (p_juez == null)
                    {
                        p_juez = new Persona();
                        p_juez.persona_nomyap = tb_nombre_juez.Value;
                        p_juez.persona_dni = dni;
                        p_juez.licenciatura_id = usuario.licenciatura_id;
                        p_juez.persona_email = tb_email.Value;
                        p_juez.persona_domicilio = tb_domicilio.Value;
                        p_juez.persona_telefono = tb_telefono.Value;
                        p_juez.persona_usuario = "";
                        p_juez.persona_clave = "";
                        p_juez.persona_estilo = "Sandstone";

                        cxt.Personas.Add(p_juez);
                    }
                    else
                    {
                        p_juez.persona_nomyap = tb_nombre_juez.Value;
                        p_juez.persona_dni = dni;
                        p_juez.persona_email = tb_email.Value;
                        p_juez.persona_domicilio = tb_domicilio.Value;
                        p_juez.persona_telefono = tb_telefono.Value;
                    }


                    if (juez == null)
                    {
                        //no existe hago un insert
                        juez = new Juez()
                        {
                            Persona = p_juez
                        };

                        cxt.Jueces.Add(juez);
                    }


                    try
                    {

                        cxt.SaveChanges();

                        tb_dni_juez.Value = string.Empty;
                        tb_domicilio.Value = string.Empty;
                        tb_email.Value = string.Empty;
                        tb_nombre_juez.Value = string.Empty;
                        tb_telefono.Value = string.Empty;
                        hidden_id_juez_editar.Value = "0";

                        MessageBox.Show(this, "Se guardó correctamente el juez!", MessageBox.Tipo_MessageBox.Success, "Exito!");
                    }
                    catch (System.Data.Entity.Validation.DbEntityValidationException dbEx)
                    {
                        Exception raise = dbEx;
                        foreach (var validationErrors in dbEx.EntityValidationErrors)
                        {
                            foreach (var validationError in validationErrors.ValidationErrors)
                            {
                                string message = string.Format("{0}:{1}",
                                    validationErrors.Entry.Entity.ToString(),
                                    validationError.ErrorMessage);
                                // raise a new exception nesting
                                // the current instance as InnerException
                                raise = new InvalidOperationException(message, raise);
                            }
                        }


                        MessageBox.Show(this, raise.Message);
                    }
                }

                ObtenerJueces();
            }
            else
            {
                string script = "<script language=\"javascript\"  type=\"text/javascript\">$(document).ready(function() { $('#agregar_juez').modal('show')});</script>";
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "ShowPopUp", script, false);
            }

        }

        protected void btn_editar_ServerClick(object sender, EventArgs e)
        {
            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                int id_juez = Convert.ToInt32(((HtmlButton)sender).Attributes["data-id"]);

                Juez juez = cxt.Jueces.FirstOrDefault(pp => pp.juez_id == id_juez);
                if (juez != null)
                {
                    tb_dni_juez.Value = juez.Persona.persona_dni.ToString();
                    tb_domicilio.Value = juez.Persona.persona_domicilio;
                    tb_email.Value = juez.Persona.persona_email;
                    tb_nombre_juez.Value = juez.Persona.persona_nomyap;
                    tb_telefono.Value = juez.Persona.persona_telefono;
                    lbl_agregar_actualizar_juez.Text = "Actualizar ";

                    tb_dni_juez.Disabled = true;
                    btn_chequear_dni.Visible = false;

                    btn_guardar.Visible = true;

                    tb_tabla_resto_campos.Visible = true;

                    hidden_id_juez_editar.Value = juez.juez_id.ToString();

                    string script = "<script language=\"javascript\"  type=\"text/javascript\">$(document).ready(function() { $('#agregar_juez').modal('show')});</script>";
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "ShowPopUp", script, false);
                }
            }
        }

        protected void btn_ver_ServerClick1(object sender, EventArgs e)
        {
            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {

                int id_juez = Convert.ToInt32(((HtmlButton)sender).Attributes["data-id"]);

                Juez juez = cxt.Jueces.FirstOrDefault(pp => pp.juez_id == id_juez);
                if (juez != null)
                {
                    lbl_ver_juez_dni.Text = juez.Persona.persona_dni.ToString();
                    lbl_ver_juez_domicilio.Text = juez.Persona.persona_domicilio;
                    lbl_ver_juez_email.Text = juez.Persona.persona_email;
                    lbl_ver_juez_nomyap.Text = juez.Persona.persona_nomyap;
                    lbl_ver_juez_telefono.Text = juez.Persona.persona_telefono;
                    lbl_ver_juez_usuario.Text = juez.Persona.persona_usuario;

                    string script = "<script language=\"javascript\"  type=\"text/javascript\">$(document).ready(function() { $('#panel_ver_juez').modal('show')});</script>";
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "ShowPopUp", script, false);
                }
            }
        }

        protected void btn_chequear_dni_ServerClick(object sender, EventArgs e)
        {
            Validate("dni_persona");
            if (IsValid)
            {
                using (HabProfDBContainer cxt = new HabProfDBContainer())
                {
                    int dni = 0;
                    if (Int32.TryParse(tb_dni_juez.Value, out dni))
                    {
                        Persona persona = cxt.Personas.FirstOrDefault(pp => pp.persona_dni == dni);
                        if (persona != null)
                        {
                            tb_dni_juez.Value = persona.persona_dni.ToString();
                            tb_domicilio.Value = persona.persona_domicilio;
                            tb_email.Value = persona.persona_email;
                            tb_nombre_juez.Value = persona.persona_nomyap;
                            tb_telefono.Value = persona.persona_telefono;
                        }
                    }
                }

                tb_dni_juez.Disabled = true;
                btn_chequear_dni.Visible = false;
                btn_guardar.Visible = true;

                tb_tabla_resto_campos.Visible = true;
            }

            string script = "<script language=\"javascript\"  type=\"text/javascript\">$(document).ready(function() { $('#agregar_juez').modal('show')});</script>";
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "ShowPopUp", script, false);
        }

        protected void btn_agregar_juez_ServerClick(object sender, EventArgs e)
        {
            lbl_agregar_actualizar_juez.Text = "Agregar ";

            tb_dni_juez.Value = "";

            tb_dni_juez.Disabled = false;

            btn_chequear_dni.Visible = true;

            btn_guardar.Visible = false;

            tb_tabla_resto_campos.Visible = false;

            tb_domicilio.Value = string.Empty;
            tb_email.Value = string.Empty;
            tb_nombre_juez.Value = string.Empty;
            tb_telefono.Value = string.Empty;
            hidden_id_juez_editar.Value = "0";

            string script = "<script language=\"javascript\"  type=\"text/javascript\">$(document).ready(function() { $('#agregar_juez').modal('show')});</script>";
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "ShowPopUp", script, false);
        }

        protected void cv_correo_duplicado_ServerValidate(object source, ServerValidateEventArgs args)
        {
            int dni = Convert.ToInt32(tb_dni_juez.Value);
            bool correcto = true;

            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                correcto = cxt.Personas.FirstOrDefault(pp => pp.persona_email == tb_email.Value && pp.persona_dni != dni) == null;
            }

            args.IsValid = correcto;
        }
    }
}