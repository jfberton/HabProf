<%@ Page Title="" Language="C#" Async="true" MasterPageFile="~/Aplicativo/Site1.Master" AutoEventWireup="true" CodeBehind="admin_tesistas.aspx.cs" Inherits="WebApplication1.Aplicativo.admin_tesistas" %>

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
        <li>Administrar Tesistas</li>
    </ol>

    <h1>Tesistas <small>Listado de Alumnos de la Licenciatura</small></h1>
    <div class="row">
        <div class="col-md-8">
            <div class="alert alert-warning" role="alert" runat="server" id="lbl_sin_tesistas">
                <strong>No existen tesistas!</strong> Pruebe agregar algunos para comenzar.
               
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        </div>
        <div class="col-md-4 text-right">

            <div class="btn-group" role="group" aria-label="...">
                <button type="button" class="btn btn-default" id="btn_agregar_tesista" runat="server" onserverclick="btn_agregar_tesista_ServerClick">
                    <span class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span>&nbsp; Agregar nuevo
                </button>

                <button type="button" class="btn btn-danger" id="btn_eliminar_tesistas" runat="server" onserverclick="btn_eliminar_tesistas_ServerClick">
                    <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>&nbsp; Realizar limpieza
                </button>
            </div>

            <div class="modal fade" id="agregar_tesista" role="dialog" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">
                                <asp:Label Text="text" ID="lbl_agregar_actualizar_tesista" runat="server" />
                                Tesista</h4>
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
                                                <input type="text" id="tb_dni_tesista" class="form-control" runat="server" placeholder="DNI del tesista" /></td>
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
                                            <td>Nombre y Apellido</td>
                                            <td style="width: auto">
                                                <input type="text" id="tb_nombre_tesista" class="form-control" runat="server" placeholder="Nombre y Apellido del tesista" /></td>
                                            <td>
                                                <asp:RequiredFieldValidator ControlToValidate="tb_nombre_tesista" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                    ID="rv_nombre_tesista" runat="server" ErrorMessage="Debe ingresar el nombre del tesista" ValidationGroup="tesista">
                                                </asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ControlToValidate="tb_nombre_tesista" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                    ID="regular_nombre_director" runat="server" ValidationExpression="^([^0-9]*)$" ErrorMessage="El nombre no debe contener números" ValidationGroup="tesista" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>E-mail</td>
                                            <td style="width: auto">
                                                <input type="text" id="tb_email" class="form-control" runat="server" placeholder="E-mail del tesista" /></td>
                                            <td>
                                                <asp:RequiredFieldValidator ControlToValidate="tb_email" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                    ID="RequiredFieldValidator2" runat="server" ErrorMessage="Debe ingresar el e-mail del tesista" ValidationGroup="tesista">
                                                </asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="tb_email" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                    ID="regex_email" runat="server" ErrorMessage="Debe ingresar un e-mail valido" ValidationGroup="tesista" />
                                                <asp:CustomValidator ControlToValidate="tb_email" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                    ID="cv_correo_duplicado" runat="server" ErrorMessage="Ya existe una persona con ese correo" OnServerValidate="cv_correo_duplicado_ServerValidate" ValidationGroup="tesista" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Domicilio</td>
                                            <td style="width: auto">
                                                <input type="text" id="tb_domicilio" class="form-control" runat="server" placeholder="Domicilio del tesista" /></td>
                                            <td>
                                                <asp:RequiredFieldValidator ControlToValidate="tb_domicilio" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                    ID="RequiredFieldValidator3" runat="server" ErrorMessage="Debe ingresar el domicilio del tesista" ValidationGroup="tesista">
                                                </asp:RequiredFieldValidator></td>
                                        </tr>
                                        <tr>
                                            <td>Teléfono</td>
                                            <td style="width: auto">
                                                <input type="text" id="tb_telefono" class="form-control" runat="server" placeholder="Teléfono del tesista" /></td>
                                            <td>
                                                <asp:RequiredFieldValidator ControlToValidate="tb_telefono" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                    ID="RequiredFieldValidator4" runat="server" ErrorMessage="Debe ingresar el teléfono del tesista" ValidationGroup="tesista">
                                                </asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ValidationExpression="\d{6,11}" ControlToValidate="tb_telefono" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                    ID="RegularExpressionValidator1" runat="server" ErrorMessage="Debe ingresar un teléfono válido (solo números entre 6 y 11 dígitos)" ValidationGroup="tesista" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Legajo</td>
                                            <td style="width: auto">
                                                <input type="text" id="tb_legajo" class="form-control" runat="server" placeholder="Legajo del tesista" /></td>
                                            <td>
                                                <asp:RequiredFieldValidator ControlToValidate="tb_legajo" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                    ID="RequiredFieldValidator5" runat="server" ErrorMessage="Debe ingresar el legajo del tesista" ValidationGroup="tesista">
                                                </asp:RequiredFieldValidator></td>
                                        </tr>
                                        <tr>
                                            <td>Sede</td>
                                            <td style="width: auto">
                                                <input type="text" id="tb_sede" class="form-control" runat="server" placeholder="Sede del tesista" /></td>
                                            <td>
                                                <asp:RequiredFieldValidator ControlToValidate="tb_sede" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                    ID="RequiredFieldValidator6" runat="server" ErrorMessage="Debe ingresar la sede del tesista" ValidationGroup="tesista">
                                                </asp:RequiredFieldValidator></td>
                                        </tr>
                                        <tr>
                                            <td>Usuario</td>
                                            <td style="width: auto">
                                                <input type="text" id="tb_usuario" class="form-control" runat="server" placeholder="Usuario del tesista por agregar" /></td>
                                            <td>
                                                <asp:CustomValidator ControlToValidate="tb_usuario" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                    ID="cv_usuario_duplicado" runat="server" ErrorMessage="Ya existe una persona con ese usuario" OnServerValidate="cv_usuario_duplicado_ServerValidate" ValidationGroup="tesista" />
                                                <asp:RequiredFieldValidator ControlToValidate="tb_usuario" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                    ID="RequiredFieldValidator7" runat="server" ErrorMessage="Debe ingresar el usuario del tesista" ValidationGroup="tesista">
                                                </asp:RequiredFieldValidator></td>
                                        </tr>
                                        <tr runat="server" id="tr_pass_alta">
                                            <td>Contraseña</td>
                                            <td style="width: auto">La contraseña asignada es el DNI del tesista ingresado </td>
                                            <td></td>
                                        </tr>
                                        <tr runat="server" id="tr_pass_edit">
                                            <td>
                                                <asp:CheckBox Text="Cambiar contraseña" ID="chk_cambiar_clave" CausesValidation="false" AutoPostBack="true" OnCheckedChanged="chk_cambiar_clave_CheckedChanged" runat="server" Checked="false" /></td>
                                            <td colspan="2">
                                                <table style="width: 100%">
                                                    <tr runat="server" id="tr_chk_change_pass">
                                                        <td style="width: auto">
                                                            <input type="password" id="tb_contraseña" class="form-control" runat="server" placeholder="Contraseña del tesista" />
                                                        </td>
                                                        <td>
                                                            <asp:RequiredFieldValidator ControlToValidate="tb_contraseña" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                                ID="RequiredFieldValidator9" runat="server" ErrorMessage="Debe asignar uan contraseña o destilde la opción de cambiar contraseña" ValidationGroup="tesista">
                                                            </asp:RequiredFieldValidator>
                                                            <%-- <asp:RegularExpressionValidator ValidationExpression="^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{4,8}$" ControlToValidate="tb_contraseña" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                                ID="RegularExpressionValidator3" runat="server" ErrorMessage="La contraseña debe tener entre 4 y 8 caracteres, al menos una mayúscula, una minúscula y un número" ValidationGroup="tesista" />--%>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button id="btn_guardar" runat="server" onserverclick="btn_guardar_ServerClick" class="btn btn-primary" validationgroup="tesista">
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
            <asp:BoundField DataField="estado" HeaderText="Estado" ReadOnly="true" />
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

                    <button runat="server" class="btn btn-sm btn-success" id="btn_habilitar_tesista" visible='<%#Eval("mostrar_habilitar")%>' causesvalidation="false" onserverclick="btn_habilitar_tesista_ServerClick" data-id='<%#Eval("tesista_id")%>'>
                        <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>&nbsp;Habilitar
                    </button>

                    <button
                        type="button" class="btn btn-sm btn-danger"
                        data-toggle="modal"
                        runat="server"
                        data-target="#advertencia_eliminacion"
                        visible='<%#Eval("mostrar_inhabilitar")%>'
                        data-id='<%#Eval("tesista_id")%>'
                        data-introduccion="el tesista"
                        data-nombre='<%#Eval("persona_nomyap")%>'>
                        <span class="glyphicon glyphicon-remove-circle" aria-hidden="true"></span>&nbsp;Inhabilitar
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

    <div class="modal fade" id="panel_ver_tesista" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-lg">
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
                    <div class="row">
                        <div class="col-md-12">
                            <h3>Tesina presentada</h3>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <asp:Label Text="Aún no posee tesina presentada" ID="lbl_sin_tesina" runat="server" />
                            <asp:GridView runat="server" ID="gv_tesina" AutoGenerateColumns="False" GridLines="None" CssClass="display" OnPreRender="gv_tesina_PreRender">
                                <Columns>
                                    <asp:BoundField DataField="tesina_tema" HeaderText="Título" ReadOnly="true" />
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
            modal.find('.modal-body #texto_a_mostrar').text('Esta por pasar a inactivo ' + introduccion + ' ' + nombre + '. Desea continuar?')
        })
        $(document).ready(function () {
            $('#<%= gv_tesistas.ClientID %>').DataTable({
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

            $('#<%= gv_tesina.ClientID %>').DataTable({
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

        $('#panel_ver_tesista').on('shown.bs.modal', function () {
            var table_tesinas = $('#<%= gv_tesina.ClientID %>').DataTable();
            table_tesinas.draw();
        });
    </script>
    <script>
        $(document).ready(function () {
            $('[data-toggle="tooltip"]').tooltip();
        });
    </script>

</asp:Content>

