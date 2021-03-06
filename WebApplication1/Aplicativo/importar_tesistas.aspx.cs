﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DocumentFormat.OpenXml.Packaging;
using DocumentFormat.OpenXml.Spreadsheet;
using System.IO;
using System.Web.UI.HtmlControls;
using WebApplication1.Aplicativo.ControlesDeUsuario;

namespace WebApplication1.Aplicativo
{
    public partial class importar_tesistas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["Perfil"].ToString() != "Administrador")
                {
                    MessageBox.Show(this, "Usted no tiene permiso para acceder a esta página", MessageBox.Tipo_MessageBox.Danger, "Acceso restringido", "../default.aspx");
                }

                btn_importar.Visible = false;
            }
        }

        protected void gv_tesinas_PreRender(object sender, EventArgs e)
        {
            if (gv_tesistas.Rows.Count > 0)
            {
                gv_tesistas.HeaderRow.TableSection = TableRowSection.TableHeader;
            }
        }

        struct item_tesista
        {
            public string DNI { get; set; }
            public string nomyap { get; set; }
            public string email { get; set; }
            public string domicilio { get; set; }
            public string telefono { get; set; }
            public string legajo { get; set; }
            public string sede { get; set; }
        }

        protected void btn_procesar_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                if (archivo_tesistas.HasFile)
                {
                    try
                    {
                        string directorio = Server.MapPath("~/Archivos/Importaciones/Tesistas/");

                        if (!Directory.Exists(directorio))
                        {
                            Directory.CreateDirectory(directorio);
                        }

                        string filename = Path.GetFileName(archivo_tesistas.FileName);
                        string path_final = directorio + DateTime.Now.ToString("ddMMyyyy hhmmss") + " " + filename;
                        archivo_tesistas.SaveAs(path_final);

                        Cargar_valores_en_grilla(path_final);

                        btn_importar.Visible = true;
                    }
                    catch (Exception ex)
                    {
                        throw ex;
                    }

                }
            }
        }

        private void Cargar_valores_en_grilla(string path)
        {
            List<item_tesista> tesistas = new List<Aplicativo.importar_tesistas.item_tesista>();
            using (FileStream fs = new FileStream(path, FileMode.Open, FileAccess.Read, FileShare.ReadWrite))
            {
                using (SpreadsheetDocument doc = SpreadsheetDocument.Open(fs, false))
                {
                    WorkbookPart workbookPart = doc.WorkbookPart;
                    SharedStringTablePart sstpart = workbookPart.GetPartsOfType<SharedStringTablePart>().First();
                    SharedStringTable sst = sstpart.SharedStringTable;

                    WorksheetPart worksheetPart = workbookPart.WorksheetParts.First();
                    Worksheet sheet = worksheetPart.Worksheet;

                    var cells = sheet.Descendants<Cell>();
                    var rows = sheet.Descendants<Row>();

                    foreach (Row row in rows)
                    {
                        item_tesista item = new item_tesista();

                        #region DNI
                        Cell DNI = row.Elements<Cell>().ElementAt(0);
                        if ((DNI.DataType != null) && (DNI.DataType == CellValues.SharedString))
                        {
                            int ssid = int.Parse(DNI.CellValue.Text);
                            string str = sst.ChildElements[ssid].InnerText;
                            item.DNI = str;
                        }
                        else if (DNI.CellValue != null)
                        {
                            item.DNI = DNI.CellValue.Text;
                        }
                        #endregion

                        #region nomyap
                        Cell nomyap = row.Elements<Cell>().ElementAt(1);
                        if ((nomyap.DataType != null) && (nomyap.DataType == CellValues.SharedString))
                        {
                            int ssid = int.Parse(nomyap.CellValue.Text);
                            string str = sst.ChildElements[ssid].InnerText;
                            item.nomyap = str;
                        }
                        else if (nomyap.CellValue != null)
                        {
                            item.nomyap = nomyap.CellValue.Text;
                        }
                        #endregion

                        #region email
                        Cell email = row.Elements<Cell>().ElementAt(2);
                        if ((email.DataType != null) && (email.DataType == CellValues.SharedString))
                        {
                            int ssid = int.Parse(email.CellValue.Text);
                            string str = sst.ChildElements[ssid].InnerText;
                            item.email = str;
                        }
                        else if (email.CellValue != null)
                        {
                            item.email = email.CellValue.Text;
                        }
                        #endregion

                        #region domicilio
                        Cell domicilio = row.Elements<Cell>().ElementAt(3);
                        if ((domicilio.DataType != null) && (domicilio.DataType == CellValues.SharedString))
                        {
                            int ssid = int.Parse(domicilio.CellValue.Text);
                            string str = sst.ChildElements[ssid].InnerText;
                            item.domicilio = str;
                        }
                        else if (domicilio.CellValue != null)
                        {
                            item.domicilio = domicilio.CellValue.Text;
                        }
                        #endregion

                        #region telefono
                        Cell telefono = row.Elements<Cell>().ElementAt(4);
                        if ((telefono.DataType != null) && (telefono.DataType == CellValues.SharedString))
                        {
                            int ssid = int.Parse(telefono.CellValue.Text);
                            string str = sst.ChildElements[ssid].InnerText;
                            item.telefono = str;
                        }
                        else if (telefono.CellValue != null)
                        {
                            item.telefono = telefono.CellValue.Text;
                        }
                        #endregion

                        #region legajo
                        Cell legajo = row.Elements<Cell>().ElementAt(5);
                        if ((legajo.DataType != null) && (legajo.DataType == CellValues.SharedString))
                        {
                            int ssid = int.Parse(legajo.CellValue.Text);
                            string str = sst.ChildElements[ssid].InnerText;
                            item.legajo = str;
                        }
                        else if (legajo.CellValue != null)
                        {
                            item.legajo = legajo.CellValue.Text;
                        }
                        #endregion

                        #region sede
                        Cell sede = row.Elements<Cell>().ElementAt(6);
                        if ((sede.DataType != null) && (sede.DataType == CellValues.SharedString))
                        {
                            int ssid = int.Parse(sede.CellValue.Text);
                            string str = sst.ChildElements[ssid].InnerText;
                            item.sede = str;
                        }
                        else if (sede.CellValue != null)
                        {
                            item.sede = sede.CellValue.Text;
                        }
                        #endregion

                        tesistas.Add(item);
                    }
                }
            }

            gv_tesistas.DataSource = tesistas;
            gv_tesistas.DataBind();
        }

        protected void cv_correo_duplicado_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string[] nombre_cv = ((CustomValidator)source).ClientID.Split('_');
            int rowNumber = Convert.ToInt32(nombre_cv[nombre_cv.Count() - 1]);
            int dni = Convert.ToInt32(((HtmlInputText)gv_tesistas.Rows[rowNumber].Cells[0].Controls[1]).Value);
            string mail = ((HtmlInputText)gv_tesistas.Rows[rowNumber].Cells[2].Controls[1]).Value;

            bool correcto = true;

            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                correcto = cxt.Personas.FirstOrDefault(pp => pp.persona_email == mail && pp.persona_dni != dni) == null;
            }

            args.IsValid = correcto;
        }

        protected void cv_correo_duplicado_grilla_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string[] nombre_cv = ((CustomValidator)source).ClientID.Split('_');
            int rowNumber = Convert.ToInt32(nombre_cv[nombre_cv.Count() - 1]);
            int dni = Convert.ToInt32(((HtmlInputText)gv_tesistas.Rows[rowNumber].Cells[0].Controls[1]).Value);
            string mail = ((HtmlInputText)gv_tesistas.Rows[rowNumber].Cells[2].Controls[1]).Value;

            int repetido_en_grilla = 0;
            //reviso que no se repita el correo en ninguna otra fila
            for (int i = rowNumber; i < gv_tesistas.Rows.Count; i++)
            {
                if (i != rowNumber)
                {
                    string mail_fila = ((HtmlInputText)gv_tesistas.Rows[i].Cells[2].Controls[1]).Value;
                    repetido_en_grilla = mail == mail_fila ? repetido_en_grilla + 1 : repetido_en_grilla;
                }
            }

            args.IsValid = repetido_en_grilla == 0;
        }

        protected void cv_dni_duplicado_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string[] nombre_cv = ((CustomValidator)source).ClientID.Split('_');
            int rowNumber = Convert.ToInt32(nombre_cv[nombre_cv.Count() - 1]);
            int dni = Convert.ToInt32(((HtmlInputText)gv_tesistas.Rows[rowNumber].Cells[0].Controls[1]).Value);

            bool correcto = true;

            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                correcto = cxt.Tesistas.FirstOrDefault(tt => tt.Persona.persona_dni == dni) == null;
            }

            args.IsValid = correcto;
        }

        protected void cv_dni_duplicado_grilla_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string[] nombre_cv = ((CustomValidator)source).ClientID.Split('_');
            int rowNumber = Convert.ToInt32(nombre_cv[nombre_cv.Count() - 1]);
            int dni = Convert.ToInt32(((HtmlInputText)gv_tesistas.Rows[rowNumber].Cells[0].Controls[1]).Value);

            int repetido_en_grilla = 0;
            //reviso que no se repita el correo en ninguna otra fila
            for (int i = rowNumber; i < gv_tesistas.Rows.Count; i++)
            {
                if (i != rowNumber)
                {
                    int dni_fila = Convert.ToInt32(((HtmlInputText)gv_tesistas.Rows[i].Cells[0].Controls[1]).Value);
                    repetido_en_grilla = dni == dni_fila ? repetido_en_grilla + 1 : repetido_en_grilla;
                }
            }

            args.IsValid = repetido_en_grilla == 0;
        }

        protected void btn_importar_Click(object sender, EventArgs e)
        {
            this.Validate("tesista");
            if (this.IsValid)
            {
                Persona usuario = Session["UsuarioLogueado"] as Persona;

                foreach (GridViewRow fila in gv_tesistas.Rows)
                {
                    int dni = Convert.ToInt32(((HtmlInputText)fila.Cells[0].Controls[1]).Value);

                    Persona p_tesista = null;
                    Tesista tesista = null;

                    using (HabProfDBContainer cxt = new HabProfDBContainer())
                    {
                        p_tesista = cxt.Personas.FirstOrDefault(pp => pp.persona_dni == dni);

                        if (p_tesista != null)
                        {
                            tesista = p_tesista.Tesista;
                        }

                        //Agrego o actualizo la persona
                        if (p_tesista == null)
                        {
                            p_tesista = new Persona()
                            {
                                licenciatura_id = usuario.licenciatura_id,
                                persona_nomyap = ((HtmlInputText)fila.Cells[1].Controls[1]).Value,
                                persona_dni = dni,
                                persona_email = ((HtmlInputText)fila.Cells[2].Controls[1]).Value,
                                persona_email_validado = false,
                                persona_domicilio = ((HtmlInputText)fila.Cells[3].Controls[1]).Value,
                                persona_telefono = ((HtmlInputText)fila.Cells[4].Controls[1]).Value,
                                persona_usuario = dni.ToString(),
                                persona_clave = Cripto.Encriptar(dni.ToString()),
                                persona_estilo = "Slate"
                            };
                            cxt.Personas.Add(p_tesista);
                        }
                        else
                        {
                            p_tesista.licenciatura_id = usuario.licenciatura_id;
                            p_tesista.persona_nomyap = ((HtmlInputText)fila.Cells[1].Controls[1]).Value;
                            p_tesista.persona_dni = dni;
                            p_tesista.licenciatura_id = usuario.licenciatura_id;
                            p_tesista.persona_email = ((HtmlInputText)fila.Cells[2].Controls[1]).Value;
                            p_tesista.persona_email_validado = false;
                            p_tesista.persona_domicilio = ((HtmlInputText)fila.Cells[3].Controls[1]).Value;
                            p_tesista.persona_telefono = ((HtmlInputText)fila.Cells[4].Controls[1]).Value;
                            p_tesista.persona_usuario = dni.ToString();
                            p_tesista.persona_clave = Cripto.Encriptar(dni.ToString());
                        }

                        //agrego o actualizo el tesista
                        if (tesista == null)
                        {
                            //no existe hago un insert
                            tesista = new Tesista()
                            {
                                Persona = p_tesista,
                                tesista_legajo = ((HtmlInputText)fila.Cells[5].Controls[1]).Value,
                                tesista_sede = ((HtmlInputText)fila.Cells[6].Controls[1]).Value
                            };

                            cxt.Tesistas.Add(tesista);
                        }
                        else
                        {
                            //existe el tesista por lo tanto tambien la persona y ya fue editada
                            tesista.tesista_legajo = ((HtmlInputText)fila.Cells[5].Controls[1]).Value;
                            tesista.tesista_sede = ((HtmlInputText)fila.Cells[6].Controls[1]).Value;
                        }


                        try
                        {

                            cxt.SaveChanges();

                            gv_tesistas.DataSource = null;
                            gv_tesistas.DataBind();

                            MessageBox.Show(this, "Se guardaron correctamente los tesistas!", MessageBox.Tipo_MessageBox.Success, "Exito!", "admin_tesistas.aspx");
                        }
                        catch (Exception ex)
                        {
                            MessageBox.Show(this, ex.Message, MessageBox.Tipo_MessageBox.Danger);
                        }
                    }

                }

            }
        }
    }
}