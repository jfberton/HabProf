<%@ Page Title="" Language="C#" MasterPageFile="~/Aplicativo/Site1.Master" AutoEventWireup="true" CodeBehind="admin_tesis.aspx.cs" Inherits="WebApplication1.Aplicativo.admin_tesis" %>

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

    <h1>Tesinas <small>Listado de tesinas de la licenciatura</small></h1>
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
                <span class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span>Agregar nuevo
            </button>
            <%--<div class="modal fade" id="agregar_tesina" role="dialog" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">
                                <asp:Label Text="text" ID="lbl_agregar_actualizar_tesina" runat="server" />
                                tesina</h4>
                        </div>
                        <div class="modal-body">
                            <input type="hidden" runat="server" id="hidden_id_tesina_editar" />
                            <div class="row">
                                <div class="col-md-12">
                                    <asp:ValidationSummary ID="validation_summary" runat="server" DisplayMode="BulletList" ValidationGroup="tesina"
                                        CssClass="validationsummary panel panel-danger" HeaderText="<div class='panel-heading'>&nbsp;Corrija los siguientes errores antes de continuar:</div>" />
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <table class="table-condensed" style="width: 100%">
                                        <tr>
                                            <td style="width: 20%">
                                                <h3>Tema</h3>
                                            </td>
                                            <td style="width: 100%">
                                                <input type="text" id="tb_tesis_tema" class="form-control" runat="server" placeholder="Tema de la tesina" /></td>
                                            <td>
                                                <asp:RequiredFieldValidator ControlToValidate="tb_tesis_tema" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                    ID="rv_nombre_tesina" runat="server" ErrorMessage="Debe ingresar el tema de la tesina" ValidationGroup="tesina">
                                                </asp:RequiredFieldValidator>
                                                <asp:CustomValidator ControlToValidate="tb_tesis_tema" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                    ID="cv_tesis_tema" runat="server" ErrorMessage="Ya existe una tesis con la misma temática" OnServerValidate="cv_tesis_tema_ServerValidate" ValidationGroup="tesina" />
                                            </td>

                                        </tr>
                                        <tr>
                                            <td>Estado</td>
                                            <td>
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <asp:TextBox runat="server" ID="tb_estado" CssClass="form-control" Enabled="false" Text="estado de la tesis" />
                                                        </td>
                                                        <td>
                                                            <button class="btn btn-warning" title="Modificar estado tesina" id="btn_tesis_cambiar_estado" data-toggle="modal" data-target="#modificar_estado_tesis"><span class="glyphicon glyphicon-edit"></span></button>
                                                            <button class="btn btn-default" title="Ver historial de estados" id="btn_tesis_ver_historial" data-toggle="modal" data-target="#ver_historial_estados_tesina"><span class="glyphicon glyphicon-calendar"></span></button>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Palabras clave</td>
                                            <td style="width: auto">
                                                <input type="text" id="tb_tesina_palabra_clave" class="form-control" runat="server" placeholder="Palabras clave de la tesina" /></td>
                                            <td>
                                                <asp:RequiredFieldValidator ControlToValidate="tb_tesina_palabra_clave" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                    ID="RequiredFieldValidator1" runat="server" ErrorMessage="Debe ingresar las palabras clave para esta tesina" ValidationGroup="tesina">
                                                </asp:RequiredFieldValidator>
                                                <asp:CustomValidator ControlToValidate="tb_tesina_palabra_clave" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                    ID="cv_tesis_palabras_clave" runat="server" ErrorMessage="Ya existe una tesis con alguna de estas palabras clave" OnServerValidate="cv_tesis_palabras_clave_ServerValidate" ValidationGroup="tesina" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Archivo Tesis</td>
                                            <td style="width: auto">
                                                <table style="width: 100%">
                                                    <tr>
                                                        <td style="width: 100%">
                                                            <asp:FileUpload runat="server" ID="tesis_archivo_upload" CssClass="form-control" data-buttonText="Seleccionar archivo" /></td>
                                                        <td>
                                                            <button class="btn btn-warning" title="Guardar archivo seleccionado" runat="server" id="btn_aceptar_archivo" onserverclick="btn_aceptar_archivo_ServerClick"><span class="glyphicon glyphicon-save"></span></button>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>

                                        </tr>
                                        <tr>
                                            <td>Fecha de presentación</td>
                                            <td style="width: auto">
                                                <div class="form-group">
                                                    <div class='input-group date' id='fecha_presentacion'>
                                                        <input type='text' class="form-control" id="tb_fecha_presentacion" />
                                                        <span class="input-group-addon">
                                                            <span class="glyphicon glyphicon-calendar"></span>
                                                        </span>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <asp:RequiredFieldValidator ControlToValidate="tb_tesina_palabra_clave" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                    ID="RequiredFieldValidator2" runat="server" ErrorMessage="Debe ingresar fecha de presentación" ValidationGroup="tesina">
                                                </asp:RequiredFieldValidator>
                                                <asp:CustomValidator ControlToValidate="tb_tesina_palabra_clave" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                    ID="CustomValidator1" runat="server" ErrorMessage="Debe ingresar una fecha válida" OnServerValidate="cv_tesis_palabras_clave_ServerValidate" ValidationGroup="tesina" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Duración (meses)</td>
                                            <td>
                                                <table style="width: 100%">
                                                    <tr>
                                                        <td>Plazo para entrega</td>
                                                        <td style="width: 15%">
                                                            <input type="text" class="form-control" id="tb_duracion_meses" runat="server" /></td>
                                                        <td>
                                                            <asp:RequiredFieldValidator ControlToValidate="tb_duracion_meses" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                                ID="RequiredFieldValidator3" runat="server" ErrorMessage="Debe ingresar los meses que tiene de plazo para la entrega de la tesina" ValidationGroup="tesina">
                                                            </asp:RequiredFieldValidator></td>
                                                        <td>Período entre notificaciones   </td>
                                                        <td style="width: 15%">
                                                            <input type="text" class="form-control" id="tb_plazo_notificaciones" runat="server" /></td>

                                                    </tr>
                                                </table>
                                            </td>
                                            <td>
                                                <asp:RequiredFieldValidator ControlToValidate="tb_plazo_notificaciones" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                    ID="RequiredFieldValidator4" runat="server" ErrorMessage="Debe ingresar los meses entre los recordatorios para la entrega de la tesina" ValidationGroup="tesina">
                                                </asp:RequiredFieldValidator>
                                                <asp:CustomValidator ControlToValidate="tb_plazo_notificaciones" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                    ID="CustomValidator2" runat="server" ErrorMessage="El período entre notificaciones debe ser menor a la duración de la tesina" OnServerValidate="cv_tesis_palabras_clave_ServerValidate" ValidationGroup="tesina" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Tesista</td>
                                            <td>
                                                <table>
                                                    <tr>
                                                        <td style="width: 100%;">
                                                            <input runat="server" id="tb_tesista" placeholder="Seleccione Tesista..." type="text" class="form-control" disabled="disabled" />
                                                        </td>
                                                        <td>
                                                            <button class="btn btn-warning" title="Seleccionar Tesista" runat="server" id="btn_seleccionar_tesista"><span class="glyphicon glyphicon-edit"></span></button>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td>
                                                <asp:RequiredFieldValidator ControlToValidate="tb_tesista" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                    ID="RequiredFieldValidator5" runat="server" ErrorMessage="Debe seleccionar al Tesista" ValidationGroup="tesina">
                                                </asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Director</td>
                                            <td>
                                                <table>
                                                    <tr>
                                                        <td style="width: 100%;">
                                                            <input runat="server" id="tb_director" placeholder="Seleccione Director..." type="text" class="form-control" disabled="disabled" />
                                                        </td>
                                                        <td>
                                                            <button class="btn btn-warning" title="Seleccionar Director..." runat="server" id="btn_seleccionar_director"><span class="glyphicon glyphicon-edit"></span></button>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td>
                                                <asp:RequiredFieldValidator ControlToValidate="tb_director" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                    ID="RequiredFieldValidator6" runat="server" ErrorMessage="Debe seleccionar al Director" ValidationGroup="tesina">
                                                </asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button id="btn_guardar" runat="server" onserverclick="btn_guardar_ServerClick" class="btn btn-success" validationgroup="tesina">
                                <span class="glyphicon glyphicon-floppy-disk" aria-hidden="true"></span>Guardar!
                            </button>
                            <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                        </div>
                    </div>
                </div>
            </div>--%>
        </div>
    </div>


    <asp:GridView ID="gv_tesinas" runat="server" OnPreRender="gv_tesinas_PreRender"
        AutoGenerateColumns="False" GridLines="None" CssClass="display">
        <Columns>
            <asp:BoundField DataField="tesista" HeaderText="Tesista" ReadOnly="true" />
            <asp:BoundField DataField="director" HeaderText="Director" ReadOnly="true" />
            <asp:TemplateField HeaderText="Tema">
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server"
                         ToolTip='<%# Eval("tema_completo") %>'
                         Text='<%# Eval("tema") %>'>
                    </asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="estado" HeaderText="Estado" ReadOnly="true" />
            <asp:TemplateField>
                <ItemTemplate>
                    <button runat="server" class="btn btn-sm btn-default" id="btn_ver" causesvalidation="false" onserverclick="btn_ver_ServerClick" data-id='<%#Eval("tesis_id")%>'>
                        <span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span>&nbsp;Ver
                    </button>
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
        <div class="modal-dialog">
            <div class="modal-content panel-default">
                <div class="modal-header panel-heading">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title panel-title"><span class="glyphicon glyphicon-remove-sign" aria-hidden="true"></span>Datos completos del tesina</h4>
                </div>
                <div class="modal-body">
                    
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="CPH_Scripts" runat="server">
    <script>
        $(function () {
            $('#fecha_presentacion').datetimepicker({
                locale: 'es',
                format: 'DD/MM/YYYY'
            });
        });

        $(":file").filestyle({ buttonBefore: true, buttonText: "Seleccionar archivo" });

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
            modal.find('.modal-body #texto_a_mostrar').text('Esta por eliminar ' + introduccion + ' ' + nombre + '. Desea continuar?')
        })
        $(document).ready(function () {
            $('#<%= gv_tesinas.ClientID %>').DataTable({
                "scrollY": "400px",
                "scrollCollapse": true,
                "paging": false,
                "language": {
                    "search": "Buscar:",
                    "zeroRecords": "No se encontraron registros",
                    "info": "Mostrando _START_ de _END_ de _TOTAL_ registros",
                    "infoEmpty": "No hay registros disponibles",
                    "infoFiltered": "(filtrado de _MAX_ registros totales)"
                }
            });

        });
    </script>
    <script>
        $(document).ready(function () {
            $('[data-toggle="tooltip"]').tooltip();
        });
    </script>

</asp:Content>
