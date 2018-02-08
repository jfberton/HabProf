using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1.Aplicativo.Reportes
{
    public partial class reportes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                byte[] bytes = Session["Reporte"] as byte[];
                Session["Reporte"] = null;
                if (bytes != null)
                {
                    Response.ClearContent();
                    Response.ClearHeaders();
                    Response.ContentType = "application/pdf";
                    Response.BinaryWrite(bytes);
                    Response.End();
                }
            }

        }
    }
}