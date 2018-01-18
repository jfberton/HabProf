using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebApplication1.Aplicativo
{
    public partial class Director
    {
        public decimal Calificacion_general
        {
            get
            {
                double? promedio = this.Tesinas.Average(tt => tt.tesina_calificacion_director);
                return Convert.ToDecimal(promedio ?? 0);
            }
        }
    }
}