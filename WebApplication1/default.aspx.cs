using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebApplication1.Aplicativo;
using WebApplication1.Aplicativo.ControlesDeUsuario;

namespace WebApplication1
{
    public partial class _default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                form_username.Focus();
            }
        }

        protected void btn_ingresar_ServerClick(object sender, EventArgs e)
        {
            RevisarCrearPrimerosDatos();

            string usuario = form_username.Value;
            string clave = Cripto.Encriptar(form_password.Value);

            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                Persona usr = cxt.Personas.FirstOrDefault(pp => pp.persona_usuario == usuario && pp.persona_clave == clave);

                if (usr != null)
                {
                    Session["UsuarioLogueado"] = usr;
                    int cantidad_perfiles = 0;
                    cantidad_perfiles = cantidad_perfiles + (usr.Administrador != null ? 1 : 0);
                    cantidad_perfiles = cantidad_perfiles + (usr.Director != null ? 1 : 0);
                    cantidad_perfiles = cantidad_perfiles + (usr.Tesista != null ? 1 : 0);
                    cantidad_perfiles = cantidad_perfiles + (usr.Jurado != null ? 1 : 0);

                    if (cantidad_perfiles > 1)
                    {
                        lbl_bienvenida_perfil.Text = "Bienvenido " + usr.persona_nomyap;
                        hidden_id_usuario.Value = usr.persona_id.ToString();

                        ddl_perfil.Items.Clear();

                        if (usr.Administrador != null)
                        {
                            ddl_perfil.Items.Add(new ListItem() { Text = Perfil_usuario.Administrador.ToString(), Value = Perfil_usuario.Administrador.ToString() });
                        }

                        if (usr.Director != null)
                        {
                            ddl_perfil.Items.Add(new ListItem() { Text = Perfil_usuario.Director.ToString(), Value = Perfil_usuario.Director.ToString() });
                        }

                        if (usr.Tesista != null)
                        {
                            ddl_perfil.Items.Add(new ListItem() { Text = Perfil_usuario.Tesista.ToString(), Value = Perfil_usuario.Tesista.ToString() });
                        }

                        if (usr.Jurado != null)
                        {
                            ddl_perfil.Items.Add(new ListItem() { Text = Perfil_usuario.Jurado.ToString(), Value = Perfil_usuario.Jurado.ToString() });
                        }

                        string script = "<script language=\"javascript\"  type=\"text/javascript\">$(document).ready(function() { $('#modal_perfil').modal('show')});</script>";
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "ShowPopUp", script, false);
                    }
                    else
                    {
                        if (usr.Administrador != null)
                        {
                            Ingresar(Perfil_usuario.Administrador, usr);
                        }

                        if (usr.Director != null)
                        {
                            Ingresar(Perfil_usuario.Director, usr);
                        }

                        if (usr.Tesista != null)
                        {
                            Ingresar(Perfil_usuario.Tesista, usr);
                        }

                        if (usr.Jurado != null)
                        {
                            Ingresar(Perfil_usuario.Jurado, usr);
                        }
                    }
                }
                else
                {
                    MessageBox.Show(this, "Usuario o contraseña incorrecto", MessageBox.Tipo_MessageBox.Info);
                }

            }
        }

        public enum Perfil_usuario
        {
            Administrador,
            Director,
            Tesista,
            Jurado
        }

        private void Ingresar(Perfil_usuario perfil, Persona usr)
        {
            switch (perfil)
            {
                case Perfil_usuario.Administrador:
                    Session["Perfil"] = perfil.ToString();
                    FormsAuthentication.RedirectFromLoginPage(usr.persona_usuario, false);
                    break;
                case Perfil_usuario.Director:
                    Session["Perfil"] = perfil.ToString();
                    FormsAuthentication.RedirectFromLoginPage(usr.persona_usuario, false);
                    break;
                case Perfil_usuario.Tesista:
                    Session["Perfil"] = perfil.ToString();
                    FormsAuthentication.RedirectFromLoginPage(usr.persona_usuario, false);
                    break;
                case Perfil_usuario.Jurado:
                    MessageBox.Show(this, "Aún no se definieron funcionalidades para el perfil Jurado");
                    break;
                default:
                    break;
            }
        }

        private void RevisarCrearPrimerosDatos()
        {
            using (HabProfDBContainer cxt = new Aplicativo.HabProfDBContainer())
            {
                if (cxt.Personas.Count() == 0)
                {
                    
                    Servidor_de_correo servidor0 = new Servidor_de_correo() { servidor_nombre = "Hotmail", servidor_smtp_host = "smtp.live.com", servidor_smtp_port = 25, servidor_enable_ssl = true };
                    Servidor_de_correo servidor1 = new Servidor_de_correo() { servidor_nombre = "Outlook", servidor_smtp_host = "smtp.live.com", servidor_smtp_port = 25, servidor_enable_ssl = true };
                    Servidor_de_correo servidor2 = new Servidor_de_correo() { servidor_nombre = "Live", servidor_smtp_host = "smtp.live.com", servidor_smtp_port = 25, servidor_enable_ssl = true };
                    Servidor_de_correo servidor3 = new Servidor_de_correo() { servidor_nombre = "Gmail", servidor_smtp_host = "smtp.gmail.com", servidor_smtp_port = 587, servidor_enable_ssl = true };
                    Servidor_de_correo servidor4 = new Servidor_de_correo() { servidor_nombre = "Yahoo!", servidor_smtp_host = "smtp.yahoo.com", servidor_smtp_port = 465, servidor_enable_ssl = true };
                    cxt.Servidores.Add(servidor0);
                    cxt.Servidores.Add(servidor1);
                    cxt.Servidores.Add(servidor2);
                    cxt.Servidores.Add(servidor3);
                    cxt.Servidores.Add(servidor4);

                    Licenciatura l = new Licenciatura() {
                        licenciatura_nombre = "Licenciatura en Tecnología Educativa",
                        licenciatura_descripcion = "Este Ciclo de Licenciatura se propone brindar una alternativa de formación de grado a aquellos profesores y/o técnicos superiores en áreas referidas en manejo de las tecnologías, interesados en Ia inserción de Ia tecnología educativa en los procesos de formación inicial y continua propios del sistema educativo. Asimismo, resulta una opción para cubrir los espacios de capacitación y actualización que se desarroIIan en las instituciones y organizaciones del sistema socio productivo, tanto de gestión pública como privada.",
                        licenciatura_email = "fede.berton@gmail.com",
                        licenciatura_email_clave = "berton_mail",
                        Servidor = servidor3 };
                    cxt.Licenciaturas.Add(l);

                    Persona p_admin = new Persona()
                    {
                        Licenciatura = l,
                        persona_nomyap = "Administrador",
                        persona_dni = 12345678,
                        persona_email = "un.mail@un.servidor.com",
                        persona_email_validado = false,
                        persona_domicilio = "un domicilio",
                        persona_telefono = "00000000",
                        persona_usuario = "admin",
                        persona_clave = Cripto.Encriptar("admin"),
                        persona_estilo = "Slate"
                    };

                    Administrador admin = new Administrador()
                    {
                       Persona = p_admin
                    };
                    cxt.Personas.Add(p_admin);
                    cxt.Administradores.Add(admin);

                    Persona p_director = new Persona()
                    {
                        Licenciatura = l,
                        persona_nomyap = "director",
                        persona_dni = 23456789,
                        persona_email = "un.mail@un.servidor.com",
                        persona_email_validado = false,
                        persona_domicilio = "un domicilio",
                        persona_telefono = "00000000",
                        persona_usuario = "dire",
                        persona_clave = Cripto.Encriptar("dire"),
                        persona_estilo = "Slate"
                    };

                    Director dire = new Director()
                    {
                        Persona = p_director
                    };
                    cxt.Personas.Add(p_director);
                    cxt.Directores.Add(dire);

                    Persona p_tesista = new Persona()
                    {
                        Licenciatura = l,
                        persona_nomyap = "Juan José Paso",
                        persona_dni = 28162815,
                        persona_email = "atp.jfbertoncini@chaco.gov.ar",
                        persona_email_validado = false,
                        persona_domicilio = "Brasil 335 - Barranqueras",
                        persona_telefono = "03624716146",
                        persona_usuario = "",
                        persona_clave = "",
                        persona_estilo = "Slate"
                    };

                    Tesista tesista = new Tesista()
                    {
                        Persona = p_tesista,
                        tesista_legajo = "12337/6",
                        tesista_sede = "Resistencia"
                    };
                    cxt.Personas.Add(p_tesista);
                    cxt.Tesistas.Add(tesista);

                    //Estado inicial
                    Estado_tesina estado_inicial = new Estado_tesina()
                    {
                        estado_tesina_estado = "Iniciada",
                        estado_tesina_descripcion = "Estado inicial, ocurre cuando aprueban el tema y se cargan los valores inciales, director, tesista, fechas de presentación, duración y notificaciones"
                    };

                    //puede llegar aqui por los estados:
                    //          * iniciada
                    //          * a corregir
                    //          * prorroga
                    Estado_tesina estado_entregada = new Estado_tesina()
                    {
                        estado_tesina_estado = "Entregada",
                        estado_tesina_descripcion = "Ocurre cuando se sube el archivo para la correción del director"
                    };

                    //llega aqui del estado:
                    //          * entregada
                    Estado_tesina estado_a_corregir = new Estado_tesina()
                    {
                        estado_tesina_estado = "Observada",
                        estado_tesina_descripcion = "Ocurre cuando el director o administrador informan sobre correcciones a realizar en la tesina presentada"
                    };

                    //llega aqui del estado:
                    //          * entregada
                    Estado_tesina estado_lista_para_presentar = new Estado_tesina()
                    {
                        estado_tesina_estado = "Lista para presentar",
                        estado_tesina_descripcion = "Ocurre cuando la presentació de la tesina no tiene observaciones y esta lista para su defenza"
                    };


                    //llega aqui del estado:
                    //          * entregada
                    //          * a corregir
                    //          * prorroga
                    Estado_tesina estado_vencida = new Estado_tesina()
                    {
                        estado_tesina_estado = "Vencida",
                        estado_tesina_descripcion = "Ocurre cuando pasan los plazos establecidos y la tesina no fue aprobada para su defenza"
                    };

                    //llega aqui del estado:
                    //          * vencida
                    Estado_tesina estado_prorrogada = new Estado_tesina()
                    {
                        estado_tesina_estado = "Prorrogar",
                        estado_tesina_descripcion = "Ocurre cuando luego de vencida la tesina, el tesista solicita prorroga, en este estado se vuelven a establecer duración y periodo entre notificaciones"
                    };

                    //llega aqui del estado:
                    //          * lista para presentar
                    Estado_tesina estado_aprobada = new Estado_tesina()
                    {
                        estado_tesina_estado = "Aprobada",
                        estado_tesina_descripcion = "Estado final, en este momento se procede a calificar la tesina y al director"
                    };

                    //llega aqui del estado:
                    //          * lista para presentar
                    Estado_tesina estado_desaprobada = new Estado_tesina()
                    {
                        estado_tesina_estado = "Desaprobada",
                        estado_tesina_descripcion = "Estado final, en este momento se procede a calificar la tesina y al director"
                    };


                    cxt.Estados_tesinas.Add(estado_inicial);
                    cxt.Estados_tesinas.Add(estado_entregada);
                    cxt.Estados_tesinas.Add(estado_a_corregir);
                    cxt.Estados_tesinas.Add(estado_lista_para_presentar);
                    cxt.Estados_tesinas.Add(estado_vencida);
                    cxt.Estados_tesinas.Add(estado_prorrogada);
                    cxt.Estados_tesinas.Add(estado_aprobada);
                    cxt.Estados_tesinas.Add(estado_desaprobada);

                    Tesina tesis = new Tesina()
                    {
                        Director = dire,
                        Tesista = tesista,
                        Estado = estado_inicial,
                        tesina_descripcion = "politica, importacion, electronico",
                        tesina_tema = "Impacto de las politicas de importación sobre la producción de artículos electronicónicos en la región",
                        tesina_plan_fch_presentacion = Convert.ToDateTime("01/06/2017"),
                        tesina_plan_duracion_meses = 12,
                        tesina_plan_aviso_meses = 3,
                        tesina_categoria = "1300 - VARIOS CAMPOS (Especificar)"
                    };

                    cxt.Tesinas.Add(tesis);

                    Historial_estado historial = new Historial_estado()
                    {
                        Tesina = tesis,
                        Estado = estado_inicial,
                        historial_tesina_descripcion = "Se inicia el seguimiento de la tesina",
                        historial_tesina_fecha = Convert.ToDateTime("01/06/2017")
                    };

                    cxt.Historial_estados.Add(historial);

                    cxt.SaveChanges();

                }
            }
        }

        protected void btn_recuperar_clave_ServerClick(object sender, EventArgs e)
        {

            string usuario_o_contraseña = tb_recuperar_clave.Value;

            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                Persona p_cxt = cxt.Personas.FirstOrDefault(pp => pp.persona_usuario == usuario_o_contraseña || pp.persona_email == usuario_o_contraseña);

                if (p_cxt != null && p_cxt.persona_email_validado)
                {
                    Envio_mail registro_envio_mail = new Envio_mail()
                    {
                        persona_id = p_cxt.persona_id,
                        envio_fecha_hora = DateTime.Now,
                        envio_email_destino = p_cxt.persona_email, //de haber mas de un destinatario separar por coma Ej: mail + "," + mail2 + "," + mail3
                        envio_respuesta_clave = Guid.NewGuid().ToString(),
                        envio_tipo = MiEmail.tipo_mail.recupero_contraseña.ToString()
                    };

                    cxt.Envio_mails.Add(registro_envio_mail);
                    cxt.SaveChanges();

                    MiEmail mail = new MiEmail(registro_envio_mail);

                    if (mail.Enviar_mail())
                    {
                        MessageBox.Show(this, "Se envió un correo con las instrucciones para recuperar su contraseña", MessageBox.Tipo_MessageBox.Success);
                    }
                    else
                    {
                        MessageBox.Show(this, "Ocurrió un error en el envio del correo", MessageBox.Tipo_MessageBox.Warning, "Oops!!");
                    }
                }
                else
                {
                    MessageBox.Show(this, "No existe el usuario o el correo no está validado", MessageBox.Tipo_MessageBox.Danger, "Oops!!");
                }
            }
        }

        protected void btn_acceder_con_perfil_ServerClick(object sender, EventArgs e)
        {
            int id_usuario = Convert.ToInt32(hidden_id_usuario.Value);

            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                Persona usr = cxt.Personas.FirstOrDefault(pp => pp.persona_id == id_usuario);

                Perfil_usuario perfil = (Perfil_usuario) Enum.Parse(typeof(Perfil_usuario), ddl_perfil.SelectedValue);

                Ingresar(perfil, usr);
            }
        }
    }
}