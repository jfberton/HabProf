using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DocumentFormat.OpenXml.Packaging;
using DocumentFormat.OpenXml.Spreadsheet;
using System.IO;
using System.Web.UI.HtmlControls;

namespace WebApplication1.Aplicativo
{
    public partial class importar_tesistas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

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
                        //status_label.Text = "Se subio correctamente el archivo!";
                        //div_status_file.Attributes.Add("class", "alert alert-success");
                        //file_tesis.Enabled = false;
                        //btn_guardar_realizar_entrega.Enabled = true;
                        //btn_subir_archivo.Enabled = false;
                    }
                    catch (Exception ex)
                    {
                        //status_label.Text = "Ocurrio un error y no se pudo subir el archivo. Error: " + ex.Message;
                        //div_status_file.Attributes.Add("class", "alert alert-danger");
                    }

                }
                else
                {
                    //status_label.Text = "Debe seleccionar un archivo!";
                    //div_status_file.Attributes.Add("class", "alert alert-danger");
                }
            }
        }

        protected void cv_correo_duplicado_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string[] nombre_cv = ((CustomValidator)source).ClientID.Split('_');
            int rowNumber = Convert.ToInt32(nombre_cv[nombre_cv.Count() - 1]);
            int dni = Convert.ToInt32(((HtmlInputText)gv_tesistas.Rows[rowNumber].Cells[0].Controls[1]).Value);
            string mail = ((HtmlInputText)gv_tesistas.Rows[rowNumber].Cells[2].Controls[1]).Value;

            int repetido_en_grilla = 0;
            //reviso que no se repita el correo en ninguna otra fila
            for (int i = rowNumber; i < gv_tesistas.Rows.Count-1; i++)
            {
                if (i != rowNumber)
                {
                    string mail_fila = ((HtmlInputText)gv_tesistas.Rows[i].Cells[2].Controls[1]).Value;
                    repetido_en_grilla = mail == mail_fila ? repetido_en_grilla + 1 : repetido_en_grilla;
                }
            }

            bool correcto = true;

            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                correcto = cxt.Personas.FirstOrDefault(pp => pp.persona_email == mail && pp.persona_dni != dni) == null;
            }

            args.IsValid = correcto && repetido_en_grilla == 0;
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

        protected void cv_dni_duplicado_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string[] nombre_cv = ((CustomValidator)source).ClientID.Split('_');
            int rowNumber = Convert.ToInt32(nombre_cv[nombre_cv.Count() - 1]);
            int dni = Convert.ToInt32(((HtmlInputText)gv_tesistas.Rows[rowNumber].Cells[0].Controls[1]).Value);

            int repetido_en_grilla = 0;
            //reviso que no se repita el correo en ninguna otra fila
            for (int i = rowNumber; i < gv_tesistas.Rows.Count - 1; i++)
            {
                if (i != rowNumber)
                {
                    int dni_fila = Convert.ToInt32(((HtmlInputText)gv_tesistas.Rows[i].Cells[0].Controls[1]).Value);
                    repetido_en_grilla = dni == dni_fila ? repetido_en_grilla + 1 : repetido_en_grilla;
                }
            }


            bool correcto = true;

            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                correcto = cxt.Tesistas.FirstOrDefault(tt => tt.Persona.persona_dni == dni) == null;
            }

            args.IsValid = correcto && repetido_en_grilla == 0;
        }

        protected void btn_importar_Click(object sender, EventArgs e)
        {

        }
    }
}