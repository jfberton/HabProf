using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebApplication1.Aplicativo
{
    public partial class Director
    {
        /// <summary>
        /// Calificacion general: Promedio de las distintas calificaciones en las tesinas en las que participo
        /// </summary>
        public decimal Calificacion_general
        {
            get
            {
                double? promedio = this.Tesinas.Average(tt => tt.tesina_calificacion_director);
                return Convert.ToDecimal(promedio ?? 0);
            }
        }

        /// <summary>
        /// Tesinas a cargo: las tesinas en las cuales esta trabajando con los tesistas
        /// </summary>
        public int Tesinas_a_cargo { get { return this.Tesinas.Count(tt => tt.tesina_fecha_cierre == null); } }
    }
}