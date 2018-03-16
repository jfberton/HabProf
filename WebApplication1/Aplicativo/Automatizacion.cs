using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebApplication1.Aplicativo
{
    /// <summary>
    /// Genera avisos automáticos para las tesinas que falta presentar y vence las que ya cumplieron el plazo
    /// </summary>
    public class Automatizacion
    {
        /// <summary>
        /// Verifico y marco como vencidas las tesinas que no esten en estado vencida, lista para presentar, aprobadas o desaprobadas.
        /// Ver el tema de si vencer o no las que se presentaron para corregir y estan en poder del director o administrador
        /// </summary>
        public void Verificar_y_marcar_tesinas_vencidas()
        {
            using (HabProfDBContainer cxt = new Aplicativo.HabProfDBContainer())
            {
                Estado_tesina et_vencida = cxt.Estados_tesinas.FirstOrDefault(eett => eett.estado_tesina_estado == "Vencida");
                Estado_tesina et_lista = cxt.Estados_tesinas.FirstOrDefault(eett => eett.estado_tesina_estado == "Lista para presentar");
                Estado_tesina et_aprobada = cxt.Estados_tesinas.FirstOrDefault(eett => eett.estado_tesina_estado == "Aprobada");
                Estado_tesina et_desaprobada = cxt.Estados_tesinas.FirstOrDefault(eett => eett.estado_tesina_estado == "Desaprobada");

                List<Tesina> tesinas = cxt.Tesinas.Where(tt =>
                                                            tt.estado_tesis_id != et_vencida.estado_tesina_id &&
                                                            tt.estado_tesis_id != et_lista.estado_tesina_id &&
                                                            tt.estado_tesis_id != et_aprobada.estado_tesina_id &&
                                                            tt.estado_tesis_id != et_desaprobada.estado_tesina_id
                                                            ).ToList();

                foreach (Tesina tesina in tesinas)
                {
                    DateTime fecha_vencimiento = tesina.tesina_plan_fch_presentacion.AddMonths(tesina.tesina_plan_duracion_meses);
                    if (fecha_vencimiento < DateTime.Today)
                    {
                        tesina.Historial_estados.Add(new Historial_estado() { estado_tesina_id = et_vencida.estado_tesina_id, historial_tesina_fecha = fecha_vencimiento, historial_tesina_descripcion = "Se venció el plazo para presentar una tesina lista para evaluar" });
                        tesina.estado_tesis_id = et_vencida.estado_tesina_id;

                        Envio_mail em_director = new Envio_mail()
                        {
                            persona_id = tesina.Director.Persona.persona_id,
                            envio_email_destino = tesina.Director.Persona.persona_email,
                            envio_fecha_hora = DateTime.Now,
                            envio_respuesta_clave = "no se usa",
                            envio_tipo = MiEmail.tipo_mail.notificacion_tesina_vencida.ToString()
                        };
                        cxt.Envio_mails.Add(em_director);

                        Envio_mail em_tesista = new Envio_mail()
                        {
                            persona_id = tesina.Tesista.Persona.persona_id,
                            envio_email_destino = tesina.Tesista.Persona.persona_email,
                            envio_fecha_hora = DateTime.Now,
                            envio_respuesta_clave = "no se usa",
                            envio_tipo = MiEmail.tipo_mail.notificacion_tesina_vencida.ToString()
                        };
                        cxt.Envio_mails.Add(em_tesista);

                        MiEmail me_director = new MiEmail(em_director, tesina);
                        MiEmail me_tesista = new MiEmail(em_tesista, tesina);

                        me_director.Enviar_mail();
                        me_tesista.Enviar_mail();

                        if (tesina.Codirector != null)
                        {
                            Envio_mail em_codirector = new Envio_mail()
                            {
                                persona_id = tesina.Codirector.Persona.persona_id,
                                envio_email_destino = tesina.Codirector.Persona.persona_email,
                                envio_fecha_hora = DateTime.Now,
                                envio_respuesta_clave = "no se usa",
                                envio_tipo = MiEmail.tipo_mail.notificacion_tesina_vencida.ToString()
                            };
                            cxt.Envio_mails.Add(em_codirector);
                            MiEmail me_codirector = new MiEmail(em_codirector, tesina);
                            me_codirector.Enviar_mail();
                        }

                        cxt.SaveChanges();
                    }
                }

            }
        }

        /// <summary>
        /// Envia correos a las tesinas con los avisos automaticos pendientes
        /// </summary>
        /// <remarks>
        /// Procedimiento:
        ///   - Marco las tesinas que deberian estar vencidas.
        ///   - Obtengo las tesinas que no estan vencidas, listas para presentar, aprobadas o desaprobadas.
        ///   - De estas tesinas verifico que la fecha actual (fa) sea mayor o igual a la fecha de inicio (fi) mas un múltiplo de los períodos de envio (xn)
        ///     y que en ese tramo de tiempo (fi+xa y fa) no se hayan enviado notificaciones de este tipo
        /// </remarks>
        public void Enviar_correos_notificacion_automatica()
        {
            Verificar_y_marcar_tesinas_vencidas();

            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                Estado_tesina et_vencida = cxt.Estados_tesinas.FirstOrDefault(eett => eett.estado_tesina_estado == "Vencida");
                Estado_tesina et_lista = cxt.Estados_tesinas.FirstOrDefault(eett => eett.estado_tesina_estado == "Lista para presentar");
                Estado_tesina et_aprobada = cxt.Estados_tesinas.FirstOrDefault(eett => eett.estado_tesina_estado == "Aprobada");
                Estado_tesina et_desaprobada = cxt.Estados_tesinas.FirstOrDefault(eett => eett.estado_tesina_estado == "Desaprobada");

                DateTime fecha_actual = DateTime.Today;

                List<Tesina> tesinas = cxt.Tesinas.Where(tt =>
                                                            tt.estado_tesis_id != et_vencida.estado_tesina_id &&
                                                            tt.estado_tesis_id != et_lista.estado_tesina_id &&
                                                            tt.estado_tesis_id != et_aprobada.estado_tesina_id &&
                                                            tt.estado_tesis_id != et_desaprobada.estado_tesina_id
                                                            ).ToList();

                foreach (Tesina tesina in tesinas)
                {
                    //multiplo de avisos automáticos
                    int multiplo = 0;

                    //al salir de aca el multiplo es uno mas que el necesario es decir, el multiplo por el periodo entre avisos nos da la fecha del proximo envio
                    while (tesina.tesina_plan_fch_presentacion.AddMonths(tesina.tesina_plan_aviso_meses * multiplo) <= fecha_actual)
                    {
                        multiplo++;
                    }

                    //descuento uno para obtener la fecha en la que se tuvo que haber enviado la ultima vez
                    multiplo--;

                    //si multiplo es mayor que cero quiere decir que deberia de enviar el aviso, si es que no se envió todavia
                    if (multiplo > 0)
                    {
                        //busco en el periodo (fecha_presentacion + (multiplo * periodo_aviso)) y fecha_actual si se realizaron envios, de no ser asi tengo que realizar el envio
                        DateTime desde = tesina.tesina_plan_fch_presentacion.AddMonths(multiplo * tesina.tesina_plan_aviso_meses);
                        DateTime hasta = fecha_actual;

                        List<Envio_mail> envios_automaticos = cxt.Envio_mails.Where(eemm => eemm.persona_id == tesina.Tesista.Persona.persona_id &&
                                                                             eemm.envio_tipo == "notificacion_recordatorio_automatico").ToList();

                        bool enviar = (from ea in envios_automaticos
                                       where
                                         ea.envio_fecha_hora.Date >= desde &&
                                         ea.envio_fecha_hora.Date <= hasta
                                       select ea).Count() == 0;

                        if (enviar)
                        {

                            Envio_mail registro_envio_mail_notificacion = new Envio_mail()
                            {
                                persona_id = tesina.Tesista.Persona.persona_id,
                                envio_fecha_hora = DateTime.Now,
                                envio_email_destino = tesina.Tesista.Persona.persona_email,
                                envio_respuesta_clave = "no se usa",
                                envio_tipo = MiEmail.tipo_mail.notificacion_recordatorio_automatico.ToString()
                            };

                            cxt.Envio_mails.Add(registro_envio_mail_notificacion);

                            MiEmail mail = new MiEmail(registro_envio_mail_notificacion, tesina);

                            if (mail.Enviar_mail())
                            {
                                cxt.SaveChanges();
                            }
                        }
                    }
                }
            }
        }

        public List<Tesina> Obtener_tesinas_por_notificar()
        {
            List<Tesina> ret = new List<Tesina>();

            Verificar_y_marcar_tesinas_vencidas();

            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                Estado_tesina et_vencida = cxt.Estados_tesinas.FirstOrDefault(eett => eett.estado_tesina_estado == "Vencida");
                Estado_tesina et_lista = cxt.Estados_tesinas.FirstOrDefault(eett => eett.estado_tesina_estado == "Lista para presentar");
                Estado_tesina et_aprobada = cxt.Estados_tesinas.FirstOrDefault(eett => eett.estado_tesina_estado == "Aprobada");
                Estado_tesina et_desaprobada = cxt.Estados_tesinas.FirstOrDefault(eett => eett.estado_tesina_estado == "Desaprobada");

                DateTime fecha_actual = DateTime.Today;

                List<Tesina> tesinas = cxt.Tesinas.Include("Estado").Include("Tesista").Include("Tesista.Persona").Where(tt =>
                                                            tt.estado_tesis_id != et_vencida.estado_tesina_id &&
                                                            tt.estado_tesis_id != et_lista.estado_tesina_id &&
                                                            tt.estado_tesis_id != et_aprobada.estado_tesina_id &&
                                                            tt.estado_tesis_id != et_desaprobada.estado_tesina_id
                                                            ).ToList();

                foreach (Tesina tesina in tesinas)
                {
                    //multiplo de avisos automáticos
                    int multiplo = 0;

                    //al salir de aca el multiplo es uno mas que el necesario es decir, el multiplo por el periodo entre avisos nos da la fecha del proximo envio
                    while (tesina.tesina_plan_fch_presentacion.AddMonths(tesina.tesina_plan_aviso_meses * multiplo) <= fecha_actual)
                    {
                        multiplo++;
                    }

                    //descuento uno para obtener la fecha en la que se tuvo que haber enviado la ultima vez
                    multiplo--;

                    //si multiplo es mayor que cero quiere decir que deberia de enviar el aviso, si es que no se envió todavia
                    if (multiplo > 0)
                    {
                        //busco en el periodo (fecha_presentacion + (multiplo * periodo_aviso)) y fecha_actual si se realizaron envios, de no ser asi tengo que realizar el envio
                        DateTime desde = tesina.tesina_plan_fch_presentacion.AddMonths(multiplo * tesina.tesina_plan_aviso_meses);
                        DateTime hasta = fecha_actual;

                        List<Envio_mail> envios_automaticos = cxt.Envio_mails.Where(eemm => eemm.persona_id == tesina.Tesista.Persona.persona_id &&
                                                                             eemm.envio_tipo == "notificacion_recordatorio_automatico").ToList();

                        bool enviar = (from ea in envios_automaticos
                                       where
                                         ea.envio_fecha_hora.Date >= desde &&
                                         ea.envio_fecha_hora.Date <= hasta
                                       select ea).Count() == 0;

                        if (enviar)
                        {
                            ret.Add(tesina);
                        }
                    }
                }
            }

            return ret;
        }

        public void Enviar_notificaciones(List<Tesina> tesinas)
        {
            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                foreach (Tesina tesina in tesinas)
                {
                    Tesina tesina_cxt = cxt.Tesinas.FirstOrDefault(tt => tt.tesina_id == tesina.tesina_id);

                    Envio_mail registro_envio_mail_notificacion = new Envio_mail()
                    {
                        persona_id = tesina_cxt.Tesista.Persona.persona_id,
                        envio_fecha_hora = DateTime.Now,
                        envio_email_destino = tesina_cxt.Tesista.Persona.persona_email,
                        envio_respuesta_clave = "no se usa",
                        envio_tipo = MiEmail.tipo_mail.notificacion_recordatorio_automatico.ToString()
                    };

                    cxt.Envio_mails.Add(registro_envio_mail_notificacion);

                    MiEmail mail = new MiEmail(registro_envio_mail_notificacion, tesina);

                    if (mail.Enviar_mail())
                    {
                        cxt.SaveChanges();
                    }
                }
            }
        }

    }
}