using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using WebApplication1.Aplicativo.ControlesDeUsuario;

namespace WebApplication1.Aplicativo
{
    public partial class admin_tesis : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["Perfil"].ToString() != "Admin")
                {
                    MessageBox.Show(this, "Usted no tiene permiso para acceder a esta página", MessageBox.Tipo_MessageBox.Danger, "Acceso restringido", "../default.aspx");
                }

                ObtenerTesinas();
            }
        }

        private void ObtenerTesinas()
        {
            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                var tesinas = (from t in cxt.Tesinas
                               where t.tesis_fecha_cierre == null
                               select new
                               {
                                   tesis_id = t.tesis_id,
                                   tesista = t.Tesista.persona_nomyap,
                                   director = t.Director.persona_nomyap,
                                   tema = t.tesis_tema,
                                   estado = t.Estado.estado_estado
                               }
                               ).ToList();

                var tesinas_tema_recortado = (from t in tesinas
                                              select new
                                              {
                                                  tesis_id = t.tesis_id,
                                                  tesista = t.tesista,
                                                  director = t.director,
                                                  tema = t.tema.Length > 20 ? t.tema.Substring(0, 20) + "..." : t.tema,
                                                  tema_completo = t.tema,
                                                  estado = t.estado
                                              }).ToList();

                if (tesinas_tema_recortado.Count > 0)
                {
                    gv_tesinas.DataSource = tesinas_tema_recortado;
                    gv_tesinas.DataBind();
                    lbl_sin_tesinas.Visible = false;
                }
                else
                {
                    lbl_sin_tesinas.Visible = true;
                }
            }
        }

        protected void btn_aceptar_eliminacion_Click(object sender, EventArgs e)
        {
            //int id_tesina = Convert.ToInt32(id_item_por_eliminar.Value);

            //using (HabProfDBContainer cxt = new HabProfDBContainer())
            //{
            //    Tesina tesina = cxt.Personas.OfType<Tesina>().FirstOrDefault(pp => pp.persona_id == id_tesina);
            //    tesina.persona_fecha_baja = DateTime.Today;

            //    cxt.SaveChanges();
            //    MessageBox.Show(this, "Se ha eliminado correctamente al tesina " + tesina.persona_nomyap, MessageBox.Tipo_MessageBox.Success);
            //}

            //ObtenerTesinas();
        }

        protected void btn_ver_ServerClick(object sender, EventArgs e)
        {

        }

        protected void gv_tesinas_PreRender(object sender, EventArgs e)
        {
            if (gv_tesinas.Rows.Count > 0)
            {
                gv_tesinas.HeaderRow.TableSection = TableRowSection.TableHeader;
            }
        }

        protected void btn_editar_ServerClick(object sender, EventArgs e)
        {
            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                int id_tesina = Convert.ToInt32(((HtmlButton)sender).Attributes["data-id"]);

                Tesis tesina = cxt.Tesinas.FirstOrDefault(pp => pp.tesis_id == id_tesina);
                if (tesina != null)
                {
                    Session["Tesina"] = tesina;
                    Response.Redirect("~/Aplicativo/admin_tesina.aspx");
                }
            }
        }

        
        protected void btn_agregar_tesina_ServerClick(object sender, EventArgs e)
        {
            Session["Tesina"] = null;
            Response.Redirect("~/Aplicativo/admin_tesina.aspx");
        }
    }
}