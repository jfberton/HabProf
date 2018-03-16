<%@ Page Title="" Language="C#" Async="true" MasterPageFile="~/Aplicativo/Site1.Master" AutoEventWireup="true" CodeBehind="recordatorios.aspx.cs" Inherits="WebApplication1.Aplicativo.recordatorios" %>

<%@ Register Src="~/Aplicativo/Menues/menu_admin.ascx" TagPrefix="uc1" TagName="menu_admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CPH_Menues" runat="server">
    <uc1:menu_admin runat="server" ID="menu_admin" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CPH_Body" runat="server">
    <ol class="breadcrumb">
        <li><a href="admin_home.aspx">Inicio</a></li>
        <li>Tesinas</li>
        <li>Recordatorio tesinas</li>
    </ol>

    <h1>Listado de tesinas por notificar <small><br />
       Tesinas con notificaciones pendientes de enviar</small></h1>
    <div class="row">
        <div class="col-md-12">
            <div class="alert alert-warning" role="alert" runat="server" id="lbl_sin_tesinas">
                <p runat="server" id="lbl_no_existe_tesina"></p>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <asp:GridView ID="gv_tesinas" runat="server" OnPreRender="gv_tesinas_PreRender"
                AutoGenerateColumns="False" GridLines="None" CssClass="display">
                <Columns>
                    <asp:BoundField DataField="prioridad_orden" HeaderText="Orden" ReadOnly="true" />
                    <asp:BoundField DataField="tesista" HeaderText="Tesista" ReadOnly="true" />
                    <asp:TemplateField HeaderText="Título">
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server"
                                ToolTip='<%# Eval("tema_completo") %>'
                                Text='<%# Eval("tema_recortado") %>'>
                            </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="fecha_fin" HeaderText="Fecha Fin" ReadOnly="true" DataFormatString="{0:d}"/>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <button runat="server" class="btn btn-sm btn-default" id="btn_ver" causesvalidation="false" onserverclick="btn_ver_ServerClick" data-id='<%#Eval("tesis_id")%>'>
                                <span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span>&nbsp;Ver
                            </button>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

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
                                <div class="col-md-4">
                                    <strong>Tesista:</strong>
                                    <asp:Label Text="" ID="lbl_tesista" runat="server" />
                                </div>
                                <div class="col-md-4">
                                    <strong>Director:</strong>
                                    <asp:Label Text="" ID="lbl_director" runat="server" />
                                </div>
                                <div class="col-md-4">
                                    <strong>Co-Director:</strong>
                                    <asp:Label Text="" ID="lbl_codirector" runat="server" />
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
                                    <strong>Calificación final Tesina:</strong>
                                    <asp:Label Text="" ID="lbl_calificacion" runat="server" />
                                </div>
                                <div class="col-md-4">
                                    <strong>Calificación Director:</strong>
                                    <asp:Label Text="" ID="lbl_calificacion_director" runat="server" />
                                </div>
                                 <div class="col-md-4">
                                    <strong>Calificación Co-Director:</strong>
                                    <asp:Label Text="" ID="lbl_calificacion_codirector" runat="server" />
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <strong>Estado:</strong>
                                    <asp:Label Text="" ID="lbl_estado" runat="server" />
                                </div>
                                <div class="col-md-8">
                                    <strong>Observaciones:</strong>
                                    <asp:Label Text="" ID="lbl_observaciones_estado" runat="server" />
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <strong>Archivo Tesina:</strong> <a href="#" target="_blank" runat="server" id="lbl_archivo_subido">sin presentaciones</a>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <strong>Jurado: </strong>
                                    <asp:Label Text="" ID="lbl_jueces_tesina_visualizacion" runat="server" />
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
                                        AutoGenerateColumns="False" GridLines="None" CssClass="display compact black">
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
                                <div class="col-md-12 text-right">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
           
        </div>
    </div>
    <br />
    <div class="row">
        <div class="col-md-12 text-right">
            <button class="btn btn-lg btn-primary" runat="server" id="btn_enviar_correos" onserverclick="btn_enviar_correos_ServerClick">
                <span class="glyphicon glyphicon-envelope">&nbsp;Enviar notificaciones </span>
            </button>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="CPH_Scripts" runat="server">
    <script>
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
    </script>
</asp:Content>
