using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1.Aplicativo.Menues
{
    public partial class menu_admin : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Persona user = Session["UsuarioLogueado"] as Persona;
                lbl_usuario.Text = user.persona_nomyap;

                string perfil = Session["Perfil"].ToString();

                switch (perfil)
                {
                    case "Administrador":
                        li_admin_tesinas.Visible = true;
                        li_admin_directores.Visible = true;
                        li_admin_jueces.Visible = true;
                        li_admin_tesistas.Visible = true;
                        li_comprobar_tema.Visible = true;
                        break;
                    case "Director":
                        li_admin_directores.Visible = false;
                        li_admin_jueces.Visible = false;
                        li_admin_tesistas.Visible = false;
                        li_comprobar_tema.Visible = false;
                        li_admin_tesinas.Visible = true;
                        break;
                    default:
                        li_admin_tesinas.Visible = false;
                        li_admin_directores.Visible = false;
                        li_admin_jueces.Visible = false;
                        li_admin_tesistas.Visible = false;
                        li_comprobar_tema.Visible = false;
                        break;
                }
            }
        }

        protected void btn_salir_Click(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();
            Response.Redirect("~/Default.aspx");
        }
    }
}