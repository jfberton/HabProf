<%@ Page Title="" Async="true" Language="C#" MasterPageFile="~/Aplicativo/Site1.Master" AutoEventWireup="true" CodeBehind="admin_mesa.aspx.cs" Inherits="WebApplication1.Aplicativo.admin_mesa" %>

<%@ Register Src="~/Aplicativo/Menues/menu_admin.ascx" TagPrefix="uc1" TagName="menu_admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CPH_Menues" runat="server">
    <uc1:menu_admin runat="server" ID="menu_admin" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CPH_Body" runat="server">
    <ol class="breadcrumb">
        <li><a href="admin_home.aspx">Inicio</a></li>
        <li><a href="admin_mesa.aspx">Administrar Mesa</a></li>
    </ol>

    <h1>
        <asp:Label Text="" ID="lbl_titulo" runat="server" />
        <small>
            <asp:Label Text="Datos de la mesa" runat="server" ID="lbl_small_titulo" /></small></h1>
    <%--ValidationSummary--%>
    <div class="row">
        <div class="col-md-12">
            <asp:ValidationSummary ID="validation_summary" runat="server" DisplayMode="BulletList" ValidationGroup="mesa"
                CssClass="validationsummary panel panel-danger" HeaderText="<div class='panel-heading'>&nbsp;Corrija los siguientes errores antes de continuar:</div>" />
        </div>
    </div>

    <br />
    <%--FECHA MESA--%>
    <div class="row">
        <div class="col-md-4"><h3>Fecha mesa</h3></div>
        <div class="col-md-7">
            <div class='input-group date' id='datetimepicker1'>
                <input type='text' runat="server" id="tb_fecha_mesa" class="form-control" />
                <span class="input-group-addon">
                    <span class="glyphicon glyphicon-calendar"></span>
                </span>
            </div>
        </div>
        <div class="col-md-1">
            <asp:RequiredFieldValidator ControlToValidate="tb_fecha_mesa" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                ID="RequiredFieldValidator2" runat="server" ErrorMessage="Debe ingresar la fecha de la mesa" ValidationGroup="mesa">
            </asp:RequiredFieldValidator>
            <asp:CustomValidator ControlToValidate="tb_fecha_mesa" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                ID="cv_fecha_mesa" runat="server" ErrorMessage="Debe ingresar una fecha válida" OnServerValidate="cv_fecha_mesa_ServerValidate" ValidationGroup="mesa" />
        </div>
    </div>

    <br />
    <%--JURADO--%>
    <div class="row">
        <div class="col-md-6">
            <h3>Jurado</h3>
        </div>
        <div class="col-md-5 text-right">
            <asp:Button Text="Seleccionar jurado/s" runat="server" ID="btn_buscar_jurados" CssClass="btn btn-default" OnClick="btn_buscar_jurados_Click" />
        </div>
        <div class="col-md-1">
            <asp:CustomValidator Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                ID="cv_jurados" runat="server" ErrorMessage="Debe ingresar los jurados evaluadores, uno como mínimo 3 como máximo" OnServerValidate="cv_jurados_ServerValidate" ValidationGroup="mesa" />
        </div>
    </div>

    <div class="modal fade" id="modal_buscar_jurado" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content panel-success">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">Seleccionar los jurados de la mesa</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-12">
                            <asp:HiddenField runat="server" ID="hidden_ids_jueces" />
                            <strong>Jurados de la mesa:</strong>
                            <asp:Label Text="Seleccione los jurados que participaron de la grilla desplegada aquí debajo" ID="lbl_jueces" runat="server" />
                        </div>
                    </div>
                    <br />
                    <div class="row">
                        <div class="col-md-12">
                            <asp:GridView ID="gv_seleccionar_jurado" runat="server" OnPreRender="gv_jueces_PreRender"
                                AutoGenerateColumns="False" GridLines="None" CssClass="display black">
                                <Columns>
                                    <asp:BoundField DataField="juez_persona_nomyap" HeaderText="Nombre" ReadOnly="true" />
                                    <asp:BoundField DataField="juez_persona_dni" HeaderText="DNI" ReadOnly="true" />
                                    <asp:BoundField DataField="juez_persona_email" HeaderText="E-mail" ReadOnly="true" />
                                    <asp:TemplateField HeaderText="Seleccionar jurado">
                                        <ItemTemplate>
                                            <asp:CheckBox Text="" AccessKey='<%#Eval("juez_id")%>' Checked='<%#Eval("seleccionado")%>' ID="chk_seleccion_juez" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button Text="Aceptar" CssClass="btn btn-primary" ID="btn_aceptar_seleccion_jurado" OnClick="btn_aceptar_seleccion_jurado_Click" runat="server" />
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <asp:GridView runat="server" ID="gv_jurados" AutoGenerateColumns="False" GridLines="None" CssClass="display" OnPreRender="gv_jueces_PreRender">
                <Columns>
                    <asp:BoundField DataField="juez_persona_nomyap" HeaderText="Nombre" ReadOnly="true" />
                    <asp:BoundField DataField="juez_persona_dni" HeaderText="DNI" ReadOnly="true" />
                    <asp:BoundField DataField="juez_persona_email" HeaderText="E-mail" ReadOnly="true" />
                </Columns>
            </asp:GridView>
        </div>
    </div>

    <br />
    <%--TESINAS--%>
    <div class="row">
        <div class="col-md-6">
            <h3>Tesinas</h3>
        </div>
        <div class="col-md-5 text-right">
            <asp:Button Text="Agregar Tesina" runat="server" ID="btn_buscar_tesina" CssClass="btn btn-default" OnClick="btn_buscar_tesina_Click" />
        </div>
        <div class="col-md-1">
            <asp:CustomValidator Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                ID="cv_tesinas" runat="server" ErrorMessage="Debe ingresar las tesinas a evaluar" OnServerValidate="cv_tesinas_ServerValidate" ValidationGroup="mesa" />
        </div>
    </div>

    <div class="modal fade" id="modal_buscar_tesina" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content panel-success">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">Seleccionar Tesina</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-12">
                            <asp:HiddenField runat="server" ID="hidden_tesinas_seleccionadas" />
                            <strong>Tesinas a evaluar:</strong>
                            <asp:Label Text="Seleccione las Tesinas por evaluar de la grilla desplegada aquí debajo" ID="lbl_tesinas_seleccionadas" runat="server" />
                        </div>
                    </div>
                    <br />
                    <div class="row">
                        <div class="col-md-12">
                            <asp:GridView ID="gv_seleccionar_tesinas" runat="server" OnPreRender="gv_jueces_PreRender"
                                AutoGenerateColumns="False" GridLines="None" CssClass="display black">
                                <Columns>
                                    <asp:BoundField DataField="tesina_tema" HeaderText="Título" ReadOnly="true" />
                                    <asp:BoundField DataField="tesina_director" HeaderText="Director" ReadOnly="true" />
                                    <asp:BoundField DataField="tesina_tesista" HeaderText="Tesista" ReadOnly="true" />
                                    <asp:TemplateField HeaderText="Seleccionar tesina">
                                        <ItemTemplate>
                                            <asp:CheckBox Text="" AccessKey='<%#Eval("tesina_id")%>' Checked='<%#Eval("seleccionada")%>' ID="chk_seleccionar_tesina" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button Text="Aceptar" CssClass="btn btn-primary" ID="btn_aceptar_seleccion_tesina" OnClick="btn_aceptar_seleccion_tesina_Click" runat="server" />
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <asp:GridView runat="server" ID="gv_tesinas_seleccionadas" AutoGenerateColumns="False" GridLines="None" CssClass="display" OnPreRender="gv_jueces_PreRender">
                <Columns>
                    <asp:BoundField DataField="tesina_tema" HeaderText="Título" ReadOnly="true" />
                    <asp:BoundField DataField="tesina_director" HeaderText="Director" ReadOnly="true" />
                    <asp:BoundField DataField="tesina_tesista" HeaderText="Tesista" ReadOnly="true" />
                </Columns>
            </asp:GridView>
        </div>
        <div class="col-md-1">
        </div>
    </div>

    <br />
    <div class="row">
        <div class="col-md-12 text-right">
            <asp:Button Text="Guardar mesa" ID="btn_crear_mesa" CssClass="btn btn-primary" OnClick="btn_crear_mesa_Click" ValidationGroup="mesa" runat="server" />
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="CPH_Scripts" runat="server">
    <script>
        $(document).ready(function () {
            $('#<%= gv_seleccionar_jurado.ClientID %>').DataTable({
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

            $('#<%= gv_jurados.ClientID %>').DataTable({
                "scrollY": "400px",
                "scrollCollapse": true,
                "paging": false,
                "searching": false,
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

            $('#<%= gv_seleccionar_tesinas.ClientID %>').DataTable({
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

            $('#<%= gv_tesinas_seleccionadas.ClientID %>').DataTable({
                "scrollY": "400px",
                "scrollCollapse": true,
                "paging": false,
                "searching": false,
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

        var d = new Date();
        d.setDate(d.getDate() + 7)
        
        $(function () {
            $('#datetimepicker1').datetimepicker({
                locale: 'es',
                format: 'L',
                minDate: d
            });
        });

        $('#modal_buscar_jurado').on('shown.bs.modal', function () {
            var table = $('#<%= gv_seleccionar_jurado.ClientID %>').DataTable();
            table.draw();
        });

            $('#modal_buscar_tesina').on('shown.bs.modal', function () {
                var table = $('#<%= gv_seleccionar_tesinas.ClientID %>').DataTable();
                table.draw();
            });

    </script>
</asp:Content>
