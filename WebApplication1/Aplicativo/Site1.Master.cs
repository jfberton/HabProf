using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace WebApplication1.Aplicativo
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                RefrescarEstilo();
            }
        }

        public void RefrescarEstilo()
        {
            Administrador persona = Session["UsuarioLogueado"] as Administrador;
            string estilo = "../Content/bootstrap-theme-";

            //por mas que la formula sea la misma para todos los casos me aseguro de que el estilo guardado exista y no sea cualquier texto
            switch (persona.estilo)
            {
                case "Cerulean": estilo = estilo + persona.estilo + ".min.css"; break;
                case "Cosmo": estilo = estilo + persona.estilo + ".min.css"; break;
                case "Cyborg": estilo = estilo + persona.estilo + ".min.css"; break;
                case "Darkly": estilo = estilo + persona.estilo + ".min.css"; break;
                case "Flatly": estilo = estilo + persona.estilo + ".min.css"; break;
                case "Journal": estilo = estilo + persona.estilo + ".min.css"; break;
                case "Lumen": estilo = estilo + persona.estilo + ".min.css"; break;
                case "Paper": estilo = estilo + persona.estilo + ".min.css"; break;
                case "Readable": estilo = estilo + persona.estilo + ".min.css"; break;
                case "Sandstone": estilo = estilo + persona.estilo + ".min.css"; break;
                case "Simplex": estilo = estilo + persona.estilo + ".min.css"; break;
                case "Slate": estilo = estilo + persona.estilo + ".min.css"; break;
                case "Spacelab": estilo = estilo + persona.estilo + ".min.css"; break;
                case "Superhero": estilo = estilo + persona.estilo + ".min.css"; break;
                case "United": estilo = estilo + persona.estilo + ".min.css"; break;
                case "Yeti": estilo = estilo + persona.estilo + ".min.css"; break;
                default: estilo = "../Content/bootstrap-theme-Sandstone.min.css"; break;
            }

            bootstrapStyle.Href = estilo;
        }
        
    }
}