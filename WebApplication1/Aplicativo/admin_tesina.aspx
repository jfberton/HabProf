<%@ Page Title="" Language="C#" MasterPageFile="~/Aplicativo/Site1.Master" AutoEventWireup="true" CodeBehind="admin_tesina.aspx.cs" Inherits="WebApplication1.Aplicativo.admin_tesina" %>

<%@ Register Src="~/Aplicativo/Menues/menu_admin.ascx" TagPrefix="uc1" TagName="menu_admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CPH_Menues" runat="server">
    <uc1:menu_admin runat="server" ID="menu_admin" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CPH_Body" runat="server">
    <ol class="breadcrumb">
        <li><a href="admin_home.aspx">Inicio</a></li>
        <li><a href="admin_tesis.aspx">Administrar tesinas</a></li>
        <li>
            <asp:Label Text="" ID="lbl_bread_last_page" runat="server" /></li>
    </ol>

    <%--ValidationSummary--%>
    <div class="row">
        <div class="col-md-12">
            <asp:ValidationSummary ID="validation_summary" runat="server" DisplayMode="BulletList" ValidationGroup="tesina"
                CssClass="validationsummary panel panel-danger" HeaderText="<div class='panel-heading'>&nbsp;Corrija los siguientes errores antes de continuar:</div>" />
        </div>
    </div>

    <%--TEMA--%>
    <div class="row">
        <div class="col-md-12">
            <h1 class="text-center">
                <asp:Label Text="Tema de la tesina" ID="lbl_tema_tesina" runat="server" /><small>    <a data-toggle="modal" title="Editar tema Tesina" data-target="#modificar_tema_tesina" href="#"><span class="glyphicon glyphicon-edit"></span></a></small></h1>
            <div class="modal fade" id="modificar_tema_tesina" role="dialog" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">Modificar tema Tesina</h4>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-md-12">
                                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" DisplayMode="BulletList" ValidationGroup="tema_tesis"
                                        CssClass="validationsummary panel panel-danger" HeaderText="<div class='panel-heading'>&nbsp;Corrija los siguientes errores antes de continuar:</div>" />
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-11">
                                    <input type="text" runat="server" id="tb_nuevo_tema_tesina" class="form-control has-error" placeholder="Ingrese el tema de la tesina..." />
                                </div>
                                <div class="col-md-1">
                                    <asp:RequiredFieldValidator ControlToValidate="tb_nuevo_tema_tesina" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                        ID="rv_nombre_tesina" runat="server" ErrorMessage="Debe ingresar el tema de la tesina" ValidationGroup="tema_tesis">
                                    </asp:RequiredFieldValidator>
                                    <asp:CustomValidator ControlToValidate="tb_nuevo_tema_tesina" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                        ID="cv_tesis_tema" runat="server" ErrorMessage="Ya existe una tesis con la misma temática" OnServerValidate="cv_tesis_tema_ServerValidate" ValidationGroup="tema_tesis" />
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button id="btn_guardar_tema_de_todos_modos" visible="false" runat="server" causesvalidation="false" onserverclick="btn_guardar_tema_de_todos_modos_ServerClick" class="btn btn-warning">
                                <span class="glyphicon glyphicon-floppy-disk" aria-hidden="true"></span>Modificar de todas maneras
                            </button>

                            <button id="btn_guardar_tema_tesis" runat="server" validationgroup="tema_tesis" onserverclick="btn_guardar_tema_tesis_ServerClick" class="btn btn-success">
                                <span class="glyphicon glyphicon-floppy-disk" aria-hidden="true"></span>Modificar Tema
                            </button>
                            <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%--ESTADO--%>
    <div class="row" runat="server" id="div_estado">
        <div class="col-md-12">
            <table>
                <tr>
                    <td>Estado</td>
                    <td>
                        <table>
                            <tr>
                                <td>
                                    <asp:TextBox runat="server" ID="tb_estado" CssClass="form-control" Enabled="false" Text="estado de la tesis" />
                                </td>
                                <td>
                                    <a class="btn btn-warning" title="Modificar estado tesina" runat="server" id="btn_tesis_cambiar_estado" data-toggle="modal" data-target="#modificar_estado_tesina"><span class="glyphicon glyphicon-edit"></span></a>
                                    <button class="btn btn-default" title="Ver historial de estados" onserverclick="btn_tesis_ver_historial_ServerClick" runat="server" id="btn_tesis_ver_historial"><span class="glyphicon glyphicon-calendar"></span></button>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>

            <div class="modal fade" id="modificar_estado_tesina" role="dialog" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">Modificar estado Tesina</h4>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-md-12">
                                    <asp:ValidationSummary ID="ValidationSummary2" runat="server" DisplayMode="BulletList" ValidationGroup="estado_tesis"
                                        CssClass="validationsummary panel panel-danger" HeaderText="<div class='panel-heading'>&nbsp;Corrija los siguientes errores antes de continuar:</div>" />
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-2">
                                    Estado
                                </div>
                                <div class="col-md-9">
                                    <asp:DropDownList runat="server" ID="ddl_estados" CssClass="form-control">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-2">
                                    Observaciones
                                </div>
                                <div class="col-md-9">
                                    <input type="text" runat="server" id="t_observacion_nuevo_estado" aria-multiline="true" class="form-control has-error" placeholder="Ingrese el tema de la tesina..." />
                                </div>
                                <div class="col-md-1">
                                    <asp:RequiredFieldValidator ControlToValidate="tb_nuevo_tema_tesina" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                        ID="RequiredFieldValidator1" runat="server" ErrorMessage="Debe ingresar alguna observación sobre el cambio de estado" ValidationGroup="estado_tesis">
                                    </asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button id="btn_modificar_estado" runat="server" validationgroup="estado_tesis" onserverclick="btn_modificar_estado_ServerClick" class="btn btn-success">
                                <span class="glyphicon glyphicon-floppy-disk" aria-hidden="true"></span>Modificar estado!
                            </button>
                            <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="ver_historial_de_estados" role="dialog" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">Historial de estados tesina</h4>
                        </div>
                        <div class="modal-body">
                            <asp:GridView ID="gv_historial" runat="server" OnPreRender="gv_historial_PreRender"
                                AutoGenerateColumns="False" GridLines="None" CssClass="display">
                                <Columns>
                                    <asp:BoundField DataField="fecha" HeaderText="Fecha" DataFormatString="{0:d}" ReadOnly="true" />
                                    <asp:BoundField DataField="estado" HeaderText="Estado" ReadOnly="true" />
                                    <asp:TemplateField HeaderText="Observaciones">
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server"
                                                ToolTip='<%# Eval("observacion_completa") %>'
                                                Text='<%# Eval("observacion_recortada") %>'>
                                            </asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12 text-right">
            <button id="btn_guardar_tesina" runat="server" onserverclick="btn_guardar_tesina_ServerClick" class="btn btn-success" validationgroup="tesina">
                <span class="glyphicon glyphicon-floppy-disk" aria-hidden="true"></span>Guardar!
            </button>
            <button type="button" class="btn btn-default" runat="server" id="btn_cancelar" onserverclick="btn_cancelar_ServerClick">Cancelar</button>
        </div>
    </div>


</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="CPH_Scripts" runat="server">
    <script>
        $(document).ready(function () {
            $('.select2').select2();
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

        $('#ver_historial_de_estados').on('shown.bs.modal', function () {
            var table = $('#<%= gv_historial.ClientID %>').DataTable();
            table.draw();
        })

    </script>
</asp:Content>
