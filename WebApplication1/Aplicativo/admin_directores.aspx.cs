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
    public partial class admin_directores : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["Perfil"].ToString() != "Administrador")
                {
                    MessageBox.Show(this, "Usted no tiene permiso para acceder a esta página", MessageBox.Tipo_MessageBox.Danger, "Acceso restringido", "../default.aspx");
                }

                ObtenerDirectores();
            }
        }

        private void ObtenerDirectores()
        {
            lbl_agregar_actualizar_director.Text = "Agregar "; //seteo el encabezado del popup porque el boton agregar levanta el popup desde html sin venir hasta el servidor
            hidden_id_director_editar.Value = "0";
            using (HabProfDBContainer cxt = new Aplicativo.HabProfDBContainer())
            {
                var directores = (from d in cxt.Directores
                                  where d.director_fecha_baja == null
                                  select d).ToList();

                var directores_con_tesina_a_cargo = (from d in directores
                                                     select new
                                                     {
                                                         director_id = d.director_id,
                                                         persona_nomyap = d.Persona.persona_nomyap,
                                                         persona_dni = d.Persona.persona_dni,
                                                         persona_email = d.Persona.persona_email,
                                                         director_tesina_a_cargo = d.Tesinas_a_cargo,
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
        }

        protected void btn_aceptar_eliminacion_Click(object sender, EventArgs e)
        {
            int id_director = Convert.ToInt32(id_item_por_eliminar.Value);

            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                Director director = cxt.Directores.FirstOrDefault(pp => pp.director_id == id_director);

                if (director.Tesinas.Count == 0)
                {
                    director.director_fecha_baja = DateTime.Today;
                    if (
                        (director.Persona.Administrador == null || director.Persona.Administrador.administrador_fecha_baja != null) && //no tiene el perfil o esta dado de baja
                        (director.Persona.Tesista == null || director.Persona.Tesista.tesista_fecha_baja != null) && //no tiene el perfil o esta dado de baja
                        (director.Persona.Juez == null || director.Persona.Juez.juez_fecha_baja != null)  //no tiene el perfil o esta dado de baja
                        )
                    {
                        director.Persona.persona_usuario = "";
                        director.Persona.persona_clave = "";
                    }

                    cxt.SaveChanges();
                    MessageBox.Show(this, "Se ha eliminado correctamente al director " + director.Persona.persona_nomyap, MessageBox.Tipo_MessageBox.Success);
                }
                else
                {
                    MessageBox.Show(this, "No se puede eliminar el director " + director.Persona.persona_nomyap + " el mismo tiene tesinas asociadas. ", MessageBox.Tipo_MessageBox.Warning);
                }
            }

            ObtenerDirectores();
        }

        protected void gv_directores_PreRender(object sender, EventArgs e)
        {
            if (gv_directores.Rows.Count > 0)
            {
                gv_directores.HeaderRow.TableSection = TableRowSection.TableHeader;
            }

            if (gv_tesinas.Rows.Count > 0)
            {
                gv_tesinas.HeaderRow.TableSection = TableRowSection.TableHeader;
            }
        }

        protected void btn_guardar_ServerClick(object sender, EventArgs e)
        {
            if (this.IsValid)
            {
                bool director_nuevo = false;
                Persona usuario = Session["UsuarioLogueado"] as Persona;
                int id_director = Convert.ToInt32(hidden_id_director_editar.Value);

                Persona p_director = null;
                Director director = null;

                using (HabProfDBContainer cxt = new HabProfDBContainer())
                {
                    int dni = 0;
                    int.TryParse(tb_dni_director.Value, out dni);
                    if (id_director != 0)
                    {
                        //abrio por editar director y cambio el DNI, obtengo el director a editar
                        director = cxt.Directores.Include("Persona").FirstOrDefault(pp => pp.director_id == id_director);
                        p_director = director.Persona;
                    }
                    else
                    {
                        p_director = cxt.Personas.FirstOrDefault(pp => pp.persona_dni == dni);
                        if (p_director != null)
                        {
                            director = p_director.Director;
                        }

                    }

                    //agrego o actualizo el director
                    if (p_director == null)
                    {
                        p_director = new Persona();
                        p_director.persona_nomyap = tb_nombre_director.Value;
                        p_director.persona_dni = dni;
                        p_director.licenciatura_id = usuario.licenciatura_id;
                        p_director.persona_email = tb_email.Value;
                        p_director.persona_domicilio = tb_domicilio.Value;
                        p_director.persona_telefono = tb_telefono.Value;
                        p_director.persona_usuario = tb_usuario.Value;
                        p_director.persona_clave = Cripto.Encriptar(tb_dni_director.Value);
                        p_director.persona_estilo = "Slate";

                        cxt.Personas.Add(p_director);
                    }
                    else
                    {
                        p_director.persona_nomyap = tb_nombre_director.Value;
                        p_director.persona_dni = dni;
                        p_director.persona_email = tb_email.Value;
                        p_director.persona_domicilio = tb_domicilio.Value;
                        p_director.persona_telefono = tb_telefono.Value;
                        p_director.persona_usuario = tb_usuario.Value;
                        if (chk_cambiar_clave.Checked)
                        {
                            p_director.persona_clave = Cripto.Encriptar(tb_contraseña.Value);
                        }
                    }


                    if (director == null)
                    {
                        //no existe hago un insert
                        director = new Director()
                        {
                            Persona = p_director
                        };

                        cxt.Directores.Add(director);

                        director_nuevo = true;
                    }


                    try
                    {

                        cxt.SaveChanges();

                        tb_dni_director.Value = string.Empty;
                        tb_domicilio.Value = string.Empty;
                        tb_email.Value = string.Empty;
                        tb_nombre_director.Value = string.Empty;
                        tb_telefono.Value = string.Empty;
                        tb_usuario.Value = string.Empty;
                        tb_contraseña.Value = string.Empty;
                        hidden_id_director_editar.Value = "0";

                        if (director_nuevo)
                        {
                            Envio_mail registro_envio_mail = new Envio_mail()
                            {
                                persona_id = p_director.persona_id,
                                envio_fecha_hora = DateTime.Now,
                                envio_email_destino = p_director.persona_email, //de haber mas de un destinatario separar por coma Ej: mail + "," + mail2 + "," + mail3
                                envio_respuesta_clave = Guid.NewGuid().ToString(),
                                envio_tipo = MiEmail.tipo_mail.alta_director.ToString()
                            };

                            cxt.Envio_mails.Add(registro_envio_mail);
                            cxt.SaveChanges();

                            MiEmail mail = new MiEmail(registro_envio_mail);

                            mail.Enviar_mail();
                        }

                        MessageBox.Show(this, "Se guardó correctamente el director!", MessageBox.Tipo_MessageBox.Success, "Exito!");
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

                ObtenerDirectores();
            }
            else
            {
                string script = "<script language=\"javascript\"  type=\"text/javascript\">$(document).ready(function() { $('#agregar_director').modal('show')});</script>";
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "ShowPopUp", script, false);
            }

        }

        protected void btn_editar_ServerClick(object sender, EventArgs e)
        {
            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                int id_director = Convert.ToInt32(((HtmlButton)sender).Attributes["data-id"]);

                Director director = cxt.Directores.FirstOrDefault(pp => pp.director_id == id_director);
                if (director != null)
                {
                    tb_dni_director.Value = director.Persona.persona_dni.ToString();
                    tb_domicilio.Value = director.Persona.persona_domicilio;
                    tb_email.Value = director.Persona.persona_email;
                    tb_nombre_director.Value = director.Persona.persona_nomyap;
                    tb_telefono.Value = director.Persona.persona_telefono;
                    tb_usuario.Value = director.Persona.persona_usuario;
                    tr_pass_alta.Visible = false;
                    tr_pass_edit.Visible = true;
                    chk_cambiar_clave.Checked = false;
                    tr_chk_change_pass.Visible = false;
                    lbl_agregar_actualizar_director.Text = "Actualizar ";

                    tb_dni_director.Disabled = true;
                    btn_chequear_dni.Visible = false;

                    btn_guardar.Visible = true;

                    tb_tabla_resto_campos.Visible = true;

                    hidden_id_director_editar.Value = director.director_id.ToString();

                    string script = "<script language=\"javascript\"  type=\"text/javascript\">$(document).ready(function() { $('#agregar_director').modal('show')});</script>";
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "ShowPopUp", script, false);
                }
            }
        }

        protected void btn_ver_ServerClick1(object sender, EventArgs e)
        {
            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {

                int id_director = Convert.ToInt32(((HtmlButton)sender).Attributes["data-id"]);

                Director director = cxt.Directores.FirstOrDefault(pp => pp.director_id == id_director);
                if (director != null)
                {
                    lbl_ver_director_dni.Text = director.Persona.persona_dni.ToString();
                    lbl_ver_director_domicilio.Text = director.Persona.persona_domicilio;
                    lbl_ver_director_email.Text = director.Persona.persona_email;
                    lbl_ver_director_nomyap.Text = director.Persona.persona_nomyap;
                    lbl_ver_director_telefono.Text = director.Persona.persona_telefono;
                    lbl_ver_director_calificacion.Text = director.Calificacion_general.ToString();
                    lbl_ver_director_usuario.Text = director.Persona.persona_usuario;

                    List<Tesina> tesinas = cxt.Tesinas.Where(tt => tt.director_id == director.director_id).OrderByDescending(tt => tt.tesina_plan_fch_presentacion).ToList();

                    var tesina_para_grilla = (from t in tesinas
                                              select new
                                              {
                                                  tesina_id = t.tesina_id,
                                                  tesina_tema_completo = t.tesina_tema,
                                                  tesina_tema_recortado = t.tesina_tema.Substring(0, 40),
                                                  tesina_plan_fch_presentacion = t.tesina_plan_fch_presentacion,
                                                  tesinata_nombre = t.Tesista.Persona.persona_nomyap,
                                                  tesina_estado = t.Estado.estado_tesina_estado
                                              }).ToList();


                    lbl_tesinas_director.Text = tesina_para_grilla.Count == 0 ? "El director no participo en ninguna tesina aún.-" : "Tesinas supervisadas y en curso";
                    gv_tesinas.DataSource = tesina_para_grilla;
                    gv_tesinas.DataBind();

                    string script = "<script language=\"javascript\"  type=\"text/javascript\">$(document).ready(function() { $('#panel_ver_director').modal('show')});</script>";
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "ShowPopUp", script, false);
                }
            }
        }

        protected void cv_usuario_duplicado_ServerValidate(object source, ServerValidateEventArgs args)
        {
            int dni = Convert.ToInt32(tb_dni_director.Value);
            bool correcto = true;

            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                correcto = cxt.Personas.FirstOrDefault(pp => pp.persona_usuario == tb_usuario.Value && pp.persona_dni != dni) == null;
            }

            args.IsValid = correcto;
        }

        protected void chk_cambiar_clave_CheckedChanged(object sender, EventArgs e)
        {
            tr_chk_change_pass.Visible = chk_cambiar_clave.Checked;

            string script = "<script language=\"javascript\"  type=\"text/javascript\">$(document).ready(function() { $('#agregar_director').modal('show')});</script>";
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "ShowPopUp", script, false);
        }

        protected void btn_chequear_dni_ServerClick(object sender, EventArgs e)
        {
            Validate("dni_persona");
            if (IsValid)
            {
                using (HabProfDBContainer cxt = new HabProfDBContainer())
                {
                    int dni = 0;
                    if (Int32.TryParse(tb_dni_director.Value, out dni))
                    {
                        Persona persona = cxt.Personas.FirstOrDefault(pp => pp.persona_dni == dni);
                        if (persona != null)
                        {
                            tb_dni_director.Value = persona.persona_dni.ToString();
                            tb_domicilio.Value = persona.persona_domicilio;
                            tb_email.Value = persona.persona_email;
                            tb_nombre_director.Value = persona.persona_nomyap;
                            tb_telefono.Value = persona.persona_telefono;
                            tb_usuario.Value = persona.persona_usuario;
                            tr_pass_edit.Visible = true;
                            chk_cambiar_clave.Checked = false;
                            tr_chk_change_pass.Visible = false;
                            tr_pass_alta.Visible = false;
                        }
                        else
                        {
                            tb_usuario.Value = tb_dni_director.Value;
                            tr_pass_edit.Visible = false;
                            tr_pass_alta.Visible = true;
                        }
                    }
                }

                tb_dni_director.Disabled = true;
                btn_chequear_dni.Visible = false;
                btn_guardar.Visible = true;

                tb_tabla_resto_campos.Visible = true;
            }

            string script = "<script language=\"javascript\"  type=\"text/javascript\">$(document).ready(function() { $('#agregar_director').modal('show')});</script>";
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "ShowPopUp", script, false);
        }

        protected void btn_agregar_director_ServerClick(object sender, EventArgs e)
        {
            lbl_agregar_actualizar_director.Text = "Agregar ";

            tb_dni_director.Value = "";

            tb_dni_director.Disabled = false;

            btn_chequear_dni.Visible = true;

            btn_guardar.Visible = false;

            tb_tabla_resto_campos.Visible = false;

            tb_domicilio.Value = string.Empty;
            tb_email.Value = string.Empty;
            tb_nombre_director.Value = string.Empty;
            tb_telefono.Value = string.Empty;
            tb_usuario.Value = string.Empty;
            tb_contraseña.Value = string.Empty;
            hidden_id_director_editar.Value = "0";

            string script = "<script language=\"javascript\"  type=\"text/javascript\">$(document).ready(function() { $('#agregar_director').modal('show')});</script>";
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "ShowPopUp", script, false);
        }

        protected void cv_correo_duplicado_ServerValidate(object source, ServerValidateEventArgs args)
        {
            int dni = Convert.ToInt32(tb_dni_director.Value);
            bool correcto = true;

            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                correcto = cxt.Personas.FirstOrDefault(pp => pp.persona_email == tb_email.Value && pp.persona_dni != dni) == null;
            }

            args.IsValid = correcto;
        }
    }
}