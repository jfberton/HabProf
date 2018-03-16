<%@ Page Title="" Language="C#" MasterPageFile="~/Aplicativo/Site1.Master" AutoEventWireup="true" CodeBehind="admin_mesas.aspx.cs" Inherits="WebApplication1.Aplicativo.admin_mesas" %>


<%@ Register Src="~/Aplicativo/Menues/menu_admin.ascx" TagPrefix="uc1" TagName="menu_admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CPH_Menues" runat="server">
    <uc1:menu_admin runat="server" ID="menu_admin" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CPH_Body" runat="server">
    <ol class="breadcrumb">
        <li><a href="admin_home.aspx">Inicio</a></li>
        <li><a href="admin_mesas.aspx">Administrar Mesas</a></li>
    </ol>
    <h1>Mesas 
        <small>Listado de Mesas existentes</small></h1>

    <div class="row">
        <div class="col-md-10">
            <div class="alert alert-warning" role="alert" runat="server" id="lbl_sin_mesas">
                <strong>No existen Mesas!</strong> Pruebe agregar algunas para comenzar.
               
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        </div>
        <div class="col-md-2">
            <button type="button" class="btn btn-default pull-right" id="btn_agregar_mesa" runat="server" onserverclick="btn_agregar_mesa_ServerClick">
                <span class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span>Agregar nueva
            </button>
        </div>
    </div>

    <asp:GridView ID="gv_mesas" runat="server" OnPreRender="gv_mesas_PreRender"
        AutoGenerateColumns="False" GridLines="None" CssClass="display">
        <Columns>
            <asp:BoundField DataField="mesa_fecha" HeaderText="Fecha" ReadOnly="true" />
            <asp:BoundField DataField="mesa_estado" HeaderText="Estado" ReadOnly="true" />
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Button Text="Ver" ID="btn_ver" OnClick="btn_ver_ServerClick" runat="server" CssClass="btn btn-sm btn-default" CommandArgument='<%#Eval("mesa_id")%>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Button Text="Imprimir" ID="btn_imprimir" OnClick="btn_imprimir_Click" CssClass="btn btn-sm btn-default" CommandArgument='<%#Eval("mesa_id")%>' runat="server" />
                    <asp:Button Text="Certif. Direct." ID="btn_imprimir_directores" OnClick="btn_imprimir_directores_Click" CssClass="btn btn-sm btn-default" CommandArgument='<%#Eval("mesa_id")%>' runat="server" />
                    <asp:Button Text="Certif. Jurados" ID="btn_imprimir_certificado_jurados" OnClick="btn_imprimir_certificado_jurados_Click" CssClass="btn btn-sm btn-default" CommandArgument='<%#Eval("mesa_id")%>' runat="server" />
                    <asp:Button Text="Deriv. Biblio" ID="btn_imprimir_derivacion_biblioteca" OnClick="btn_imprimir_derivacion_biblioteca_Click" CssClass="btn btn-sm btn-default" CommandArgument='<%#Eval("mesa_id")%>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Button Text="Cerrar" ID="btn_cerrar_mesa" Enabled='<%#Eval("enabled_cerrar")%>' OnClick="btn_cerrar_mesa_ServerClick" runat="server" CssClass="btn btn-sm btn-primary" CommandArgument='<%#Eval("mesa_id")%>' />
                    <asp:Button Text="Editar" ID="btn_editar" Enabled='<%#Eval("enabled_editar")%>' OnClick="btn_editar_ServerClick" runat="server" CssClass="btn btn-sm btn-warning" CommandArgument='<%#Eval("mesa_id")%>' />
                    <button
                        type="button" class="btn btn-sm btn-danger"
                        data-toggle="modal"
                        data-target="#advertencia_eliminacion"
                        data-id='<%#Eval("mesa_id")%>'
                        data-introduccion="la mesa"
                        data-nombre='<%#Eval("mesa_fecha")%>'>
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
                    <asp:Button Text="Aceptar" CssClass="btn btn-primary" CausesValidation="false" ID="btn_aceptar_eliminacion" OnClick="btn_aceptar_eliminacion_Click" runat="server" />
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="panel_ver_mesa" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content panel-default">
                <div class="modal-header panel-heading">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title panel-title">Datos completos de la mesa</h4>
                </div>
                <div class="modal-body">
                    <h3>Fecha: 
                        <asp:Label Text="" ID="lbl_ver_mesa_fecha" runat="server" /></h3>
                    <div class="row">
                        <div class="col-md-12">
                            <h4>Estado:
                                <asp:Label Text="" ID="lbl_estado" runat="server" /></h4>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <h4>Jurados:</h4>
                            <asp:GridView runat="server" ID="gv_jurados" AutoGenerateColumns="False" GridLines="None" CssClass="display black" OnPreRender="gv_mesas_PreRender">
                                <Columns>
                                    <asp:BoundField DataField="juez_persona_nomyap" HeaderText="Nombre" ReadOnly="true" />
                                    <asp:BoundField DataField="juez_persona_dni" HeaderText="DNI" ReadOnly="true" />
                                    <asp:BoundField DataField="juez_persona_email" HeaderText="E-mail" ReadOnly="true" />
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <h4>Tesinas evaluadas:</h4>
                            <asp:GridView runat="server" ID="gv_tesinas" AutoGenerateColumns="False" GridLines="None" CssClass="display black" OnPreRender="gv_mesas_PreRender">
                                <Columns>
                                    <%--<asp:BoundField DataField="tesina_tema" HeaderText="Título" ReadOnly="true" />--%>
                                    <asp:BoundField DataField="tesina_tesista" HeaderText="Tesista" ReadOnly="true" />
                                    <asp:BoundField DataField="tesina_director" HeaderText="Director" ReadOnly="true" />
                                    <asp:BoundField DataField="tesina_codirector" HeaderText="Co-Director" ReadOnly="true" />
                                    <asp:BoundField DataField="tesina_nota" HeaderText="Calificación" ReadOnly="true" />
                                    <asp:BoundField DataField="tesina_nota_director" HeaderText="Calificación Director" ReadOnly="true" />
                                    <asp:BoundField DataField="tesina_nota_codirector" HeaderText="Calificación Co-Director" ReadOnly="true" />
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Aceptar</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="panel_cerrar_mesa" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content panel-default">
                <div class="modal-header panel-heading">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title panel-title">Cerrar mesa <small>Guarda las calificaciones de las exposiciones</small></h4>
                </div>
                <div class="modal-body">
                    <asp:HiddenField runat="server" ID="hidden_cerrar_mesa_id" />
                    Mesa del dia
                    <asp:Label Text="" ID="lbl_cerrar_mesa_fecha" runat="server" />
                    <strong>Jurado evaluador:</strong>
                    <asp:Label Text="" ID="lbl_cerrar_mesa_jurado" runat="server" />
                    <div class="row">
                        <div class="col-md-12">
                            <asp:ValidationSummary ID="ValidationSummary3" runat="server" DisplayMode="BulletList" ValidationGroup="cerrar"
                                CssClass="validationsummary panel panel-danger" HeaderText="<div class='panel-heading'>&nbsp;Corrija los siguientes errores antes de continuar:</div>" />
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <h4>Tesinas:</h4>
                            <asp:GridView runat="server" ID="gv_cerrar_mesa_tesinas" AutoGenerateColumns="False" GridLines="None" CssClass="display black" OnPreRender="gv_mesas_PreRender">
                                <Columns>
                                    <asp:BoundField DataField="tesina_tema" HeaderText="Título" ReadOnly="true" />
                                    <asp:BoundField DataField="tesina_director" HeaderText="Director" ReadOnly="true" />
                                    <asp:BoundField DataField="tesina_tesista" HeaderText="Tesista" ReadOnly="true" />
                                    <asp:TemplateField HeaderText="Calificación">
                                        <ItemTemplate>
                                            <table>
                                                <tr>
                                                    <td>
                                                        <asp:TextBox runat="server" Columns="3" ID="tb_calificacion_tesina" AccessKey='<%#Eval("tesina_id")%>' />
                                                    </td>
                                                    <td>
                                                        <asp:RequiredFieldValidator ControlToValidate="tb_calificacion_tesina" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                            ID="rfv_calificacion_tesina" runat="server" ErrorMessage="Debe ingresar la calificación final de la tesina" ValidationGroup="cerrar">
                                                        </asp:RequiredFieldValidator>
                                                        <asp:RegularExpressionValidator ValidationExpression="^([0-9]|10)$" ControlToValidate="tb_calificacion_tesina" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                            ID="rev_calificacion_tesina" runat="server" ErrorMessage="Debe ingresar un número entero del 0 al 10" ValidationGroup="cerrar" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Calificación Director">
                                        <ItemTemplate>
                                            <table>
                                                <tr>
                                                    <td>
                                                        <asp:TextBox runat="server" Columns="3" ID="tb_calificacion_director_tesina" AccessKey='<%#Eval("tesina_id")%>' />
                                                    </td>
                                                    <td>
                                                        <asp:RequiredFieldValidator ControlToValidate="tb_calificacion_director_tesina" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                            ID="rfv_calificacion_director_tesina" runat="server" ErrorMessage="Debe ingresar la calificación final de la tesina" ValidationGroup="cerrar">
                                                        </asp:RequiredFieldValidator>
                                                        <asp:RegularExpressionValidator ValidationExpression="^([0-9]|10)$" ControlToValidate="tb_calificacion_director_tesina" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                            ID="rev_calificacion_director_tesina" runat="server" ErrorMessage="Debe ingresar un número entero del 0 al 10" ValidationGroup="cerrar" />
                                                    </td>
                                                </tr>
                                            </table>

                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Calificación Co-Director">
                                        <ItemTemplate>
                                            <table>
                                                <tr>
                                                    <td>
                                                        <asp:TextBox runat="server" Columns="3" ID="tb_calificacion_codirector_tesina" AccessKey='<%#Eval("tesina_id")%>' />
                                                    </td>
                                                    <td>
                                                        <asp:CustomValidator ControlToValidate="tb_calificacion_codirector_tesina" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                            ID="cv_calificacion_codirector" runat="server" ErrorMessage="Debe ingresar una calificacion entre 1 y 10" OnServerValidate="cv_calificacion_codirector_ServerValidate" ValidationGroup="cerrar" />
                                                    </td>
                                                </tr>
                                            </table>

                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button Text="Cerrar Mesa" ID="btn_guardar_cerrar_mesa" OnClick="btn_guardar_cerrar_mesa_Click" CssClass="btn btn-primary" runat="server" />
                    <button type="button" class="btn btn-default" data-dismiss="modal">Salir</button>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="CPH_Scripts" runat="server">
    <script>
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
            modal.find('.modal-body #texto_a_mostrar').text('Esta por eliminar ' + introduccion + ' de fecha ' + nombre + '. Desea continuar?')
        })

        $(document).ready(function () {
            $('#<%= gv_mesas.ClientID %>').DataTable({
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

            $('#<%= gv_tesinas.ClientID %>').DataTable({
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

            $('#<%= gv_cerrar_mesa_tesinas.ClientID %>').DataTable({
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

        $('#panel_ver_mesa').on('shown.bs.modal', function () {
            var table_jurado = $('#<%= gv_jurados.ClientID %>').DataTable();
            table_jurado.draw();

            var table_tesinas = $('#<%= gv_tesinas.ClientID %>').DataTable();
            table_tesinas.draw();
        });

        $('#panel_cerrar_mesa').on('shown.bs.modal', function () {
            var table_tesinas = $('#<%= gv_cerrar_mesa_tesinas.ClientID %>').DataTable();
            table_tesinas.draw();
        });
    </script>
    <script>
        $(document).ready(function () {
            $('[data-toggle="tooltip"]').tooltip();
        });
    </script>

</asp:Content>
