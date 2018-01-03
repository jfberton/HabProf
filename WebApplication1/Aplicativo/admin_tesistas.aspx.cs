using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1.Aplicativo
{
    public partial class admin_tesistas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Persona per = Session["UsuarioLogueado"] as Persona;
                using (HabProfDBContainer cxt = new HabProfDBContainer())
                {
                    
                    //verifico que el usuario logueado sea administrador, en caso contrario lo mando al inicio ya que no deberia estar aca
                    //Administrador admin = cxt.Personas.FirstOrDefault(aa => aa.persona_id == per.persona_id);
                }
            }
        }

        protected void btn_aceptar_eliminacion_Click(object sender, EventArgs e)
        {

        }

        protected void btn_ver_ServerClick(object sender, EventArgs e)
        {

        }

        protected void gv_tesistas_PreRender(object sender, EventArgs e)
        {
            if (gv_tesistas.Rows.Count > 0)
            {
                gv_tesistas.HeaderRow.TableSection = TableRowSection.TableHeader;
            }

            //if (gv_areas_view.Rows.Count > 0)
            //{
            //    gv_areas_view.HeaderRow.TableSection = TableRowSection.TableHeader;
            //}

            //if (gv_empleado.Rows.Count > 0)
            //{
            //    gv_empleado.HeaderRow.TableSection = TableRowSection.TableHeader;
            //}
        }

        protected void btn_guardar_ServerClick(object sender, EventArgs e)
        {

        }
        
    }
}