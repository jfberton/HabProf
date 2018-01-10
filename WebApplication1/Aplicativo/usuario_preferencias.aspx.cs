using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using WebApplication1.Aplicativo.ControlesDeUsuario;

namespace WebApplication1.Aplicativo
{
    public partial class usuario_preferencias : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Persona usuario = Session["UsuarioLogueado"] as Persona;
                lbl_email.Text = usuario.persona_email;
                if (usuario.persona_email_validado)
                {
                    lbl_validado.Text = "Validado";
                    lbl_correo_a_editar.Text = usuario.persona_email;
                    lbl_estado_mail_a_editar.Text = "validado";
                    p_validado_mail_editar.Attributes["class"] = "text-success";
                    lbl_validado.ForeColor = Color.DarkGreen;
                }
                else
                {
                    lbl_validado.Text = "Sin validar";
                    lbl_validado.ToolTip = "No va a poder recuperar la contraseña si no tiene validado su correo";
                    lbl_correo_a_editar.Text = usuario.persona_email;
                    p_validado_mail_editar.Attributes["class"] = "text-danger";
                    lbl_estado_mail_a_editar.Text = "sin validar";
                    lbl_validado.ForeColor = Color.DarkRed;
                }


            }
        }

        protected void changeStyleButton_Click(object sender, EventArgs e)
        {

            string estilo = ((LinkButton)sender).Text;
            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                Persona admin = Session["UsuarioLogueado"] as Persona;
                admin.persona_estilo = estilo;
                Persona admin_cxt = cxt.Personas.FirstOrDefault(pp => pp.persona_id == admin.persona_id);
                //actualizo el estilo 
                admin_cxt.persona_estilo = estilo;
                cxt.SaveChanges();
                //actualizo el usuario de la session
                Session["UsuarioLogueado"] = admin_cxt;
                ((Aplicativo.Site1)this.Master).RefrescarEstilo();
            }
        }

        protected void btn_cambiar_clave_Click(object sender, EventArgs e)
        {
            Persona admin = Session["UsuarioLogueado"] as Persona;
            string clave_actual_db = Cripto.Desencriptar(admin.persona_clave);
            string clave_actual_ingresada = tb_clave_actual.Text;
            string clave_nueva = tb_clave_nueva.Text;
            string clave_nueva_repite = tb_clave_nueva_repite.Text;


            if (clave_actual_db != clave_actual_ingresada || clave_nueva != clave_nueva_repite)
            {
                MessageBox.Show(this, "Las claves ingresadas no coinciden", MessageBox.Tipo_MessageBox.Danger);
            }
            else
            {
                using (HabProfDBContainer cxt = new Aplicativo.HabProfDBContainer())
                {
                    Persona admin_cxt = cxt.Personas.FirstOrDefault(pp => pp.persona_id == admin.persona_id);
                    admin_cxt.persona_clave = Cripto.Encriptar(clave_nueva);
                    cxt.SaveChanges();
                }
                MessageBox.Show(this, "La clave se actualizó correctamente.-", MessageBox.Tipo_MessageBox.Success);
            }
        }

        protected void btn_guardar_nuevo_mail_ServerClick(object sender, EventArgs e)
        {
            this.Validate("email");
            if (this.IsValid)
            {
                Persona p = Session["UsuarioLogueado"] as Persona;
                using (HabProfDBContainer cxt = new HabProfDBContainer())
                {
                    Persona p_cxt = cxt.Personas.FirstOrDefault(pp => pp.persona_id == p.persona_id);
                    p_cxt.persona_email = tb_email.Value;
                    p_cxt.persona_email_validado = false;
                    cxt.SaveChanges();
                    Enviar_validacion();
                }
            }
            else
            {
                string script = "<script language=\"javascript\"  type=\"text/javascript\">$(document).ready(function() { $('#modificar_mail').modal('show')});</script>";
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "ShowPopUp", script, false);
            }
        }

        private void Enviar_validacion()
        {
            Persona p = Session["UsuarioLogueado"] as Persona;
            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                Persona p_cxt = cxt.Personas.FirstOrDefault(pp => pp.persona_id == p.persona_id);

                Envio_mail registro_envio_mail = new Envio_mail()
                {
                    persona_id = p_cxt.persona_id,
                    envio_fecha_hora = DateTime.Now,
                    envio_email_destino = p_cxt.persona_email, //de haber mas de un destinatario separar por coma Ej: mail + "," + mail2 + "," + mail3
                    envio_respuesta_clave = Guid.NewGuid().ToString(),
                    envio_tipo = MiEmail.tipo_mail.validacion.ToString()
                };

                cxt.Envio_mails.Add(registro_envio_mail);
                cxt.SaveChanges();

                MiEmail mail = new MiEmail(registro_envio_mail);

                if (mail.Enviar_mail())
                {
                    MessageBox.Show(this, "El correo se envió satisfactoriamente", MessageBox.Tipo_MessageBox.Success);
                }
                else
                {
                    MessageBox.Show(this, "Ocurrio un error en el envio del correo", MessageBox.Tipo_MessageBox.Warning, "Oops!!");
                }
            }
        }

        protected void lnk_enviar_validacion_Click(object sender, EventArgs e)
        {
            Enviar_validacion();
        }
    }
}