﻿using System;
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
                Correos_por_enviar correos_por_enviar = new Correos_por_enviar();
                correos_por_enviar.envios_por_realizar = new List<Envio_mail>();
                Session["Correos_por_enviar"] = correos_por_enviar;
            }
        }

        struct Correos_por_enviar
        {
            public int tesina_id { get; set; }
            public List<Envio_mail> envios_por_realizar { get; set; }
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
                tb_codirector.Value = "";
                tb_duracion.Value = "12";
                tb_notificacion.Value = "";
                ddl_categoria.SelectedValue = "Categoria 1";
                hidden_codirector_id.Value = "0";
                hidden_director_id.Value = "0";
                btn_eliminar_codirector.Visible = false;
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
                        tb_codirector.Value = t.Codirector != null ? t.Codirector.Persona.persona_nomyap : "";
                        hidden_codirector_id.Value = t.Codirector != null ? t.codirector_id.ToString() : "0";
                        btn_eliminar_codirector.Visible = t.Codirector != null;
                        tb_duracion.Value = t.tesina_plan_duracion_meses.ToString();
                        tb_notificacion.Value = t.tesina_plan_aviso_meses.ToString();
                        ddl_categoria.SelectedValue = t.tesina_categoria;
                        btn_buscar_tesista.Visible = false;
                    }
                }
            }
        }

        protected void gv_PreRender(object sender, EventArgs e)
        {
            if (gv_tesistas.Rows.Count > 0)
            {
                gv_tesistas.HeaderRow.TableSection = TableRowSection.TableHeader;
            }

            if (gv_directores.Rows.Count > 0)
            {
                gv_directores.HeaderRow.TableSection = TableRowSection.TableHeader;
            }

            if (gv_codirectores.Rows.Count > 0)
            {
                gv_codirectores.HeaderRow.TableSection = TableRowSection.TableHeader;
            }
        }

        protected void btn_cancelar_ServerClick(object sender, EventArgs e)
        {
            Session["Tesina"] = null;
            Response.Redirect("~/Aplicativo/admin_tesinas.aspx");
        }

        protected void btn_buscar_tesista_ServerClick(object sender, EventArgs e)
        {
            using (HabProfDBContainer cxt = new Aplicativo.HabProfDBContainer())
            {
                var tesistas = (
                    from t in cxt.Tesistas
                    where t.tesista_fecha_baja == null && t.Tesina.Where(tt => tt.tesina_fecha_cierre == null).Count() == 0
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
                                  where d.director_fecha_baja == null
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

        protected void btn_buscar_codirector_ServerClick(object sender, EventArgs e)
        {
            using (HabProfDBContainer cxt = new Aplicativo.HabProfDBContainer())
            {
                var codirectores = (from d in cxt.Directores
                                    where d.director_fecha_baja == null
                                    select d).ToList();

                var codirectores_con_tesina_a_cargo = (from d in codirectores
                                                       select new
                                                       {
                                                           codirector_id = d.director_id,
                                                           persona_nomyap = d.Persona.persona_nomyap,
                                                           persona_dni = d.Persona.persona_dni,
                                                           persona_email = d.Persona.persona_email,
                                                           codirector_calificacion = d.Calificacion_general
                                                       }).ToList();


                if (codirectores_con_tesina_a_cargo.Count() > 0)
                {
                    gv_codirectores.DataSource = codirectores_con_tesina_a_cargo;
                    gv_codirectores.DataBind();
                    lbl_sin_codirectores.Visible = false;
                }
                else
                {
                    lbl_sin_codirectores.Visible = true;
                    gv_codirectores.DataSource = null;
                    gv_codirectores.DataBind();
                }

            }

            string script = "<script language=\"javascript\"  type=\"text/javascript\">$(document).ready(function() { $('#buscar_codirector').modal('show')});</script>";
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

        protected void btn_seleccionar_codirector_ServerClick(object sender, EventArgs e)
        {
            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                int id_codirector = Convert.ToInt32(((HtmlButton)sender).Attributes["data-id"]);

                Director codirector = cxt.Directores.FirstOrDefault(pp => pp.director_id == id_codirector);
                if (codirector != null)
                {
                    tb_codirector.Value = codirector.Persona.persona_nomyap;
                    hidden_codirector_id.Value = codirector.director_id.ToString();
                    btn_eliminar_codirector.Visible = true;
                }
            }
        }

        protected void btn_eliminar_codirector_ServerClick(object sender, EventArgs e)
        {
            hidden_codirector_id.Value = "0";
            tb_codirector.Value = string.Empty;
            btn_eliminar_codirector.Visible = false;
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

        protected void cv_codirector_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = hidden_director_id.Value != hidden_codirector_id.Value;
        }

        protected void btn_guardar_tesina_ServerClick(object sender, EventArgs e)
        {
            //se supone que ingreso aca porque esta todo bien, sino corregir en el boton verificar
            Validate();
            if (IsValid)
            {
                int? codirector_id = null;
                if (hidden_codirector_id.Value != "0")
                {
                    codirector_id = Convert.ToInt32(hidden_codirector_id.Value);
                }

                string str_tesina_id = Request.QueryString["t"];
                bool enviar_correos = true;

                using (HabProfDBContainer cxt = new HabProfDBContainer())
                {
                    #region modificaciones y creacion de los correos

                    if (str_tesina_id == null)
                    {
                        #region tesina nueva
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
                            t.tesina_categoria = ddl_categoria.SelectedValue;
                            t.codirector_id = codirector_id;
                            Historial_estado he = new Historial_estado()
                            {
                                estado_tesina_id = t.estado_tesis_id,
                                historial_tesina_fecha = DateTime.Today,
                                Tesina = t,
                                historial_tesina_descripcion = "Se inicia el seguimiento de la tesina"
                            };

                            cxt.Tesinas.Add(t);
                            cxt.Historial_estados.Add(he);
                            cxt.SaveChanges();

                            #region genero los correos a enviar

                            Correos_por_enviar correos_por_enviar = ((Correos_por_enviar)Session["Correos_por_enviar"]);
                            correos_por_enviar.tesina_id = t.tesina_id;

                            int director_id = Convert.ToInt32(hidden_director_id.Value);
                            int tesista_id = Convert.ToInt32(hidden_tesista_id.Value);

                            Persona director_asignado = cxt.Directores.First(dd => dd.director_id == director_id).Persona;
                            Persona tesista_asignado = cxt.Tesistas.First(tt => tt.tesista_id == tesista_id).Persona;

                            if (codirector_id != null)
                            {
                                Persona codirector_asignado = cxt.Directores.First(dd => dd.director_id == director_id).Persona;

                                Envio_mail registro_envio_mail_codirector = new Envio_mail()
                                {
                                    persona_id = codirector_asignado.persona_id,
                                    envio_fecha_hora = DateTime.Now,
                                    envio_email_destino = codirector_asignado.persona_email, //de haber mas de un destinatario separar por coma Ej: mail + "," + mail2 + "," + mail3
                                    envio_respuesta_clave = "no se usa",
                                    envio_tipo = MiEmail.tipo_mail.notificacion_asignacion_tesina_director.ToString()
                                };

                                correos_por_enviar.envios_por_realizar.Add(registro_envio_mail_codirector);
                            }

                            Envio_mail registro_envio_mail_director = new Envio_mail()
                            {
                                persona_id = director_asignado.persona_id,
                                envio_fecha_hora = DateTime.Now,
                                envio_email_destino = director_asignado.persona_email, //de haber mas de un destinatario separar por coma Ej: mail + "," + mail2 + "," + mail3
                                envio_respuesta_clave = "no se usa",
                                envio_tipo = MiEmail.tipo_mail.notificacion_asignacion_tesina_director.ToString()
                            };
                            correos_por_enviar.envios_por_realizar.Add(registro_envio_mail_director);

                            Envio_mail registro_envio_mail_tesista = new Envio_mail()
                            {
                                persona_id = tesista_asignado.persona_id,
                                envio_fecha_hora = DateTime.Now,
                                envio_email_destino = tesista_asignado.persona_email, //de haber mas de un destinatario separar por coma Ej: mail + "," + mail2 + "," + mail3
                                envio_respuesta_clave = "no se usa",
                                envio_tipo = MiEmail.tipo_mail.notificacion_inicio_tesina_tesista.ToString()
                            };
                            correos_por_enviar.envios_por_realizar.Add(registro_envio_mail_tesista);

                            Session["Correos_por_enviar"] = correos_por_enviar;

                            #endregion
                        }
                        catch (System.Data.Entity.Validation.DbEntityValidationException dbEx)
                        {
                            enviar_correos = false;
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

                        #endregion
                    }
                    else
                    {
                        #region tesina existente
                        //tesina existente, editar
                        int tesina_id = 0;
                        if (int.TryParse(str_tesina_id, out tesina_id))
                        {
                            try
                            {
                                //aca verificar los datos y los cambios que tiene que hacer dependiendo del mismo.
                                Tesina t = cxt.Tesinas.FirstOrDefault(tt => tt.tesina_id == tesina_id);
                                string perfil = Session["Perfil"].ToString();
                                if (perfil == "Administrador")
                                {
                                    #region genero correos de y guardo modificaciones del administrador sin que tenga que ver con el estado de la tesis

                                    //guardo posibles cambios en director, tema, descripcion
                                    if (t.tesina_tema != tb_tema.Value ||
                                        t.tesina_descripcion != tb_descripcion.Value ||
                                        t.tesina_plan_fch_presentacion != Convert.ToDateTime(tb_fecha_inicio.Value) ||
                                        t.tesina_plan_duracion_meses != Convert.ToInt16(tb_duracion.Value) ||
                                        t.tesina_plan_aviso_meses != Convert.ToInt16(tb_notificacion.Value) ||
                                        t.director_id.ToString() != hidden_director_id.Value ||
                                        (t.codirector_id == null && hidden_codirector_id.Value != "0") ||  //cargo un codirector
                                        (t.codirector_id != null && hidden_codirector_id.Value == "0") ||  //elimino el codirector
                                        (t.codirector_id != null && t.codirector_id.ToString() != hidden_codirector_id.Value) //modifico el codirector
                                        )
                                    {
                                        Correos_por_enviar correos_por_enviar = ((Correos_por_enviar)Session["Correos_por_enviar"]);
                                        correos_por_enviar.tesina_id = t.tesina_id;

                                        //modifico director u otro parametro hay que mandar correos
                                        //mandar correo tesista modificacion de tesis
                                        #region controlar director
                                        if (t.director_id.ToString() != hidden_director_id.Value)
                                        {
                                            int nuevo_director_id = Convert.ToInt32(hidden_director_id.Value);
                                            Persona nuevo_director = cxt.Directores.First(pp => pp.director_id == nuevo_director_id).Persona;

                                            //cambio de director, mandar correo de asignacion de tesis al nuevo director y de eliminacion de tesis al viejo
                                            Envio_mail registro_envio_mail_director_aisgnacion = new Envio_mail()
                                            {
                                                persona_id = nuevo_director.persona_id,
                                                envio_fecha_hora = DateTime.Now,
                                                envio_email_destino = nuevo_director.persona_email,
                                                envio_respuesta_clave = "no se usa",
                                                envio_tipo = MiEmail.tipo_mail.notificacion_asignacion_tesina_director.ToString()
                                            };

                                            Envio_mail registro_envio_mail_director_eliminacion = new Envio_mail()
                                            {
                                                persona_id = t.Director.Persona.persona_id,
                                                envio_fecha_hora = DateTime.Now,
                                                envio_email_destino = t.Director.Persona.persona_email, //de haber mas de un destinatario separar por coma Ej: mail + "," + mail2 + "," + mail3
                                                envio_respuesta_clave = "no se usa",
                                                envio_tipo = MiEmail.tipo_mail.notificacion_eliminacion_tesina_director.ToString()
                                            };

                                            correos_por_enviar.envios_por_realizar.Add(registro_envio_mail_director_aisgnacion);
                                            correos_por_enviar.envios_por_realizar.Add(registro_envio_mail_director_eliminacion);
                                        }
                                        else
                                        {
                                            //mantuvo director, mandar correo de modificacion de tesis director
                                            Envio_mail registro_envio_mail_director_modificacion = new Envio_mail()
                                            {
                                                persona_id = t.Director.Persona.persona_id,
                                                envio_fecha_hora = DateTime.Now,
                                                envio_email_destino = t.Director.Persona.persona_email, //de haber mas de un destinatario separar por coma Ej: mail + "," + mail2 + "," + mail3
                                                envio_respuesta_clave = "no se usa",
                                                envio_tipo = MiEmail.tipo_mail.notificacion_modificacion_tesina_director.ToString()
                                            };

                                            correos_por_enviar.envios_por_realizar.Add(registro_envio_mail_director_modificacion);
                                        }
                                        #endregion

                                        #region controlar codirector

                                        if (t.codirector_id == null && hidden_codirector_id.Value != "0") //cargo un codirector
                                        {
                                            int nuevo_codirector_id = Convert.ToInt32(hidden_director_id.Value);
                                            Persona nuevo_codirector = cxt.Directores.First(pp => pp.director_id == nuevo_codirector_id).Persona;

                                            Envio_mail registro_envio_mail_codirector_aisgnacion = new Envio_mail()
                                            {
                                                persona_id = nuevo_codirector.persona_id,
                                                envio_fecha_hora = DateTime.Now,
                                                envio_email_destino = nuevo_codirector.persona_email,
                                                envio_respuesta_clave = "no se usa",
                                                envio_tipo = MiEmail.tipo_mail.notificacion_asignacion_tesina_director.ToString()
                                            };
                                            correos_por_enviar.envios_por_realizar.Add(registro_envio_mail_codirector_aisgnacion);
                                        }
                                        else
                                        {
                                            if (t.codirector_id != null && hidden_codirector_id.Value == "0") //elimino el codirector
                                            {
                                                Envio_mail registro_envio_mail_codirector_eliminacion = new Envio_mail()
                                                {
                                                    persona_id = t.Director.Persona.persona_id,
                                                    envio_fecha_hora = DateTime.Now,
                                                    envio_email_destino = t.Director.Persona.persona_email, //de haber mas de un destinatario separar por coma Ej: mail + "," + mail2 + "," + mail3
                                                    envio_respuesta_clave = "no se usa",
                                                    envio_tipo = MiEmail.tipo_mail.notificacion_eliminacion_tesina_director.ToString()
                                                };
                                                correos_por_enviar.envios_por_realizar.Add(registro_envio_mail_codirector_eliminacion);
                                            }
                                            else
                                            {
                                                if (t.codirector_id != null && t.codirector_id.ToString() != hidden_codirector_id.Value) //modifico el codirector
                                                {
                                                    int nuevo_codirector_id = Convert.ToInt32(hidden_director_id.Value);
                                                    Persona nuevo_codirector = cxt.Directores.First(pp => pp.director_id == nuevo_codirector_id).Persona;
                                                    //cambio de director, mandar correo de asignacion de tesis al nuevo director y de eliminacion de tesis al viejo
                                                    Envio_mail registro_envio_mail_codirector_aisgnacion = new Envio_mail()
                                                    {
                                                        persona_id = nuevo_codirector.persona_id,
                                                        envio_fecha_hora = DateTime.Now,
                                                        envio_email_destino = nuevo_codirector.persona_email,
                                                        envio_respuesta_clave = "no se usa",
                                                        envio_tipo = MiEmail.tipo_mail.notificacion_asignacion_tesina_director.ToString()
                                                    };

                                                    Envio_mail registro_envio_mail_codirector_eliminacion = new Envio_mail()
                                                    {
                                                        persona_id = t.Director.Persona.persona_id,
                                                        envio_fecha_hora = DateTime.Now,
                                                        envio_email_destino = t.Director.Persona.persona_email, //de haber mas de un destinatario separar por coma Ej: mail + "," + mail2 + "," + mail3
                                                        envio_respuesta_clave = "no se usa",
                                                        envio_tipo = MiEmail.tipo_mail.notificacion_eliminacion_tesina_director.ToString()
                                                    };

                                                    correos_por_enviar.envios_por_realizar.Add(registro_envio_mail_codirector_aisgnacion);
                                                    correos_por_enviar.envios_por_realizar.Add(registro_envio_mail_codirector_eliminacion);
                                                }
                                                else
                                                {
                                                    //mantuvo codirector, mandar correo de modificacion de tesis codirector
                                                    Envio_mail registro_envio_mail_codirector_modificacion = new Envio_mail()
                                                    {
                                                        persona_id = t.Codirector.Persona.persona_id,
                                                        envio_fecha_hora = DateTime.Now,
                                                        envio_email_destino = t.Codirector.Persona.persona_email, //de haber mas de un destinatario separar por coma Ej: mail + "," + mail2 + "," + mail3
                                                        envio_respuesta_clave = "no se usa",
                                                        envio_tipo = MiEmail.tipo_mail.notificacion_modificacion_tesina_director.ToString()
                                                    };
                                                    correos_por_enviar.envios_por_realizar.Add(registro_envio_mail_codirector_modificacion);
                                                }
                                            }
                                        }
                                        #endregion

                                        //mandar correo de modificacion de tesina al tesista Envio_mail registro_envio_mail_director = new Envio_mail()
                                        Envio_mail registro_envio_mail_tesista = new Envio_mail()
                                        {
                                            persona_id = t.Tesista.Persona.persona_id,
                                            envio_fecha_hora = DateTime.Now,
                                            envio_email_destino = t.Tesista.Persona.persona_email, //de haber mas de un destinatario separar por coma Ej: mail + "," + mail2 + "," + mail3
                                            envio_respuesta_clave = "no se usa",
                                            envio_tipo = MiEmail.tipo_mail.notificacion_modificacion_tesina_tesista.ToString()
                                        };

                                        correos_por_enviar.envios_por_realizar.Add(registro_envio_mail_tesista);

                                        Session["Correos_por_enviar"] = correos_por_enviar;
                                    }

                                    t.tesina_tema = tb_tema.Value;
                                    t.tesina_descripcion = tb_descripcion.Value;
                                    t.tesina_plan_fch_presentacion = Convert.ToDateTime(tb_fecha_inicio.Value);
                                    t.tesina_plan_duracion_meses = Convert.ToInt16(tb_duracion.Value);
                                    t.tesina_plan_aviso_meses = Convert.ToInt16(tb_notificacion.Value);
                                    t.director_id = Convert.ToInt32(hidden_director_id.Value);
                                    t.tesina_categoria = ddl_categoria.SelectedValue;
                                    t.codirector_id = codirector_id;

                                    #endregion
                                }

                                cxt.SaveChanges();

                            }
                            catch (System.Data.Entity.Validation.DbEntityValidationException dbEx)
                            {
                                enviar_correos = false;
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
                            enviar_correos = false;
                            MessageBox.Show(this, "Error en el identificador de la tesina", MessageBox.Tipo_MessageBox.Danger, "Error general", "../default.aspx");
                        }

                        #endregion
                    }

                    #endregion

                    #region enviar correos

                    if (enviar_correos)
                    {
                        Correos_por_enviar correos_por_enviar = ((Correos_por_enviar)Session["Correos_por_enviar"]);

                        Tesina t = cxt.Tesinas.
                                            Include("Tesista").
                                            Include("Tesista.Persona").
                                            Include("Director").
                                            Include("Director.Persona").FirstOrDefault(tt => tt.tesina_id == correos_por_enviar.tesina_id);

                        bool envios_correctos = true;
                        foreach (Envio_mail item in correos_por_enviar.envios_por_realizar)
                        {
                            cxt.Envio_mails.Add(item);
                            MiEmail mail = new MiEmail(item, t);
                            if (!mail.Enviar_mail())
                            {
                                envios_correctos = false;
                            }
                        }

                        if (envios_correctos)
                        {
                            cxt.SaveChanges();
                            MessageBox.Show(this, "Los correos se enviaron satisfactoriamente", MessageBox.Tipo_MessageBox.Success, "Atención", "../Aplicativo/admin_tesinas.aspx");
                        }
                        else
                        {
                            MessageBox.Show(this, "Ocurrio un error en el envio del correo", MessageBox.Tipo_MessageBox.Warning, "Oops!!");
                        }
                    }

                    #endregion
                }
            }
        }

        protected void btn_cancelar_envio_mail_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Aplicativo/admin_tesinas.aspx");
        }

    }

}