using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Web;

namespace WebApplication1.Aplicativo
{
    public class Buscar
    {

        public bool Hubo_coincidencia { get; set; }

        public string Texto_con_palabras_resaltadas { get; set; }

        private string[] palabras_buscadas;

        private string texto;

        private List<string> palabras_exeptuadas = new List<string> { "a", "ante", "bajo", "cabe", "con", "contra", "de", "desde", "durante", "en", "entre", "hacia", "hasta", "mediante", "para", "por", "segun", "sin", "so", "sobre", "tras", "versus", "via", "que", "la", "el", "los" };

        public Buscar(string palabras_buscadas, string texto)
        {
            //separo las palabas por espacio y por coma
            this.palabras_buscadas = palabras_buscadas.Replace(' ', ',').Split(',');
            this.texto = texto;
            Buscar_coincidencias();
        }

        public Buscar(List<string> palabras_buscadas, string texto)
        {
            //separo las palabas por espacio y por coma
            this.palabras_buscadas = palabras_buscadas.ToArray();
            this.texto = texto;
            Buscar_coincidencias();
        }

        public Buscar(string[] palabras_buscadas, string texto)
        {
            this.palabras_buscadas = palabras_buscadas;
            this.texto = texto;
            Buscar_coincidencias();
        }

        private void Buscar_coincidencias()
        {
            Hubo_coincidencia = false;
            Texto_con_palabras_resaltadas = string.Empty;

            //lo convierto en lista para poder utilizar IndexOf
            List<string> palabras_buscadas_lista = new List<string>();
            foreach (string palabra_buscada in palabras_buscadas)
            {
                //agrego las palabras buscadas a la lista y les quito la coma, los acentos y la paso a minusculas. y que no este en el listado de palabras excluidas
                string palabra_buscada_normalizada = RemoveDiacritics(palabra_buscada).ToLower().Replace(",", "");
                if (palabras_exeptuadas.IndexOf(palabra_buscada_normalizada) >= 0)
                {
                    palabras_buscadas_lista.Add(palabra_buscada_normalizada);
                }
            }

            //tomo el texto donde tengo que buscar y lo separo por espacios
            string[] texto_separado_por_espacios = texto.Split(' ');

            foreach (string palabra in texto_separado_por_espacios)
            {
                string palabra_normalizada = RemoveDiacritics(palabra).ToLower().Replace(",", "");
                if (palabras_buscadas_lista.IndexOf(palabra_normalizada) >= 0)
                {
                    //existe la palabra en el listado de palabras buscadas
                    Hubo_coincidencia = true;
                    Texto_con_palabras_resaltadas = Texto_con_palabras_resaltadas + " <u><strong>" + palabra + "</strong></u>";
                }
                else
                {
                    Texto_con_palabras_resaltadas = Texto_con_palabras_resaltadas + " " + palabra;
                }
            }
        }

        static string RemoveDiacritics(string text)
        {
            return string.Concat(
                text.Normalize(NormalizationForm.FormD)
                .Where(ch => CharUnicodeInfo.GetUnicodeCategory(ch) !=
                                              UnicodeCategory.NonSpacingMark)
              ).Normalize(NormalizationForm.FormC);
        }

    }
}