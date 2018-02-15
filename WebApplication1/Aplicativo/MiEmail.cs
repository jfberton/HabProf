using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Text;
using System.Web;

namespace WebApplication1.Aplicativo
{
    public class MiEmail
    {
        public enum tipo_mail
        {
            validacion,
            recupero_contraseña,
            notificacion_asignacion_tesina_director,
            notificacion_inicio_tesina_tesista,
            notificacion_modificacion_tesina_tesista,
            notificacion_modificacion_tesina_director,
            notificacion_eliminacion_tesina_tesista,
            notificacion_eliminacion_tesina_director,
            notificacion_entrega_archivo_tesina,
            notificacion_correcciones_tesina,
            notificacion_tesina_lista_para_presentar,
            notificacion_tesina_vencida,
            notificacion_tesina_prorrogada,
            alta_director,
            notificacion_recordatorio_automatico
        }

        public MiEmail(Envio_mail mail)
        {
            using (HabProfDBContainer cxt = new Aplicativo.HabProfDBContainer())
            {
                Persona p = cxt.Personas.FirstOrDefault(pp => pp.persona_id == mail.persona_id);
                Tipo_mail = (tipo_mail)Enum.Parse(typeof(tipo_mail), mail.envio_tipo);
                Smtp_client = p.Licenciatura.Servidor.servidor_smtp_host;
                Smtp_puerto = p.Licenciatura.Servidor.servidor_smtp_port;
                Persona_nombre = p.persona_nomyap;
                Persona_usuario = p.persona_usuario;
                Persona_pass = Cripto.Desencriptar(p.persona_clave);
                Url_respuesta = ConfigurationManager.AppSettings["direccion_localhost_raiz"] + "landing_mail.aspx?tipo_mail=" + mail.envio_tipo + "&clave=" + mail.envio_respuesta_clave;
                Credenciales_mail = p.Licenciatura.licenciatura_email;
                Credenciales_contraseña = p.Licenciatura.licenciatura_email_clave;
                Destinatarios = new List<string>(mail.envio_email_destino.Replace(" ", "").Split(','));
            }
        }

        public MiEmail(Envio_mail mail, Tesina t)
        {
            using (HabProfDBContainer cxt = new Aplicativo.HabProfDBContainer())
            {
                Persona p = cxt.Personas.FirstOrDefault(pp => pp.persona_id == mail.persona_id);
                Tipo_mail = (tipo_mail)Enum.Parse(typeof(tipo_mail), mail.envio_tipo);
                Smtp_client = p.Licenciatura.Servidor.servidor_smtp_host;
                Smtp_puerto = p.Licenciatura.Servidor.servidor_smtp_port;
                Persona_nombre = p.persona_nomyap;
                Persona_usuario = p.persona_usuario;
                Persona_pass = Cripto.Desencriptar(p.persona_clave);
                Url_respuesta = ConfigurationManager.AppSettings["direccion_localhost_raiz"] + "landing_mail.aspx?tipo_mail=" + mail.envio_tipo + "&clave=" + mail.envio_respuesta_clave;
                Credenciales_mail = p.Licenciatura.licenciatura_email;
                Credenciales_contraseña = p.Licenciatura.licenciatura_email_clave;
                Destinatarios = new List<string>(mail.envio_email_destino.Replace(" ", "").Split(','));
                //datos extra para el envio de mails
                Director_mail = t.Director.Persona.persona_email;
                Director_nombre = t.Director.Persona.persona_nomyap;
                Codirector_mail = t.Codirector != null ? t.Codirector.Persona.persona_email : "-";
                Codirector_nombre = t.Codirector != null ? t.Codirector.Persona.persona_nomyap : "-";
                Tesista_mail = t.Tesista.Persona.persona_email;
                Tesista_nombre = t.Tesista.Persona.persona_nomyap;
                Tesis_fecha_limite = t.tesina_plan_fch_presentacion.AddMonths(t.tesina_plan_duracion_meses -1).ToShortDateString();
                Tesis_periodo_notificaciones = t.tesina_plan_aviso_meses.ToString();
                Tesis_tema = t.tesina_tema;
                Tesis_Url_archivo = ConfigurationManager.AppSettings["direccion_localhost_raiz"] + "Archivos/Tesinas/" + t.tesina_id + "/presentado.pdf";
                Tesis_meses_restantes = Math.Abs((t.tesina_plan_fch_presentacion.AddMonths(t.tesina_plan_duracion_meses).Month - DateTime.Today.Month) + 12 * (t.tesina_plan_fch_presentacion.AddMonths(t.tesina_plan_duracion_meses).Year - DateTime.Today.Year))-1;
            }
        }

        public tipo_mail Tipo_mail { get; set; }

        private string cuerpo;

        public List<string> Destinatarios { get; set; }

        public string Credenciales_mail { get; set; }

        public string Credenciales_contraseña { get; set; }

        public string Asunto { get; set; }

        public string Smtp_client { get; set; }

        public int Smtp_puerto { get; set; }

        public string Persona_nombre { get; set; }

        public string Persona_usuario { get; set; }

        public string Persona_pass { get; set; }

        public string Director_nombre { get; set; }

        public string Director_mail { get; set; }

        public string Codirector_nombre { get; set; }

        public string Codirector_mail { get; set; }

        public string Tesista_nombre { get; set; }

        public string Tesista_mail { get; set; }

        public string Tesis_fecha_limite { get; set; }

        public string Tesis_periodo_notificaciones { get; set; }

        public string Tesis_tema { get; set; }

        public string Tesis_Url_archivo { get; set; }

        public int Tesis_meses_restantes { get; set; }

        public string Url_respuesta { get; set; }

        public bool Enviar_mail()
        {
            try
            {
                using (HabProfDBContainer cxt = new HabProfDBContainer())
                {
                    switch (Tipo_mail)
                    {
                        case tipo_mail.validacion:
                            Asunto = "Sistema de administración de Tesina - Validación de correo";
                            cuerpo = File.ReadAllText(HttpRuntime.AppDomainAppPath + @"Aplicativo\Mails\" + Tipo_mail.ToString() + ".html").ToString().
                                                                                                                            Replace("Username", Persona_nombre).
                                                                                                                            Replace("TestUser", Persona_usuario).
                                                                                                                            Replace("url_respuesta", Url_respuesta);
                            break;
                        case tipo_mail.recupero_contraseña:
                            Asunto = "Sistema de administración de Tesina - Recuperar contraseña";
                            cuerpo = File.ReadAllText(HttpRuntime.AppDomainAppPath + @"Aplicativo\Mails\" + Tipo_mail.ToString() + ".html").ToString().
                                                                                                                           Replace("UserName", Persona_nombre).
                                                                                                                           Replace("TestUser", Persona_usuario).
                                                                                                                           Replace("url_respuesta", Url_respuesta);
                            break;
                        case tipo_mail.notificacion_asignacion_tesina_director:
                            Asunto = "Sistema de administración de Tesina - Asignación de Tesina";
                            cuerpo = File.ReadAllText(HttpRuntime.AppDomainAppPath + @"Aplicativo\Mails\" + Tipo_mail.ToString() + ".html").ToString().
                                                                                                                            Replace("Username", Persona_nombre).
                                                                                                                           Replace("nombre_tesista", Tesista_nombre).
                                                                                                                           Replace("fecha_limite_tesina", Tesis_fecha_limite).
                                                                                                                           Replace("correo_tesista", Tesista_mail).
                                                                                                                           Replace("tema_tesina", Tesis_tema);
                            break;
                        case tipo_mail.notificacion_inicio_tesina_tesista:
                            Asunto = "Sistema de administración de Tesina - Inicio de Tesina";
                            cuerpo = File.ReadAllText(HttpRuntime.AppDomainAppPath + @"Aplicativo\Mails\" + Tipo_mail.ToString() + ".html").ToString().
                                                                                                Replace("Username", Persona_nombre).
                                                                                               Replace("tesis_fecha_limite", Tesis_fecha_limite).
                                                                                               Replace("nombre_director", Director_nombre).
                                                                                               Replace("correo_director", Director_mail).
                                                                                               Replace("nombre_codirector", Codirector_nombre).
                                                                                               Replace("correo_codirector", Codirector_mail).
                                                                                               Replace("periodo_notificaciones ", Tesis_periodo_notificaciones);
                            break;
                        case tipo_mail.notificacion_modificacion_tesina_director:
                            Asunto = "Sistema de administración de Tesina - Modificación de Tesina";
                            cuerpo = File.ReadAllText(HttpRuntime.AppDomainAppPath + @"Aplicativo\Mails\" + Tipo_mail.ToString() + ".html").ToString().
                                                                                                                            Replace("Username", Persona_nombre).
                                                                                                                           Replace("tesista_nombre", Tesista_nombre).
                                                                                                                           Replace("fecha_limite", Tesis_fecha_limite).
                                                                                                                           Replace("tema_tesina", Tesis_tema);
                            break;
                        case tipo_mail.notificacion_modificacion_tesina_tesista:
                            Asunto = "Sistema de administración de Tesina - Modificación de Tesina";
                            cuerpo = File.ReadAllText(HttpRuntime.AppDomainAppPath + @"Aplicativo\Mails\" + Tipo_mail.ToString() + ".html").ToString().
                                                                                              Replace("Username", Persona_nombre).
                                                                                              Replace("tema_tesina", Tesis_tema).
                                                                                              Replace("fecha_limite", Tesis_fecha_limite).
                                                                                              Replace("director_tesina", Director_nombre).
                                                                                              Replace("correo_director", Director_mail).
                                                                                              Replace("codirector_tesina", Codirector_nombre).
                                                                                              Replace("correo_codirector", Codirector_mail);

                            break;
                        case tipo_mail.notificacion_eliminacion_tesina_director:
                            Asunto = "Sistema de administración de Tesina - Eliminación de Tesina";
                            cuerpo = File.ReadAllText(HttpRuntime.AppDomainAppPath + @"Aplicativo\Mails\" + Tipo_mail.ToString() + ".html").ToString().
                                                                                             Replace("Username", Persona_nombre).
                                                                                             Replace("tesista_nombre", Tesista_nombre);

                            break;
                        case tipo_mail.notificacion_eliminacion_tesina_tesista:
                            Asunto = "Sistema de administración de Tesina - Eliminación de Tesina";
                            cuerpo = File.ReadAllText(HttpRuntime.AppDomainAppPath + @"Aplicativo\Mails\" + Tipo_mail.ToString() + ".html").ToString().
                                                                                             Replace("Username", Persona_nombre);
                            break;

                        case tipo_mail.alta_director:
                            Asunto = "Sistema de administración de Tesina - Alta Director";
                            cuerpo = File.ReadAllText(HttpRuntime.AppDomainAppPath + @"Aplicativo\Mails\" + Tipo_mail.ToString() + ".html").ToString().
                                                                                             Replace("Username", Persona_nombre).
                                                                                             Replace("TestUser", Persona_usuario).
                                                                                             Replace("UserPass", Persona_pass).
                                                                                             Replace("url_respuesta", Url_respuesta);
                            break;

                        case tipo_mail.notificacion_entrega_archivo_tesina:
                            Asunto = "Sistema de administración de Tesina - Entrega archivo Tesina";
                            cuerpo = File.ReadAllText(HttpRuntime.AppDomainAppPath + @"Aplicativo\Mails\" + Tipo_mail.ToString() + ".html").ToString().
                                                                                              Replace("Username", Persona_nombre).
                                                                                              Replace("url_archivo", Tesis_Url_archivo).
                                                                                              Replace("tema_tesina", Tesis_tema);
                            break;

                        case tipo_mail.notificacion_correcciones_tesina:
                            Asunto = "Sistema de administración de Tesina - Corregir Tesina";
                            cuerpo = File.ReadAllText(HttpRuntime.AppDomainAppPath + @"Aplicativo\Mails\" + Tipo_mail.ToString() + ".html").ToString().
                                                                                               Replace("Username", Persona_nombre).
                                                                                               Replace("tema_tesina", Tesis_tema);
                            break;

                        case tipo_mail.notificacion_tesina_lista_para_presentar:
                            Asunto = "Sistema de administración de Tesina - Tesina lista para evaluar";
                            cuerpo = File.ReadAllText(HttpRuntime.AppDomainAppPath + @"Aplicativo\Mails\" + Tipo_mail.ToString() + ".html").ToString().
                                                                                               Replace("Username", Persona_nombre).
                                                                                               Replace("tema_tesina", Tesis_tema);
                            break;

                        case tipo_mail.notificacion_tesina_vencida:
                            Asunto = "Sistema de administración de Tesina - Tesina Vencida";
                            cuerpo = File.ReadAllText(HttpRuntime.AppDomainAppPath + @"Aplicativo\Mails\" + Tipo_mail.ToString() + ".html").ToString().
                                                                                               Replace("Username", Persona_nombre).
                                                                                               Replace("tema_tesina", Tesis_tema);
                            break;

                        case tipo_mail.notificacion_tesina_prorrogada:
                            Asunto = "Sistema de administración de Tesina - Tesina Prorrogada";
                            cuerpo = File.ReadAllText(HttpRuntime.AppDomainAppPath + @"Aplicativo\Mails\" + Tipo_mail.ToString() + ".html").ToString().
                                                                                               Replace("Username", Persona_nombre).
                                                                                               Replace("tema_tesina", Tesis_tema).
                                                                                               Replace("fecha_limite", Tesis_fecha_limite);
                            break;

                        case tipo_mail.notificacion_recordatorio_automatico:
                            Asunto = "Sistema de administración de Tesina - Recordatorio Tesina";
                            cuerpo = File.ReadAllText(HttpRuntime.AppDomainAppPath + @"Aplicativo\Mails\" + Tipo_mail.ToString() + ".html").ToString().
                                                                                               Replace("Username", Persona_nombre).
                                                                                               Replace("meses_para_fin ", Tesis_meses_restantes.ToString()).
                                                                                               Replace("nombre_director", Director_nombre).
                                                                                               Replace("correo_director", Director_mail).
                                                                                               Replace("codirector_tesina", Codirector_nombre).
                                                                                               Replace("correo_codirector", Codirector_mail);
                            break;

                        default:
                            break;
                    }
                }

                EnviarAsincrono.para = Destinatarios[0];
                EnviarAsincrono.asunto = Asunto;
                EnviarAsincrono.cuerpo = cuerpo;
                EnviarAsincrono.credenciales_mail = Credenciales_mail;
                EnviarAsincrono.credenciales_pass = Credenciales_contraseña;
                EnviarAsincrono.smtp_client = Smtp_client;
                EnviarAsincrono.smtp_port = Smtp_puerto;
                EnviarAsincrono.Enviar();

                return true;
            }
            catch (SmtpException ex)
            {
                string error = ex.Message;
                return false;
            }
        }

    }

    public static class EnviarAsincrono
    {
        public static string para { get; set; }
        public static string asunto { get; set; }
        public static string cuerpo { get; set; }
        public static string credenciales_mail { get; set; }
        public static string credenciales_pass { get; set; }
        public static string smtp_client { get; set; }
        public static int smtp_port { get; set; }

        public static async void Enviar()
        {
            MailAddress ma_de = new MailAddress(credenciales_mail, "Sistema de Tesinas");
            MailAddress ma_para = new MailAddress(para);

            MailMessage mail = new MailMessage(ma_de, ma_para);

            mail.Body = cuerpo;
            mail.BodyEncoding = System.Text.Encoding.UTF8;
            mail.IsBodyHtml = true;
            mail.Subject = asunto;
            mail.SubjectEncoding = System.Text.Encoding.UTF8;

            SmtpClient smtpClient = new SmtpClient(smtp_client, smtp_port);
            smtpClient.UseDefaultCredentials = false;
            smtpClient.Credentials = new NetworkCredential(credenciales_mail, credenciales_pass);
            smtpClient.EnableSsl = true;
            smtpClient.SendCompleted += new SendCompletedEventHandler(SendCompletedCallback);
            //smtpClient.Send(mail);
            await smtpClient.SendMailAsync(mail);

            mail.Dispose();
        }

        private static void SendCompletedCallback(object sender, AsyncCompletedEventArgs e)
        {
            // Get the unique identifier for this asynchronous operation.
            //String token = (string)e.UserState;

            if (e.Cancelled)
            {
                Console.WriteLine(" Send canceled.");
            }
            if (e.Error != null)
            {
                Console.WriteLine("Error {1}", e.Error.ToString());
            }
            else
            {
                Console.WriteLine("Message sent.");
                //sw.Stop();
                //TimeSpan ts = sw.Elapsed;
                //string elapsedTime = String.Format("{0:00}:{1:00}:{2:00}.{3:00}",
                //                                    ts.Hours, ts.Minutes, ts.Seconds,
                //                                    ts.Milliseconds / 10);
                //Console.WriteLine("RunTime " + elapsedTime);
            }

            //mailSent = true;
        }
    }
}