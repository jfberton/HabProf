
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
    
public partial class Estado_tesis
{

    [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
    public Estado_tesis()
    {

        this.Tesinas = new HashSet<Tesis>();

        this.Historial_estado = new HashSet<Historial_estado>();

    }


    public int estado_tesis_id { get; set; }

    public string estado_estado { get; set; }

    public string estado_descripcion { get; set; }



    [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]

    public virtual ICollection<Tesis> Tesinas { get; set; }

    [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]

    public virtual ICollection<Historial_estado> Historial_estado { get; set; }

}

}
