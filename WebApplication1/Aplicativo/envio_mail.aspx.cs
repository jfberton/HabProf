using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Net;
using System.Net.Mail;
using WebApplication1.Aplicativo.ControlesDeUsuario;

namespace WebApplication1.Aplicativo
{
    public partial class envio_mail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void SendEmail(object sender, EventArgs e)
        {
            //string mailBodyhtml = "<p>some text here</p>";
            //var msg = new MailMessage("fede.berton@gmail.com", "fede.berton@outlook.com", "Prueba", mailBodyhtml);
            //msg.To.Add("atp.jfbertoncini@chaco.gov.ar");
            //msg.IsBodyHtml = true;
            //var smtpClient = new SmtpClient("smtp.gmail.com", 587);
            //smtpClient.UseDefaultCredentials = true;
            //smtpClient.Credentials = new NetworkCredential("fede.berton@gmail.com", "berton_mail");
            //smtpClient.EnableSsl = true;
            //smtpClient.Send(msg);

            //    this.Tipo_mail = tipo;
            //    this.Smtp_client = smtp_client;
            //    this.Smtp_puerto = smtp_port;
            //    this.Persona_nombre = nombre;
            //    this.Url_respuesta = url_respuesta;
            //    this.Credenciales_mail = credenciales_mail;
            //    this.Credenciales_contraseña = credenciales_contraseña;
            //    this.Destinatarios = destinatarios;
            //    this.Asunto = asunto;
            MiEmail mail = new Aplicativo.MiEmail()
            {
                Tipo_mail = MiEmail.tipo_mail.validacion,
                Smtp_client = "smtp.gmail.com",
                Smtp_puerto = 587,
                Persona_nombre = "Juan Perez",
                Url_respuesta = "http://google.com",
                Credenciales_mail = "fede.berton@gmail.com",
                Credenciales_contraseña = "berton_mail",
                Asunto = "Validacion",
                Destinatarios = new List<string>(new string[] { "atp.jfbertoncini@chaco.gov.ar", "fede.berton@gmail.com" })
            };

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
}