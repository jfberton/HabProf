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
    
    public partial class Tesista
    {
        public int tesista_id { get; set; }
        public string tesista_legajo { get; set; }
        public string tesista_sede { get; set; }
        public int director_id { get; set; }
    
        public virtual Persona Persona { get; set; }
        public virtual Tesis Tesis { get; set; }
        public virtual Director Director { get; set; }
    }
}