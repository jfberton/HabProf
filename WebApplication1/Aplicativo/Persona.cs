
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
    
public partial class Persona
{

    [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
    public Persona()
    {

        this.Envios_mail = new HashSet<Envio_mail>();

    }


    public int persona_id { get; set; }

    public string persona_nomyap { get; set; }

    public int persona_dni { get; set; }

    public string persona_email { get; set; }

    public bool persona_email_validado { get; set; }

    public string persona_domicilio { get; set; }

    public string persona_telefono { get; set; }

    public int licenciatura_id { get; set; }

    public string persona_usuario { get; set; }

    public string persona_clave { get; set; }

    public string persona_estilo { get; set; }



    public virtual Licenciatura Licenciatura { get; set; }

    [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]

    public virtual ICollection<Envio_mail> Envios_mail { get; set; }

    public virtual Tesista Tesista { get; set; }

    public virtual Director Director { get; set; }

    public virtual Jurado Jurado { get; set; }

    public virtual Administrador Administrador { get; set; }

}

}
