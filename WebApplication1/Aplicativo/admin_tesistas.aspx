<%@ Page Title="" Language="C#" MasterPageFile="~/Aplicativo/Site1.Master" AutoEventWireup="true" CodeBehind="admin_tesistas.aspx.cs" Inherits="WebApplication1.Aplicativo.admin_tesistas" %>

<%@ Register Src="~/Aplicativo/Menues/menu_admin.ascx" TagPrefix="uc1" TagName="menu_admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CPH_Menues" runat="server">
    <uc1:menu_admin runat="server" ID="menu_admin" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CPH_Body" runat="server">
    <ol class="breadcrumb">
        <li><a href="admin_home.aspx">Inicio</a></li>
        <li>Personas</li>
        <li>Administrar tesistas</li>
    </ol>

    <h1>Tesistas <small>Listado de alumnos de la licenciatura</small></h1>
    <div class="row">
        <div class="col-md-10">
            <div class="alert alert-warning" role="alert" runat="server" id="lbl_sin_tesistas">
                <strong>No existen tesistas!</strong> Pruebe agregar algunos para comenzar.
               
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        </div>
        <div class="col-md-2">
            <button type="button" class="btn btn-default pull-right" id="btn_agregar_tesista" runat="server" onserverclick="btn_agregar_tesista_ServerClick">
                <span class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span>Agregar nuevo
           
            </button>
            <div class="modal fade" id="agregar_tesista" role="dialog" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">
                                <asp:Label Text="text" ID="lbl_agregar_actualizar_tesista" runat="server" />
                                tesista</h4>
                        </div>
                        <div class="modal-body">
                            <input type="hidden" runat="server" id="hidden_id_tesista_editar" />
                            <div class="row">
                                <div class="col-md-12">
                                    <asp:ValidationSummary ID="validation_summary" runat="server" DisplayMode="BulletList" ValidationGroup="tesista"
                                        CssClass="validationsummary panel panel-danger" HeaderText="<div class='panel-heading'>&nbsp;Corrija los siguientes errores antes de continuar:</div>" />
                                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" DisplayMode="BulletList" ValidationGroup="dni_persona"
                                        CssClass="validationsummary panel panel-danger" HeaderText="<div class='panel-heading'>&nbsp;Corrija los siguientes errores antes de continuar:</div>" />
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <table class="table-condensed" style="width: 100%">
                                        <tr>
                                            <td>DNI</td>
                                            <td style="width: auto">
                                                <input type="text" id="tb_dni_tesista" class="form-control" runat="server" placeholder="DNI del tesista por agregar" /></td>
                                            <td>
                                                <asp:RequiredFieldValidator ControlToValidate="tb_dni_tesista" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                    ID="RequiredFieldValidator1" runat="server" ErrorMessage="Debe ingresar el DNI del tesista" ValidationGroup="dni_persona">
                                                </asp:RequiredFieldValidator>

                                                <asp:RegularExpressionValidator ValidationExpression="\d{7,8}" ControlToValidate="tb_dni_tesista" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                    ID="RegularExpressionValidator2" runat="server" ErrorMessage="Debe ingresar un DNI válido (solo números entre 7 y 8 caracteres)" ValidationGroup="dni_persona" />

                                                <button runat="server" class="btn btn-default" id="btn_chequear_dni" onserverclick="btn_chequear_dni_ServerClick" validationgroup="dni_persona"><span class="glyphicon glyphicon-search"></span></button>

                                            </td>
                                        </tr>

                                    </table>

                                    <table class="table-condensed" runat="server" id="tb_tabla_resto_campos" visible="false" style="width: 100%">
                                        <tr>
                                            <td>Nombre y apellido</td>
                                            <td style="width: auto">
                                                <input type="text" id="tb_nombre_tesista" class="form-control" runat="server" placeholder="Nombre y apellido del tesista por agregar" /></td>
                                            <td>
                                                <asp:RequiredFieldValidator ControlToValidate="tb_nombre_tesista" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                    ID="rv_nombre_tesista" runat="server" ErrorMessage="Debe ingresar el nombre del tesista" ValidationGroup="tesista">
                                                </asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator  ControlToValidate="tb_nombre_tesista" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                    ID="regular_nombre_director" runat="server" ValidationExpression="^([^0-9]*)$" ErrorMessage="El nombre no debe contener números" ValidationGroup="tesista" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>E-mail</td>
                                            <td style="width: auto">
                                                <input type="text" id="tb_email" class="form-control" runat="server" placeholder="E-mail del tesista por agregar" /></td>
                                            <td>
                                                <asp:RequiredFieldValidator ControlToValidate="tb_email" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                    ID="RequiredFieldValidator2" runat="server" ErrorMessage="Debe ingresar el e-mail del tesista" ValidationGroup="tesista">
                                                </asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="tb_email" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                    ID="regex_email" runat="server" ErrorMessage="Debe ingresar un e-mail valido" ValidationGroup="tesista" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Domicilio</td>
                                            <td style="width: auto">
                                                <input type="text" id="tb_domicilio" class="form-control" runat="server" placeholder="Nombre del tesista por agregar" /></td>
                                            <td>
                                                <asp:RequiredFieldValidator ControlToValidate="tb_domicilio" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                    ID="RequiredFieldValidator3" runat="server" ErrorMessage="Debe ingresar el domicilio del tesista" ValidationGroup="tesista">
                                                </asp:RequiredFieldValidator></td>
                                        </tr>
                                        <tr>
                                            <td>Teléfono</td>
                                            <td style="width: auto">
                                                <input type="text" id="tb_telefono" class="form-control" runat="server" placeholder="Teléfono del tesista por agregar" /></td>
                                            <td>
                                                <asp:RequiredFieldValidator ControlToValidate="tb_telefono" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                    ID="RequiredFieldValidator4" runat="server" ErrorMessage="Debe ingresar el teléfono del tesista" ValidationGroup="tesista">
                                                </asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ValidationExpression="\d{6,11}" ControlToValidate="tb_telefono" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                    ID="RegularExpressionValidator1" runat="server" ErrorMessage="Debe ingresar un teléfono válido (solo números entre 6 y 11 caracteres)" ValidationGroup="tesista" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Legajo</td>
                                            <td style="width: auto">
                                                <input type="text" id="tb_legajo" class="form-control" runat="server" placeholder="Nombre del tesista por agregar" /></td>
                                            <td>
                                                <asp:RequiredFieldValidator ControlToValidate="tb_legajo" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                    ID="RequiredFieldValidator5" runat="server" ErrorMessage="Debe ingresar el legajo del tesista" ValidationGroup="tesista">
                                                </asp:RequiredFieldValidator></td>
                                        </tr>
                                        <tr>
                                            <td>Sede</td>
                                            <td style="width: auto">
                                                <input type="text" id="tb_sede" class="form-control" runat="server" placeholder="Nombre del tesista por agregar" /></td>
                                            <td>
                                                <asp:RequiredFieldValidator ControlToValidate="tb_sede" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                    ID="RequiredFieldValidator6" runat="server" ErrorMessage="Debe ingresar la sede del tesista" ValidationGroup="tesista">
                                                </asp:RequiredFieldValidator></td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button id="btn_guardar" runat="server" onserverclick="btn_guardar_ServerClick" class="btn btn-success" validationgroup="tesista">
                                <span class="glyphicon glyphicon-floppy-disk" aria-hidden="true"></span>Guardar!
                           
                            </button>
                            <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <asp:GridView ID="gv_tesistas" runat="server" OnPreRender="gv_tesistas_PreRender"
        AutoGenerateColumns="False" GridLines="None" CssClass="display">
        <Columns>
            <asp:BoundField DataField="persona_nomyap" HeaderText="Nombre" ReadOnly="true" />
            <asp:BoundField DataField="persona_dni" HeaderText="DNI" ReadOnly="true" />
            <asp:BoundField DataField="persona_email" HeaderText="E-mail" ReadOnly="true" />
            <asp:BoundField DataField="tesista_legajo" HeaderText="Legajo" ReadOnly="true" />
            <asp:BoundField DataField="tesista_sede" HeaderText="Sede" ReadOnly="true" />

            <asp:TemplateField>
                <ItemTemplate>
                    <button runat="server" class="btn btn-sm btn-default" id="btn_ver" causesvalidation="false" onserverclick="btn_ver_ServerClick1" data-id='<%#Eval("tesista_id")%>'>
                        <span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span>&nbsp;Ver
                   
                    </button>
                    <button runat="server" class="btn btn-sm btn-warning" id="btn_editar" causesvalidation="false" onserverclick="btn_editar_ServerClick" data-id='<%#Eval("tesista_id")%>'>
                        <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>&nbsp;Editar
                   
                    </button>
                    <button
                        type="button" class="btn btn-sm btn-danger"
                        data-toggle="modal"
                        data-target="#advertencia_eliminacion"
                        data-id='<%#Eval("tesista_id")%>'
                        data-introduccion="el tesista"
                        data-nombre='<%#Eval("persona_nomyap")%>'>
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

    <div class="modal fade" id="panel_ver_tesista" role="dialog" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content panel-default">
                <div class="modal-header panel-heading">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title panel-title">Datos completos del tesista</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-12">
                            <h3>
                                <asp:Label Text="" ID="lbl_ver_tesista_nomyap" runat="server" /></h3>
                            <table class="table-condensed" style="width: 100%">
                                <tr>
                                    <td>DNI</td>
                                    <td style="width: auto">
                                        <asp:Label Text="" ID="lbl_ver_tesista_dni" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Legajo</td>
                                    <td style="width: auto">
                                        <asp:Label Text="" ID="lbl_ver_tesista_legajo" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>E-mail</td>
                                    <td style="width: auto">
                                        <asp:Label Text="" ID="lbl_ver_tesista_email" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Sede</td>
                                    <td style="width: auto">
                                        <asp:Label Text="" ID="lbl_ver_tesista_sede" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Domicilio</td>
                                    <td style="width: auto">
                                        <asp:Label Text="" ID="lbl_ver_tesista_domicilio" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Teléfono</td>
                                    <td style="width: auto">
                                        <asp:Label Text="" ID="lbl_ver_tesista_telefono" runat="server" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
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

        });
    </script>
    <script>
        $(document).ready(function () {
            $('[data-toggle="tooltip"]').tooltip();
        });
    </script>

</asp:Content>

