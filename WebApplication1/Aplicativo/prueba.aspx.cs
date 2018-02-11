using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebApplication1.Aplicativo.ControlesDeUsuario;

namespace WebApplication1.Aplicativo
{
    public partial class prueba : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_verificar_correos_Click(object sender, EventArgs e)
        {
            Automatizacion auto = new Aplicativo.Automatizacion();
            auto.Enviar_correos_notificacion_automatica();
        }
    }
}