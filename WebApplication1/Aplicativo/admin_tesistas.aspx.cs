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
    public partial class admin_tesistas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["Perfil"].ToString() != "Administrador")
                {
                    MessageBox.Show(this, "Usted no tiene permiso para acceder a esta página", MessageBox.Tipo_MessageBox.Danger, "Acceso restringido", "../default.aspx");
                }

                ObtenerTesistas();
            }
        }

        private void ObtenerTesistas()
        {
            lbl_agregar_actualizar_tesista.Text = "Agregar "; //seteo el encabezado del popup porque el boton agregar levanta el popup desde html sin venir hasta el servidor
            hidden_id_tesista_editar.Value = "0";
            using (HabProfDBContainer cxt = new Aplicativo.HabProfDBContainer())
            {
                var tesistas = (
                    from t in cxt.Tesistas
                    where t.tesista_baja_definitiva == null
                    select new
                    {
                        tesista_id = t.tesista_id,
                        persona_nomyap = t.Persona.persona_nomyap,
                        persona_dni = t.Persona.persona_dni,
                        persona_email = t.Persona.persona_email,
                        tesista_legajo = t.tesista_legajo,
                        tesista_sede = t.tesista_sede,
                        fecha_baja = t.tesista_fecha_baja
                    }).ToList();

                var tesistas_estado_activo_inactivo = (from t in tesistas
                                                       select new
                                                       {
                                                           tesista_id = t.tesista_id,
                                                           persona_nomyap = t.persona_nomyap,
                                                           persona_dni = t.persona_dni,
                                                           persona_email = t.persona_email,
                                                           tesista_legajo = t.tesista_legajo,
                                                           tesista_sede = t.tesista_sede,
                                                           estado = t.fecha_baja == null ? "Activo" : "Inactivo",
                                                           mostrar_inhabilitar = t.fecha_baja == null,
                                                           mostrar_habilitar = t.fecha_baja != null
                                                       }).OrderBy(t => t.estado).ThenBy(t => t.persona_nomyap).ToList();

                if (tesistas.Count() > 0)
                {
                    gv_tesistas.DataSource = tesistas_estado_activo_inactivo;
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
                Tesista tesista = cxt.Tesistas.FirstOrDefault(pp => pp.tesista_id == id_tesista);
                tesista.tesista_fecha_baja = DateTime.Today;

                if (
                   (tesista.Persona.Administrador == null || tesista.Persona.Administrador.administrador_fecha_baja != null) && //no tiene el perfil o esta dado de baja
                   (tesista.Persona.Director == null || tesista.Persona.Director.director_fecha_baja != null) && //no tiene el perfil o esta dado de baja
                   (tesista.Persona.Juez == null || tesista.Persona.Juez.juez_fecha_baja != null)  //no tiene el perfil o esta dado de baja
                   )
                {
                    tesista.Persona.persona_usuario = "";
                    tesista.Persona.persona_clave = "";
                }

                cxt.SaveChanges();
                MessageBox.Show(this, "Se ha inhabilitado correctamente al tesista " + tesista.Persona.persona_nomyap, MessageBox.Tipo_MessageBox.Success);
            }

            ObtenerTesistas();
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
            this.Validate("tesista");
            if (this.IsValid)
            {
                Persona usuario = Session["UsuarioLogueado"] as Persona;
                int id_tesista = Convert.ToInt32(hidden_id_tesista_editar.Value);

                int dni = 0;
                int.TryParse(tb_dni_tesista.Value, out dni);

                Persona p_tesista = null;
                Tesista tesista = null;

                using (HabProfDBContainer cxt = new HabProfDBContainer())
                {
                    if (id_tesista != 0)
                    {
                        //abrio por editar tesista
                        tesista = cxt.Tesistas.FirstOrDefault(pp => pp.tesista_id == id_tesista);
                        p_tesista = tesista.Persona;
                    }
                    else
                    {
                        p_tesista = cxt.Personas.FirstOrDefault(pp => pp.persona_dni == dni);
                        if (p_tesista != null)
                        {
                            tesista = p_tesista.Tesista;
                        }
                    }

                    //Agrego o actualizo la persona
                    if (p_tesista == null)
                    {
                        p_tesista = new Persona()
                        {
                            licenciatura_id = usuario.licenciatura_id,
                            persona_nomyap = tb_nombre_tesista.Value,
                            persona_dni = dni,
                            persona_email = tb_email.Value,
                            persona_email_validado = false,
                            persona_domicilio = tb_domicilio.Value,
                            persona_telefono = tb_telefono.Value,
                            persona_usuario = tb_usuario.Value,
                            persona_clave = Cripto.Encriptar(tb_dni_tesista.Value),
                            persona_estilo = "Sandstone"
                        };
                        cxt.Personas.Add(p_tesista);
                    }
                    else
                    {
                        p_tesista.licenciatura_id = usuario.licenciatura_id;
                        p_tesista.persona_nomyap = tb_nombre_tesista.Value;
                        p_tesista.persona_dni = dni;
                        p_tesista.licenciatura_id = usuario.licenciatura_id;
                        p_tesista.persona_email = tb_email.Value;
                        p_tesista.persona_email_validado = false;
                        p_tesista.persona_domicilio = tb_domicilio.Value;
                        p_tesista.persona_telefono = tb_telefono.Value;
                        p_tesista.persona_usuario = tb_usuario.Value;
                        if (chk_cambiar_clave.Checked)
                        {
                            p_tesista.persona_clave = Cripto.Encriptar(tb_contraseña.Value);
                        }
                    }

                    //agrego o actualizo el tesista
                    if (tesista == null)
                    {
                        //no existe hago un insert
                        tesista = new Tesista()
                        {
                            Persona = p_tesista,
                            tesista_legajo = tb_legajo.Value,
                            tesista_sede = tb_sede.Value
                        };

                        cxt.Tesistas.Add(tesista);
                    }
                    else
                    {
                        //existe el tesista por lo tanto tambien la persona y ya fue editada
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
                        hidden_id_tesista_editar.Value = "0";

                        MessageBox.Show(this, "Se guardó correctamente el tesista!", MessageBox.Tipo_MessageBox.Success, "Exito!");
                    }
                    catch (Exception ex)
                    {
                        MessageBox.Show(this, ex.Message, MessageBox.Tipo_MessageBox.Danger);
                    }
                }

                ObtenerTesistas();
            }
            else
            {
                string script = "<script language=\"javascript\"  type=\"text/javascript\">$(document).ready(function() { $('#agregar_tesista').modal('show')});</script>";
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "ShowPopUp", script, false);
            }
        }

        protected void cv_usuario_duplicado_ServerValidate(object source, ServerValidateEventArgs args)
        {
            int dni = Convert.ToInt32(tb_dni_tesista.Value);
            bool correcto = true;

            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                correcto = cxt.Personas.FirstOrDefault(pp => pp.persona_usuario == tb_usuario.Value && pp.persona_dni != dni) == null;
            }

            args.IsValid = correcto;
        }

        protected void cv_correo_duplicado_ServerValidate(object source, ServerValidateEventArgs args)
        {
            int dni = Convert.ToInt32(tb_dni_tesista.Value);
            bool correcto = true;

            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                correcto = cxt.Personas.FirstOrDefault(pp => pp.persona_email == tb_email.Value && pp.persona_dni != dni) == null;
            }

            args.IsValid = correcto;
        }

        protected void chk_cambiar_clave_CheckedChanged(object sender, EventArgs e)
        {
            tr_chk_change_pass.Visible = chk_cambiar_clave.Checked;

            string script = "<script language=\"javascript\"  type=\"text/javascript\">$(document).ready(function() { $('#agregar_tesista').modal('show')});</script>";
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "ShowPopUp", script, false);
        }

        protected void btn_editar_ServerClick(object sender, EventArgs e)
        {
            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                int id_tesista = Convert.ToInt32(((HtmlButton)sender).Attributes["data-id"]);

                Tesista tesista = cxt.Tesistas.FirstOrDefault(pp => pp.tesista_id == id_tesista);
                if (tesista != null)
                {
                    tb_dni_tesista.Value = tesista.Persona.persona_dni.ToString();
                    tb_domicilio.Value = tesista.Persona.persona_domicilio;
                    tb_email.Value = tesista.Persona.persona_email;
                    tb_nombre_tesista.Value = tesista.Persona.persona_nomyap;
                    tb_telefono.Value = tesista.Persona.persona_telefono;
                    tb_usuario.Value = tesista.Persona.persona_usuario;
                    tr_pass_alta.Visible = false;
                    tr_pass_edit.Visible = true;
                    chk_cambiar_clave.Checked = false;
                    tr_chk_change_pass.Visible = false;
                    tb_legajo.Value = tesista.tesista_legajo;
                    tb_sede.Value = tesista.tesista_sede;
                    lbl_agregar_actualizar_tesista.Text = "Actualizar ";

                    tb_dni_tesista.Disabled = true;
                    btn_chequear_dni.Visible = false;

                    btn_guardar.Visible = true;

                    tb_tabla_resto_campos.Visible = true;

                    hidden_id_tesista_editar.Value = tesista.tesista_id.ToString();

                    string script = "<script language=\"javascript\"  type=\"text/javascript\">$(document).ready(function() { $('#agregar_tesista').modal('show')});</script>";
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "ShowPopUp", script, false);
                }
            }
        }

        protected void btn_ver_ServerClick1(object sender, EventArgs e)
        {
            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {

                int id_tesista = Convert.ToInt32(((HtmlButton)sender).Attributes["data-id"]);

                Tesista tesista = cxt.Tesistas.FirstOrDefault(pp => pp.tesista_id == id_tesista);
                if (tesista != null)
                {
                    lbl_sin_tesina.Visible = false;
                    lbl_ver_tesista_dni.Text = tesista.Persona.persona_dni.ToString();
                    lbl_ver_tesista_domicilio.Text = tesista.Persona.persona_domicilio;
                    lbl_ver_tesista_email.Text = tesista.Persona.persona_email;
                    lbl_ver_tesista_legajo.Text = tesista.tesista_legajo;
                    lbl_ver_tesista_nomyap.Text = tesista.Persona.persona_nomyap;
                    lbl_ver_tesista_sede.Text = tesista.tesista_sede;
                    lbl_ver_tesista_telefono.Text = tesista.Persona.persona_telefono;

                    var tesinas = (from t in tesista.Tesina select t).ToList();
                    var tesinas_para_grilla = (from t in tesinas
                                               select new
                                               {
                                                   tesina_tema = t.tesina_tema,
                                                   tesina_director = t.Director.Persona.persona_nomyap,
                                                   tesina_tesista = t.Tesista.Persona.persona_nomyap,
                                                   tesina_codirector = t.Codirector == null ? "-" : t.Codirector.Persona.persona_nomyap,
                                                   tesina_nota = t.tesina_calificacion,
                                                   tesina_nota_director = t.tesina_calificacion_director,
                                                   tesina_nota_codirector = t.tesina_calificacion_codirector == null ? "-" : t.tesina_calificacion_codirector.ToString()
                                               }).ToList();

                    if (tesinas_para_grilla.Count > 0)
                    {
                        gv_tesina.DataSource = tesinas_para_grilla;
                        gv_tesina.DataBind();
                    }
                    else
                    {
                        gv_tesina.DataSource = null;
                        gv_tesina.DataBind();
                    }

                    string script = "<script language=\"javascript\"  type=\"text/javascript\">$(document).ready(function() { $('#panel_ver_tesista').modal('show')});</script>";
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
                    if (Int32.TryParse(tb_dni_tesista.Value, out dni))
                    {
                        Persona persona = cxt.Personas.FirstOrDefault(pp => pp.persona_dni == dni);
                        if (persona != null)
                        {
                            tb_dni_tesista.Value = persona.persona_dni.ToString();
                            tb_domicilio.Value = persona.persona_domicilio;
                            tb_email.Value = persona.persona_email;
                            tb_nombre_tesista.Value = persona.persona_nomyap;
                            tb_telefono.Value = persona.persona_telefono;
                            tb_usuario.Value = persona.persona_usuario;
                            tr_pass_edit.Visible = true;
                            chk_cambiar_clave.Checked = false;
                            tr_chk_change_pass.Visible = false;
                            tr_pass_alta.Visible = false;
                        }
                        else
                        {
                            tb_usuario.Value = tb_dni_tesista.Value;
                            tr_pass_edit.Visible = false;
                            tr_pass_alta.Visible = true;
                        }
                    }
                }

                tb_dni_tesista.Disabled = true;
                btn_chequear_dni.Visible = false;

                btn_guardar.Visible = true;

                tb_tabla_resto_campos.Visible = true;
            }

            string script = "<script language=\"javascript\"  type=\"text/javascript\">$(document).ready(function() { $('#agregar_tesista').modal('show')});</script>";
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "ShowPopUp", script, false);
        }

        protected void btn_agregar_tesista_ServerClick(object sender, EventArgs e)
        {

            lbl_agregar_actualizar_tesista.Text = "Agregar ";

            tb_dni_tesista.Value = "";

            tb_dni_tesista.Disabled = false;

            btn_chequear_dni.Visible = true;

            btn_guardar.Visible = false;

            tb_tabla_resto_campos.Visible = false;
            tb_usuario.Value = string.Empty;
            tb_contraseña.Value = string.Empty;
            hidden_id_tesista_editar.Value = "0";

            string script = "<script language=\"javascript\"  type=\"text/javascript\">$(document).ready(function() { $('#agregar_tesista').modal('show')});</script>";
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "ShowPopUp", script, false);
        }

        protected void btn_habilitar_tesista_ServerClick(object sender, EventArgs e)
        {
            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                int id_tesista = Convert.ToInt32(((HtmlButton)sender).Attributes["data-id"]);
                Tesista tesista = cxt.Tesistas.FirstOrDefault(pp => pp.tesista_id == id_tesista);
                if (tesista != null)
                {
                    tesista.tesista_fecha_baja = null;
                    cxt.SaveChanges();
                    MessageBox.Show(this, "Se habilitó correctamente al tesista " + tesista.Persona.persona_nomyap, MessageBox.Tipo_MessageBox.Success);
                }
            }

            ObtenerTesistas();
        }

        protected void gv_tesina_PreRender(object sender, EventArgs e)
        {
            if (gv_tesina.Rows.Count > 0)
            {
                gv_tesina.HeaderRow.TableSection = TableRowSection.TableHeader;
            }
        }

        protected void btn_eliminar_tesistas_ServerClick(object sender, EventArgs e)
        {
            Response.Redirect("~/Aplicativo/admin_tesistas_eliminar_limpieza.aspx");
        }
    }
}