<%@ Page Title="" Language="C#" Async="true" MasterPageFile="~/Aplicativo/Site1.Master" AutoEventWireup="true" CodeBehind="admin_tesinas.aspx.cs" Inherits="WebApplication1.Aplicativo.admin_tesinas" %>

<%@ Register Src="~/Aplicativo/Menues/menu_admin.ascx" TagPrefix="uc1" TagName="menu_admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CPH_Menues" runat="server">
    <uc1:menu_admin runat="server" ID="menu_admin" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CPH_Body" runat="server">
    <ol class="breadcrumb">
        <li><a href="admin_home.aspx">Inicio</a></li>
        <li>Administrar tesinas</li>
    </ol>

    <h1>Tesinas <small>
        <asp:Label Text="Listado de Tesinas de la Licenciatura" runat="server" ID="lbl_small_titulo" /></small></h1>
    <div class="row">
        <div class="col-md-10">
            <div class="alert alert-warning" role="alert" runat="server" id="lbl_sin_tesinas">
                <strong>No existen Tesinas!</strong> Pruebe agregar algunos para comenzar.
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        </div>
        <div class="col-md-2">
            <button type="button" class="btn btn-default pull-right" id="btn_agregar_tesina" runat="server" onserverclick="btn_agregar_tesina_ServerClick">
                <span class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span>Nueva Tesina
            </button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <asp:GridView ID="gv_tesinas" runat="server" OnPreRender="gv_tesinas_PreRender"
                AutoGenerateColumns="False" GridLines="None" CssClass="display">
                <Columns>
                    <asp:BoundField DataField="prioridad_orden" HeaderText="Orden" ReadOnly="true" />
                    <asp:BoundField DataField="tesista" HeaderText="Tesista" ReadOnly="true" />
                    <asp:BoundField DataField="director" HeaderText="Director" ReadOnly="true" />
                    <asp:TemplateField HeaderText="Tema">
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server"
                                ToolTip='<%# Eval("tema_completo") %>'
                                Text='<%# Eval("tema_recortado") %>'>
                            </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="estado" HeaderText="Estado" ReadOnly="true" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <button runat="server" class="btn btn-sm btn-default" id="btn_ver" causesvalidation="false" onserverclick="btn_ver_ServerClick" data-id='<%#Eval("tesis_id")%>'>
                                <span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span>&nbsp;Ver-Tratar
                            </button>

                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <button runat="server" class="btn btn-sm btn-warning" id="btn_editar" causesvalidation="false" onserverclick="btn_editar_ServerClick" data-id='<%#Eval("tesis_id")%>'>
                                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>&nbsp;Editar
                            </button>
                            <button
                                type="button" class="btn btn-sm btn-danger"
                                data-toggle="modal"
                                data-target="#advertencia_eliminacion"
                                data-id='<%#Eval("tesis_id")%>'
                                data-introduccion="la tesina del tesista"
                                data-nombre='<%#Eval("tesista")%>'>
                                <span class="glyphicon glyphicon-remove-circle" aria-hidden="true"></span>&nbsp;Eliminar
                            </button>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

            <div class="modal fade" id="advertencia_eliminacion" role="dialog" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content panel-danger">
                        <div class="modal-header panel-heading">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title panel-title" style="color: white; font-weight: bold;">ATENCIÓN!!</h4>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-md-12">
                                    <input type="hidden" runat="server" id="id_item_por_eliminar" />
                                    <p id="texto_a_mostrar"></p>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <asp:Button Text="Aceptar" CssClass="btn btn-success" CausesValidation="false" ID="btn_aceptar_eliminacion" OnClick="btn_aceptar_eliminacion_Click" runat="server" />
                            <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="panel_ver_tesina" role="dialog" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content panel-default">
                        <div class="modal-header panel-heading">
                            <h3 class="panel-title text-center">
                                <asp:Label Text="" ID="lbl_tema" runat="server" /></h3>
                            <h3 class="modal-title panel-title text-center"><small>
                                <asp:Label Text="" ID="lbl_descripcion" runat="server" /></small></h3>
                        </div>
                        <div class="modal-body">
                            <asp:HiddenField runat="server" ID="hidden_tesina_id" />
                            <div class="row">
                                <div class="col-md-6">
                                    <strong>Tesista:</strong>
                                    <asp:Label Text="" ID="lbl_tesista" runat="server" />
                                </div>
                                <div class="col-md-6">
                                    <strong>Director:</strong>
                                    <asp:Label Text="" ID="lbl_director" runat="server" />
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-4">
                                    <strong>Fecha de inicio:</strong>
                                    <asp:Label Text="" ID="lbl_alta" runat="server" />
                                </div>
                                <div class="col-md-4">
                                    <strong>Duración:</strong>
                                    <asp:Label Text="" ID="lbl_duracion" runat="server" />
                                </div>
                                <div class="col-md-4">
                                    <strong>Notificaciones cada:</strong>
                                    <asp:Label Text="" ID="lbl_periodo_notificaciones" runat="server" />
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-4">
                                    <strong>Estado:</strong>
                                    <asp:Label Text="" ID="lbl_estado" runat="server" />
                                </div>
                                <div class="col-md-4">
                                    <strong>Calificación final Tesina:</strong>
                                    <asp:Label Text="" ID="lbl_calificacion" runat="server" />
                                </div>
                                <div class="col-md-4">
                                    <strong>Calificación Director:</strong>
                                    <asp:Label Text="" ID="lbl_calificacion_director" runat="server" />
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <strong>Archivo Tesina:</strong> <a href="#" target="_blank" runat="server" id="lbl_archivo_subido">sin presentaciones</a>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <strong>Jueces: </strong><asp:Label Text="" ID="lbl_jueces_tesina_visualizacion" runat="server" />
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <u><strong>Historial de estados</strong></u>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <asp:GridView ID="gv_historial" runat="server" OnPreRender="gv_tesinas_PreRender"
                                        AutoGenerateColumns="False" GridLines="None" CssClass="display compact">
                                        <Columns>
                                            <asp:BoundField DataField="fecha" HeaderText="Fecha" DataFormatString="{0:d}" ReadOnly="true" />
                                            <asp:BoundField DataField="estado" HeaderText="Estado" ReadOnly="true" />
                                            <asp:BoundField DataField="observacion_completa" HeaderText="Observaciones" ReadOnly="true" />
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </div>

                        </div>
                        <div class="modal-footer">
                            <div class="row">
                                <div class="col-md-10 text-right">
                                    <div class="btn-group" role="group" aria-label="...">
                                        <button type="button" class="btn btn-default" runat="server" id="btn_realizar_entrega" onserverclick="btn_realizar_entrega_ServerClick" title="Sube un nuevo archivo de tesina.">Realizar entrega</button>
                                        <button type="button" class="btn btn-default" data-toggle="modal" runat="server" id="btn_lista_para_presentar" data-target="#lista_para_presentar" title="Pasa al estado lista para presentar, no se puede editar más.">Lista para presentar</button>
                                        <button type="button" class="btn btn-default" data-toggle="modal" runat="server" id="btn_devolver_para_corregir" data-target="#devolver_a_corregir" title="Rechaza la entrega y para al estado A Corregir.">Devolver a corregir</button>
                                        <button type="button" class="btn btn-default" data-toggle="modal" runat="server" id="btn_prorroga" data-target="#generar_prorroga" title="Modifica los valores de la tesina y la deja con estado prorroga.">Prorroga</button>

                                        <button type="button" class="btn btn-default" runat="server" id="btn_aprobar" onserverclick="btn_aprobar_ServerClick" title="Finaliza la tesina con estado aprobada, guarda calificaciones de tesina y director.">Aprobar</button>
                                        <button type="button" class="btn btn-default" runat="server" id="btn_desaprobar" onserverclick="btn_desaprobar_ServerClick" itle="Finaliza la tesina con estado desaprobada, guarda calificaciones de tesina y director.">Desaprobar</button>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="realizar_entrega" role="dialog" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">Pasar a estado Entregada</h4>
                        </div>
                        <div class="modal-body">
                            <p>Suba el archivo de tesina para que el mismo esté disponible para su corrección por parte del Director.</p>
                            <p>Una vez guardado el cambio no podrá editar el archivo.</p>
                            <h4>Archivo:</h4>
                            <asp:FileUpload runat="server" ID="file_tesis" />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="file_tesis" ErrorMessage="Únicamente archivos .pdf" ValidationExpression="^([a-zA-Z].*|[1-9].*)\.(((p|P)(d|D)(f|F)))$"></asp:RegularExpressionValidator>
                            <div class="alert" role="alert" runat="server" id="div_status_file">
                                <asp:Label Text="" ID="status_label" runat="server" />
                            </div>
                        </div>
                        <div class="modal-footer">
                            <asp:Button Text="Subir archivo" runat="server" ID="btn_subir_archivo" CssClass="btn btn-success" OnClick="btn_subir_archivo_Click" />
                            <asp:Button Text="Realizar entrega" runat="server" Enabled="false" CssClass="btn btn-primary" ID="btn_guardar_realizar_entrega" OnClick="btn_guardar_realizar_entrega_Click" />
                            <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="devolver_a_corregir" role="dialog" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">Rechazar entrega</h4>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-md-12">
                                    <asp:ValidationSummary ID="validation_summary" runat="server" DisplayMode="BulletList" ValidationGroup="rechazar"
                                        CssClass="validationsummary panel panel-danger" HeaderText="<div class='panel-heading'>&nbsp;Corrija los siguientes errores antes de continuar:</div>" />
                                </div>
                            </div>
                            <p>El archivo de tesina que subio el tesista no esta apto para su presentación.</p>
                            <p>Seleccione cual de las opciones se ajusta al rechazo</p>
                            <div class="row" runat="server" id="div_descripcion">
                                <div class="col-md-11">
                                    <%--<textarea runat="server" id="tb_descripcion_rechazo" rows="2" class="form-control" placeholder="Ingrese las observaciones del cambio de estado.-"></textarea>--%>
                                    <asp:RadioButton Text="Opcion 1" GroupName="opciones_rechazo" runat="server" ID="opcion_1" CssClass="form-control" Checked="true" />
                                    <asp:RadioButton Text="Opcion 2" GroupName="opciones_rechazo" runat="server" ID="opcion_2" CssClass="form-control" />
                                    <asp:RadioButton Text="Opcion 3" GroupName="opciones_rechazo" runat="server" ID="opcion_3" CssClass="form-control" />
                                </div>
                                <%--<div class="col-md-1">
                                    <asp:RequiredFieldValidator ControlToValidate="tb_descripcion_rechazo" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                        ID="RequiredFieldValidator3" runat="server" ErrorMessage="Debe ingresar las observaciones para poder continuar" ValidationGroup="rechazar">
                                    </asp:RequiredFieldValidator>
                                </div>--%>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <asp:Button Text="Enviar a corregir!" CssClass="btn btn-success" ID="btn_enviar_a_corregir" OnClick="btn_enviar_a_corregir_Click" ValidationGroup="rechazar" runat="server" />
                            <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="lista_para_presentar" role="dialog" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">Lista para presentar</h4>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-md-12">
                                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" DisplayMode="BulletList" ValidationGroup="lista_par_presentar"
                                        CssClass="validationsummary panel panel-danger" HeaderText="<div class='panel-heading'>&nbsp;Corrija los siguientes errores antes de continuar:</div>" />
                                </div>
                            </div>
                            <p>El archivo de tesina que subio el tesista esta apto para su presentación.</p>
                            <p>Ingrese unas observaciones </p>
                            <div class="row" runat="server" id="div1">
                                <div class="col-md-11">
                                    <asp:RadioButton Text="Opcion 1" GroupName="opciones_lista_presentar" runat="server" ID="rb_opcion_1_lista_presentar" CssClass="form-control" Checked="true" />
                                    <asp:RadioButton Text="Opcion 2" GroupName="opciones_lista_presentar" runat="server" ID="rb_opcion_2_lista_presentar" CssClass="form-control" />
                                    <asp:RadioButton Text="Opcion 3" GroupName="opciones_lista_presentar" runat="server" ID="rb_opcion_3_lista_presentar" CssClass="form-control" />
                                    <%--<textarea runat="server" id="tb_descripcion_lista_para_presentar" rows="2" class="form-control" placeholder="Ingrese las observaciones del cambio de estado.-"></textarea>--%>
                                </div>
                                <div class="col-md-1">
                                    <%--<asp:RequiredFieldValidator ControlToValidate="tb_descripcion_lista_para_presentar" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                        ID="RequiredFieldValidator1" runat="server" ErrorMessage="Debe ingresar las observaciones para poder continuar" ValidationGroup="lista_par_presentar">
                                    </asp:RequiredFieldValidator>--%>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <asp:Button Text="Lista para evaluar!" CssClass="btn btn-success" ID="btn_pasar_a_lista_para_presentar" OnClick="btn_pasar_a_lista_para_presentar_Click" ValidationGroup="lista_par_presentar" runat="server" />
                            <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="generar_prorroga" role="dialog" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">Cargar prorroga</h4>
                        </div>
                        <div class="modal-body">
                            <div class="col-md-12">
                                <asp:ValidationSummary ID="ValidationSummary2" runat="server" DisplayMode="BulletList" ValidationGroup="prorroga"
                                    CssClass="validationsummary panel panel-danger" HeaderText="<div class='panel-heading'>&nbsp;Corrija los siguientes errores antes de continuar:</div>" />
                            </div>
                            <%--FECHA INICIO--%>
                            <div class="row" runat="server" id="div_fecha_inicio">
                                <div class="col-md-2">Fecha inicio</div>
                                <div class="col-md-9">
                                    <div class='input-group date' id='datetimepicker1'>
                                        <input type='text' runat="server" id="tb_fecha_inicio" class="form-control" />
                                        <span class="input-group-addon">
                                            <span class="glyphicon glyphicon-calendar"></span>
                                        </span>
                                    </div>
                                </div>
                                <div class="col-md-1">
                                    <asp:RequiredFieldValidator ControlToValidate="tb_fecha_inicio" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                        ID="RequiredFieldValidator2" runat="server" ErrorMessage="Debe ingresar la fecha de inicio de la tesina" ValidationGroup="prorroga">
                                    </asp:RequiredFieldValidator>
                                    <asp:CustomValidator ControlToValidate="tb_fecha_inicio" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                        ID="cv_fecha_inicio" runat="server" ErrorMessage="Debe ingresar una fecha válida" OnServerValidate="cv_fecha_inicio_ServerValidate" ValidationGroup="prorroga" />
                                </div>
                            </div>

                            <br />
                            <%--DURACION MESES PERIODO ENTRE NOTIFICACIONES--%>
                            <div class="row" runat="server" id="div_duracion_y_notificaciones">
                                <div class="col-md-2">Plazo</div>
                                <div class="col-md-3">
                                    <div class="input-group">
                                        <input type="text" class="form-control" runat="server" id="tb_duracion" />
                                        <span class="input-group-addon">meses</span>
                                    </div>
                                </div>
                                <div class="col-md-1">
                                    <asp:RequiredFieldValidator ControlToValidate="tb_duracion" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                        ID="RequiredFieldValidator4" runat="server" ErrorMessage="Debe ingresar los meses de duración para la entrega final de la tesina" ValidationGroup="prorroga">
                                    </asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ValidationExpression="\d{1,2}" ControlToValidate="tb_duracion" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                        ID="RegularExpressionValidator2" runat="server" ErrorMessage="Debe ingresar un numero entero de hasta dos dígitos" ValidationGroup="prorroga" />
                                </div>
                                <div class="col-md-2">
                                    Período entre notificaciones
                                </div>
                                <div class="col-md-3">
                                    <div class="input-group">
                                        <input type="text" class="form-control" runat="server" id="tb_notificacion" />
                                        <span class="input-group-addon">meses</span>
                                    </div>
                                </div>
                                <div class="col-md-1">
                                    <asp:RequiredFieldValidator ControlToValidate="tb_notificacion" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                        ID="RequiredFieldValidator5" runat="server" ErrorMessage="Debe ingresar los meses entre recordatorios automáticos" ValidationGroup="prorroga">
                                    </asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ValidationExpression="\d{1}" ControlToValidate="tb_notificacion" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                        ID="RegularExpressionValidator1" runat="server" ErrorMessage="Debe ingresar un numero entero de un dígito" ValidationGroup="prorroga" />
                                    <asp:CustomValidator ControlToValidate="tb_notificacion" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                        ID="cv_notificacion" runat="server" ErrorMessage="El valor ingresado debe ser menor o igual a el plazo para la entrega de la tesina" OnServerValidate="cv_notificacion_ServerValidate" ValidationGroup="prorroga" />
                                </div>
                            </div>
                            <br />
                        </div>
                        <div class="modal-footer">
                            <asp:Button Text="Generar prorroga" CssClass="btn btn-success" ID="btn_prorrogar" OnClick="btn_prorrogar_Click" ValidationGroup="prorroga" runat="server" />
                            <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="aprobar_tesina" role="dialog" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content panel-success">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">
                                <asp:Label Text="" ID="lbl_aprobar_desaprobar_tesina" runat="server" /></h4>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-md-12">
                                    <asp:ValidationSummary ID="ValidationSummary3" runat="server" DisplayMode="BulletList" ValidationGroup="aprobar"
                                        CssClass="validationsummary panel panel-danger" HeaderText="<div class='panel-heading'>&nbsp;Corrija los siguientes errores antes de continuar:</div>" />
                                </div>
                            </div>
                            <p>Guardar aprobación de tesina.</p>
                            <p>Ingrese unas observaciones sobre la finalización de la tesina</p>
                            <div class="row">
                                <div class="col-md-11">
                                    <textarea runat="server" id="tb_descripcion_aprobar_tesina" rows="2" class="form-control" placeholder="Ingrese las observaciones del cambio de estado.-"></textarea>
                                </div>
                                <div class="col-md-1">
                                    <asp:RequiredFieldValidator ControlToValidate="tb_descripcion_aprobar_tesina" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                        ID="RequiredFieldValidator6" runat="server" ErrorMessage="Debe ingresar las observaciones para poder continuar" ValidationGroup="aprobar">
                                    </asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <br />
                            <div class="row">
                                <div class="col-md-3">Calificación Tesina</div>
                                <div class="col-md-2">
                                    <input type="text" class="form-control" runat="server" id="tb_calificacion_tesina_aprobada" />
                                </div>
                                <div class="col-md-1">
                                    <asp:RequiredFieldValidator ControlToValidate="tb_calificacion_tesina_aprobada" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                        ID="RequiredFieldValidator7" runat="server" ErrorMessage="Debe ingresar la calificación final de la tesina" ValidationGroup="aprobar">
                                    </asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ValidationExpression="^([0-9]|10)$" ControlToValidate="tb_calificacion_tesina_aprobada" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                        ID="RegularExpressionValidator4" runat="server" ErrorMessage="Debe ingresar un número entero del 0 al 10" ValidationGroup="aprobar" />
                                </div>
                                <div class="col-md-3">
                                    Calificación Director
                                </div>
                                <div class="col-md-2">
                                    <input type="text" class="form-control" runat="server" id="tb_calificacion_director_aprobada" />
                                </div>
                                <div class="col-md-1">
                                    <asp:RequiredFieldValidator ControlToValidate="tb_calificacion_director_aprobada" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                        ID="RequiredFieldValidator8" runat="server" ErrorMessage="Debe ingresar la calificación para el desempeño del Director en la Tesina" ValidationGroup="aprobar">
                                    </asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ValidationExpression="^([0-9]|10)$" ControlToValidate="tb_calificacion_director_aprobada" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                        ID="RegularExpressionValidator5" runat="server" ErrorMessage="Debe ingresar un número entero del 0 al 10" ValidationGroup="aprobar" />
                                </div>
                            </div>
                            <br />
                            <div class="row">
                                <div class="col-md-11">
                                    <asp:HiddenField runat="server" ID="hidden_ids_jueces" />
                                    <strong>Jueces que participaron:</strong>
                                    <asp:Label Text="Seleccione los jueces que participaron de la grilla desplegada aquí debajo" ID="lbl_jueces" runat="server" />
                                </div>
                                <div class="col-md-1">
                                    <asp:CustomValidator ControlToValidate="tb_calificacion_director_aprobada" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                        ID="cv_jueces" runat="server" ErrorMessage="Debe seleccionar al menos un juez" OnServerValidate="cv_jueces_ServerValidate" ValidationGroup="aprobar" />
                                </div>
                            </div>
                            <br />
                            <div class="row">
                                <div class="col-md-12">
                                    <asp:GridView ID="gv_jueces" runat="server" OnPreRender="gv_tesinas_PreRender"
                                        AutoGenerateColumns="False" GridLines="None" CssClass="display">
                                        <Columns>
                                            <asp:BoundField DataField="juez_persona_nomyap" HeaderText="Nombre" ReadOnly="true" />
                                            <asp:BoundField DataField="juez_persona_dni" HeaderText="DNI" ReadOnly="true" />
                                            <asp:BoundField DataField="juez_persona_email" HeaderText="E-mail" ReadOnly="true" />
                                            <asp:TemplateField HeaderText="Seleccionar juez">
                                                <ItemTemplate>
                                                    <asp:CheckBox Text="" AccessKey='<%#Eval("juez_id")%>' Checked="false" OnCheckedChanged="chk_seleccion_juez_CheckedChanged" AutoPostBack="true" ID="chk_seleccion_juez" runat="server" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <asp:Button Text="Aprobar Tesina" CssClass="btn btn-success" ID="btn_guardar_aprobar_tesina" OnClick="btn_guardar_aprobar_tesina_Click" ValidationGroup="aprobar" runat="server" />
                            <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="CPH_Scripts" runat="server">
    <script>

        var d = new Date();
        d.getDate();
        $(function () {
            $('#datetimepicker1').datetimepicker({
                maxDate: d,
                locale: 'es',
                format: 'L'
            });
        });

        $(":file").filestyle({ buttonBefore: false, buttonText: "Seleccionar archivo" });

        $(document).ready(function () {
            $('#<%= gv_jueces.ClientID %>').DataTable({
               "scrollY": "400px",
               "scrollCollapse": true,
               "paging": true,
               "language": {
                   "search": "Buscar:",
                   "emptyTable": "Sin registros",
                   "lengthMenu": "Mostrando _MENU_ registros",
                   "zeroRecords": "No se encontraron registros",
                   "info": "Mostrando _START_ de _END_ de _TOTAL_ registros",
                   "infoEmpty": "No hay registros disponibles",
                   "infoFiltered": "(filtrado de _MAX_ registros totales)",
                   "paginate": {
                       "first": "primero",
                       "last": "último",
                       "next": "próximo",
                       "previous": "anterior"
                   }
               }
           });

       });

       $('#advertencia_eliminacion').on('show.bs.modal', function (event) {
           // Button that triggered the modal
           var button = $(event.relatedTarget)
           // Extract info from data-* attributes
           var id = button.data('id')
           var introduccion = button.data('introduccion')
           var nombre = button.data('nombre')
           // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
           var modal = $(this)
           modal.find('.modal-body #' + '<%= id_item_por_eliminar.ClientID %>').val(id)
            modal.find('.modal-body #texto_a_mostrar').text('Esta por eliminar ' + introduccion + ' ' + nombre + '. Esta acción enviará correos de notificación al tesista y su director. Desea continuar?')
        })

        $(document).ready(function () {
            $('#<%= gv_tesinas.ClientID %>').DataTable({
                "scrollY": "400px",
                "scrollCollapse": true,
                "language": {
                    "search": "Buscar:",
                    "emptyTable": "Sin registros",
                    "lengthMenu": "Mostrando _MENU_ registros",
                    "zeroRecords": "No se encontraron registros",
                    "info": "Mostrando _START_ de _END_ de _TOTAL_ registros",
                    "infoEmpty": "No hay registros disponibles",
                    "infoFiltered": "(filtrado de _MAX_ registros totales)",
                    "paginate": {
                        "first": "primero",
                        "last": "último",
                        "next": "próximo",
                        "previous": "anterior"
                    },
                }
            });

        });


        $(document).ready(function () {
            $('#<%= gv_historial.ClientID %>').DataTable({
                "scrollY": "400px",
                "scrollCollapse": true,
                "paging": false,
                "searching": false,
                "language": {
                    "search": "Buscar:",
                    "zeroRecords": "No se encontraron registros",
                    "info": "Mostrando _START_ de _END_ de _TOTAL_ registros",
                    "infoEmpty": "No hay registros disponibles",
                    "infoFiltered": "(filtrado de _MAX_ registros totales)"
                }
            });

        });

        $('#panel_ver_tesina').on('shown.bs.modal', function () {
            var table = $('#<%= gv_historial.ClientID %>').DataTable();
            table.draw();
        });

        $('#aprobar_tesina').on('shown.bs.modal', function () {
            var table = $('#<%= gv_jueces.ClientID %>').DataTable();
            table.draw();
        });

    </script>

</asp:Content>
