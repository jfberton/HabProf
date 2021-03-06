﻿using System;
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
            string perfil = Session["Perfil"].ToString();

            switch (perfil)
            {
                case "Administrador":
                    Response.Redirect("~/Aplicativo/admin_home.aspx");
                    break;
                case "Director":
                    Response.Redirect("~/Aplicativo/admin_tesinas.aspx");
                    break;
                case "Tesista":
                    Response.Redirect("~/Aplicativo/admin_tesinas.aspx");
                    break;
                default:
                    break;
            }
        }
    }
}