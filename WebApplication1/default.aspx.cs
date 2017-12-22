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

        }

        protected void btn_ingresar_ServerClick(object sender, EventArgs e)
        {
            string usuario = form_username.Value;
            string clave = Encriptador.Cripto.Encriptar(form_password.Value);

            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                Persona persona = cxt.Personas.FirstOrDefault(pp => pp.Usuario == usuario && pp.Clave == clave);

                if (persona != null)
                {
                    Session["UsuarioLogueado"] = persona;
                    FormsAuthentication.RedirectFromLoginPage(persona.Usuario, false);
                }
                else
                {
                    MessageBox.Show(this, "Usuario o contraseña incorrecto", MessageBox.Tipo_MessageBox.Info);
                }

            }
        }
    }
}