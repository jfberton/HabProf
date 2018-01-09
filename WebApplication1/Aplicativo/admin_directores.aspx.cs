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
                if (Session["Perfil"].ToString() != "Admin")
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
                var directores = (from d in cxt.Personas.OfType<Director>()
                                  where d.persona_fecha_baja == null
                                  select new
                                  {
                                      persona_id = d.persona_id,
                                      persona_nomyap = d.persona_nomyap,
                                      persona_dni = d.persona_dni,
                                      persona_email = d.persona_email,
                                      director_calificacion = d.director_calificacion
                                  }).ToList();

                var directores_con_tesis_a_cargo = (from d in directores
                                                    select new
                                                    {
                                                        persona_id = d.persona_id,
                                                        persona_nomyap = d.persona_nomyap,
                                                        persona_dni = d.persona_dni,
                                                        persona_email = d.persona_email,
                                                        director_tesis_a_cargo = (cxt.Tesinas.Count(tt => tt.tesis_fecha_cierre != null && tt.director_persona_id == d.persona_id)),
                                                        director_calificacion = d.director_calificacion
                                                    }).ToList();


                if (directores_con_tesis_a_cargo.Count() > 0)
                {

                    gv_directores.DataSource = directores_con_tesis_a_cargo;
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
                Director director = cxt.Personas.OfType<Director>().FirstOrDefault(pp => pp.persona_id == id_director);
                director.persona_fecha_baja = DateTime.Today;

                cxt.SaveChanges();
                MessageBox.Show(this, "Se ha eliminado correctamente al director " + director.persona_nomyap, MessageBox.Tipo_MessageBox.Success);
            }

            ObtenerDirectores();
        }

        protected void btn_ver_ServerClick(object sender, EventArgs e)
        {

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
            this.Validate("director");
            if (this.IsValid)
            {
                Persona usuario = Session["UsuarioLogueado"] as Persona;
                int id_director = Convert.ToInt32(hidden_id_director_editar.Value);
                using (HabProfDBContainer cxt = new HabProfDBContainer())
                {
                    Director director = cxt.Personas.OfType<Director>().FirstOrDefault(pp => pp.persona_dni == tb_dni_director.Value);
                    if (director == null && id_director != 0)
                    {
                        //abrio por editar director y cambio el DNI, obtengo el director a editar
                        director = cxt.Personas.OfType<Director>().FirstOrDefault(pp => pp.persona_id == id_director);
                    }

                    if (director == null)
                    {
                        //no existe hago un insert
                        director = new Director()
                        {
                            licenciatura_id = usuario.licenciatura_id,
                            persona_nomyap = tb_nombre_director.Value,
                            persona_dni = tb_dni_director.Value,
                            persona_email = tb_email.Value,
                            persona_domicilio = tb_domicilio.Value,
                            persona_telefono = tb_telefono.Value,
                            persona_usuario = tb_usuario.Value,
                            persona_clave = Cripto.Encriptar(tb_contraseña.Value),
                            persona_estilo = "Sandstone",
                        };
                        cxt.Personas.Add(director);

                        if (chk_cambiar_clave.Checked)
                        {
                            director.persona_clave = Cripto.Encriptar(tb_contraseña.Value);
                        }
                        else
                        {
                            director.persona_clave = "debe cambiar la contraseña";
                        }
                    }
                    else
                    {
                        //existe hago un update
                        director.licenciatura_id = usuario.licenciatura_id;
                        director.persona_nomyap = tb_nombre_director.Value;
                        director.persona_dni = tb_dni_director.Value;
                        director.persona_email = tb_email.Value;
                        director.persona_domicilio = tb_domicilio.Value;
                        director.persona_telefono = tb_telefono.Value;
                        director.persona_usuario = tb_usuario.Value;
                        if (chk_cambiar_clave.Checked)
                        {
                            director.persona_clave = Cripto.Encriptar(tb_contraseña.Value);
                        }
                        director.persona_estilo = "Sandstone";
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

                        MessageBox.Show(this, "Se guardó correctamente el director!", MessageBox.Tipo_MessageBox.Success, "Exito!");
                    }
                    catch (Exception ex)
                    {
                        MessageBox.Show(this, ex.Message, MessageBox.Tipo_MessageBox.Danger);
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

                Director director = cxt.Personas.OfType<Director>().FirstOrDefault(pp => pp.persona_id == id_director);
                if (director != null)
                {
                    tb_dni_director.Value = director.persona_dni;
                    tb_domicilio.Value = director.persona_domicilio;
                    tb_email.Value = director.persona_email;
                    tb_nombre_director.Value = director.persona_nomyap;
                    tb_telefono.Value = director.persona_telefono;
                    tb_usuario.Value = director.persona_usuario;
                    tb_contraseña.Attributes["type"] = "text";
                    tb_contraseña.Value = Cripto.Desencriptar(director.persona_clave);
                    tb_contraseña.Attributes["type"] = "password";
                    lbl_agregar_actualizar_director.Text = "Actualizar ";

                    hidden_id_director_editar.Value = director.persona_id.ToString();

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

                Director director = cxt.Personas.OfType<Director>().FirstOrDefault(pp => pp.persona_id == id_director);
                if (director != null)
                {
                    lbl_ver_director_dni.Text = director.persona_dni;
                    lbl_ver_director_domicilio.Text = director.persona_domicilio;
                    lbl_ver_director_email.Text = director.persona_email;
                    lbl_ver_director_nomyap.Text = director.persona_nomyap;
                    lbl_ver_director_telefono.Text = director.persona_telefono;
                    lbl_ver_director_calificacion.Text = director.director_calificacion.ToString();
                    lbl_ver_director_usuario.Text = director.persona_usuario;

                    List<Tesis> tesinas = cxt.Tesinas.Where(tt => tt.director_persona_id == director.persona_id && tt.tesis_fecha_cierre == null).ToList();

                    var tesis_para_grilla = (from t in tesinas
                                             select new
                                             {
                                                 tesis_id = t.tesis_id,
                                                 tesis_tema = t.tesis_tema,
                                                 tesis_palabras_clave = t.tesis_palabras_clave,
                                                 tesis_plan_fch_presentacion = t.tesis_plan_fch_presentacion,
                                                 tesista_nombre = t.Tesista.persona_nomyap,
                                                 tesis_estado = t.Estado.estado_estado
                                             }).ToList();

                    gv_tesinas.DataSource = tesis_para_grilla;
                    gv_tesinas.DataBind();

                    string script = "<script language=\"javascript\"  type=\"text/javascript\">$(document).ready(function() { $('#panel_ver_director').modal('show')});</script>";
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "ShowPopUp", script, false);
                }
                else
                {

                }
            }
        }

        protected void cv_dni_duplicado_ServerValidate(object source, ServerValidateEventArgs args)
        {
            Director director;
            int id_director = Convert.ToInt32(hidden_id_director_editar.Value);

            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                if (id_director != 0)
                {
                    //esta editando: controlo que no se repita el DNI en otro director
                    director = cxt.Personas.OfType<Director>().FirstOrDefault(pp => pp.persona_dni == tb_dni_director.Value && pp.persona_id != id_director);
                }
                else
                {
                    //esta agregando: controlo que no se repita el DNI en ningun otro director
                    director = cxt.Personas.OfType<Director>().FirstOrDefault(pp => pp.persona_dni == tb_dni_director.Value);
                }

            }

            args.IsValid = director == null;
        }

        protected void cv_usuario_duplicado_ServerValidate(object source, ServerValidateEventArgs args)
        {
            Director director;
            int id_director = Convert.ToInt32(hidden_id_director_editar.Value);

            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                if (id_director != 0)
                {
                    //esta editando: controlo que no se repita el DNI en otro director
                    director = cxt.Personas.OfType<Director>().FirstOrDefault(pp => pp.persona_usuario == tb_usuario.Value && pp.persona_id != id_director);
                }
                else
                {
                    //esta agregando: controlo que no se repita el DNI en ningun otro director
                    director = cxt.Personas.OfType<Director>().FirstOrDefault(pp => pp.persona_usuario == tb_usuario.Value);
                }

            }

            args.IsValid = director == null;
        }

        protected void cv_contraseña_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = (chk_cambiar_clave.Checked && tb_contraseña.Value.Length > 0) || !chk_cambiar_clave.Checked;
        }

        protected void chk_cambiar_clave_CheckedChanged(object sender, EventArgs e)
        {
            tb_contraseña.Visible = chk_cambiar_clave.Checked;
            string script = "<script language=\"javascript\"  type=\"text/javascript\">$(document).ready(function() { $('#agregar_director').modal('show')});</script>";
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "ShowPopUp", script, false);
        }
    }
}