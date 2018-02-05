using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using WebApplication1.Aplicativo.ControlesDeUsuario;

namespace WebApplication1.Aplicativo
{
    public partial class admin_tesinas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ObtenerTesinas();
            }
        }

        struct itemgrilla_tesina
        {
            public int tesis_id { get; set; }
            public string tesista { get; set; }
            public string director { get; set; }
            public string tema_recortado { get; set; }
            public string tema_completo { get; set; }
            public string estado { get; set; }
            public int prioridad_orden { get; set; }
        }

        private void ObtenerTesinas()
        {
            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                Persona usuario_logueado = Session["UsuarioLogueado"] as Persona;
                List<Tesina> tesinas = new List<Tesina>();

                Verificar_y_marcar_tesinas_vencidas();

                if (Session["Perfil"].ToString() == "Administrador")
                {//administrador: obtengo todas las tesinas

                    tesinas = (from t in cxt.Tesinas
                               select t
                               ).ToList();
                }
                else
                {
                    if (Session["Perfil"].ToString() == "Director")
                    {
                        //director: obtengo las tesinas asociadas al director
                        Director dire = cxt.Personas.FirstOrDefault(pp => pp.persona_id == usuario_logueado.persona_id).Director;
                        tesinas = (from t in cxt.Tesinas
                                   where t.director_id == dire.director_id
                                   select t
                                   ).ToList();

                        btn_agregar_tesina.Visible = false;
                        lbl_small_titulo.Text = "Listado de Tesinas bajo su supervisión";
                    }
                    else
                    {
                        //tesista: obtengo la tesina del tesista
                        Tesista tesista = cxt.Personas.FirstOrDefault(pp => pp.persona_id == usuario_logueado.persona_id).Tesista;
                        tesinas = (from t in cxt.Tesinas
                                   where t.tesista_id == tesista.tesista_id
                                   select t
                                   ).ToList();

                        btn_agregar_tesina.Visible = false;
                        lbl_small_titulo.Text = "Tesina presentada";
                    }

                }

                List<itemgrilla_tesina> tesinas_tema_recortado = (from t in tesinas
                                                                  select new itemgrilla_tesina
                                                                  {
                                                                      tesis_id = t.tesina_id,
                                                                      tesista = t.Tesista.Persona.persona_nomyap,
                                                                      director = t.Director.Persona.persona_nomyap,
                                                                      tema_recortado = t.tesina_tema.Length > 20 ? t.tesina_tema.Substring(0, 20) + "..." : t.tesina_tema,
                                                                      tema_completo = t.tesina_tema,
                                                                      estado = t.Estado.estado_tesina_estado,
                                                                      prioridad_orden = Obtener_prioridad(t.Estado.estado_tesina_estado)
                                                                  }).OrderBy(ii => ii.prioridad_orden).ToList();

                if (tesinas_tema_recortado.Count > 0)
                {
                    gv_tesinas.DataSource = tesinas_tema_recortado;
                    gv_tesinas.DataBind();
                    lbl_sin_tesinas.Visible = false;
                }
                else
                {
                    lbl_sin_tesinas.Visible = true;
                }

                //no muestro la columna prioridad
                gv_tesinas.Columns[0].Visible = false;

                //si no es administrador escondo la columna para eliminar o editar la tesina
                if (Session["Perfil"].ToString() != "Administrador")
                {
                    gv_tesinas.Columns[6].Visible = false;
                }
            }
        }

        private void Verificar_y_marcar_tesinas_vencidas()
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
                            envio_tipo = MiEmail.tipo_mail.notificacion_tesina_prorrogada.ToString()
                        };

                        Envio_mail em_tesista = new Envio_mail()
                        {
                            persona_id = tesina.Tesista.Persona.persona_id,
                            envio_email_destino = tesina.Tesista.Persona.persona_email,
                            envio_fecha_hora = DateTime.Now,
                            envio_respuesta_clave = "no se usa",
                            envio_tipo = MiEmail.tipo_mail.notificacion_tesina_prorrogada.ToString()
                        };

                        MiEmail me_director = new MiEmail(em_director, tesina);
                        MiEmail me_tesista = new MiEmail(em_tesista, tesina);

                        me_director.Enviar_mail();
                        me_tesista.Enviar_mail();


                        cxt.SaveChanges();
                    }
                }

            }
        }

        private int Obtener_prioridad(string estado)
        {
            int ret = 99;

            switch (estado)
            {
                case "Prorrogar":
                    ret = 0;
                    break;
                case "Lista para presentar":
                    ret = 1;
                    break;
                case "Iniciada":
                    ret = 2;
                    break;
                case "Entregada":
                    ret = 3;
                    break;
                case "A corregir":
                    ret = 4;
                    break;
                case "Vencida":
                    ret = 5;
                    break;
                case "Aprobada":
                    ret = 6;
                    break;
                case "Desaprobada":
                    ret = 7;
                    break;
                default:
                    break;
            }

            return ret;
        }

        protected void btn_aceptar_eliminacion_Click(object sender, EventArgs e)
        {
            int id_tesina = Convert.ToInt32(id_item_por_eliminar.Value);

            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                Tesina tesina = cxt.Tesinas.FirstOrDefault(tt => tt.tesina_id == id_tesina);

                if (tesina.Estado.estado_tesina_estado == "Iniciada")
                {
                    //Enviar correos a tesista y director sobre eliminacion de la tesis
                    Envio_mail em_director = new Envio_mail()
                    {
                        envio_email_destino = tesina.Director.Persona.persona_email,
                        envio_fecha_hora = DateTime.Now,
                        envio_respuesta_clave = "",
                        envio_tipo = MiEmail.tipo_mail.notificacion_eliminacion_tesina_director.ToString(),
                        persona_id = tesina.Director.Persona.persona_id
                    };

                    Envio_mail em_tesista = new Envio_mail()
                    {
                        envio_email_destino = tesina.Tesista.Persona.persona_email,
                        envio_fecha_hora = DateTime.Now,
                        envio_respuesta_clave = "",
                        envio_tipo = MiEmail.tipo_mail.notificacion_eliminacion_tesina_tesista.ToString(),
                        persona_id = tesina.Tesista.Persona.persona_id
                    };

                    MiEmail mail_director = new MiEmail(em_director, tesina);
                    MiEmail mail_tesista = new MiEmail(em_tesista, tesina);

                    mail_director.Enviar_mail();
                    mail_tesista.Enviar_mail();

                    cxt.Historial_estados.RemoveRange(tesina.Historial_estados);
                    cxt.Tesinas.Remove(tesina);
                    cxt.SaveChanges();

                    MessageBox.Show(this, "Se ha eliminado correctamente la tesina.", MessageBox.Tipo_MessageBox.Success);
                    ObtenerTesinas();
                }
                else
                {
                    MessageBox.Show(this, "No se puede eliminar una tesina cuyo estado sea posterior al de iniciada");
                }
            }

            ObtenerTesinas();
        }

        protected void btn_ver_ServerClick(object sender, EventArgs e)
        {
            int id_tesina = Convert.ToInt32(((HtmlButton)sender).Attributes["data-id"]);

            if (id_tesina != 0)
            {
                using (HabProfDBContainer cxt = new HabProfDBContainer())
                {
                    hidden_tesina_id.Value = id_tesina.ToString();
                    Tesina tesina = cxt.Tesinas.FirstOrDefault(tt => tt.tesina_id == id_tesina);

                    lbl_alta.Text = tesina.tesina_plan_fch_presentacion.ToShortDateString();
                    lbl_calificacion.Text = tesina.tesina_calificacion == null ? "-" : tesina.tesina_calificacion.ToString();
                    lbl_calificacion_director.Text = tesina.tesina_calificacion_director == null ? "-" : tesina.tesina_calificacion_director.ToString();
                    lbl_descripcion.Text = tesina.tesina_descripcion;
                    lbl_director.Text = tesina.Director.Persona.persona_nomyap;
                    lbl_duracion.Text = tesina.tesina_plan_duracion_meses.ToString() + " meses.";
                    lbl_estado.Text = tesina.Estado.estado_tesina_estado;
                    lbl_periodo_notificaciones.Text = tesina.tesina_plan_aviso_meses.ToString() + " meses.";
                    lbl_tema.Text = tesina.tesina_tema;
                    lbl_tesista.Text = tesina.Tesista.Persona.persona_nomyap;
                    string archivo = Server.MapPath("~/Archivos/Tesinas/" + hidden_tesina_id.Value + "/presentado.pdf");
                    if (File.Exists(archivo))
                    {
                        lbl_archivo_subido.HRef = "~/Archivos/Tesinas/" + hidden_tesina_id.Value + "/presentado.pdf";
                        lbl_archivo_subido.InnerText = "Archivo presentado";
                    }
                    else
                    {
                        lbl_archivo_subido.HRef = "#";
                        lbl_archivo_subido.InnerText = "Sin presentaciones";
                    }

                    foreach (Juez juez in tesina.Jueces)
                    {
                        lbl_jueces_tesina_visualizacion.Text = lbl_jueces_tesina_visualizacion.Text + juez.Persona.persona_nomyap + "; ";
                    }

                    var historial = (from he in tesina.Historial_estados
                                     select new
                                     {
                                         fecha = he.historial_tesina_fecha,
                                         estado = he.Estado.estado_tesina_estado,
                                         observacion_completa = he.historial_tesina_descripcion
                                     }).ToList();

                    var historial_con_observacion_recortada = (from he in historial
                                                               select new
                                                               {
                                                                   fecha = he.fecha,
                                                                   estado = he.estado,
                                                                   observacion_completa = he.observacion_completa,
                                                                   observacion_recortada = he.observacion_completa.Length > 40 ? he.observacion_completa.Substring(0, 40) + "..." : he.observacion_completa
                                                               }).ToList();

                    gv_historial.DataSource = historial_con_observacion_recortada;
                    gv_historial.DataBind();

                    Mostrar_botones_segun_estado();

                    string script = "<script language=\"javascript\"  type=\"text/javascript\">$(document).ready(function() { $('#panel_ver_tesina').modal('show')});</script>";
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "ShowPopUp", script, false);

                }
            }

        }

        private void Mostrar_botones_segun_estado()
        {
            int tesina_id = Convert.ToInt32(hidden_tesina_id.Value);
            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                Tesina t = cxt.Tesinas.FirstOrDefault(tt => tt.tesina_id == tesina_id);

                btn_realizar_entrega.Visible = false;
                btn_devolver_para_corregir.Visible = false;
                btn_lista_para_presentar.Visible = false;
                btn_prorroga.Visible = false;
                btn_aprobar.Visible = false;
                btn_desaprobar.Visible = false;

                switch (t.Estado.estado_tesina_estado)
                {
                    case "Iniciada":
                        btn_realizar_entrega.Visible = true;
                        break;
                    case "Entregada":
                        if (Session["Perfil"].ToString() != "Tesista")
                        {
                            btn_devolver_para_corregir.Visible = true;
                            btn_lista_para_presentar.Visible = true;
                        }
                        break;
                    case "A corregir":
                        if (Session["Perfil"].ToString() != "Tesista")
                        {
                            btn_realizar_entrega.Visible = true;
                        }
                        break;
                    case "Lista para presentar":
                        if (Session["Perfil"].ToString() == "Administrador")
                        {
                            btn_aprobar.Visible = true;
                            btn_desaprobar.Visible = true;
                        }
                        break;
                    case "Vencida":
                        if (Session["Perfil"].ToString() == "Administrador")
                        {
                            btn_prorroga.Visible = true;
                        }
                        break;
                    case "Prorrogar":
                        btn_realizar_entrega.Visible = true;
                        break;
                    case "Aprobada":
                        break;
                    case "Desaprobada":
                        break;
                    default:
                        break;
                }

            }

        }

        protected void gv_tesinas_PreRender(object sender, EventArgs e)
        {
            if (gv_tesinas.Rows.Count > 0)
            {
                gv_tesinas.HeaderRow.TableSection = TableRowSection.TableHeader;
            }

            if (gv_historial.Rows.Count > 0)
            {
                gv_historial.HeaderRow.TableSection = TableRowSection.TableHeader;
            }

            if (gv_jueces.Rows.Count > 0)
            {
                gv_jueces.HeaderRow.TableSection = TableRowSection.TableHeader;
            }
        }

        protected void btn_editar_ServerClick(object sender, EventArgs e)
        {
            string id_tesina = ((HtmlButton)sender).Attributes["data-id"];
            Response.Redirect("~/Aplicativo/admin_tesina.aspx?t=" + id_tesina);
        }

        protected void btn_agregar_tesina_ServerClick(object sender, EventArgs e)
        {
            Response.Redirect("~/Aplicativo/admin_tesina.aspx");
        }

        protected void btn_realizar_entrega_ServerClick(object sender, EventArgs e)
        {
            btn_guardar_realizar_entrega.Enabled = false;
            btn_subir_archivo.Enabled = true;
            status_label.Visible = false;
            file_tesis.Enabled = true;

            string script = "<script language=\"javascript\"  type=\"text/javascript\">$(document).ready(function() { $('#panel_ver_tesina').modal('show'); $('#realizar_entrega').modal('show')});</script>";
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "ShowPopUp", script, false);
        }

        protected void btn_subir_archivo_Click(object sender, EventArgs e)
        {
            if (file_tesis.HasFile)
            {
                try
                {
                    string directorio = Server.MapPath("~/Archivos/Tesinas/" + hidden_tesina_id.Value + "/");

                    if (!Directory.Exists(directorio))
                    {
                        Directory.CreateDirectory(directorio);
                    }

                    string filename = Path.GetFileName(file_tesis.FileName);
                    file_tesis.SaveAs(directorio + "borrador.pdf");
                    status_label.Text = "Se subio correctamente el archivo!";
                    div_status_file.Attributes.Add("class", "alert alert-success");
                    file_tesis.Enabled = false;
                    btn_guardar_realizar_entrega.Enabled = true;
                    btn_subir_archivo.Enabled = false;
                }
                catch (Exception ex)
                {
                    status_label.Text = "Ocurrio un error y no se pudo subir el archivo. Error: " + ex.Message;
                    div_status_file.Attributes.Add("class", "alert alert-danger");
                }

            }
            else
            {
                status_label.Text = "Debe seleccionar un archivo!";
                div_status_file.Attributes.Add("class", "alert alert-danger");
            }

            string script = "<script language=\"javascript\"  type=\"text/javascript\">$(document).ready(function() { $('#panel_ver_tesina').modal('show'); $('#realizar_entrega').modal('show')});</script>";
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "ShowPopUp", script, false);
        }

        protected void btn_guardar_realizar_entrega_Click(object sender, EventArgs e)
        {
            string directorio = Server.MapPath("~/Archivos/Tesinas/" + hidden_tesina_id.Value + "/");
            int tesina_id = Convert.ToInt32(hidden_tesina_id.Value);
            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                File.Copy(directorio + "borrador.pdf", directorio + "presentado.pdf", true);
                Tesina t = cxt.Tesinas.FirstOrDefault(tt => tt.tesina_id == tesina_id);
                Estado_tesina et = cxt.Estados_tesinas.FirstOrDefault(ee => ee.estado_tesina_estado == "Entregada");

                Historial_estado he = new Historial_estado()
                {
                    estado_tesina_id = et.estado_tesina_id,
                    tesina_id = tesina_id,
                    historial_tesina_fecha = DateTime.Now,
                    historial_tesina_descripcion = "Se entregó satisfactoriamente la tesina para ser evaluada por el director."
                };

                t.estado_tesis_id = et.estado_tesina_id;
                cxt.Historial_estados.Add(he);

                Envio_mail em_director = new Envio_mail()
                {
                    persona_id = t.Director.Persona.persona_id,
                    envio_email_destino = t.Director.Persona.persona_email,
                    envio_fecha_hora = DateTime.Now,
                    envio_respuesta_clave = "no se usa",
                    envio_tipo = MiEmail.tipo_mail.notificacion_entrega_archivo_tesina.ToString()
                };

                Envio_mail em_tesista = new Envio_mail()
                {
                    persona_id = t.Tesista.Persona.persona_id,
                    envio_email_destino = t.Tesista.Persona.persona_email,
                    envio_fecha_hora = DateTime.Now,
                    envio_respuesta_clave = "no se usa",
                    envio_tipo = MiEmail.tipo_mail.notificacion_entrega_archivo_tesina.ToString()
                };

                MiEmail me_director = new MiEmail(em_director, t);
                MiEmail me_tesista = new MiEmail(em_tesista, t);

                me_director.Enviar_mail();
                me_tesista.Enviar_mail();

                cxt.SaveChanges();

                ObtenerTesinas();
            }
        }

        protected void btn_enviar_a_corregir_Click(object sender, EventArgs e)
        {
            int tesina_id = Convert.ToInt32(hidden_tesina_id.Value);
            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                Tesina t = cxt.Tesinas.FirstOrDefault(tt => tt.tesina_id == tesina_id);

                Estado_tesina et = cxt.Estados_tesinas.FirstOrDefault(ee => ee.estado_tesina_estado == "A corregir");

                string descripcion = string.Empty;
                descripcion = descripcion + (opcion_1.Checked ? opcion_1.Text : "");
                descripcion = descripcion + (opcion_2.Checked ? opcion_2.Text : "");
                descripcion = descripcion + (opcion_3.Checked ? opcion_3.Text : "");

                Historial_estado he = new Historial_estado()
                {
                    estado_tesina_id = et.estado_tesina_id,
                    tesina_id = tesina_id,
                    historial_tesina_fecha = DateTime.Now,
                    historial_tesina_descripcion = descripcion//tb_descripcion_rechazo.Value
                };

                t.estado_tesis_id = et.estado_tesina_id;
                cxt.Historial_estados.Add(he);

                Envio_mail em_director = new Envio_mail()
                {
                    persona_id = t.Director.Persona.persona_id,
                    envio_email_destino = t.Director.Persona.persona_email,
                    envio_fecha_hora = DateTime.Now,
                    envio_respuesta_clave = "no se usa",
                    envio_tipo = MiEmail.tipo_mail.notificacion_correcciones_tesina.ToString()
                };

                Envio_mail em_tesista = new Envio_mail()
                {
                    persona_id = t.Tesista.Persona.persona_id,
                    envio_email_destino = t.Tesista.Persona.persona_email,
                    envio_fecha_hora = DateTime.Now,
                    envio_respuesta_clave = "no se usa",
                    envio_tipo = MiEmail.tipo_mail.notificacion_correcciones_tesina.ToString()
                };

                MiEmail me_director = new MiEmail(em_director, t);
                MiEmail me_tesista = new MiEmail(em_tesista, t);

                me_director.Enviar_mail();
                me_tesista.Enviar_mail();

                cxt.SaveChanges();

                //tb_descripcion_rechazo.Value = "";

                ObtenerTesinas();
            }
        }

        protected void btn_pasar_a_lista_para_presentar_Click(object sender, EventArgs e)
        {
            int tesina_id = Convert.ToInt32(hidden_tesina_id.Value);
            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                Tesina t = cxt.Tesinas.FirstOrDefault(tt => tt.tesina_id == tesina_id);

                Estado_tesina et = cxt.Estados_tesinas.FirstOrDefault(ee => ee.estado_tesina_estado == "Lista para presentar");

                string descripcion = string.Empty;
                descripcion = descripcion + (rb_opcion_1_lista_presentar.Checked ? rb_opcion_1_lista_presentar.Text : "");
                descripcion = descripcion + (rb_opcion_2_lista_presentar.Checked ? rb_opcion_2_lista_presentar.Text : "");
                descripcion = descripcion + (rb_opcion_3_lista_presentar.Checked ? rb_opcion_3_lista_presentar.Text : "");

                Historial_estado he = new Historial_estado()
                {
                    estado_tesina_id = et.estado_tesina_id,
                    tesina_id = tesina_id,
                    historial_tesina_fecha = DateTime.Now,
                    historial_tesina_descripcion = descripcion//tb_descripcion_lista_para_presentar.Value
                };

                t.estado_tesis_id = et.estado_tesina_id;
                cxt.Historial_estados.Add(he);

                Envio_mail em_director = new Envio_mail()
                {
                    persona_id = t.Director.Persona.persona_id,
                    envio_email_destino = t.Director.Persona.persona_email,
                    envio_fecha_hora = DateTime.Now,
                    envio_respuesta_clave = "no se usa",
                    envio_tipo = MiEmail.tipo_mail.notificacion_tesina_lista_para_presentar.ToString()
                };

                Envio_mail em_tesista = new Envio_mail()
                {
                    persona_id = t.Tesista.Persona.persona_id,
                    envio_email_destino = t.Tesista.Persona.persona_email,
                    envio_fecha_hora = DateTime.Now,
                    envio_respuesta_clave = "no se usa",
                    envio_tipo = MiEmail.tipo_mail.notificacion_tesina_lista_para_presentar.ToString()
                };

                MiEmail me_director = new MiEmail(em_director, t);
                MiEmail me_tesista = new MiEmail(em_tesista, t);

                me_director.Enviar_mail();
                me_tesista.Enviar_mail();


                cxt.SaveChanges();

                //tb_descripcion_lista_para_presentar.Value = "";

                ObtenerTesinas();
            }
        }

        protected void btn_prorrogar_Click(object sender, EventArgs e)
        {
            int tesina_id = Convert.ToInt32(hidden_tesina_id.Value);
            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                Tesina t = cxt.Tesinas.FirstOrDefault(tt => tt.tesina_id == tesina_id);

                Estado_tesina et = cxt.Estados_tesinas.FirstOrDefault(ee => ee.estado_tesina_estado == "Prorrogar");

                Historial_estado he = new Historial_estado()
                {
                    estado_tesina_id = et.estado_tesina_id,
                    tesina_id = tesina_id,
                    historial_tesina_fecha = DateTime.Now,
                    historial_tesina_descripcion = "Se otorgo la prorroga solicitada"
                };

                t.estado_tesis_id = et.estado_tesina_id;
                t.tesina_plan_fch_presentacion = Convert.ToDateTime(tb_fecha_inicio.Value);
                t.tesina_plan_duracion_meses = Convert.ToInt16(tb_duracion.Value);
                t.tesina_plan_aviso_meses = Convert.ToInt16(tb_notificacion.Value);
                cxt.Historial_estados.Add(he);

                Envio_mail em_director = new Envio_mail()
                {
                    persona_id = t.Director.Persona.persona_id,
                    envio_email_destino = t.Director.Persona.persona_email,
                    envio_fecha_hora = DateTime.Now,
                    envio_respuesta_clave = "no se usa",
                    envio_tipo = MiEmail.tipo_mail.notificacion_tesina_prorrogada.ToString()
                };

                Envio_mail em_tesista = new Envio_mail()
                {
                    persona_id = t.Tesista.Persona.persona_id,
                    envio_email_destino = t.Tesista.Persona.persona_email,
                    envio_fecha_hora = DateTime.Now,
                    envio_respuesta_clave = "no se usa",
                    envio_tipo = MiEmail.tipo_mail.notificacion_tesina_prorrogada.ToString()
                };

                MiEmail me_director = new MiEmail(em_director, t);
                MiEmail me_tesista = new MiEmail(em_tesista, t);

                me_director.Enviar_mail();
                me_tesista.Enviar_mail();


                cxt.SaveChanges();

                tb_fecha_inicio.Value = "";
                tb_duracion.Value = "";
                tb_notificacion.Value = "";

                ObtenerTesinas();
            }
        }

        protected void cv_notificacion_ServerValidate(object source, ServerValidateEventArgs args)
        {
            int duracion;
            if (!int.TryParse(tb_duracion.Value, out duracion))
            {
                duracion = 0;
            }

            int notificaciones;
            if (!int.TryParse(tb_notificacion.Value, out notificaciones))
            {
                notificaciones = 0;
            }

            args.IsValid = notificaciones <= duracion;
        }

        protected void cv_fecha_inicio_ServerValidate(object source, ServerValidateEventArgs args)
        {
            DateTime fecha;
            if (DateTime.TryParse(tb_fecha_inicio.Value, out fecha))
            {
                args.IsValid = true;
            }
            else
            {
                args.IsValid = false;
            }
        }

        protected void btn_guardar_aprobar_tesina_Click(object sender, EventArgs e)
        {
            int tesina_id = Convert.ToInt32(hidden_tesina_id.Value);
            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                Tesina t = cxt.Tesinas.FirstOrDefault(tt => tt.tesina_id == tesina_id);

                Estado_tesina et;

                if (lbl_aprobar_desaprobar_tesina.Text == "Aprobar Tesina")
                {
                    et = cxt.Estados_tesinas.FirstOrDefault(ee => ee.estado_tesina_estado == "Aprobada");
                }
                else
                {
                    et = cxt.Estados_tesinas.FirstOrDefault(ee => ee.estado_tesina_estado == "Desaprobada");
                }

                Historial_estado he = new Historial_estado()
                {
                    estado_tesina_id = et.estado_tesina_id,
                    tesina_id = tesina_id,
                    historial_tesina_fecha = DateTime.Now,
                    historial_tesina_descripcion = tb_descripcion_aprobar_tesina.Value
                };

                t.estado_tesis_id = et.estado_tesina_id;
                t.tesina_calificacion = Convert.ToInt16(tb_calificacion_tesina_aprobada.Value);
                t.tesina_calificacion_director = Convert.ToInt16(tb_calificacion_director_aprobada.Value);
                cxt.Historial_estados.Add(he);

                foreach (string str_id_juez in hidden_ids_jueces.Value.Split(','))
                {
                    int id_juez;
                    if (int.TryParse(str_id_juez, out id_juez))
                    {
                        t.Jueces.Add(cxt.Jueces.FirstOrDefault(jj => jj.juez_id == id_juez));
                    }
                }

                cxt.SaveChanges();

                tb_calificacion_tesina_aprobada.Value = "";
                tb_calificacion_director_aprobada.Value = "";
                tb_descripcion_aprobar_tesina.Value = "";

                ObtenerTesinas();
            }
        }

        protected void btn_aprobar_ServerClick(object sender, EventArgs e)
        {
            hidden_ids_jueces.Value = string.Empty;
            lbl_jueces.Text= "Seleccione los jueces que participaron de la grilla desplegada aquí debajo";
            lbl_aprobar_desaprobar_tesina.Text = "Aprobar Tesina";
            CargarJueces();
            btn_guardar_aprobar_tesina.Attributes.Add("CssClass", "btn btn-success");
            btn_guardar_aprobar_tesina.Text = "Aprobar Tesina";
            string script = "<script language=\"javascript\"  type=\"text/javascript\">$(document).ready(function() { $('#panel_ver_tesina').modal('show'); $('#aprobar_tesina').modal('show')});</script>";
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "ShowPopUp", script, false);
        }

        protected void btn_desaprobar_ServerClick(object sender, EventArgs e)
        {
            hidden_ids_jueces.Value = string.Empty;
            lbl_jueces.Text = "Seleccione los jueces que participaron de la grilla desplegada aquí debajo";
            lbl_aprobar_desaprobar_tesina.Text = "Desaprobar Tesina";
            CargarJueces();
            btn_guardar_aprobar_tesina.Attributes.Add("CssClass", "btn btn-danger");
            btn_guardar_aprobar_tesina.Text = "Desaprobar Tesina";
            string script = "<script language=\"javascript\"  type=\"text/javascript\">$(document).ready(function() { $('#panel_ver_tesina').modal('show'); $('#aprobar_tesina').modal('show')});</script>";
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "ShowPopUp", script, false);
        }

        private void CargarJueces()
        {
            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                var jueces = (from d in cxt.Jueces
                              where d.juez_fecha_baja == null
                              select d).ToList();

                var jueces_con_tesina_a_cargo = (from d in jueces
                                                 select new
                                                 {
                                                     juez_id = d.juez_id,
                                                     juez_persona_nomyap = d.Persona.persona_nomyap,
                                                     juez_persona_dni = d.Persona.persona_dni,
                                                     juez_persona_email = d.Persona.persona_email
                                                 }).ToList();

                if (jueces_con_tesina_a_cargo.Count() > 0)
                {
                    gv_jueces.DataSource = jueces_con_tesina_a_cargo;
                    gv_jueces.DataBind();
                }
                else
                {
                    gv_jueces.DataSource = null;
                    gv_jueces.DataBind();
                }

            }
        }

        protected void chk_seleccion_juez_CheckedChanged(object sender, EventArgs e)
        {
            List<string> ids = hidden_ids_jueces.Value.Split(',').ToList();
            CheckBox chk = ((CheckBox)sender);

            if (chk.Checked)
            {
                //agregar el juez al listado
                ids.Add(chk.AccessKey);
            }
            else
            {
                //quitar el juez del listado
                if (ids.IndexOf(chk.AccessKey) >= 0)
                {
                    ids.RemoveAt(ids.IndexOf(chk.AccessKey));
                }
            }

            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                string texto_para_el_label = string.Empty;
                string texto_para_el_hidden = string.Empty;
                foreach (string str_id_juez in ids)
                {
                    int id_juez;
                    if (int.TryParse(str_id_juez, out id_juez))
                    {
                        texto_para_el_label = texto_para_el_label + cxt.Personas.FirstOrDefault(pp => pp.Juez.juez_id == id_juez).persona_nomyap + "; ";
                        texto_para_el_hidden = texto_para_el_hidden + id_juez.ToString() + ",";
                    }
                }

                lbl_jueces.Text = texto_para_el_label;
                hidden_ids_jueces.Value = texto_para_el_hidden;
            }

            string script = "<script language=\"javascript\"  type=\"text/javascript\">$(document).ready(function() { $('#panel_ver_tesina').modal('show'); $('#aprobar_tesina').modal('show')});</script>";
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "ShowPopUp", script, false);

        }

        protected void cv_jueces_ServerValidate(object source, ServerValidateEventArgs args)
        {
            bool hay_jueces = false;

            foreach (string str_id_juez in hidden_ids_jueces.Value.Split(','))
            {
                int id_juez;
                if (int.TryParse(str_id_juez, out id_juez))
                {
                    hay_jueces = true;
                    break;
                }
            }

            args.IsValid = hay_jueces;

            string script = "<script language=\"javascript\"  type=\"text/javascript\">$(document).ready(function() { $('#panel_ver_tesina').modal('show'); $('#aprobar_tesina').modal('show')});</script>";
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "ShowPopUp", script, false);
        }
    }
}