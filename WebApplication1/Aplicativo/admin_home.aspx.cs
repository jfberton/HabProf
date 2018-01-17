using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebApplication1.Aplicativo.ControlesDeUsuario;

namespace WebApplication1.Aplicativo
{
    public partial class admin_home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                using (HabProfDBContainer cxt = new HabProfDBContainer())
                {
                    //Persona p = Session["UsuarioLogueado"] as Persona;
                    //Administrador admin = cxt.Administradores.FirstOrDefault(pp => pp.Persona.persona_id == p.persona_id);
                    //if (admin == null)
                    //{
                    //    MessageBox.Show(this, "Usted no tiene permiso para acceder a esta página", MessageBox.Tipo_MessageBox.Danger, "Atención", "~/default.aspx");
                    //}

                }
            }
        }
    }
}