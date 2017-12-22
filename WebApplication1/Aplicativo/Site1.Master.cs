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
            Persona persona = Session["UsuarioLogueado"] as Persona;
            string estilo = "../Content/bootstrap-theme-";

            //por mas que la formula sea la misma para todos los casos me aseguro de que el estilo guardado exista y no sea cualquier texto
            switch (persona.Estilo)
            {
                case "Cerulean": estilo = estilo + persona.Estilo + ".min.css"; break;
                case "Cosmo": estilo = estilo + persona.Estilo + ".min.css"; break;
                case "Cyborg": estilo = estilo + persona.Estilo + ".min.css"; break;
                case "Darkly": estilo = estilo + persona.Estilo + ".min.css"; break;
                case "Flatly": estilo = estilo + persona.Estilo + ".min.css"; break;
                case "Journal": estilo = estilo + persona.Estilo + ".min.css"; break;
                case "Lumen": estilo = estilo + persona.Estilo + ".min.css"; break;
                case "Paper": estilo = estilo + persona.Estilo + ".min.css"; break;
                case "Readable": estilo = estilo + persona.Estilo + ".min.css"; break;
                case "Sandstone": estilo = estilo + persona.Estilo + ".min.css"; break;
                case "Simplex": estilo = estilo + persona.Estilo + ".min.css"; break;
                case "Slate": estilo = estilo + persona.Estilo + ".min.css"; break;
                case "Spacelab": estilo = estilo + persona.Estilo + ".min.css"; break;
                case "Superhero": estilo = estilo + persona.Estilo + ".min.css"; break;
                case "United": estilo = estilo + persona.Estilo + ".min.css"; break;
                case "Yeti": estilo = estilo + persona.Estilo + ".min.css"; break;
                default: estilo = "../Content/bootstrap-theme-Cosmo.min.css"; break;
            }

            bootstrapStyle.Href = estilo;
        }
        
    }
}