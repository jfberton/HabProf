using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebApplication1.Aplicativo;
using WebApplication1.Aplicativo.ControlesDeUsuario;

namespace WebApplication1
{
    public partial class landing_mail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                MiEmail.tipo_mail tipo_mail = (MiEmail.tipo_mail)Enum.Parse(typeof(MiEmail.tipo_mail), Request.QueryString["tipo_mail"].ToString());
                string clave = Request.QueryString["clave"];

                using (HabProfDBContainer cxt = new HabProfDBContainer())
                {
                    Envio_mail envio = cxt.Envio_mails.FirstOrDefault(eemm => eemm.envio_respuesta_clave == clave);

                    if (envio != null)
                    {
                        DateTime ahora = DateTime.Now;
                        DateTime fecha_hora_envio = envio.envio_fecha_hora;
                        //le doy una hora de tiempo entre el envio y la validacion
                        if (fecha_hora_envio.AddHours(1) > ahora && envio.envio_email_destino == envio.Persona.persona_email)
                        {
                            switch (tipo_mail)
                            {
                                case MiEmail.tipo_mail.validacion:
                                    envio.Persona.persona_email_validado = true;
                                    cxt.SaveChanges();
                                    lbl_titulo.Text = "Su correo ha sido validado!";
                                    texto.InnerHtml = "Listo! Completó los pasos necesarios para la validación del correo: <strong>" + envio.envio_email_destino + "</strong>.<br/>Haga click en el botón para acceder al sistema.";
                                    btn_redireccionar.HRef = "~/default.aspx";
                                    break;
                                case MiEmail.tipo_mail.notificacion:
                                    break;
                                case MiEmail.tipo_mail.recupero_contraseña:
                                    break;
                                default:
                                    break;
                            }
                        }
                        else
                        {
                            //se le vencio el tiempo o no es el mismo mail entre que envio la solicitud y entro a validar, caducó asi que tendra que pedir de nuevo la validacion
                            lbl_titulo.Text = "Validación caducada!";
                            texto.InnerHtml = "Lamentablemente te tomaste mas tiempo del que podías y la validacón ya se venció, o modificaste el correo y esta validación quedo sin efecto. Solicita nuevamente un envío de validación a tu correo.-";
                            btn_redireccionar.HRef = "~/default.aspx";
                            MessageBox.Show(this, "El correo que intenta validar fue modificado o la solicitud ha caducado. Solicite nuevamente el envío de una nueva validación.-", MessageBox.Tipo_MessageBox.Danger, "Error al validar correo", "~/default.aspx");
                        }

                    }
                }
            }
        }
    }
}