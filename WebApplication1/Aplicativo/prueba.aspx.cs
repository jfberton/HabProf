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

        protected void btn_buscar_en_el_texto_Click(object sender, EventArgs e)
        {
            Buscar buscar = new Buscar(tb_palabras_buscadas.Value, tb_texto_descripcion.Value);
            if (buscar.Hubo_coincidencia)
            {
                p_resultado.InnerHtml = buscar.Texto_con_palabras_resaltadas;
                MessageBox.Show(this, "Se encontraron coincidencias", MessageBox.Tipo_MessageBox.Success);
            }
            else
            {
                MessageBox.Show(this, "No se encontraron coincidencias", MessageBox.Tipo_MessageBox.Danger);
            }
        }
    }
}