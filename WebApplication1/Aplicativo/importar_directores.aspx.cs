using DocumentFormat.OpenXml.Packaging;
using DocumentFormat.OpenXml.Spreadsheet;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using WebApplication1.Aplicativo.ControlesDeUsuario;

namespace WebApplication1.Aplicativo
{
    public partial class importar_directores : System.Web.UI.Page
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
            if (gv_directores.Rows.Count > 0)
            {
                gv_directores.HeaderRow.TableSection = TableRowSection.TableHeader;
            }
        }

        struct item_director
        {
            public string DNI { get; set; }
            public string nomyap { get; set; }
            public string email { get; set; }
            public string domicilio { get; set; }
            public string telefono { get; set; }
        }

        protected void btn_procesar_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                if (archivo_directores.HasFile)
                {
                    try
                    {
                        string directorio = Server.MapPath("~/Archivos/Importaciones/Directores/");

                        if (!Directory.Exists(directorio))
                        {
                            Directory.CreateDirectory(directorio);
                        }

                        string filename = Path.GetFileName(archivo_directores.FileName);
                        string path_final = directorio + DateTime.Now.ToString("ddMMyyyy hhmmss") + " " + filename;
                        archivo_directores.SaveAs(path_final);

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
            List<item_director> directores = new List<Aplicativo.importar_directores.item_director>();
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
                        item_director item = new item_director();

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

                        directores.Add(item);
                    }
                }
            }

            gv_directores.DataSource = directores;
            gv_directores.DataBind();
        }

        protected void cv_correo_duplicado_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string[] nombre_cv = ((CustomValidator)source).ClientID.Split('_');
            int rowNumber = Convert.ToInt32(nombre_cv[nombre_cv.Count() - 1]);
            int dni = Convert.ToInt32(((HtmlInputText)gv_directores.Rows[rowNumber].Cells[0].Controls[1]).Value);
            string mail = ((HtmlInputText)gv_directores.Rows[rowNumber].Cells[2].Controls[1]).Value;

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
            int dni = Convert.ToInt32(((HtmlInputText)gv_directores.Rows[rowNumber].Cells[0].Controls[1]).Value);
            string mail = ((HtmlInputText)gv_directores.Rows[rowNumber].Cells[2].Controls[1]).Value;

            int repetido_en_grilla = 0;
            //reviso que no se repita el correo en ninguna otra fila
            for (int i = rowNumber; i < gv_directores.Rows.Count; i++)
            {
                if (i != rowNumber)
                {
                    string mail_fila = ((HtmlInputText)gv_directores.Rows[i].Cells[2].Controls[1]).Value;
                    repetido_en_grilla = mail == mail_fila ? repetido_en_grilla + 1 : repetido_en_grilla;
                }
            }

            args.IsValid = repetido_en_grilla == 0;
        }

        protected void cv_dni_duplicado_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string[] nombre_cv = ((CustomValidator)source).ClientID.Split('_');
            int rowNumber = Convert.ToInt32(nombre_cv[nombre_cv.Count() - 1]);
            int dni = Convert.ToInt32(((HtmlInputText)gv_directores.Rows[rowNumber].Cells[0].Controls[1]).Value);

            bool correcto = true;

            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                correcto = cxt.Directores.FirstOrDefault(tt => tt.Persona.persona_dni == dni) == null;
            }

            args.IsValid = correcto;
        }

        protected void cv_dni_duplicado_grilla_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string[] nombre_cv = ((CustomValidator)source).ClientID.Split('_');
            int rowNumber = Convert.ToInt32(nombre_cv[nombre_cv.Count() - 1]);
            int dni = Convert.ToInt32(((HtmlInputText)gv_directores.Rows[rowNumber].Cells[0].Controls[1]).Value);

            int repetido_en_grilla = 0;
            //reviso que no se repita el correo en ninguna otra fila
            for (int i = rowNumber; i < gv_directores.Rows.Count; i++)
            {
                if (i != rowNumber)
                {
                    int dni_fila = Convert.ToInt32(((HtmlInputText)gv_directores.Rows[i].Cells[0].Controls[1]).Value);
                    repetido_en_grilla = dni == dni_fila ? repetido_en_grilla + 1 : repetido_en_grilla;
                }
            }

            args.IsValid = repetido_en_grilla == 0;
        }

        protected void btn_importar_Click(object sender, EventArgs e)
        {
            this.Validate("director");
            if (this.IsValid)
            {
                Persona usuario = Session["UsuarioLogueado"] as Persona;

                foreach (GridViewRow fila in gv_directores.Rows)
                {
                    int dni = Convert.ToInt32(((HtmlInputText)fila.Cells[0].Controls[1]).Value);

                    Persona p_director = null;
                    Director director = null;

                    using (HabProfDBContainer cxt = new HabProfDBContainer())
                    {
                        p_director = cxt.Personas.FirstOrDefault(pp => pp.persona_dni == dni);

                        if (p_director != null)
                        {
                            director = p_director.Director;
                        }

                        //Agrego o actualizo la persona
                        if (p_director == null)
                        {
                            p_director = new Persona()
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
                                persona_estilo = "Sandstone"
                            };
                            cxt.Personas.Add(p_director);
                        }
                        else
                        {
                            p_director.licenciatura_id = usuario.licenciatura_id;
                            p_director.persona_nomyap = ((HtmlInputText)fila.Cells[1].Controls[1]).Value;
                            p_director.persona_dni = dni;
                            p_director.licenciatura_id = usuario.licenciatura_id;
                            p_director.persona_email = ((HtmlInputText)fila.Cells[2].Controls[1]).Value;
                            p_director.persona_email_validado = false;
                            p_director.persona_domicilio = ((HtmlInputText)fila.Cells[3].Controls[1]).Value;
                            p_director.persona_telefono = ((HtmlInputText)fila.Cells[4].Controls[1]).Value;
                            p_director.persona_usuario = dni.ToString();
                            p_director.persona_clave = Cripto.Encriptar(dni.ToString());
                        }

                        //agrego o actualizo el director
                        if (director == null)
                        {
                            //no existe hago un insert
                            director = new Director()
                            {
                                Persona = p_director,
                            };

                            cxt.Directores.Add(director);
                        }

                        try
                        {

                            cxt.SaveChanges();

                            gv_directores.DataSource = null;
                            gv_directores.DataBind();

                            MessageBox.Show(this, "Se guardaron correctamente los directores!", MessageBox.Tipo_MessageBox.Success, "Exito!", "admin_directores.aspx");
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