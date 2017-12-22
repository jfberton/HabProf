using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1.Aplicativo
{
    public partial class Prueba : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void changeStyleButton_Click(object sender, EventArgs e)
        {

            string estilo = ((Button)sender).Text;
            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                Persona persona = Session["UsuarioLogueado"] as Persona;
                persona.Estilo = estilo;
                Persona persona_cxt = cxt.Personas.FirstOrDefault(pp => pp.PersonaId == persona.PersonaId);
                //actualizo el estilo 
                persona_cxt.Estilo = estilo;
                cxt.SaveChanges();
                //actualizo el usuario de la session
                Session["UsuarioLogueado"] = persona_cxt;
                ((Aplicativo.Site1)this.Master).RefrescarEstilo();
            }
        }
    }
}