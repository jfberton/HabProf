
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
    
public partial class Administrador
{

    public int administrador_id { get; set; }

    public Nullable<System.DateTime> administrador_fecha_baja { get; set; }



    public virtual Persona Persona { get; set; }

}

}
