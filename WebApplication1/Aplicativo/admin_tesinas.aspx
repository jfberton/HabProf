<%@ Page Title="" Language="C#" MasterPageFile="~/Aplicativo/Site1.Master" AutoEventWireup="true" CodeBehind="admin_tesinas.aspx.cs" Inherits="WebApplication1.Aplicativo.admin_tesinas" %>

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
                <span class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span>Nueva Tesina
            </button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <asp:GridView ID="gv_tesinas" runat="server" OnPreRender="gv_tesinas_PreRender"
                AutoGenerateColumns="False" GridLines="None" CssClass="display">
                <Columns>
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
                            <h4 class="modal-title panel-title text-center">
                                <asp:Label Text="" ID="lbl_tema" runat="server" /></h4>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-md-12">
                                    <h4>Descripción 
                                    <small>
                                        <asp:Label Text="" ID="lbl_descripcion" runat="server" /></small></h4>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-12">
                                    <table>
                                        <tr>
                                            <td>Tesista</td>
                                            <td>
                                                <asp:Label Text="" ID="lbl_tesista" runat="server" /></td>
                                        </tr>
                                        <tr>
                                            <td>Director</td>
                                            <td>
                                                <asp:Label Text="" ID="lbl_director" runat="server" /></td>
                                        </tr>
                                        <tr>
                                            <td>Estado</td>
                                            <td>
                                                <asp:Label Text="" ID="lbl_estado" runat="server" /></td>
                                        </tr>
                                        <tr>
                                            <td>Fecha de alta</td>
                                            <td>
                                                <asp:Label Text="" ID="lbl_alta" runat="server" /></td>
                                        </tr>
                                        <tr>
                                            <td>Duración</td>
                                            <td>
                                                <asp:Label Text="" ID="lbl_duracion" runat="server" /></td>
                                        </tr>
                                        <tr>
                                            <td>Periodo entre notificaciones</td>
                                            <td>
                                                <asp:Label Text="" ID="lbl_periodo_notificaciones" runat="server" /></td>
                                        </tr>
                                        <tr>
                                            <td>Calificación final</td>
                                            <td>
                                                <asp:Label Text="" ID="lbl_calificacion" runat="server" /></td>
                                        </tr>
                                        <tr>
                                            <td>Calificación del director</td>
                                            <td>
                                                <asp:Label Text="" ID="lbl_calificacion_director" runat="server" /></td>
                                        </tr>
                                    </table>
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
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                        </div>
                    </div>
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
            modal.find('.modal-body #texto_a_mostrar').text('Esta por eliminar ' + introduccion + ' ' + nombre + '. Desea continuar?')
        })

        $(document).ready(function () {
            $('#<%= gv_tesinas.ClientID %>').DataTable({
                //"scrollY": "400px",
                //"scrollCollapse": true,
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

    </script>

</asp:Content>
