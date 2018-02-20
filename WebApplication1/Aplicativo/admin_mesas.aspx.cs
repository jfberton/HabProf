using Microsoft.Reporting.WebForms;
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
    public partial class admin_mesas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["Perfil"].ToString() != "Administrador")
                {
                    MessageBox.Show(this, "Usted no tiene permiso para acceder a esta página", MessageBox.Tipo_MessageBox.Danger, "Acceso restringido", "../default.aspx");
                }

                ObtenerMesas();
            }
        }

        private void ObtenerMesas()
        {
            using (HabProfDBContainer cxt = new Aplicativo.HabProfDBContainer())
            {
                var mesas = (from m in cxt.Mesas
                             select new
                             {
                                 mesa_id = m.mesa_id,
                                 mesa_fecha = m.mesa_fecha,
                                 mesa_estado = m.mesa_estado,
                             }).ToList();

                var mesas_para_grilla = (from m in mesas
                                         select new
                                         {
                                             mesa_id = m.mesa_id,
                                             mesa_fecha = m.mesa_fecha,
                                             mesa_estado = m.mesa_estado,
                                             enabled_cerrar = m.mesa_estado == "Generada",
                                             enabled_editar = m.mesa_estado == "Generada"
                                         });

                if (mesas.Count() > 0)
                {
                    gv_mesas.DataSource = mesas_para_grilla;
                    gv_mesas.DataBind();
                    lbl_sin_mesas.Visible = false;
                }
                else
                {
                    lbl_sin_mesas.Visible = true;
                    gv_mesas.DataSource = null;
                    gv_mesas.DataBind();
                }

            }
        }

        protected void btn_aceptar_eliminacion_Click(object sender, EventArgs e)
        {
            int id_mesa = Convert.ToInt32(id_item_por_eliminar.Value);

            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                Mesa mesa = cxt.Mesas.FirstOrDefault(pp => pp.mesa_id == id_mesa);
                if (mesa.mesa_estado == "Generada")
                {
                    List<int> id_jueces = mesa.Jueces.Select(jj => jj.juez_id).ToList();
                    foreach (int id_juez in id_jueces)
                    {
                        Juez j = cxt.Jueces.FirstOrDefault(jj => jj.juez_id == id_juez);
                        mesa.Jueces.Remove(j);
                    }

                    List<int> id_tesinas = mesa.Tesinas.Select(tt => tt.tesina_id).ToList();
                    foreach (int id_tesina in id_tesinas)
                    {
                        Tesina t = cxt.Tesinas.FirstOrDefault(tt => tt.tesina_id == id_tesina);
                        mesa.Tesinas.Remove(t);
                    }

                    cxt.Mesas.Remove(mesa);
                    cxt.SaveChanges();
                    MessageBox.Show(this, "Se ha eliminado correctamente la mesa", MessageBox.Tipo_MessageBox.Success);
                }
                else
                {
                    MessageBox.Show(this, "No se puede eliminar una mesa que tenga estado distinta de Generada", MessageBox.Tipo_MessageBox.Danger);
                }

            }

            ObtenerMesas();
        }

        protected void gv_mesas_PreRender(object sender, EventArgs e)
        {
            if (gv_mesas.Rows.Count > 0)
            {
                gv_mesas.HeaderRow.TableSection = TableRowSection.TableHeader;
            }

            if (gv_jurados.Rows.Count > 0)
            {
                gv_jurados.HeaderRow.TableSection = TableRowSection.TableHeader;
            }

            if (gv_tesinas.Rows.Count > 0)
            {
                gv_tesinas.HeaderRow.TableSection = TableRowSection.TableHeader;
            }

            if (gv_cerrar_mesa_tesinas.Rows.Count > 0)
            {
                gv_cerrar_mesa_tesinas.HeaderRow.TableSection = TableRowSection.TableHeader;
            }
        }

        protected void btn_editar_ServerClick(object sender, EventArgs e)
        {
            Response.Redirect("~/Aplicativo/admin_mesa.aspx?m=" + ((Button)sender).CommandArgument);
        }

        protected void btn_ver_ServerClick(object sender, EventArgs e)
        {
            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                int id_mesa = Convert.ToInt32(((Button)sender).CommandArgument);
                Mesa mesa = cxt.Mesas.FirstOrDefault(pp => pp.mesa_id == id_mesa);
                if (mesa != null)
                {
                    lbl_estado.Text = mesa.mesa_estado;
                    lbl_ver_mesa_fecha.Text = mesa.mesa_fecha.ToShortDateString();

                    var jurados = (from j in mesa.Jueces
                                   select new
                                   {
                                       juez_persona_nomyap = j.Persona.persona_nomyap,
                                       juez_persona_dni = j.Persona.persona_dni,
                                       juez_persona_email = j.Persona.persona_email
                                   }).ToList();
                    var tesinas = (from t in mesa.Tesinas select t).ToList();
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
                                               });

                    gv_jurados.DataSource = jurados;
                    gv_jurados.DataBind();

                    gv_tesinas.DataSource = tesinas_para_grilla;
                    gv_tesinas.DataBind();

                    string script = "<script language=\"javascript\"  type=\"text/javascript\">$(document).ready(function() { $('#panel_ver_mesa').modal('show')});</script>";
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "ShowPopUp", script, false);
                }
            }
        }

        protected void btn_cerrar_mesa_ServerClick(object sender, EventArgs e)
        {
            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                int id_mesa = Convert.ToInt32(((Button)sender).CommandArgument);

                Mesa mesa = cxt.Mesas.FirstOrDefault(pp => pp.mesa_id == id_mesa);
                if (mesa != null && mesa.mesa_estado == "Generada")
                {
                    lbl_estado.Text = mesa.mesa_estado;
                    lbl_ver_mesa_fecha.Text = mesa.mesa_fecha.ToShortDateString();
                    hidden_cerrar_mesa_id.Value = mesa.mesa_id.ToString();

                    string jurados = string.Empty;
                    foreach (Juez jurado in mesa.Jueces)
                    {
                        jurados = jurados + jurado.Persona.persona_nomyap + ",";
                    }

                    lbl_cerrar_mesa_jurado.Text = jurados;

                    var tesinas = (from t in mesa.Tesinas
                                   select new
                                   {
                                       tesina_id = t.tesina_id,
                                       tesina_tema = t.tesina_tema,
                                       tesina_director = t.Director.Persona.persona_nomyap,
                                       tesina_tesista = t.Tesista.Persona.persona_nomyap,
                                       tesina_nota = t.tesina_calificacion,
                                       tesina_nota_director = t.tesina_calificacion_director
                                   });

                    gv_cerrar_mesa_tesinas.DataSource = tesinas;
                    gv_cerrar_mesa_tesinas.DataBind();

                    string script = "<script language=\"javascript\"  type=\"text/javascript\">$(document).ready(function() { $('#panel_cerrar_mesa').modal('show')});</script>";
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "ShowPopUp", script, false);
                }
                else
                {
                    MessageBox.Show(this, "Solo se pueden cerrar mesas en estado Generadas", MessageBox.Tipo_MessageBox.Danger);
                }
            }
        }

        protected void btn_agregar_mesa_ServerClick(object sender, EventArgs e)
        {
            Response.Redirect("~/Aplicativo/admin_mesa.aspx");
        }

        protected void btn_guardar_cerrar_mesa_Click(object sender, EventArgs e)
        {
            Validate("cerrar");
            if (IsValid)
            {
                using (HabProfDBContainer cxt = new HabProfDBContainer())
                {
                    int mesa_id = Convert.ToInt32(hidden_cerrar_mesa_id.Value);
                    Mesa mesa = cxt.Mesas.FirstOrDefault(mm => mm.mesa_id == mesa_id);
                    mesa.mesa_estado = "Cerrada";

                    foreach (GridViewRow fila in gv_cerrar_mesa_tesinas.Rows)
                    {
                        TextBox calificacion_tesina = ((TextBox)fila.Cells[3].Controls[1]);
                        TextBox calificacion_director_tesina = ((TextBox)fila.Cells[4].Controls[1]);
                        TextBox calificacion_codirector_tesina = ((TextBox)fila.Cells[5].Controls[1]);
                        //DropDownList estado_final_tesina = ((DropDownList)fila.Cells[5].Controls[1]);

                        int tesina_id = Convert.ToInt32(calificacion_tesina.AccessKey);

                        Tesina t = cxt.Tesinas.FirstOrDefault(tt => tt.tesina_id == tesina_id);
                        t.tesina_calificacion = Convert.ToInt16(calificacion_tesina.Text);
                        t.tesina_calificacion_director = Convert.ToInt16(calificacion_director_tesina.Text);
                        if (t.Codirector != null)
                        {
                            t.tesina_calificacion_codirector = Convert.ToInt16(calificacion_codirector_tesina.Text);
                        }
                        string estado_final = t.tesina_calificacion >= 6 ? "Aprobada" : "Desaprobada";
                        Estado_tesina et = cxt.Estados_tesinas.FirstOrDefault(eett => eett.estado_tesina_estado == estado_final);
                        t.estado_tesis_id = et.estado_tesina_id;

                        foreach (Juez juez in mesa.Jueces)
                        {
                            t.Jueces.Add(juez);
                        }

                        Historial_estado he = new Historial_estado()
                        {
                            estado_tesina_id = et.estado_tesina_id,
                            historial_tesina_descripcion = "Estado final de la evaluación",
                            historial_tesina_fecha = DateTime.Now,
                            tesina_id = t.tesina_id
                        };

                        cxt.Historial_estados.Add(he);
                    }



                    cxt.SaveChanges();

                    ObtenerMesas();

                    MessageBox.Show(this, "Se cerró correctamente la mesa.", MessageBox.Tipo_MessageBox.Success);
                }
            }
            else
            {
                string script = "<script language=\"javascript\"  type=\"text/javascript\">$(document).ready(function() { $('#panel_cerrar_mesa').modal('show')});</script>";
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "ShowPopUp", script, false);
            }


        }

        protected void btn_imprimir_Click(object sender, EventArgs e)
        {
            int id_mesa = Convert.ToInt32(((Button)sender).CommandArgument);

            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                Mesa mesa = cxt.Mesas.FirstOrDefault(pp => pp.mesa_id == id_mesa);

                Reportes.reporte_mesa ds = new Reportes.reporte_mesa();

                Reportes.reporte_mesa.t_mesaRow mr = ds.t_mesa.Newt_mesaRow();
                mr.mesa_fecha = mesa.mesa_fecha;
                mr.mesa_estado = mesa.mesa_estado;
                mr.mesa_licenciatura = mesa.Tesinas.First().Tesista.Persona.Licenciatura.licenciatura_nombre;
                ds.t_mesa.Addt_mesaRow(mr);

                foreach (Juez jurado in mesa.Jueces)
                {
                    Reportes.reporte_mesa.t_juradosRow jr = ds.t_jurados.Newt_juradosRow();
                    jr.jurado_dni = jurado.Persona.persona_dni.ToString();
                    jr.jurado_nombre = jurado.Persona.persona_nomyap;
                    jr.jurado_mail = jurado.Persona.persona_email;

                    ds.t_jurados.Addt_juradosRow(jr);
                }

                foreach (Tesina tesina in mesa.Tesinas)
                {
                    Reportes.reporte_mesa.t_tesinasRow tr = ds.t_tesinas.Newt_tesinasRow();
                    tr.tesina_titulo = tesina.tesina_tema;
                    tr.tesina_tesista = tesina.Tesista.Persona.persona_nomyap;
                    tr.tesina_director = tesina.Director.Persona.persona_nomyap;
                    tr.tesina_calificacion = tesina.tesina_calificacion.ToString();
                    tr.tesina_calificacion_director = tesina.tesina_calificacion_director.ToString();
                    tr.tesina_calificacion_codirector = tesina.Codirector != null ? tesina.tesina_calificacion_codirector.ToString() : "0";
                    tr.tesista_legajo = tesina.Tesista.tesista_legajo;
                    ds.t_tesinas.Addt_tesinasRow(tr);
                }

                Session["ds_mesa"] = ds;
            }

            RenderReport_mesa();
        }

        private void RenderReport_mesa()
        {
            Reportes.reporte_mesa ds = Session["ds_mesa"] as Reportes.reporte_mesa;

            ReportViewer viewer = new ReportViewer();
            viewer.ProcessingMode = ProcessingMode.Local;
            viewer.LocalReport.EnableExternalImages = true;

            viewer.LocalReport.ReportPath = Server.MapPath("~/Aplicativo/Reportes/reporte_mesa.rdlc");

            ReportDataSource mesa = new ReportDataSource("t_mesa", ds.t_mesa.Rows);
            ReportDataSource jurado = new ReportDataSource("t_jurados", ds.t_jurados.Rows);
            ReportDataSource tesinas = new ReportDataSource("t_tesinas", ds.t_tesinas.Rows);

            viewer.LocalReport.DataSources.Add(mesa);
            viewer.LocalReport.DataSources.Add(jurado);
            viewer.LocalReport.DataSources.Add(tesinas);

            Microsoft.Reporting.WebForms.Warning[] warnings = null;
            string[] streamids = null;
            string mimeType = null;
            string encoding = null;
            string extension = null;
            string deviceInfo = null;
            byte[] bytes = null;

            deviceInfo = "<DeviceInfo><SimplePageHeaders>True</SimplePageHeaders></DeviceInfo>";

            //Render the report
            bytes = viewer.LocalReport.Render("PDF", deviceInfo, out mimeType, out encoding, out extension, out streamids, out warnings);
            Session["Reporte"] = bytes;

            string script = "<script type='text/javascript'>window.open('Reportes/reportes.aspx');</script>";
            Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "VentanaPadre", script);
        }

        protected void btn_imprimir_directores_Click(object sender, EventArgs e)
        {
            int id_mesa = Convert.ToInt32(((Button)sender).CommandArgument);
            bool mesa_cerrada = false;
            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                Mesa mesa = cxt.Mesas.FirstOrDefault(pp => pp.mesa_id == id_mesa);

                if (mesa.mesa_estado == "Cerrada")
                {
                    Estado_tesina aprobada = cxt.Estados_tesinas.FirstOrDefault(eett => eett.estado_tesina_estado == "Aprobada");

                    Reportes.reporte_director ds = new Reportes.reporte_director();

                    foreach (Tesina tesina in mesa.Tesinas)
                    {
                        if (tesina.estado_tesis_id == aprobada.estado_tesina_id)
                        {
                            Reportes.reporte_director.DetalleRow md = ds.Detalle.NewDetalleRow();

                            md.director_nombre = tesina.Director.Persona.persona_nomyap;
                            md.director_dni = tesina.Director.Persona.persona_dni.ToString();
                            md.tema_tesina = tesina.tesina_tema;
                            md.tesina_calificacion = tesina.tesina_calificacion_director.ToString();
                            md.tesina_calificacion_letra = Calificacion_a_texto(tesina.tesina_calificacion ?? 0);
                            md.tesista_nombre = tesina.Tesista.Persona.persona_nomyap;
                            md.tesina_fecha_evaluacion = mesa.mesa_fecha.ToShortDateString();
                            md.licenciatura_nombre = tesina.Tesista.Persona.Licenciatura.licenciatura_nombre;
                            md.anteco = "";

                            ds.Detalle.Rows.Add(md);

                            if (tesina.Codirector != null)
                            {
                                Reportes.reporte_director.DetalleRow md_co = ds.Detalle.NewDetalleRow();

                                md_co.director_nombre = tesina.Codirector.Persona.persona_nomyap;
                                md_co.director_dni = tesina.Codirector.Persona.persona_dni.ToString();
                                md_co.tema_tesina = tesina.tesina_tema;
                                md_co.tesina_calificacion = tesina.tesina_calificacion_codirector.ToString();
                                md_co.tesina_calificacion_letra = Calificacion_a_texto(tesina.tesina_calificacion_codirector ?? 0);
                                md_co.tesista_nombre = tesina.Tesista.Persona.persona_nomyap;
                                md_co.tesina_fecha_evaluacion = mesa.mesa_fecha.ToShortDateString();
                                md_co.licenciatura_nombre = tesina.Tesista.Persona.Licenciatura.licenciatura_nombre;
                                md_co.anteco = "co-";

                                ds.Detalle.Rows.Add(md_co);
                            }
                        }
                    }

                    mesa_cerrada = true;
                    Session["ds_directores"] = ds;
                }
            }

            if (mesa_cerrada)
            {
                RenderReport_directores();
            }
            else
            {
                MessageBox.Show(this, "No se pueden imprimir los certificados mientras la mesa no este cerrada.", MessageBox.Tipo_MessageBox.Warning);
            }
        }

        private void RenderReport_directores()
        {
            Reportes.reporte_director ds = Session["ds_directores"] as Reportes.reporte_director;

            ReportViewer viewer = new ReportViewer();
            viewer.ProcessingMode = ProcessingMode.Local;
            viewer.LocalReport.EnableExternalImages = true;

            viewer.LocalReport.ReportPath = Server.MapPath("~/Aplicativo/Reportes/reporte_director.rdlc");

            ReportDataSource detalle = new ReportDataSource("Detalle", ds.Detalle.Rows);

            viewer.LocalReport.DataSources.Add(detalle);

            Microsoft.Reporting.WebForms.Warning[] warnings = null;
            string[] streamids = null;
            string mimeType = null;
            string encoding = null;
            string extension = null;
            string deviceInfo = null;
            byte[] bytes = null;

            deviceInfo = "<DeviceInfo><SimplePageHeaders>True</SimplePageHeaders></DeviceInfo>";

            //Render the report
            bytes = viewer.LocalReport.Render("PDF", deviceInfo, out mimeType, out encoding, out extension, out streamids, out warnings);
            Session["Reporte"] = bytes;

            string script = "<script type='text/javascript'>window.open('Reportes/reportes.aspx');</script>";
            Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "VentanaPadre", script);
        }

        private string Calificacion_a_texto(int calificacion)
        {
            string calificacion_a_texto = string.Empty;
            switch (calificacion)
            {
                case 0: calificacion_a_texto = "CERO"; break;
                case 1: calificacion_a_texto = "UNO"; break;
                case 2: calificacion_a_texto = "DOS"; break;
                case 3: calificacion_a_texto = "TRES"; break;
                case 4: calificacion_a_texto = "CUATRO"; break;
                case 5: calificacion_a_texto = "CINCO"; break;
                case 6: calificacion_a_texto = "SEIS"; break;
                case 7: calificacion_a_texto = "SIETE"; break;
                case 8: calificacion_a_texto = "OCHO"; break;
                case 9: calificacion_a_texto = "NUEVE"; break;
                case 10: calificacion_a_texto = "DIEZ"; break;
                default:
                    break;
            }
            return calificacion_a_texto;
        }

        protected void btn_imprimir_certificado_jurados_Click(object sender, EventArgs e)
        {
            int id_mesa = Convert.ToInt32(((Button)sender).CommandArgument);
            bool mesa_cerrada = false;

            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                Mesa mesa = cxt.Mesas.FirstOrDefault(pp => pp.mesa_id == id_mesa);

                if (mesa.mesa_estado == "Cerrada")
                {
                    Reportes.reporte_jurado ds = new Reportes.reporte_jurado();

                    foreach (Juez jurado in mesa.Jueces)
                    {
                        foreach (Tesina tesina in mesa.Tesinas)
                        {
                            Reportes.reporte_jurado.t_juradoRow jr = ds.t_jurado.Newt_juradoRow();
                            jr.jurado_id = jurado.juez_id;
                            jr.jurado_dni = jurado.Persona.persona_dni.ToString();
                            jr.jurado_licenciatura_nombre = jurado.Persona.Licenciatura.licenciatura_nombre;
                            jr.jurado_mesa_fecha = mesa.mesa_fecha.ToShortDateString();
                            jr.jurado_nombre = jurado.Persona.persona_nomyap;
                            jr.jurado_tesina_tema = tesina.tesina_tema;
                            jr.jurado_tesina_tesista = tesina.Tesista.Persona.persona_nomyap;

                            ds.t_jurado.Rows.Add(jr);
                        }
                    }

                    mesa_cerrada = true;
                    Session["ds_jurados"] = ds;
                }
            }

            if (mesa_cerrada)
            {
                RenderReport_jurados();
            }
            else
            {
                MessageBox.Show(this, "No se pueden imprimir los certificados mientras la mesa no este cerrada.", MessageBox.Tipo_MessageBox.Warning);
            }
        }

        private void RenderReport_jurados()
        {
            Reportes.reporte_jurado ds = Session["ds_jurados"] as Reportes.reporte_jurado;

            ReportViewer viewer = new ReportViewer();
            viewer.ProcessingMode = ProcessingMode.Local;
            viewer.LocalReport.EnableExternalImages = true;

            viewer.LocalReport.ReportPath = Server.MapPath("~/Aplicativo/Reportes/reporte_jurado.rdlc");

            ReportDataSource detalle = new ReportDataSource("t_jurado", ds.t_jurado.Rows);

            viewer.LocalReport.DataSources.Add(detalle);

            Microsoft.Reporting.WebForms.Warning[] warnings = null;
            string[] streamids = null;
            string mimeType = null;
            string encoding = null;
            string extension = null;
            string deviceInfo = null;
            byte[] bytes = null;

            deviceInfo = "<DeviceInfo><SimplePageHeaders>True</SimplePageHeaders></DeviceInfo>";

            //Render the report
            bytes = viewer.LocalReport.Render("PDF", deviceInfo, out mimeType, out encoding, out extension, out streamids, out warnings);
            Session["Reporte"] = bytes;

            string script = "<script type='text/javascript'>window.open('Reportes/reportes.aspx');</script>";
            Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "VentanaPadre", script);
        }

        protected void cv_calificacion_codirector_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string[] nombre_cv = ((CustomValidator)source).ClientID.Split('_');
            int rowNumber = Convert.ToInt32(nombre_cv[nombre_cv.Count() - 1]);
            TextBox tb_nota_codirector = ((TextBox)gv_cerrar_mesa_tesinas.Rows[rowNumber].Cells[5].Controls[1]);
            int tesina_id = Convert.ToInt32(tb_nota_codirector.AccessKey);

            bool correcto = true;

            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                bool hay_codirector = cxt.Tesinas.FirstOrDefault(tt => tt.tesina_id == tesina_id).Codirector != null;
                int nota = 0;

                if (hay_codirector)
                {
                    correcto = tb_nota_codirector.Text.Length > 0;
                    correcto = correcto && int.TryParse(tb_nota_codirector.Text, out nota);
                    correcto = correcto && nota > 0 && nota <= 10;
                }

            }

            args.IsValid = correcto;
        }
    }
}