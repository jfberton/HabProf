//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace WebApplication1.Aplicativo
{
    using System;
    using System.Collections.Generic;
    
    public partial class Historial_estado
    {
        public int historial_id { get; set; }
        public int tesis_id { get; set; }
        public int estado_tesis_id { get; set; }
        public string historial_descripcion { get; set; }
    
        public virtual Tesis Tesis { get; set; }
        public virtual Estado_tesis Estado { get; set; }
    }
}
