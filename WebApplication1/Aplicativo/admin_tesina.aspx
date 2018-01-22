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
        <li><a href="admin_tesina.aspx">Administrar tesinas</a></li>
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
    <div class="row" runat="server" id="div_tema">
        <div class="col-md-2">Tema</div>
        <div class="col-md-9">
            <input type="text" runat="server" id="tb_tema" class="form-control" />
        </div>
        <div class="col-md-1">
            <asp:RequiredFieldValidator ControlToValidate="tb_tema" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                ID="RequiredFieldValidator6" runat="server" ErrorMessage="Debe ingresar la fecha de inicio de la tesina" ValidationGroup="tesina">
            </asp:RequiredFieldValidator>
        </div>
    </div>

    <%--DESCRIPCION--%>
    <div class="row" runat="server" id="div_descripcion">
        <div class="col-md-2">Descripción</div>
        <div class="col-md-9">
            <textarea runat="server" id="tb_descripcion" rows="5" class="form-control" placeholder="Ingrese la descripción del contenido de la tesina.-"></textarea>
        </div>
        <div class="col-md-1">
            <asp:RequiredFieldValidator ControlToValidate="tb_descripcion" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                ID="RequiredFieldValidator3" runat="server" ErrorMessage="Debe ingresar la descripción de la tesina" ValidationGroup="tesina">
            </asp:RequiredFieldValidator>
        </div>
    </div>

    <br />
    <%--TESISTA Y DIRECTOR--%>
    <div class="row">
        <div class="col-md-2">
            Tesista
        </div>
        <div class="col-md-3">
            <asp:HiddenField runat="server" ID="hidden_tesista_id" />
            <div class="input-group">
                <input type="text" class="form-control" runat="server" id="tb_tesista" />
                <span class="input-group-btn">
                    <button class="btn btn-default" type="button" runat="server" id="btn_buscar_tesista" onserverclick="btn_buscar_tesista_ServerClick"><span class="glyphicon glyphicon-search"></span></button>
                </span>
            </div>
        </div>
        <div class="col-md-1">validators</div>
        <div class="col-md-2">
            Director
        </div>
        <div class="col-md-3">
            <asp:HiddenField runat="server" ID="hidden_director_id" />
            <div class="input-group">
                <input type="text" class="form-control" runat="server" id="tb_director" />
                <span class="input-group-btn">
                    <button class="btn btn-default" type="button" runat="server" id="btn_buscar_director" onserverclick="btn_buscar_director_ServerClick"><span class="glyphicon glyphicon-search"></span></button>
                </span>
            </div>
        </div>
        <div class="col-md-1">validators</div>

        <div class="modal fade" id="buscar_tesista" tabindex="-1" role="dialog">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">Seleccionar tesista</h4>
                    </div>
                    <div class="modal-body">
                        <asp:Label Text="No existen tesistas en condiciones de presentar una tesis." Visible="false" ID="lbl_sin_tesistas_habilitados" runat="server" />
                        <asp:GridView ID="gv_tesistas" runat="server" OnPreRender="gv_PreRender"
                            AutoGenerateColumns="False" GridLines="None" CssClass="display">
                            <Columns>
                                <asp:BoundField DataField="persona_dni" HeaderText="DNI" ReadOnly="true" />
                                <asp:BoundField DataField="persona_nomyap" HeaderText="Nombre" ReadOnly="true" />
                                <asp:BoundField DataField="persona_email" HeaderText="E-mail" ReadOnly="true" />
                                <asp:BoundField DataField="tesista_legajo" HeaderText="Legajo" ReadOnly="true" />
                                <asp:BoundField DataField="tesista_sede" HeaderText="Sede" ReadOnly="true" />
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <button runat="server" class="btn btn-sm btn-default" id="btn_seleccionar_tesista" causesvalidation="false" onserverclick="btn_seleccionar_tesista_Click" data-id='<%#Eval("tesista_id")%>'>
                                            Seleccionar
                                       
                                        </button>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary">Save changes</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="buscar_director" tabindex="-1" role="dialog">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">Seleccionar directors</h4>
                    </div>
                    <div class="modal-body">
                        <asp:Label Text="No existen directores disponibles para realizar asesoramiento al tesista." Visible="false" ID="lbl_sin_directores" runat="server" />
                        <asp:GridView ID="gv_directores" runat="server" OnPreRender="gv_PreRender"
                            AutoGenerateColumns="False" GridLines="None" CssClass="display">
                            <Columns>
                                <asp:BoundField DataField="persona_nomyap" HeaderText="Nombre" ReadOnly="true" />
                                <asp:BoundField DataField="persona_dni" HeaderText="DNI" ReadOnly="true" />
                                <asp:BoundField DataField="persona_email" HeaderText="E-mail" ReadOnly="true" />
                                <asp:BoundField DataField="director_calificacion" HeaderText="Calificación" ReadOnly="true" />
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <button runat="server" class="btn btn-sm btn-default" id="btn_seleccionar_director" causesvalidation="false" onserverclick="btn_seleccionar_director_ServerClick" data-id='<%#Eval("director_id")%>'>
                                            Seleccionar
                                        </button>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary">Save changes</button>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <br />
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
                ID="RequiredFieldValidator2" runat="server" ErrorMessage="Debe ingresar la fecha de inicio de la tesina" ValidationGroup="tesina">
            </asp:RequiredFieldValidator>
            <asp:CustomValidator ControlToValidate="tb_fecha_inicio" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                ID="cv_fecha_inicio" runat="server" ErrorMessage="Debe ingresar una fecha válida" OnServerValidate="cv_fecha_inicio_ServerValidate" ValidationGroup="tesina" />
        </div>
    </div>

    <br />
    <%--DURACION MESES PERIODO ENTRE NOTIFICACIONES--%>
    <div class="row" runat="server" id="div_duracion_y_notificaciones">
        <div class="col-md-3">Plazo hasta la entrega final</div>
        <div class="col-md-2">
            <div class="input-group">
                <input type="text" class="form-control" runat="server" id="tb_duracion" />
                <span class="input-group-addon">meses</span>
            </div>
        </div>
        <div class="col-md-1">
            <asp:RequiredFieldValidator ControlToValidate="tb_duracion" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                ID="RequiredFieldValidator4" runat="server" ErrorMessage="Debe ingresar la fecha de inicio de la tesina" ValidationGroup="tesina">
            </asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ValidationExpression="\d{1,2}" ControlToValidate="tb_duracion" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                ID="RegularExpressionValidator2" runat="server" ErrorMessage="Debe ingresar un numero entero de hasta dos dígitos" ValidationGroup="tesina" />
        </div>
        <div class="col-md-3">
            Período entre notificaciones automáticas
        </div>
        <div class="col-md-2">
            <div class="input-group">
                <input type="text" class="form-control" runat="server" id="tb_notificacion" />
                <span class="input-group-addon">meses</span>
            </div>
        </div>
        <div class="col-md-1">
            <asp:RequiredFieldValidator ControlToValidate="tb_notificacion" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                ID="RequiredFieldValidator5" runat="server" ErrorMessage="Debe ingresar la fecha de inicio de la tesina" ValidationGroup="tesina">
            </asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ValidationExpression="\d{1}" ControlToValidate="tb_notificacion" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                ID="RegularExpressionValidator1" runat="server" ErrorMessage="Debe ingresar un numero entero de un dígito" ValidationGroup="tesina" />
            <asp:CustomValidator ControlToValidate="tb_notificacion" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                ID="CustomValidator2" runat="server" ErrorMessage="Debe ingresar una fecha válida" OnServerValidate="cv_fecha_inicio_ServerValidate" ValidationGroup="tesina" />
        </div>
    </div>

    <br />
    <%--ESTADO--%>
    <div class="row" runat="server" id="div_estado">
        <div class="col-md-12">
            <table style="width: 100%">
                <tr>
                    <td>Estado</td>
                    <td>
                        <table style="width: 100%">
                            <tr>
                                <td>
                                    <asp:TextBox runat="server" ID="tb_estado" CssClass="form-control" Enabled="false" Text="estado de la tesina" />
                                </td>
                                <td>
                                    <button class="btn btn-default" title="Ver historial de estados" onserverclick="btn_tesina_ver_historial_ServerClick" runat="server" id="btn_tesina_ver_historial"><span class="glyphicon glyphicon-calendar"></span></button>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>

            <div class="modal fade" id="estado_iniciar" role="dialog" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">Marcar fecha de inicio</h4>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-md-12">
                                    <asp:ValidationSummary ID="ValidationSummary3" runat="server" DisplayMode="BulletList" ValidationGroup="estado_inicio"
                                        CssClass="validationsummary panel panel-danger" HeaderText="<div class='panel-heading'>&nbsp;Corrija los siguientes errores antes de continuar:</div>" />
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-2">
                                    Fecha inicial
                                </div>
                                <div class="col-md-9">
                                </div>
                                <div class="col-md-1">
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <%--<button id="Button1" runat="server" validationgroup="estado_tesina" onserverclick="btn_modificar_estado_ServerClick" class="btn btn-success">
                                <span class="glyphicon glyphicon-floppy-disk" aria-hidden="true"></span>Modificar estado!
                            </button>--%>
                            <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                        </div>
                        |
                    </div>
                </div>
            </div>

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
                                    <asp:ValidationSummary ID="ValidationSummary2" runat="server" DisplayMode="BulletList" ValidationGroup="estado_tesina"
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
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button id="btn_modificar_estado" runat="server" validationgroup="estado_tesina" onserverclick="btn_modificar_estado_ServerClick" class="btn btn-success">
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
                            <asp:GridView ID="gv_historial" runat="server" OnPreRender="gv_PreRender"
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

            $('#<%= gv_tesistas.ClientID %>').DataTable({
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

            $('#<%= gv_directores.ClientID %>').DataTable({
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

        $('#ver_historial_de_estados').on('shown.bs.modal', function () {
            var table = $('#<%= gv_historial.ClientID %>').DataTable();
            table.draw();
        })

        var d = new Date();
        d.getDate();
        $(function () {
            $('#datetimepicker1').datetimepicker({
                maxDate: d,
                locale: 'es',
                format: 'L'
            });
        });

        $('#buscar_tesista').on('shown.bs.modal', function () {
            var table = $('#<%= gv_tesistas.ClientID %>').DataTable();
            table.draw();
        })

        $('#buscar_director').on('shown.bs.modal', function () {
            var table = $('#<%= gv_directores.ClientID %>').DataTable();
            table.draw();
        })
    </script>
</asp:Content>
