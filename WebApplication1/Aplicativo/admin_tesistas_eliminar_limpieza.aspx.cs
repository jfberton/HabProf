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
    public partial class admin_tesistas_eliminar_limpieza : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["Perfil"].ToString() != "Administrador")
                {
                    MessageBox.Show(this, "Usted no tiene permiso para acceder a esta página", MessageBox.Tipo_MessageBox.Danger, "Acceso restringido", "../default.aspx");
                }

                ObtenerTesistas();
            }
        }

        private void ObtenerTesistas()
        {
            using (HabProfDBContainer cxt = new Aplicativo.HabProfDBContainer())
            {

                Estado_tesina et_vencida = cxt.Estados_tesinas.FirstOrDefault(eett => eett.estado_tesina_estado == "Vencida");
                Estado_tesina et_lista = cxt.Estados_tesinas.FirstOrDefault(eett => eett.estado_tesina_estado == "Lista para presentar");
                Estado_tesina et_aprobada = cxt.Estados_tesinas.FirstOrDefault(eett => eett.estado_tesina_estado == "Aprobada");
                Estado_tesina et_desaprobada = cxt.Estados_tesinas.FirstOrDefault(eett => eett.estado_tesina_estado == "Desaprobada");

                List<Tesina> tesinas = cxt.Tesinas.Where(tt =>
                                                            tt.estado_tesis_id != et_lista.estado_tesina_id &&
                                                            tt.estado_tesis_id != et_aprobada.estado_tesina_id &&
                                                            tt.estado_tesis_id != et_desaprobada.estado_tesina_id
                                                            ).ToList();

                var tesistas_con_tesinas_de_mas_de_dos_años_de_antiguedad = (from tesina in tesinas
                                                                             where
                                                                                tesina.Historial_estados.Min(he => he.historial_tesina_fecha) <= DateTime.Today.AddYears(-2)
                                                                             select tesina.Tesista).ToList();

                var tesistas = (
                       from t in tesistas_con_tesinas_de_mas_de_dos_años_de_antiguedad
                       where t.tesista_baja_definitiva == null
                       select new
                       {
                           tesista_id = t.tesista_id,
                           persona_nomyap = t.Persona.persona_nomyap,
                           persona_dni = t.Persona.persona_dni,
                           persona_email = t.Persona.persona_email,
                           tesista_legajo = t.tesista_legajo,
                           tesista_sede = t.tesista_sede,
                           fecha_baja = t.tesista_fecha_baja
                       }).ToList();

                var tesistas_estado_activo_inactivo = (from t in tesistas
                                                       select new
                                                       {
                                                           tesista_id = t.tesista_id,
                                                           persona_nomyap = t.persona_nomyap,
                                                           persona_dni = t.persona_dni,
                                                           persona_email = t.persona_email,
                                                           tesista_legajo = t.tesista_legajo,
                                                           tesista_sede = t.tesista_sede
                                                       }).OrderBy(t => t.persona_nomyap).ToList();

                if (tesistas.Count() > 0)
                {
                    gv_tesistas.DataSource = tesistas_estado_activo_inactivo;
                    gv_tesistas.DataBind();
                    lbl_sin_tesistas.Visible = false;
                }
                else
                {
                    lbl_sin_tesistas.Visible = true;
                    gv_tesistas.DataSource = null;
                    gv_tesistas.DataBind();
                }

            }
        }

        protected void btn_aceptar_eliminacion_Click(object sender, EventArgs e)
        {
            int id_tesista = Convert.ToInt32(id_item_por_eliminar.Value);

            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                try
                {
                    Tesista tesista = cxt.Tesistas.FirstOrDefault(pp => pp.tesista_id == id_tesista);

                    tesista.tesista_baja_definitiva = DateTime.Today;

                    cxt.SaveChanges();
                }
                catch (System.Data.Entity.Validation.DbEntityValidationException dbEx)
                {
                    Exception raise = dbEx;
                    foreach (var validationErrors in dbEx.EntityValidationErrors)
                    {
                        foreach (var validationError in validationErrors.ValidationErrors)
                        {
                            string message = string.Format("{0}:{1}",
                                validationErrors.Entry.Entity.ToString(),
                                validationError.ErrorMessage);
                            // raise a new exception nesting
                            // the current instance as InnerException
                            raise = new InvalidOperationException(message, raise);
                        }
                    }

                    MessageBox.Show(this, raise.Message, MessageBox.Tipo_MessageBox.Danger, "Ups! ocurrio un error al guardar los cambios");
                }

                MessageBox.Show(this, "Se ha eliminado el tesista", MessageBox.Tipo_MessageBox.Success);
            }

            ObtenerTesistas();
        }

        protected void gv_tesistas_PreRender(object sender, EventArgs e)
        {
            if (gv_tesistas.Rows.Count > 0)
            {
                gv_tesistas.HeaderRow.TableSection = TableRowSection.TableHeader;
            }
        }

        protected void btn_ver_ServerClick1(object sender, EventArgs e)
        {
            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {

                int id_tesista = Convert.ToInt32(((HtmlButton)sender).Attributes["data-id"]);

                Tesista tesista = cxt.Tesistas.FirstOrDefault(pp => pp.tesista_id == id_tesista);
                if (tesista != null)
                {
                    lbl_sin_tesina.Visible = false;
                    lbl_ver_tesista_dni.Text = tesista.Persona.persona_dni.ToString();
                    lbl_ver_tesista_domicilio.Text = tesista.Persona.persona_domicilio;
                    lbl_ver_tesista_email.Text = tesista.Persona.persona_email;
                    lbl_ver_tesista_legajo.Text = tesista.tesista_legajo;
                    lbl_ver_tesista_nomyap.Text = tesista.Persona.persona_nomyap;
                    lbl_ver_tesista_sede.Text = tesista.tesista_sede;
                    lbl_ver_tesista_telefono.Text = tesista.Persona.persona_telefono;

                    var tesinas = (from t in tesista.Tesina select t).ToList();
                    var tesinas_para_grilla = (from t in tesinas
                                               select new
                                               {
                                                   tesina_tema = t.tesina_tema,
                                                   tesina_director = t.Director.Persona.persona_nomyap,
                                                   tesina_tesista = t.Tesista.Persona.persona_nomyap,
                                                   tesina_codirector = t.Codirector == null ? "-" : t.Codirector.Persona.persona_nomyap,
                                                   tesina_nota = t.tesina_calificacion,
                                                   tesina_nota_director = t.tesina_calificacion_director,
                                                   tesina_nota_codirector = t.tesina_calificacion_codirector == null ? "-" : t.tesina_calificacion_codirector.ToString()
                                               }).ToList();

                    if (tesinas_para_grilla.Count > 0)
                    {
                        gv_tesina.DataSource = tesinas_para_grilla;
                        gv_tesina.DataBind();
                    }
                    else
                    {
                        gv_tesina.DataSource = null;
                        gv_tesina.DataBind();
                    }

                    string script = "<script language=\"javascript\"  type=\"text/javascript\">$(document).ready(function() { $('#panel_ver_tesista').modal('show')});</script>";
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "ShowPopUp", script, false);
                }
            }
        }

        protected void gv_tesina_PreRender(object sender, EventArgs e)
        {
            if (gv_tesina.Rows.Count > 0)
            {
                gv_tesina.HeaderRow.TableSection = TableRowSection.TableHeader;
            }
        }
    }
}