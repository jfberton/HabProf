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
    public partial class verificar_coincidencias : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_buscar_Click(object sender, EventArgs e)
        {
            List<resultado_coincidencias> resultados = new List<resultado_coincidencias>();
            Buscar buscar;
            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                List<Tesina> tesinas = cxt.Tesinas.Include("Tesista").Include("Tesista.Persona").Include("Estado").ToList();
                string html_tema = string.Empty;
                string html_descripcion = string.Empty;

                foreach (Tesina tesina in tesinas)
                {
                    int coincidencias = 0;
                    buscar = new Buscar(tb_palabras_buscadas.Value, tesina.tesina_tema);
                    if (buscar.Hubo_coincidencia)
                    {
                        coincidencias++;
                        html_tema = buscar.Texto_con_palabras_resaltadas;
                    }

                    buscar = new Buscar(tb_palabras_buscadas.Value, tesina.tesina_descripcion);
                    if (buscar.Hubo_coincidencia)
                    {
                        coincidencias++;
                        html_descripcion = buscar.Texto_con_palabras_resaltadas;
                    }

                    if (coincidencias > 0)
                    {
                        resultados.Add(new resultado_coincidencias()
                        {
                            tesina = tesina,
                            html_tema = html_tema,
                            html_descripcion = html_descripcion,
                            estado = tesina.Estado.estado_tesina_estado
                            
                        });
                    }

                }
            }

            if (resultados.Count > 0)
            {
                foreach (resultado_coincidencias item in resultados)
                {
                    HtmlGenericControl div_panel_cascara = new HtmlGenericControl("div");
                    div_panel_cascara.Attributes["class"] = "panel panel-default";

                    HtmlGenericControl div_panel_heading = new HtmlGenericControl("div");
                    div_panel_heading.Attributes["class"] = "panel-heading";
                    div_panel_heading.InnerHtml = "<b>Presentada por: </b>" + item.tesina.Tesista.Persona.persona_nomyap + " - <b>Estado: </b>" + item.tesina.Estado.estado_tesina_estado;

                    HtmlGenericControl div_panel_body = new HtmlGenericControl("div");
                    div_panel_body.Attributes["class"] = "panel-body";
                    div_panel_body.InnerHtml = "<p>" + "Título: " + item.html_tema + "</p> <p>Descripción: " + item.html_descripcion + "</p>";


                    div_panel_cascara.Controls.Add(div_panel_heading);
                    div_panel_cascara.Controls.Add(div_panel_body);
                    div_coincidencias.Controls.Add(div_panel_cascara);
                }
            }
            else
            {
                MessageBox.Show(this, "No se han encontrado coincidencias!", MessageBox.Tipo_MessageBox.Success);
            }

        }


        private struct resultado_coincidencias
        {
            public Tesina tesina { get; set; }
            public string html_tema { get; set; }
            public string html_descripcion { get; set; }
            public string estado { get; set; }
        }
    }
}