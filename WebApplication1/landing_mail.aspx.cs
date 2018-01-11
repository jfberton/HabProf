using System;
using System.Collections.Generic;
using System.Drawing;
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

                        bool correcto = true;

                        //controlo que no haya pasado una hora desde el envio de la solicitud de validacion
                        correcto = correcto && fecha_hora_envio.AddHours(1) > ahora;

                        //controlo que no haya cambiado su mail desde el envio de la solicitud
                        correcto = correcto && envio.envio_email_destino == envio.Persona.persona_email;

                        //controlo que no haya una solicitud posterior para la misma persona
                        int id_ultimo_envio = cxt.Envio_mails.Where(ee => ee.persona_id == envio.persona_id && ee.envio_tipo == envio.envio_tipo).Max(ee => ee.envio_id);
                        correcto = correcto && envio.envio_id == id_ultimo_envio;

                        //controlo que ya no haya sido respondida anteriormente
                        correcto = correcto && envio.envio_respuesta_recibida == null;

                        if (correcto)
                        {
                            switch (tipo_mail)
                            {
                                case MiEmail.tipo_mail.validacion:
                                    div_validar_correo.Visible = true;
                                    div_recuperar_contraseña.Visible = false;
                                    envio.Persona.persona_email_validado = true;
                                    envio.envio_respuesta_recibida = DateTime.Now;
                                    cxt.SaveChanges();
                                    lbl_titulo.Text = "Su correo ha sido validado!";
                                    texto.InnerHtml = "Listo! Completó los pasos necesarios para la validación del correo: <strong>" + envio.envio_email_destino + "</strong>.<br/>Haga click en el botón para acceder al sistema.";
                                    btn_redireccionar.HRef = "~/default.aspx";
                                    break;
                                case MiEmail.tipo_mail.notificacion:
                                    break;
                                case MiEmail.tipo_mail.recupero_contraseña:
                                    div_validar_correo.Visible = false;
                                    div_recuperar_contraseña.Visible = true;
                                    envio.envio_respuesta_recibida = DateTime.Now;
                                    cxt.SaveChanges();
                                    lbl_recuperar_contraseña.Text = "Recuperar contraseña";
                                    textp_recuperar_contraseña.InnerHtml = "Bienvenido <strong>" + envio.Persona.persona_nomyap +"</strong>, esta teniendo problemas para ingresar? <br/>Para modificar su contraseña complete los siguientes campos y haga click en el botón recuperar.";
                                    break;
                                default:
                                    break;
                            }
                        }
                        else
                        {
                            switch (tipo_mail)
                            {
                                case MiEmail.tipo_mail.validacion:
                                    div_validar_correo.Visible = true;
                                    div_recuperar_contraseña.Visible = false;
                                    //se le vencio el tiempo o no es el mismo mail entre que envio la solicitud y entro a validar, caducó asi que tendra que pedir de nuevo la validacion
                                    lbl_titulo.Text = "Validación caducada!";
                                    lbl_titulo.ForeColor = Color.DarkRed;
                                    texto.InnerHtml = "Lamentablemente la validación ha caducado, te tomaste mas tiempo del que podías o fue aprobada anteriormete o modificaste el correo original. Solicita nuevamente un envío de validación a tu correo.-";
                                    btn_redireccionar.HRef = "~/default.aspx";
                                    MessageBox.Show(this, "El correo que intenta validar fue modificado o la solicitud ha caducado. Solicite nuevamente el envío de una nueva validación.-", MessageBox.Tipo_MessageBox.Danger, "Error al validar correo", "default.aspx");
                                    break;
                                case MiEmail.tipo_mail.notificacion:
                                    break;
                                case MiEmail.tipo_mail.recupero_contraseña:
                                    div_validar_correo.Visible = false;
                                    div_recuperar_contraseña.Visible = true;
                                    lbl_recuperar_contraseña.Text = "Recuperar contraseña - ";
                                    textp_recuperar_contraseña.InnerHtml = "La solicitud ha caducado o existe una solicitud más reciente";
                                    MessageBox.Show(this, "La solicitud ha caducado o existe una solicitud más reciente.-", MessageBox.Tipo_MessageBox.Danger, "Error", "default.aspx");
                                    break;
                                default:
                                    break;
                            }
                           
                        }

                    }
                }
            }
        }

        protected void btn_recuperar_contraseña_Click(object sender, EventArgs e)
        {
            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                string clave = Request.QueryString["clave"];
                Envio_mail envio = cxt.Envio_mails.FirstOrDefault(eemm => eemm.envio_respuesta_clave == clave);
                Persona p_cxt = cxt.Personas.FirstOrDefault(pp => pp.persona_id == envio.persona_id);

                if (tb_pass.Value == tb_pass1.Value)
                {
                    p_cxt.persona_clave = Cripto.Encriptar(tb_pass.Value);
                    cxt.SaveChanges();
                    MessageBox.Show(this, "La contraseña se modificó correctamente", MessageBox.Tipo_MessageBox.Success, "Éxito!", "default.aspx");
                }
                else
                {
                    MessageBox.Show(this, "Las contraseñas ingresadas no coinciden", MessageBox.Tipo_MessageBox.Danger);
                }

            }
            
        }
    }
}