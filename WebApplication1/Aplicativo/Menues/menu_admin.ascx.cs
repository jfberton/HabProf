﻿using System;
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
                using (HabProfDBContainer cxt = new HabProfDBContainer())
                {
                    Administrador admin = Session["UsuarioLogueado"] as Administrador;
                    lbl_usuario.Text = cxt.Administradores.FirstOrDefault(aa => aa.administrador_id == admin.administrador_id).Persona.persona_nomyap;

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