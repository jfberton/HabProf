using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebApplication1.Aplicativo;
using WebApplication1.Aplicativo.ControlesDeUsuario;

namespace WebApplication1
{
    public partial class _default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                form_username.Focus();
            }
        }

        protected void btn_ingresar_ServerClick(object sender, EventArgs e)
        {
            RevisarCrearPrimerosDatos();

            string usuario = form_username.Value;
            string clave = Cripto.Encriptar(form_password.Value);

            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                Persona usr = cxt.Personas.FirstOrDefault(pp => pp.persona_usuario == usuario && pp.persona_clave == clave);
                Administrador admin = cxt.Personas.OfType<Administrador>().FirstOrDefault(pp => pp.persona_usuario == usuario && pp.persona_clave == clave);
                Director dire = cxt.Personas.OfType<Director>().FirstOrDefault(pp => pp.persona_usuario == usuario && pp.persona_clave == clave);

                if (usr != null)
                {
                    Session["UsuarioLogueado"] = usr;
                    if (admin != null && dire != null)
                    {
                        string script = "<script language=\"javascript\"  type=\"text/javascript\">$(document).ready(function() { $('#ver_perfil').modal('show')});</script>";
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "ShowPopUp", script, false);
                    }
                    else
                    {
                        if (admin != null)
                        {
                            Session["Perfil"] = "Admin";
                            FormsAuthentication.RedirectFromLoginPage(usr.persona_usuario, false);
                        }

                        if (dire != null)
                        {
                            Session["Perfil"] = "Dire";
                            FormsAuthentication.RedirectFromLoginPage(usr.persona_usuario, false);
                        }
                    }

                }
                else
                {
                    MessageBox.Show(this, "Usuario o contraseña incorrecto", MessageBox.Tipo_MessageBox.Info);
                }

            }
        }

        private void RevisarCrearPrimerosDatos()
        {
            using (HabProfDBContainer cxt = new Aplicativo.HabProfDBContainer())
            {
                if (cxt.Personas.Count() == 0)
                {
                    //https://www.aspsnippets.com/Articles/How-to-send-email-with-attachment-in-ASPNet.aspx
                    Servidor_de_correo servidor0 = new Servidor_de_correo() { servidor_nombre = "Hotmail", servidor_smtp_host = "smtp.live.com", servidor_smtp_port = 25, servidor_enable_ssl = true };
                    Servidor_de_correo servidor1 = new Servidor_de_correo() { servidor_nombre = "Outlook", servidor_smtp_host = "smtp.live.com", servidor_smtp_port = 25, servidor_enable_ssl = true };
                    Servidor_de_correo servidor2 = new Servidor_de_correo() { servidor_nombre = "Live", servidor_smtp_host = "smtp.live.com", servidor_smtp_port = 25, servidor_enable_ssl = true };
                    Servidor_de_correo servidor3 = new Servidor_de_correo() { servidor_nombre = "Gmail", servidor_smtp_host = "smtp.gmail.com", servidor_smtp_port = 587, servidor_enable_ssl = true };
                    Servidor_de_correo servidor4 = new Servidor_de_correo() { servidor_nombre = "Yahoo!", servidor_smtp_host = "smtp.yahoo.com", servidor_smtp_port = 465, servidor_enable_ssl = true };
                    cxt.Servidores.Add(servidor0);
                    cxt.Servidores.Add(servidor1);
                    cxt.Servidores.Add(servidor2);
                    cxt.Servidores.Add(servidor3);
                    cxt.Servidores.Add(servidor4);

                    Licenciatura l = new Licenciatura() { licenciatura_nombre = "Licenciatura en Tecnología Educativa", licenciatura_descripcion = "Este Ciclo de Licenciatura se propone brindar una alternativa de formación de grado a aquellos profesores y/o técnicos superiores en áreas referidas en manejo de las tecnologías, interesados en Ia inserción de Ia tecnología educativa en los procesos de formación inicial y continua propios del sistema educativo. Asimismo, resulta una opción para cubrir los espacios de capacitación y actualización que se desarroIIan en las instituciones y organizaciones del sistema socio productivo, tanto de gestión pública como privada.", licenciatura_email = "fede.berton@gmail.com", licenciatura_email_clave = "berton_mail", Servidor = servidor3 };
                    cxt.Licenciaturas.Add(l);

                    Administrador admin = new Administrador()
                    {
                        Licenciatura = l,
                        persona_nomyap = "Administrador",
                        persona_dni = "00000000",
                        persona_email = "un.mail@un.servidor.com",
                        persona_email_validado = false,
                        persona_domicilio = "un domicilio",
                        persona_telefono = "00000000",
                        persona_usuario = "admin",
                        persona_clave = Cripto.Encriptar("admin"),
                        persona_estilo = "Sandstone"
                    };
                    cxt.Personas.Add(admin);

                    Director dire = new Director()
                    {
                        Licenciatura = l,
                        persona_nomyap = "director",
                        persona_dni = "00000000",
                        persona_email = "un.mail@un.servidor.com",
                        persona_email_validado = false,
                        persona_domicilio = "un domicilio",
                        persona_telefono = "00000000",
                        persona_usuario = "dire",
                        persona_clave = Cripto.Encriptar("dire"),
                        persona_estilo = "Sandstone",
                        director_calificacion = 0
                    };
                    cxt.Personas.Add(dire);

                    cxt.SaveChanges();

                }
            }
        }

        protected void btn_recuperar_clave_ServerClick(object sender, EventArgs e)
        {

            string usuario_o_contraseña = tb_recuperar_clave.Value;

            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                Persona p_cxt = cxt.Personas.FirstOrDefault(pp => pp.persona_usuario == usuario_o_contraseña || pp.persona_email == usuario_o_contraseña);

                if (p_cxt != null && p_cxt.persona_email_validado)
                {
                    Envio_mail registro_envio_mail = new Envio_mail()
                    {
                        persona_id = p_cxt.persona_id,
                        envio_fecha_hora = DateTime.Now,
                        envio_email_destino = p_cxt.persona_email, //de haber mas de un destinatario separar por coma Ej: mail + "," + mail2 + "," + mail3
                        envio_respuesta_clave = Guid.NewGuid().ToString(),
                        envio_tipo = MiEmail.tipo_mail.recupero_contraseña.ToString()
                    };

                    cxt.Envio_mails.Add(registro_envio_mail);
                    cxt.SaveChanges();

                    MiEmail mail = new MiEmail(registro_envio_mail);

                    if (mail.Enviar_mail())
                    {
                        MessageBox.Show(this, "Se envió un correo con las instrucciones para recuperar su contraseña", MessageBox.Tipo_MessageBox.Success);
                    }
                    else
                    {
                        MessageBox.Show(this, "Ocurrió un error en el envio del correo", MessageBox.Tipo_MessageBox.Warning, "Oops!!");
                    }
                }
                else
                {
                    MessageBox.Show(this, "No existe el usuario o el correo no esta validado", MessageBox.Tipo_MessageBox.Danger, "Oops!!");
                }
            }
        }
    }
}