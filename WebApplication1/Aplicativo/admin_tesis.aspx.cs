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
    public partial class admin_tesis : System.Web.UI.Page
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
            //lbl_agregar_actualizar_tesina.Text = "Agregar "; //seteo el encabezado del popup porque el boton agregar levanta el popup desde html sin venir hasta el servidor
            //hidden_id_tesina_editar.Value = "0";
            //using (HabProfDBContainer cxt = new Aplicativo.HabProfDBContainer())
            //{
            //    var tesinas = (from d in cxt.Personas.OfType<Tesina>()
            //                      where d.persona_fecha_baja == null
            //                      select new
            //                      {
            //                          persona_id = d.persona_id,
            //                          persona_nomyap = d.persona_nomyap,
            //                          persona_dni = d.persona_dni,
            //                          persona_email = d.persona_email,
            //                          tesina_calificacion = d.tesina_calificacion
            //                      }).ToList();

            //    var tesinas_con_tesis_a_cargo = (from d in tesinas
            //                                        select new
            //                                        {
            //                                            persona_id = d.persona_id,
            //                                            persona_nomyap = d.persona_nomyap,
            //                                            persona_dni = d.persona_dni,
            //                                            persona_email = d.persona_email,
            //                                            tesina_tesis_a_cargo = (cxt.Tesinas.Count(tt => tt.tesis_fecha_cierre != null && tt.tesina_persona_id == d.persona_id)),
            //                                            tesina_calificacion = d.tesina_calificacion
            //                                        }).ToList();


            //    if (tesinas_con_tesis_a_cargo.Count() > 0)
            //    {

            //        gv_tesinas.DataSource = tesinas_con_tesis_a_cargo;
            //        gv_tesinas.DataBind();
            //        lbl_sin_tesinas.Visible = false;
            //    }
            //    else
            //    {
            //        lbl_sin_tesinas.Visible = true;
            //        gv_tesinas.DataSource = null;
            //        gv_tesinas.DataBind();
            //    }

            //}
        }

        protected void btn_aceptar_eliminacion_Click(object sender, EventArgs e)
        {
            //int id_tesina = Convert.ToInt32(id_item_por_eliminar.Value);

            //using (HabProfDBContainer cxt = new HabProfDBContainer())
            //{
            //    Tesina tesina = cxt.Personas.OfType<Tesina>().FirstOrDefault(pp => pp.persona_id == id_tesina);
            //    tesina.persona_fecha_baja = DateTime.Today;

            //    cxt.SaveChanges();
            //    MessageBox.Show(this, "Se ha eliminado correctamente al tesina " + tesina.persona_nomyap, MessageBox.Tipo_MessageBox.Success);
            //}

            //ObtenerTesinas();
        }

        protected void btn_ver_ServerClick(object sender, EventArgs e)
        {

        }

        protected void gv_tesinas_PreRender(object sender, EventArgs e)
        {
            //if (gv_tesinas.Rows.Count > 0)
            //{
            //    gv_tesinas.HeaderRow.TableSection = TableRowSection.TableHeader;
            //}

            //if (gv_tesinas.Rows.Count > 0)
            //{
            //    gv_tesinas.HeaderRow.TableSection = TableRowSection.TableHeader;
            //}
        }

        protected void btn_guardar_ServerClick(object sender, EventArgs e)
        {
            this.Validate("tesina");
            if (this.IsValid)
            {
                Persona usuario = Session["UsuarioLogueado"] as Persona;
                int id_tesina = Convert.ToInt32(hidden_id_tesina_editar.Value);
                using (HabProfDBContainer cxt = new HabProfDBContainer())
                {
                    //Tesina tesina = cxt.Personas.OfType<Tesina>().FirstOrDefault(pp => pp.persona_dni == tb_dni_tesina.Value);
                    //if (tesina == null && id_tesina != 0)
                    //{
                    //    //abrio por editar tesina y cambio el DNI, obtengo el tesina a editar
                    //    tesina = cxt.Personas.OfType<Tesina>().FirstOrDefault(pp => pp.persona_id == id_tesina);
                    //}

                    //if (tesina == null)
                    //{
                    //    //no existe hago un insert
                    //    tesina = new Tesina()
                    //    {
                    //        licenciatura_id = usuario.licenciatura_id,
                    //        persona_nomyap = tb_nombre_tesina.Value,
                    //        persona_dni = tb_dni_tesina.Value,
                    //        persona_email = tb_email.Value,
                    //        persona_domicilio = tb_domicilio.Value,
                    //        persona_telefono = tb_telefono.Value,
                    //        persona_usuario = tb_usuario.Value,
                    //        persona_clave = Cripto.Encriptar(tb_contraseña.Value),
                    //        persona_estilo = "Sandstone",
                    //    };
                    //    cxt.Personas.Add(tesina);

                    //    if (chk_cambiar_clave.Checked)
                    //    {
                    //        tesina.persona_clave = Cripto.Encriptar(tb_contraseña.Value);
                    //    }
                    //    else
                    //    {
                    //        tesina.persona_clave = "debe cambiar la contraseña";
                    //    }
                    //}
                    //else
                    //{
                    //    //existe hago un update
                    //    tesina.licenciatura_id = usuario.licenciatura_id;
                    //    tesina.persona_nomyap = tb_nombre_tesina.Value;
                    //    tesina.persona_dni = tb_dni_tesina.Value;
                    //    tesina.persona_email = tb_email.Value;
                    //    tesina.persona_domicilio = tb_domicilio.Value;
                    //    tesina.persona_telefono = tb_telefono.Value;
                    //    tesina.persona_usuario = tb_usuario.Value;
                    //    if (chk_cambiar_clave.Checked)
                    //    {
                    //        tesina.persona_clave = Cripto.Encriptar(tb_contraseña.Value);
                    //    }
                    //    tesina.persona_estilo = "Sandstone";
                    //}

                    //try
                    //{

                    //    cxt.SaveChanges();

                    //    tb_dni_tesina.Value = string.Empty;
                    //    tb_domicilio.Value = string.Empty;
                    //    tb_email.Value = string.Empty;
                    //    tb_nombre_tesina.Value = string.Empty;
                    //    tb_telefono.Value = string.Empty;
                    //    tb_usuario.Value = string.Empty;
                    //    tb_contraseña.Value = string.Empty;
                    //    hidden_id_tesina_editar.Value = "0";

                    //    MessageBox.Show(this, "Se guardó correctamente el tesina!", MessageBox.Tipo_MessageBox.Success, "Exito!");
                    //}
                    //catch (Exception ex)
                    //{
                    //    MessageBox.Show(this, ex.Message, MessageBox.Tipo_MessageBox.Danger);
                    //}
                }

                ObtenerTesinas();
            }
            else
            {
                string script = "<script language=\"javascript\"  type=\"text/javascript\">$(document).ready(function() { $('#agregar_tesina').modal('show')});</script>";
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "ShowPopUp", script, false);
            }

        }

        protected void btn_editar_ServerClick(object sender, EventArgs e)
        {
            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                //int id_tesina = Convert.ToInt32(((HtmlButton)sender).Attributes["data-id"]);

                //Tesina tesina = cxt.Personas.OfType<Tesina>().FirstOrDefault(pp => pp.persona_id == id_tesina);
                //if (tesina != null)
                //{
                //    tb_dni_tesina.Value = tesina.persona_dni;
                //    tb_domicilio.Value = tesina.persona_domicilio;
                //    tb_email.Value = tesina.persona_email;
                //    tb_nombre_tesina.Value = tesina.persona_nomyap;
                //    tb_telefono.Value = tesina.persona_telefono;
                //    tb_usuario.Value = tesina.persona_usuario;
                //    tb_contraseña.Attributes["type"] = "text";
                //    tb_contraseña.Value = Cripto.Desencriptar(tesina.persona_clave);
                //    tb_contraseña.Attributes["type"] = "password";
                //    lbl_agregar_actualizar_tesina.Text = "Actualizar ";

                //    hidden_id_tesina_editar.Value = tesina.persona_id.ToString();

                //    string script = "<script language=\"javascript\"  type=\"text/javascript\">$(document).ready(function() { $('#agregar_tesina').modal('show')});</script>";
                //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "ShowPopUp", script, false);
                //}
            }
        }



        protected void btn_ver_ServerClick1(object sender, EventArgs e)
        {
            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {

                //int id_tesina = Convert.ToInt32(((HtmlButton)sender).Attributes["data-id"]);

                //Tesina tesina = cxt.Personas.OfType<Tesina>().FirstOrDefault(pp => pp.persona_id == id_tesina);
                //if (tesina != null)
                //{
                //    lbl_ver_tesina_dni.Text = tesina.persona_dni;
                //    lbl_ver_tesina_domicilio.Text = tesina.persona_domicilio;
                //    lbl_ver_tesina_email.Text = tesina.persona_email;
                //    lbl_ver_tesina_nomyap.Text = tesina.persona_nomyap;
                //    lbl_ver_tesina_telefono.Text = tesina.persona_telefono;
                //    lbl_ver_tesina_calificacion.Text = tesina.tesina_calificacion.ToString();
                //    lbl_ver_tesina_usuario.Text = tesina.persona_usuario;

                //    List<Tesis> tesinas = cxt.Tesinas.Where(tt => tt.tesina_persona_id == tesina.persona_id && tt.tesis_fecha_cierre == null).ToList();

                //    var tesis_para_grilla = (from t in tesinas
                //                             select new
                //                             {
                //                                 tesis_id = t.tesis_id,
                //                                 tesis_tema = t.tesis_tema,
                //                                 tesis_palabras_clave = t.tesis_palabras_clave,
                //                                 tesis_plan_fch_presentacion = t.tesis_plan_fch_presentacion,
                //                                 tesista_nombre = t.Tesista.persona_nomyap,
                //                                 tesis_estado = t.Estado.estado_estado
                //                             }).ToList();

                //    gv_tesinas.DataSource = tesis_para_grilla;
                //    gv_tesinas.DataBind();

                //    string script = "<script language=\"javascript\"  type=\"text/javascript\">$(document).ready(function() { $('#panel_ver_tesina').modal('show')});</script>";
                //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "ShowPopUp", script, false);
                //}
                //else
                //{

                //}
            }
        }

        protected void cv_dni_duplicado_ServerValidate(object source, ServerValidateEventArgs args)
        {
            //Tesina tesina;
            //int id_tesina = Convert.ToInt32(hidden_id_tesina_editar.Value);

            //using (HabProfDBContainer cxt = new HabProfDBContainer())
            //{
            //    if (id_tesina != 0)
            //    {
            //        //esta editando: controlo que no se repita el DNI en otro tesina
            //        tesina = cxt.Personas.OfType<Tesina>().FirstOrDefault(pp => pp.persona_dni == tb_dni_tesina.Value && pp.persona_id != id_tesina);
            //    }
            //    else
            //    {
            //        //esta agregando: controlo que no se repita el DNI en ningun otro tesina
            //        tesina = cxt.Personas.OfType<Tesina>().FirstOrDefault(pp => pp.persona_dni == tb_dni_tesina.Value);
            //    }

            //}

            //args.IsValid = tesina == null;
        }

        protected void cv_usuario_duplicado_ServerValidate(object source, ServerValidateEventArgs args)
        {
            //Tesina tesina;
            //int id_tesina = Convert.ToInt32(hidden_id_tesina_editar.Value);

            //using (HabProfDBContainer cxt = new HabProfDBContainer())
            //{
            //    if (id_tesina != 0)
            //    {
            //        //esta editando: controlo que no se repita el DNI en otro tesina
            //        tesina = cxt.Personas.OfType<Tesina>().FirstOrDefault(pp => pp.persona_usuario == tb_usuario.Value && pp.persona_id != id_tesina);
            //    }
            //    else
            //    {
            //        //esta agregando: controlo que no se repita el DNI en ningun otro tesina
            //        tesina = cxt.Personas.OfType<Tesina>().FirstOrDefault(pp => pp.persona_usuario == tb_usuario.Value);
            //    }

            //}

            //args.IsValid = tesina == null;
        }

        protected void cv_contraseña_ServerValidate(object source, ServerValidateEventArgs args)
        {
            //args.IsValid = (chk_cambiar_clave.Checked && tb_contraseña.Value.Length > 0) || !chk_cambiar_clave.Checked;
        }

        protected void chk_cambiar_clave_CheckedChanged(object sender, EventArgs e)
        {
            //tb_contraseña.Visible = chk_cambiar_clave.Checked;
            //string script = "<script language=\"javascript\"  type=\"text/javascript\">$(document).ready(function() { $('#agregar_tesina').modal('show')});</script>";
            //ScriptManager.RegisterStartupScript(Page, this.GetType(), "ShowPopUp", script, false);
        }

        protected void btn_tesis_cambiar_estado_ServerClick(object sender, EventArgs e)
        {

        }

        protected void btn_tesis_ver_historial_ServerClick(object sender, EventArgs e)
        {

        }

        protected void cv_tesis_tema_ServerValidate(object source, ServerValidateEventArgs args)
        {

        }

        protected void cv_tesis_palabras_clave_ServerValidate(object source, ServerValidateEventArgs args)
        {

        }

        protected void btn_aceptar_archivo_ServerClick(object sender, EventArgs e)
        {

        }
    }
}