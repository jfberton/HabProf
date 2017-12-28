using Encriptador;
using System;
using System.Collections.Generic;
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
            string clave = Encriptador.Cripto.Encriptar(form_password.Value);

            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                Administrador usr = cxt.Administradores.FirstOrDefault(pp => pp.usuario == usuario && pp.clave == clave);

                if (usr != null)
                {
                    Session["UsuarioLogueado"] = usr;
                    FormsAuthentication.RedirectFromLoginPage(usr.usuario, false);
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
                    Servidor_de_correo servidor = new Servidor_de_correo() { nombre = "Hotmail", smtp_server = "smtp.live.com", smtp_port = 25, enable_ssl = true };
                    Servidor_de_correo servidor1 = new Servidor_de_correo() { nombre = "Outlook", smtp_server = "smtp.live.com", smtp_port = 25, enable_ssl = true };
                    Servidor_de_correo servidor2 = new Servidor_de_correo() { nombre = "Live", smtp_server = "smtp.live.com", smtp_port = 25, enable_ssl = true };
                    cxt.Servidores.Add(servidor);
                    cxt.Servidores.Add(servidor1);
                    cxt.Servidores.Add(servidor2);

                    Licenciatura l = new Licenciatura() { nombre = "Licenciatura en Tecnología Educativa", descripcion = "Este Ciclo de Licenciatura se propone brindar una alternativa de formación de grado a aquellos profesores y/o técnicos superiores en áreas referidas en manejo de las tecnologías, interesados en Ia inserción de Ia tecnología educativa en los procesos de formación inicial y continua propios del sistema educativo. Asimismo, resulta una opción para cubrir los espacios de capacitación y actualización que se desarroIIan en las instituciones y organizaciones del sistema socio productivo, tanto de gestión pública como privada." , email="email.de.prueba", clave="clave.del.mail", Servidor= servidor};
                    cxt.Licenciaturas.Add(l);

                    Persona p = new Persona() { nomyap = "Administrador", dni = "00000000", email = "un.mail@un.servidor.com", domicilio = "un domicilio", telefono = "00000000" };
                    cxt.Personas.Add(p);

                    Administrador ad = new Administrador() { Persona = p, usuario = "admin", clave = Cripto.Encriptar("admin"), estilo = "Sandstone", Licenciatura = l };
                    cxt.Administradores.Add(ad);

                    cxt.SaveChanges();

                }
            }
        }
    }
}