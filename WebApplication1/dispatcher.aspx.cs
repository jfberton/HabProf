using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebApplication1.Aplicativo;

namespace WebApplication1
{
    public partial class dispatcher : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Redireccionar();

        }

        private void Redireccionar()
        {
            Persona user = Session["UsuarioLogueado"] as Persona;

            Response.Redirect("~/Aplicativo/admin_home.aspx");

            //switch (user.perfil)
            //{
            //    case perfil_usuario.Admin:
            //        Response.Redirect("~/Aplicativo/main_admin.aspx");
            //        break;
            //    case perfil_usuario.Jefe:
            //        Response.Redirect("~/Aplicativo/main_admin.aspx");
            //        break;
            //    case perfil_usuario.Supervisor:
            //        break;
            //    case perfil_usuario.Usuario:
            //        Response.Redirect("~/Aplicativo/main_usuario.aspx");
            //        break;
            //    case perfil_usuario.Sistema:
            //        Response.Redirect("~/Aplicativo/main_sistema.aspx");
            //        break;
            //    case perfil_usuario.Seleccionar:
            //        break;
            //    default:
            //        break;
            //}
        }
    }
}