using Encriptador;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebApplication1.Aplicativo.ControlesDeUsuario;

namespace WebApplication1.Aplicativo
{
    public partial class usuario_preferencias : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void changeStyleButton_Click(object sender, EventArgs e)
        {

            string estilo = ((Button)sender).Text;
            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                Persona admin = Session["UsuarioLogueado"] as Persona;
                admin.persona_estilo = estilo;
                Persona admin_cxt = cxt.Personas.FirstOrDefault(pp => pp.persona_id == admin.persona_id);
                //actualizo el estilo 
                admin_cxt.persona_estilo = estilo;
                cxt.SaveChanges();
                //actualizo el usuario de la session
                Session["UsuarioLogueado"] = admin_cxt;
                ((Aplicativo.Site1)this.Master).RefrescarEstilo();
            }
        }

        protected void btn_cambiar_clave_Click(object sender, EventArgs e)
        {
            Persona admin = Session["UsuarioLogueado"] as Persona;
            string clave_actual_db = Cripto.Desencriptar(admin.persona_clave);
            string clave_actual_ingresada = tb_clave_actual.Text;
            string clave_nueva = tb_clave_nueva.Text;
            string clave_nueva_repite = tb_clave_nueva_repite.Text;


            if (clave_actual_db != clave_actual_ingresada || clave_nueva != clave_nueva_repite)
            {
                MessageBox.Show(this, "Las claves ingresadas no coinciden", MessageBox.Tipo_MessageBox.Danger);
            }
            else
            {
                using (HabProfDBContainer cxt = new Aplicativo.HabProfDBContainer())
                {
                    Persona admin_cxt = cxt.Personas.FirstOrDefault(pp => pp.persona_id == admin.persona_id);
                    admin_cxt.persona_clave = Cripto.Encriptar(clave_nueva);
                    cxt.SaveChanges();
                }
                MessageBox.Show(this, "La clave se actualizó correctamente.-", MessageBox.Tipo_MessageBox.Success);
            }
        }
    }
}