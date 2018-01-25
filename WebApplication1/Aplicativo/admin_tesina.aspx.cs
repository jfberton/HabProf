using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using WebApplication1.Aplicativo.ControlesDeUsuario;

namespace WebApplication1.Aplicativo
{
    public partial class admin_tesina : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Verificar_Acceso();
                Mostrar_datos_tesina();
            }

        }

        /// <summary>
        /// Verifico el usuario que esta logueado y si puede ver esta pagina
        /// </summary>
        private void Verificar_Acceso()
        {
            Persona usuario = Session["UsuarioLogueado"] as Persona;
            string perfil = Session["Perfil"].ToString();
            string str_tesina_id = Request.QueryString["t"];
            if (str_tesina_id == null)
            {
                //la tesina es nueva o sea tiene que ser administrador
                if (perfil != "Administrador")
                {
                    MessageBox.Show(this, "Usted no tiene permiso para acceder a esta página", MessageBox.Tipo_MessageBox.Danger, "Acceso restringido", "../default.aspx");
                }
            }
            else
            {
                int tesina_id;
                if (int.TryParse(str_tesina_id, out tesina_id))
                {
                    //existe la tesina, entro a editar, si el perfil es director o tesista, los mismos tienen que estar asignados a la tesina, sino fuera!
                    using (HabProfDBContainer cxt = new HabProfDBContainer())
                    {
                        if (perfil == "Director")
                        {
                            Persona p = cxt.Personas.FirstOrDefault(pp => pp.persona_id == usuario.persona_id);
                            //se que la persona tiene perfil director porque se logueo con ese perfil, por eso consulto por p.Director.director_id sin miedo a que de error
                            Tesina t = cxt.Tesinas.FirstOrDefault(tt => tt.director_id == p.Director.director_id && tt.tesina_id == tesina_id);
                            if (t == null)
                            {
                                //ese director no tiene la tesina que se esta por editar entre sus tesinas
                                MessageBox.Show(this, "Usted no tiene permiso para acceder a esta página", MessageBox.Tipo_MessageBox.Danger, "Acceso restringido", "../default.aspx");
                            }
                        }

                        if (perfil == "Tesista")
                        {
                            Persona p = cxt.Personas.FirstOrDefault(pp => pp.persona_id == usuario.persona_id);
                            //se que la persona tiene perfil director porque se logueo con ese perfil, por eso consulto por p.Director.director_id sin miedo a que de error
                            Tesina t = cxt.Tesinas.FirstOrDefault(tt => tt.director_id == p.Tesista.tesista_id && tt.tesina_id == tesina_id);
                            if (t == null)
                            {
                                //ese tesista no tiene la tesina que se esta por editar
                                MessageBox.Show(this, "Usted no tiene permiso para acceder a esta página", MessageBox.Tipo_MessageBox.Danger, "Acceso restringido", "../default.aspx");
                            }
                        }
                    }
                }
                else
                {
                    MessageBox.Show(this, "Usted no tiene permiso para acceder a esta página", MessageBox.Tipo_MessageBox.Danger, "Acceso restringido", "../default.aspx");
                }
            }
        }

        private void Mostrar_datos_tesina()
        {
            string str_tesina_id = Request.QueryString["t"];

            if (str_tesina_id == null)
            {
                //tesina nueva
                lbl_bread_last_page.Text = "Agregar Tesina";
                tb_tema.Value = "";
                tb_descripcion.Value = "";
                tb_fecha_inicio.Value = "";
                tb_tesista.Value = "";
                tb_director.Value = "";
                tb_duracion.Value = "";
                tb_notificacion.Value = "";
                tb_estado.Text = "";
                div_archivo.Visible = false;
            }
            else
            {
                using (HabProfDBContainer cxt = new HabProfDBContainer())
                {
                    int tesina_id = Convert.ToInt32(str_tesina_id);
                    Tesina t = cxt.Tesinas.FirstOrDefault(tt => tt.tesina_id == tesina_id);
                    if (t != null)
                    {
                        lbl_bread_last_page.Text = "Editar Tesina";
                        tb_tema.Value = t.tesina_tema;
                        tb_descripcion.Value = t.tesina_descripcion;
                        tb_fecha_inicio.Value = t.tesina_plan_fch_presentacion.ToShortDateString();
                        tb_tesista.Value = t.Tesista.Persona.persona_nomyap;
                        hidden_tesista_id.Value = t.tesista_id.ToString();
                        tb_director.Value = t.Director.Persona.persona_nomyap;
                        hidden_director_id.Value = t.director_id.ToString();
                        tb_duracion.Value = t.tesina_plan_duracion_meses.ToString();
                        tb_notificacion.Value = t.tesina_plan_aviso_meses.ToString();
                        tb_estado.Text = t.Estado.estado_tesina_estado;
                        btn_buscar_tesista.Visible = false;
                        Cargar_historial_estados();
                    }

                }
            }
        }

        private void Cargar_historial_estados()
        {
            string str_tesina_id = Request.QueryString["t"];
            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                if (str_tesina_id != null)
                {
                    int tesina_id = Convert.ToInt32(str_tesina_id);
                    Tesina t = cxt.Tesinas.FirstOrDefault(tt => tt.tesina_id == tesina_id);
                    if (t != null)
                    {
                        var historial = (from he in t.Historial_estados
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


                    }
                }
                else
                {
                    btn_buscar_tesista.Visible = true;
                }
            }
        }

        protected void btn_cancelar_ServerClick(object sender, EventArgs e)
        {
            Session["Tesina"] = null;
            Response.Redirect("~/Aplicativo/admin_tesinas.aspx");
        }

        protected void gv_PreRender(object sender, EventArgs e)
        {
            if (gv_historial.Rows.Count > 0)
            {
                gv_historial.HeaderRow.TableSection = TableRowSection.TableHeader;
            }

            if (gv_tesistas.Rows.Count > 0)
            {
                gv_tesistas.HeaderRow.TableSection = TableRowSection.TableHeader;
            }

            if (gv_directores.Rows.Count > 0)
            {
                gv_directores.HeaderRow.TableSection = TableRowSection.TableHeader;
            }
        }

        protected void btn_tesina_ver_historial_ServerClick(object sender, EventArgs e)
        {
            Cargar_historial_estados();

            string script = "<script language=\"javascript\"  type=\"text/javascript\">$(document).ready(function() { $('#ver_historial_de_estados').modal('show')});</script>";
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "ShowPopUp", script, false);
        }

        protected void btn_buscar_tesista_ServerClick(object sender, EventArgs e)
        {
            using (HabProfDBContainer cxt = new Aplicativo.HabProfDBContainer())
            {
                var tesistas = (
                    from t in cxt.Tesistas
                    where t.Persona.persona_fecha_baja == null && t.Tesina.Where(tt => tt.tesina_fecha_cierre == null).Count() == 0
                    select new
                    {
                        tesista_id = t.tesista_id,
                        persona_nomyap = t.Persona.persona_nomyap,
                        persona_dni = t.Persona.persona_dni,
                        persona_email = t.Persona.persona_email,
                        tesista_legajo = t.tesista_legajo,
                        tesista_sede = t.tesista_sede
                    }).ToList();

                if (tesistas.Count() > 0)
                {
                    lbl_sin_tesistas_habilitados.Visible = false;
                    gv_tesistas.DataSource = tesistas;
                    gv_tesistas.DataBind();
                }
                else
                {
                    lbl_sin_tesistas_habilitados.Visible = true;
                    gv_tesistas.DataSource = null;
                    gv_tesistas.DataBind();
                }

            }

            string script = "<script language=\"javascript\"  type=\"text/javascript\">$(document).ready(function() { $('#buscar_tesista').modal('show')});</script>";
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "ShowPopUp", script, false);
        }

        protected void btn_buscar_director_ServerClick(object sender, EventArgs e)
        {
            using (HabProfDBContainer cxt = new Aplicativo.HabProfDBContainer())
            {
                var directores = (from d in cxt.Directores
                                  where d.Persona.persona_fecha_baja == null
                                  select d).ToList();

                var directores_con_tesina_a_cargo = (from d in directores
                                                     select new
                                                     {
                                                         director_id = d.director_id,
                                                         persona_nomyap = d.Persona.persona_nomyap,
                                                         persona_dni = d.Persona.persona_dni,
                                                         persona_email = d.Persona.persona_email,
                                                         director_calificacion = d.Calificacion_general
                                                     }).ToList();


                if (directores_con_tesina_a_cargo.Count() > 0)
                {
                    gv_directores.DataSource = directores_con_tesina_a_cargo;
                    gv_directores.DataBind();
                    lbl_sin_directores.Visible = false;
                }
                else
                {
                    lbl_sin_directores.Visible = true;
                    gv_directores.DataSource = null;
                    gv_directores.DataBind();
                }

            }

            string script = "<script language=\"javascript\"  type=\"text/javascript\">$(document).ready(function() { $('#buscar_director').modal('show')});</script>";
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "ShowPopUp", script, false);
        }

        protected void btn_seleccionar_tesista_Click(object sender, EventArgs e)
        {
            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                int id_tesista = Convert.ToInt32(((HtmlButton)sender).Attributes["data-id"]);

                Tesista tesista = cxt.Tesistas.FirstOrDefault(pp => pp.tesista_id == id_tesista);
                if (tesista != null)
                {
                    tb_tesista.Value = tesista.Persona.persona_nomyap;
                    hidden_tesista_id.Value = tesista.tesista_id.ToString();
                }
            }
        }

        protected void btn_seleccionar_director_ServerClick(object sender, EventArgs e)
        {
            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                int id_director = Convert.ToInt32(((HtmlButton)sender).Attributes["data-id"]);

                Director director = cxt.Directores.FirstOrDefault(pp => pp.director_id == id_director);
                if (director != null)
                {
                    tb_director.Value = director.Persona.persona_nomyap;
                    hidden_director_id.Value = director.director_id.ToString();
                }
            }
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

        private struct resultado_coincidencias
        {
            public Tesina tesina { get; set; }
            public string html_tema { get; set; }
            public string html_descripcion { get; set; }
        }

        protected void btn_verificar_tesina_Click(object sender, EventArgs e)
        {
            if (IsValid)//revisa que se cumplan todos las validaciones de ingreso
            {
                #region controlo tema y descripción

                List<resultado_coincidencias> resultados = new List<resultado_coincidencias>();
                Buscar buscar;
                using (HabProfDBContainer cxt = new HabProfDBContainer())
                {
                    List<Tesina> tesinas = cxt.Tesinas.Include("Tesista").Include("Tesista.Persona").ToList();
                    string html_tema = string.Empty;
                    string html_descripcion = string.Empty;

                    foreach (Tesina tesina in tesinas)
                    {
                        int coincidencias = 0;
                        buscar = new Buscar(tb_tema.Value, tesina.tesina_tema);
                        if (buscar.Hubo_coincidencia)
                        {
                            coincidencias++;
                            html_tema = buscar.Texto_con_palabras_resaltadas;
                        }

                        buscar = new Buscar(tb_descripcion.Value, tesina.tesina_descripcion);
                        if (buscar.Hubo_coincidencia)
                        {
                            coincidencias++;
                            html_descripcion = buscar.Texto_con_palabras_resaltadas;
                        }

                        if (coincidencias > 0)
                        {
                            resultados.Add(new resultado_coincidencias()
                            {
                                tesina = tesina,
                                html_tema = html_tema,
                                html_descripcion = html_descripcion
                            });
                        }

                    }
                }

                if (resultados.Count > 0)
                {
                    foreach (resultado_coincidencias item in resultados)
                    {
                        HtmlGenericControl div_panel_cascara = new HtmlGenericControl("div");
                        div_panel_cascara.Attributes["class"] = "panel panel-default";

                        HtmlGenericControl div_panel_heading = new HtmlGenericControl("div");
                        div_panel_heading.Attributes["class"] = "panel-heading";
                        div_panel_heading.InnerHtml = "Presentada por: " + item.tesina.Tesista.Persona.persona_nomyap;

                        HtmlGenericControl div_panel_body = new HtmlGenericControl("div");
                        div_panel_body.Attributes["class"] = "panel-body";
                        div_panel_body.InnerHtml = "<p>" + "Tema: " + item.html_tema + "</p> <p>Descripción: " + item.html_descripcion + "</p>";


                        div_panel_cascara.Controls.Add(div_panel_heading);
                        div_panel_cascara.Controls.Add(div_panel_body);
                        div_coincidencias.Controls.Add(div_panel_cascara);
                    }

                    string script = "<script language=\"javascript\"  type=\"text/javascript\">$(document).ready(function() { $('#mostrar_coincidencias').modal('show')});</script>";
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "ShowPopUp", script, false);
                }
                else
                {
                    btn_guardar_tesina.Enabled = true;
                }

                #endregion
            }
        }

        protected void btn_habilitar_guardar_Click(object sender, EventArgs e)
        {
            btn_guardar_tesina.Enabled = true;
        }

        protected void btn_guardar_tesina_ServerClick(object sender, EventArgs e)
        {
            //se supone que ingreso aca porque esta todo bien, sino corregir en el boton verificar
            string str_tesina_id = Request.QueryString["t"];
            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                if (str_tesina_id == null)
                {
                    try
                    {
                        //tesina nueva (la mas facil)
                        Tesina t = new Tesina();
                        t.director_id = Convert.ToInt32(hidden_director_id.Value);
                        t.tesista_id = Convert.ToInt32(hidden_tesista_id.Value);
                        t.tesina_tema = tb_tema.Value;
                        t.tesina_descripcion = tb_descripcion.Value;
                        t.tesina_plan_fch_presentacion = Convert.ToDateTime(tb_fecha_inicio.Value);
                        t.tesina_plan_duracion_meses = Convert.ToInt16(tb_duracion.Value);
                        t.tesina_plan_aviso_meses = Convert.ToInt16(tb_notificacion.Value);
                        t.estado_tesis_id = cxt.Estados_tesinas.FirstOrDefault(ee => ee.estado_tesina_estado == "Iniciada").estado_tesina_id;
                        Historial_estado he = new Historial_estado()
                        {
                            estado_tesina_id = t.estado_tesis_id,
                            historial_tesina_fecha = DateTime.Today,
                            Tesina = t,
                            historial_tesina_descripcion = "Se ha dado de alta la tesina con fecha de inicio " + tb_fecha_inicio.Value
                        };

                        cxt.Tesinas.Add(t);
                        cxt.Historial_estados.Add(he);
                        cxt.SaveChanges();

                        hidden_id_tesina_a_mandar.Value = t.tesina_id.ToString();

                        string script = "<script language=\"javascript\"  type=\"text/javascript\">$(document).ready(function() { $('#consulto_por_envio_mail').modal('show')});</script>";
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "ShowPopUp", script, false);
                    }
                    catch (System.Data.Entity.Validation.DbEntityValidationException dbEx)
                    {
                        Exception raise = dbEx;
                        foreach (var validationErrors in dbEx.EntityValidationErrors)
                        {
                            foreach (var validationError in validationErrors.ValidationErrors)
                            {
                                string message = string.Format("{0}:{1}",
                                    validationErrors.Entry.Entity.ToString(),
                                    validationError.ErrorMessage);
                                // raise a new exception nesting
                                // the current instance as InnerException
                                raise = new InvalidOperationException(message, raise);
                            }
                        }

                        MessageBox.Show(this, raise.Message, MessageBox.Tipo_MessageBox.Danger, "Ups! ocurrio un error al guardar los cambios");
                    }

                }
                else
                {
                    //tesina existente, editar
                    int tesina_id = 0;
                    if (int.TryParse(str_tesina_id, out tesina_id))
                    {
                        //aca verificar el estado y los cambios que tiene que hacer dependiendo del mismo.
                    }
                    else
                    {
                        MessageBox.Show(this, "Error en el identificador de la tesina", MessageBox.Tipo_MessageBox.Danger, "Error general", "../default.aspx");
                    }
                }
            }
           
        }

        protected void btn_enviar_correos_Click(object sender, EventArgs e)
        {
            int tesina_id = Convert.ToInt32(hidden_id_tesina_a_mandar.Value);

            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                Tesina t = cxt.Tesinas.
                    Include("Tesista").
                    Include("Tesista.Persona").
                    Include("Director").
                    Include("Director.Persona").FirstOrDefault(tt => tt.tesina_id == tesina_id);

                Envio_mail registro_envio_mail_director = new Envio_mail()
                {
                    persona_id = t.Director.Persona.persona_id,
                    envio_fecha_hora = DateTime.Now,
                    envio_email_destino = t.Director.Persona.persona_email, //de haber mas de un destinatario separar por coma Ej: mail + "," + mail2 + "," + mail3
                    envio_respuesta_clave = "no se usa",
                    envio_tipo = MiEmail.tipo_mail.notificacion_asignacion_tesina_director.ToString()
                };

                Envio_mail registro_envio_mail_tesista = new Envio_mail()
                {
                    persona_id = t.Tesista.Persona.persona_id,
                    envio_fecha_hora = DateTime.Now,
                    envio_email_destino = t.Tesista.Persona.persona_email, //de haber mas de un destinatario separar por coma Ej: mail + "," + mail2 + "," + mail3
                    envio_respuesta_clave = "no se usa",
                    envio_tipo = MiEmail.tipo_mail.notificacion_inicio_tesina_tesista.ToString()
                };

                cxt.Envio_mails.Add(registro_envio_mail_director);
                cxt.Envio_mails.Add(registro_envio_mail_tesista);
                cxt.SaveChanges();

                MiEmail mail_director = new MiEmail(registro_envio_mail_director, t);
                MiEmail mail_tesista = new MiEmail(registro_envio_mail_tesista, t);

                if (mail_director.Enviar_mail() && mail_tesista.Enviar_mail())
                {
                    MessageBox.Show(this, "Los correos se enviaron satisfactoriamente", MessageBox.Tipo_MessageBox.Success, "Atención", "../Aplicativo/admin_tesinas.aspx");
                }
                else
                {
                    MessageBox.Show(this, "Ocurrio un error en el envio del correo", MessageBox.Tipo_MessageBox.Warning, "Oops!!", "../Aplicativo/admin_tesinas.aspx");
                }

            }
        }

        protected void btn_cancelar_envio_mail_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Aplicativo/admin_tesinas.aspx");
        }
    }

}