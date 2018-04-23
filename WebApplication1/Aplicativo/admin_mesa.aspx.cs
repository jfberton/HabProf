using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebApplication1.Aplicativo.ControlesDeUsuario;

namespace WebApplication1.Aplicativo
{
    public partial class admin_mesa : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarDatosMesa();
            }
        }

        private void CargarDatosMesa()
        {
            string str_mesa_id = Request.QueryString["m"];
            if (str_mesa_id == null)
            {
                //mesa nueva
                lbl_titulo.Text = "Nueva Mesa de Examen";
                //lbl_small_titulo.Text = 
            }
            else
            {
                int mesa_id;
                if (int.TryParse(str_mesa_id, out mesa_id))
                {
                    using (HabProfDBContainer cxt = new HabProfDBContainer())
                    {
                        Mesa mesa = cxt.Mesas.FirstOrDefault(mm => mm.mesa_id == mesa_id);

                        tb_fecha_mesa.Value = mesa.mesa_fecha.ToShortDateString();
                        tb_cod_carrera.Text = mesa.mesa_codigo_carrera.ToString();
                        tb_cod_materia.Text = mesa.mesa_codigo_materia.ToString();
                        tb_cod_plan.Text = mesa.mesa_codigo_plan.ToString();

                        List<item_jurado> jurados = new List<Aplicativo.admin_mesa.item_jurado>();
                        string texto_hidden_jueces = string.Empty;
                        foreach (Jurado jurado in mesa.Jueces)
                        {
                            jurados.Add(new item_jurado()
                            {
                                juez_id = jurado.juez_id,
                                juez_persona_dni = jurado.Persona.persona_dni,
                                juez_persona_email = jurado.Persona.persona_email,
                                juez_persona_nomyap = jurado.Persona.persona_nomyap,
                                seleccionado = true
                            });

                            texto_hidden_jueces = texto_hidden_jueces + jurado.juez_id + ",";
                        }

                        hidden_ids_jueces.Value = texto_hidden_jueces;

                        if (jurados.Count > 0)
                        {
                            gv_jurados.DataSource = jurados;
                            gv_jurados.DataBind();
                        }
                        else
                        {
                            gv_jurados.DataSource = null;
                            gv_jurados.DataBind();
                        }


                        List<item_tesina> tesinas = new List<item_tesina>();
                        string texto_hidden_tesinas = string.Empty;
                        foreach (Tesina tesina in mesa.Tesinas)
                        {
                            tesinas.Add(new item_tesina()
                            {
                                tesina_id = tesina.tesina_id,
                                tesina_tema = tesina.tesina_tema,
                                tesina_descripcion = tesina.tesina_descripcion,
                                tesina_director = tesina.Director.Persona.persona_nomyap,
                                tesina_tesista = tesina.Tesista.Persona.persona_nomyap,
                                seleccionada = true,
                                nota_tesina = tesina.tesina_calificacion ?? 0,
                                nota_director = tesina.tesina_calificacion_director ?? 0
                            });

                            texto_hidden_tesinas = texto_hidden_tesinas + tesina.tesina_id + ",";
                        }

                        hidden_tesinas_seleccionadas.Value = texto_hidden_tesinas;

                        if (tesinas.Count > 0)
                        {
                            gv_tesinas_seleccionadas.DataSource = tesinas;
                            gv_tesinas_seleccionadas.DataBind();
                        }
                        else
                        {
                            gv_tesinas_seleccionadas.DataSource = null;
                            gv_tesinas_seleccionadas.DataBind();
                        }

                    }
                }
            }
        }

        #region Jurado

        struct item_jurado
        {
            public int juez_id { get; set; }
            public string juez_persona_nomyap { get; set; }
            public string juez_persona_email { get; set; }
            public int juez_persona_dni { get; set; }
            public bool seleccionado { get; set; }

        }

        protected void btn_buscar_jurados_Click(object sender, EventArgs e)
        {
            CargarJueces();

            string script = "<script language=\"javascript\"  type=\"text/javascript\">$(document).ready(function() { $('#modal_buscar_jurado').modal('show');});</script>";
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "ShowPopUp", script, false);
        }

        private void CargarJueces()
        {
            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                List<string> id_jueces = hidden_ids_jueces.Value.Split(',').ToList();
                List<int> items_seleccionados = new List<int>();
                foreach (string id in id_jueces)
                {
                    int id_juez;
                    if (int.TryParse(id, out id_juez))
                    {
                        items_seleccionados.Add(id_juez);
                    }
                }

                var jueces = (from d in cxt.Jueces
                              where d.juez_fecha_baja == null
                              select d).ToList();

                var jueces_sin_baja = (from d in jueces
                                       select new item_jurado
                                       {
                                           juez_id = d.juez_id,
                                           juez_persona_nomyap = d.Persona.persona_nomyap,
                                           juez_persona_dni = d.Persona.persona_dni,
                                           juez_persona_email = d.Persona.persona_email,
                                           seleccionado = (items_seleccionados.IndexOf(d.juez_id) > -1)
                                       }).ToList();

                if (jueces_sin_baja.Count() > 0)
                {
                    gv_seleccionar_jurado.DataSource = jueces_sin_baja;
                    gv_seleccionar_jurado.DataBind();
                }
                else
                {
                    gv_seleccionar_jurado.DataSource = null;
                    gv_seleccionar_jurado.DataBind();
                }
            }
        }

        protected void chk_seleccion_juez_CheckedChanged(object sender, EventArgs e)
        {
            List<string> ids = hidden_ids_jueces.Value.Split(',').ToList();
            CheckBox chk = ((CheckBox)sender);

            if (chk.Checked)
            {
                //agregar el jurado al listado
                ids.Add(chk.AccessKey);
            }
            else
            {
                //quitar el jurado del listado
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
                        texto_para_el_label = texto_para_el_label + cxt.Personas.FirstOrDefault(pp => pp.Jurado.juez_id == id_juez).persona_nomyap + "; ";
                        texto_para_el_hidden = texto_para_el_hidden + id_juez.ToString() + ",";
                    }
                }

                lbl_jueces.Text = texto_para_el_label;
                hidden_ids_jueces.Value = texto_para_el_hidden;
            }

            string script = "<script language=\"javascript\"  type=\"text/javascript\">$(document).ready(function() { $('#modal_buscar_jurado').modal('show');});</script>";
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "ShowPopUp", script, false);

        }

        protected void btn_aceptar_seleccion_jurado_Click(object sender, EventArgs e)
        {
            List<item_jurado> items_seleccionados = new List<item_jurado>();
            string texto_para_el_hidden = string.Empty;
            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                foreach (GridViewRow fila in gv_seleccionar_jurado.Rows)
                {
                    CheckBox chk = ((CheckBox)fila.Cells[3].Controls[1]);

                    int jurado_id = Convert.ToInt32(chk.AccessKey);
                    Jurado jurado = cxt.Jueces.FirstOrDefault(jj => jj.juez_id == jurado_id);
                    if (chk.Checked)
                    {
                        items_seleccionados.Add(new item_jurado()
                        {
                            juez_id = jurado.juez_id,
                            juez_persona_nomyap = jurado.Persona.persona_nomyap,
                            juez_persona_dni = jurado.Persona.persona_dni,
                            juez_persona_email = jurado.Persona.persona_email
                        });

                        texto_para_el_hidden = texto_para_el_hidden + chk.AccessKey + ",";
                    }
                }
            }

            hidden_ids_jueces.Value = texto_para_el_hidden;

            if (items_seleccionados.Count > 0)
            {
                gv_jurados.DataSource = items_seleccionados;
                gv_jurados.DataBind();
            }
            else
            {
                gv_jurados.DataSource = null;
                gv_jurados.DataBind();
            }
        }

        #endregion

        #region Tesinas

        struct item_tesina
        {
            public int tesina_id { get; set; }
            public string tesina_tema { get; set; }
            public string tesina_descripcion { get; set; }
            public string tesina_tesista { get; set; }
            public string tesina_director { get; set; }
            public bool seleccionada { get; set; }
            public int nota_tesina { get; set; }
            public int nota_director { get; set; }
        }

        protected void btn_buscar_tesina_Click(object sender, EventArgs e)
        {
            CargarTesinas();

            string script = "<script language=\"javascript\"  type=\"text/javascript\">$(document).ready(function() { $('#modal_buscar_tesina').modal('show');});</script>";
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "ShowPopUp", script, false);
        }

        private void CargarTesinas()
        {
            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                List<string> id_tesinas = hidden_tesinas_seleccionadas.Value.Split(',').ToList();
                List<int> items_seleccionados = new List<int>();
                foreach (string id in id_tesinas)
                {
                    int id_tesina;
                    if (int.TryParse(id, out id_tesina))
                    {
                        items_seleccionados.Add(id_tesina);
                    }
                }

                Estado_tesina et = cxt.Estados_tesinas.FirstOrDefault(eett => eett.estado_tesina_estado == "Lista para presentar");

                var tesinas = (from t in cxt.Tesinas
                               where t.estado_tesis_id == et.estado_tesina_id && t.Tesista.tesista_baja_definitiva == null
                               select t).ToList();

                var tesinas_sin_baja = (from t in tesinas
                                       select new item_tesina
                                       {
                                           tesina_id = t.tesina_id,
                                           tesina_tema = t.tesina_tema,
                                           tesina_descripcion = t.tesina_descripcion,
                                           tesina_director = t.Director.Persona.persona_nomyap,
                                           tesina_tesista = t.Tesista.Persona.persona_nomyap,
                                           seleccionada = (items_seleccionados.IndexOf(t.tesina_id) > -1)
                                       }).ToList();

                if (tesinas_sin_baja.Count() > 0)
                {
                    gv_seleccionar_tesinas.DataSource = tesinas_sin_baja;
                    gv_seleccionar_tesinas.DataBind();
                }
                else
                {
                    gv_seleccionar_tesinas.DataSource = null;
                    gv_seleccionar_tesinas.DataBind();
                }
            }
        }

        protected void chk_seleccionar_tesina_CheckedChanged(object sender, EventArgs e)
        {
            List<string> ids = hidden_tesinas_seleccionadas.Value.Split(',').ToList();
            CheckBox chk = ((CheckBox)sender);

            if (chk.Checked)
            {
                //agregar tesina al listado
                ids.Add(chk.AccessKey);
            }
            else
            {
                //quitar tesina del listado
                if (ids.IndexOf(chk.AccessKey) >= 0)
                {
                    ids.RemoveAt(ids.IndexOf(chk.AccessKey));
                }
            }

            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                string texto_para_el_label = string.Empty;
                string texto_para_el_hidden = string.Empty;
                foreach (string str_id_tesina in ids)
                {
                    int id_tesina;
                    if (int.TryParse(str_id_tesina, out id_tesina))
                    {
                        //texto_para_el_label = texto_para_el_label + cxt.Tesinas.FirstOrDefault(tt => tt.tesina_id == id_tesina).tesina_tema + "; ";
                        texto_para_el_hidden = texto_para_el_hidden + id_tesina.ToString() + ",";
                    }
                }

                //lbl_jueces.Text = texto_para_el_label;
                hidden_tesinas_seleccionadas.Value = texto_para_el_hidden;
            }

            string script = "<script language=\"javascript\"  type=\"text/javascript\">$(document).ready(function() { $('#modal_buscar_jurado').modal('show');});</script>";
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "ShowPopUp", script, false);

        }

        protected void btn_aceptar_seleccion_tesina_Click(object sender, EventArgs e)
        {
            List<item_tesina> items_seleccionados = new List<item_tesina>();
            string texto_para_el_hidden = string.Empty;
            using (HabProfDBContainer cxt = new HabProfDBContainer())
            {
                foreach (GridViewRow fila in gv_seleccionar_tesinas.Rows)
                {
                    CheckBox chk = ((CheckBox)fila.Cells[3].Controls[1]);
                    if (chk.Checked)
                    {
                        int tesina_id = Convert.ToInt32(chk.AccessKey);
                        Tesina t = cxt.Tesinas.FirstOrDefault(tt => tt.tesina_id == tesina_id);
                        items_seleccionados.Add(new item_tesina()
                        {
                            tesina_id = t.tesina_id,
                            tesina_tema = t.tesina_tema,
                            tesina_director = t.Director.Persona.persona_nomyap,
                            tesina_tesista = t.Tesista.Persona.persona_nomyap
                        });

                        texto_para_el_hidden = texto_para_el_hidden + chk.AccessKey + ",";
                    }
                }
            }


            hidden_tesinas_seleccionadas.Value = texto_para_el_hidden;

            if (items_seleccionados.Count > 0)
            {
                gv_tesinas_seleccionadas.DataSource = items_seleccionados;
                gv_tesinas_seleccionadas.DataBind();
            }
            else
            {
                gv_tesinas_seleccionadas.DataSource = null;
                gv_tesinas_seleccionadas.DataBind();
            }

        }

        #endregion

        protected void gv_jueces_PreRender(object sender, EventArgs e)
        {
            if (gv_seleccionar_jurado.Rows.Count > 0)
            {
                gv_seleccionar_jurado.HeaderRow.TableSection = TableRowSection.TableHeader;
            }

            if (gv_jurados.Rows.Count > 0)
            {
                gv_jurados.HeaderRow.TableSection = TableRowSection.TableHeader;
            }

            if (gv_seleccionar_tesinas.Rows.Count > 0)
            {
                gv_seleccionar_tesinas.HeaderRow.TableSection = TableRowSection.TableHeader;
            }

            if (gv_tesinas_seleccionadas.Rows.Count > 0)
            {
                gv_tesinas_seleccionadas.HeaderRow.TableSection = TableRowSection.TableHeader;
            }

        }

        #region Validaciones

        protected void cv_fecha_mesa_ServerValidate(object source, ServerValidateEventArgs args)
        {
            DateTime d;
            args.IsValid = DateTime.TryParse(tb_fecha_mesa.Value, out d);
        }

        protected void cv_jurados_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string[] ids_jueces = hidden_ids_jueces.Value.Split(',');

            int id_jurado = 0;
            int jurados = 0;

            foreach (string id_jurado_str in ids_jueces)
            {
                if (int.TryParse(id_jurado_str, out id_jurado))
                {
                    jurados++;
                }
            }

            args.IsValid = jurados >= 1 && jurados <= 3;
        }

        protected void cv_tesinas_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = hidden_tesinas_seleccionadas.Value.Length > 1;
        }


        #endregion

        protected void btn_crear_mesa_Click(object sender, EventArgs e)
        {
            Validate();
            if (IsValid)
            {
                string str_mesa_id = Request.QueryString["m"];
                int mesa_id = 0;
                if (str_mesa_id == null || int.TryParse(str_mesa_id, out mesa_id))
                {
                    using (HabProfDBContainer cxt = new Aplicativo.HabProfDBContainer())
                    {
                        Mesa mesa = new Mesa();
                        if (str_mesa_id == null)
                        {
                            //mesa nueva
                            mesa = new Aplicativo.Mesa();
                            cxt.Mesas.Add(mesa);
                        }
                        else
                        {

                            mesa = cxt.Mesas.FirstOrDefault(mm => mm.mesa_id == mesa_id);
                            //elimino los jueces y tesinas que tenia asignada para cargar los nuevos
                            List<int> id_jueces = mesa.Jueces.Select(jj => jj.juez_id).ToList();
                            foreach (int id_juez in id_jueces)
                            {
                                Jurado j = cxt.Jueces.FirstOrDefault(jj => jj.juez_id == id_juez);
                                mesa.Jueces.Remove(j);
                            }

                            List<int> id_tesinas = mesa.Tesinas.Select(tt => tt.tesina_id).ToList();
                            foreach (int id_tesina in id_tesinas)
                            {
                                Tesina t = cxt.Tesinas.FirstOrDefault(tt => tt.tesina_id == id_tesina);
                                mesa.Tesinas.Remove(t);
                            }

                        }

                        string[] jurados_ids = hidden_ids_jueces.Value.Split(',');
                        string[] tesinas_ids = hidden_tesinas_seleccionadas.Value.Split(',');

                        //Agrego jueces
                        foreach (string str_jurado_id in jurados_ids)
                        {
                            int jurado_id;
                            if (int.TryParse(str_jurado_id, out jurado_id))
                            {
                                Jurado jurado = cxt.Jueces.FirstOrDefault(jj => jj.juez_id == jurado_id);
                                mesa.Jueces.Add(jurado);
                            }
                        }

                        //agrego tesinas
                        foreach (string str_tesina_id in tesinas_ids)
                        {
                            int tesina_id;
                            if (int.TryParse(str_tesina_id, out tesina_id))
                            {
                                Tesina tesina = cxt.Tesinas.FirstOrDefault(tt => tt.tesina_id == tesina_id);
                                mesa.Tesinas.Add(tesina);
                            }
                        }

                        mesa.mesa_fecha = Convert.ToDateTime(tb_fecha_mesa.Value);
                        mesa.mesa_codigo_carrera = Convert.ToInt32(tb_cod_carrera.Text);
                        mesa.mesa_codigo_materia = Convert.ToInt32(tb_cod_materia.Text);
                        mesa.mesa_codigo_plan = Convert.ToInt32(tb_cod_plan.Text);

                        mesa.mesa_estado = "Generada";

                        /*
                          Envio_mail em_codirector = new Envio_mail()
                        {
                            persona_id = tesina.Codirector.Persona.persona_id,
                            envio_email_destino = tesina.Codirector.Persona.persona_email,
                            envio_fecha_hora = DateTime.Now,
                            envio_respuesta_clave = "no se usa",
                            envio_tipo = MiEmail.tipo_mail.notificacion_eliminacion_tesina_director.ToString()
                        };
                        cxt.Envio_mails.Add(em_codirector);
                        MiEmail me_codirector = new MiEmail(em_codirector, tesina);
                        me_codirector.Enviar_mail();
                         */

                        foreach (Jurado jurado in mesa.Jueces)
                        {
                            Envio_mail em_jurado = new Envio_mail()
                            {
                                persona_id = jurado.Persona.persona_id,
                                envio_email_destino = jurado.Persona.persona_email,
                                envio_fecha_hora = DateTime.Now,
                                envio_respuesta_clave = "no se usa",
                                envio_tipo = MiEmail.tipo_mail.notificacion_alta_mesa_jurado.ToString()
                            };
                            cxt.Envio_mails.Add(em_jurado);
                            MiEmail me_jurado = new MiEmail(em_jurado, "Jurado", mesa.mesa_fecha);
                            me_jurado.Enviar_mail();
                        }

                        foreach (Tesina tesina in mesa.Tesinas)
                        {
                            Envio_mail em_tesista = new Envio_mail()
                            {
                                persona_id = tesina.Tesista.Persona.persona_id,
                                envio_email_destino = tesina.Tesista.Persona.persona_email,
                                envio_fecha_hora = DateTime.Now,
                                envio_respuesta_clave = "no se usa",
                                envio_tipo = MiEmail.tipo_mail.notificacion_alta_mesa_tesista.ToString()
                            };
                            cxt.Envio_mails.Add(em_tesista);
                            MiEmail me_tesista = new MiEmail(em_tesista, "Tesista", mesa.mesa_fecha);
                            me_tesista.Enviar_mail();

                            Envio_mail em_director = new Envio_mail()
                            {
                                persona_id = tesina.Director.Persona.persona_id,
                                envio_email_destino = tesina.Director.Persona.persona_email,
                                envio_fecha_hora = DateTime.Now,
                                envio_respuesta_clave = "no se usa",
                                envio_tipo = MiEmail.tipo_mail.notificacion_alta_mesa.ToString()
                            };
                            cxt.Envio_mails.Add(em_director);
                            MiEmail me_director = new MiEmail(em_director, "Director", mesa.mesa_fecha);
                            me_director.Enviar_mail();

                            if (tesina.Codirector != null)
                            {
                                Envio_mail em_codirector = new Envio_mail()
                                {
                                    persona_id = tesina.Codirector.Persona.persona_id,
                                    envio_email_destino = tesina.Codirector.Persona.persona_email,
                                    envio_fecha_hora = DateTime.Now,
                                    envio_respuesta_clave = "no se usa",
                                    envio_tipo = MiEmail.tipo_mail.notificacion_alta_mesa.ToString()
                                };
                                cxt.Envio_mails.Add(em_codirector);
                                MiEmail me_codirector = new MiEmail(em_codirector, tesina);
                                me_codirector.Enviar_mail();
                            }

                        }

                        cxt.SaveChanges();

                        MessageBox.Show(this, "La mesa se creo correctamente", MessageBox.Tipo_MessageBox.Success, "Exito", "../Aplicativo/admin_mesas.aspx");
                    }
                }
                else
                {
                    MessageBox.Show(this, "No se encontro la mesa buscada", MessageBox.Tipo_MessageBox.Danger, "Atención", "../Aplicativo/admin_mesas.aspx");
                }

            }
        }

    }
}