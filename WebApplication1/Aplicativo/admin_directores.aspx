﻿<%@ Page Title="" Language="C#" Async="true" MasterPageFile="~/Aplicativo/Site1.Master" AutoEventWireup="true" CodeBehind="admin_directores.aspx.cs" Inherits="WebApplication1.Aplicativo.admin_directores" %>

<%@ Register Src="~/Aplicativo/Menues/menu_admin.ascx" TagPrefix="uc1" TagName="menu_admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CPH_Menues" runat="server">
    <uc1:menu_admin runat="server" ID="menu_admin" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CPH_Body" runat="server">
    <ol class="breadcrumb">
        <li><a href="admin_home.aspx">Inicio</a></li>
        <li>Administrar directores</li>
    </ol>

    <h1>Directores <small>Listado de Directores de la Licenciatura</small></h1>
    <div class="row">
        <div class="col-md-10">
            <div class="alert alert-warning" role="alert" runat="server" id="lbl_sin_directores">
                <strong>No existen Directores!</strong> Pruebe agregar algunos para comenzar.
               
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        </div>
        <div class="col-md-2">
            <button type="button" class="btn btn-default pull-right" id="btn_agregar_director" runat="server" onserverclick="btn_agregar_director_ServerClick">
                <span class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span>Agregar nuevo
            </button>
            <div class="modal fade" id="agregar_director" role="dialog" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">
                                <asp:Label Text="text" ID="lbl_agregar_actualizar_director" runat="server" />
                                Director</h4>
                        </div>
                        <div class="modal-body">
                            <input type="hidden" runat="server" id="hidden_id_director_editar" />
                            <div class="row">
                                <div class="col-md-12">
                                    <asp:ValidationSummary ID="validation_summary" runat="server" DisplayMode="BulletList" ValidationGroup="director"
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
                                                <input type="text" id="tb_dni_director" class="form-control" runat="server" placeholder="DNI del director" /></td>
                                            <td>
                                                <asp:RequiredFieldValidator ControlToValidate="tb_dni_director" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                    ID="RequiredFieldValidator1" runat="server" ErrorMessage="Debe ingresar el DNI del director" ValidationGroup="dni_persona">
                                                </asp:RequiredFieldValidator>

                                                <asp:RegularExpressionValidator ValidationExpression="\d{7,8}" ControlToValidate="tb_dni_director" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                    ID="RegularExpressionValidator2" runat="server" ErrorMessage="Debe ingresar un DNI válido (solo números entre 7 y 8 caracteres)" ValidationGroup="dni_persona" />

                                                <button runat="server" class="btn btn-default" id="btn_chequear_dni" onserverclick="btn_chequear_dni_ServerClick" validationgroup="dni_persona"><span class="glyphicon glyphicon-search"></span></button>

                                            </td>
                                        </tr>

                                    </table>
                                    <table class="table-condensed" runat="server" id="tb_tabla_resto_campos" visible="false" style="width: 100%">
                                        <tr>
                                            <td>Nombre y Apellido</td>
                                            <td style="width: auto">
                                                <input type="text" id="tb_nombre_director" class="form-control" runat="server" placeholder="Nombre y Apellido del director" /></td>
                                            <td>
                                                <asp:RequiredFieldValidator ControlToValidate="tb_nombre_director" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                    ID="rv_nombre_director" runat="server" ErrorMessage="Debe ingresar el nombre del director" ValidationGroup="director">
                                                </asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ControlToValidate="tb_nombre_director" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                    ID="regular_nombre_director" runat="server" ValidationExpression="^([^0-9]*)$" ErrorMessage="El nombre no debe contener números" ValidationGroup="director" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>E-mail</td>
                                            <td style="width: auto">
                                                <input type="text" id="tb_email" class="form-control" runat="server" placeholder="E-mail del director por agregar" /></td>
                                            <td>
                                                <asp:RequiredFieldValidator ControlToValidate="tb_email" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                    ID="RequiredFieldValidator2" runat="server" ErrorMessage="Debe ingresar el e-mail del director" ValidationGroup="director">
                                                </asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="tb_email" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                    ID="regex_email" runat="server" ErrorMessage="Debe ingresar un e-mail valido" ValidationGroup="director" />
                                                <asp:CustomValidator ControlToValidate="tb_email" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                    ID="cv_correo_duplicado" runat="server" ErrorMessage="Ya existe una persona con ese correo" OnServerValidate="cv_correo_duplicado_ServerValidate" ValidationGroup="director" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Domicilio</td>
                                            <td style="width: auto">
                                                <input type="text" id="tb_domicilio" class="form-control" runat="server" placeholder="Domicilio del director" /></td>
                                            <td>
                                                <asp:RequiredFieldValidator ControlToValidate="tb_domicilio" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                    ID="RequiredFieldValidator3" runat="server" ErrorMessage="Debe ingresar el domicilio del director" ValidationGroup="director">
                                                </asp:RequiredFieldValidator></td>
                                        </tr>
                                        <tr>
                                            <td>Teléfono</td>
                                            <td style="width: auto">
                                                <input type="text" id="tb_telefono" class="form-control" runat="server" placeholder="Teléfono del director" /></td>
                                            <td>
                                                <asp:RequiredFieldValidator ControlToValidate="tb_telefono" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                    ID="RequiredFieldValidator4" runat="server" ErrorMessage="Debe ingresar el teléfono del director" ValidationGroup="director">
                                                </asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ValidationExpression="\d{6,11}" ControlToValidate="tb_telefono" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                    ID="RegularExpressionValidator1" runat="server" ErrorMessage="Debe ingresar un teléfono válido (solo números entre 6 y 11 dígitos)" ValidationGroup="director" />

                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Usuario</td>
                                            <td style="width: auto">
                                                <input type="text" id="tb_usuario" class="form-control" runat="server" placeholder="Usuario del director" /></td>
                                            <td>
                                                <asp:CustomValidator ControlToValidate="tb_usuario" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                    ID="cv_usuario_duplicado" runat="server" ErrorMessage="Ya existe una persona con ese usuario" OnServerValidate="cv_usuario_duplicado_ServerValidate" ValidationGroup="director" />
                                                <asp:RequiredFieldValidator ControlToValidate="tb_usuario" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                    ID="RequiredFieldValidator5" runat="server" ErrorMessage="Debe ingresar el usuario del director" ValidationGroup="director">
                                                </asp:RequiredFieldValidator></td>
                                        </tr>
                                        <tr runat="server" id="tr_pass_alta">
                                            <td>Contraseña</td>
                                            <td style="width: auto">La contraseña es igual al DNI
                                                </td>
                                            <td>
                                               
                                            </td>
                                        </tr>
                                        <tr runat="server" id="tr_pass_edit">
                                            <td>
                                                <asp:CheckBox Text="Cambiar contraseña" ID="chk_cambiar_clave" CausesValidation="false" AutoPostBack="true" OnCheckedChanged="chk_cambiar_clave_CheckedChanged" runat="server" Checked="false" /></td>
                                            <td colspan="2">
                                                <table style="width: 100%">
                                                    <tr runat="server" id="tr_chk_change_pass">
                                                        <td style="width: auto">
                                                            <input type="password" id="tb_contraseña" class="form-control" runat="server" placeholder="Contraseña del director" />
                                                        </td>
                                                        <td>
                                                            <asp:RequiredFieldValidator ControlToValidate="tb_contraseña" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                                ID="RequiredFieldValidator7" runat="server" ErrorMessage="Debe asignar uan contraseña o destilde la opción de cambiar contraseña" ValidationGroup="director">
                                                            </asp:RequiredFieldValidator>
                                                           <%-- <asp:RegularExpressionValidator ValidationExpression="^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{4,8}$" ControlToValidate="tb_contraseña" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                                ID="RegularExpressionValidator3" runat="server" ErrorMessage="La contraseña debe tener entre 4 y 8 caracteres, al menos una mayúscula, una minúscula y un número" ValidationGroup="director" />--%>
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
                            <button id="btn_guardar" runat="server" onserverclick="btn_guardar_ServerClick" visible="false" class="btn btn-primary" validationgroup="director">
                                <span class="glyphicon glyphicon-floppy-disk" aria-hidden="true"></span>Guardar!
                           
                            </button>
                            <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <asp:GridView ID="gv_directores" runat="server" OnPreRender="gv_directores_PreRender"
        AutoGenerateColumns="False" GridLines="None" CssClass="display">
        <Columns>
            <asp:BoundField DataField="persona_nomyap" HeaderText="Nombre" ReadOnly="true" />
            <asp:BoundField DataField="persona_dni" HeaderText="DNI" ReadOnly="true" />
            <asp:BoundField DataField="persona_email" HeaderText="E-mail" ReadOnly="true" />
            <asp:BoundField DataField="director_calificacion" HeaderText="Calificación" ReadOnly="true" />
            <asp:BoundField DataField="director_tesina_a_cargo" HeaderText="Tesis a cargo" ReadOnly="true" />
            <asp:TemplateField>
                <ItemTemplate>
                    <button runat="server" class="btn btn-sm btn-default" id="btn_ver" causesvalidation="false" onserverclick="btn_ver_ServerClick1" data-id='<%#Eval("director_id")%>'>
                        <span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span>&nbsp;Ver
                   
                    </button>
                    <button runat="server" class="btn btn-sm btn-warning" id="btn_editar" causesvalidation="false" onserverclick="btn_editar_ServerClick" data-id='<%#Eval("director_id")%>'>
                        <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>&nbsp;Editar
                   
                    </button>
                    <button
                        type="button" class="btn btn-sm btn-danger"
                        data-toggle="modal"
                        data-target="#advertencia_eliminacion"
                        data-id='<%#Eval("director_id")%>'
                        data-introduccion="el director"
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
                    <asp:Button Text="Aceptar" CssClass="btn btn-primary" CausesValidation="false" ID="btn_aceptar_eliminacion" OnClick="btn_aceptar_eliminacion_Click" runat="server" />
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="panel_ver_director" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content panel-default">
                <div class="modal-header panel-heading">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title panel-title">Datos completos del director</h4>
                </div>
                <div class="modal-body">
                    <h3>
                        <asp:Label Text="" ID="lbl_ver_director_nomyap" runat="server" /></h3>
                    <div class="row">
                        <div class="col-md-12">
                            <table class="table-condensed" style="width: 100%">
                                <tr>
                                    <td>DNI</td>
                                    <td style="width: auto">
                                        <asp:Label Text="" ID="lbl_ver_director_dni" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>E-mail</td>
                                    <td style="width: auto">
                                        <asp:Label Text="" ID="lbl_ver_director_email" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Domicilio</td>
                                    <td style="width: auto">
                                        <asp:Label Text="" ID="lbl_ver_director_domicilio" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Teléfono</td>
                                    <td style="width: auto">
                                        <asp:Label Text="" ID="lbl_ver_director_telefono" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Calificaión</td>
                                    <td style="width: auto">
                                        <asp:Label Text="" ID="lbl_ver_director_calificacion" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Usuario</td>
                                    <td style="width: auto">
                                        <asp:Label Text="" ID="lbl_ver_director_usuario" runat="server" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <h3>
                        <asp:Label Text="" ID="lbl_tesinas_director" runat="server" /></h3>
                    <div class="row">
                        <div class="col-md-12">
                            <asp:GridView ID="gv_tesinas" runat="server" OnPreRender="gv_directores_PreRender"
                                AutoGenerateColumns="False" GridLines="None" CssClass="display black">
                                <Columns>
                                    <asp:BoundField DataField="tesinata_nombre" HeaderText="Tesista" ReadOnly="true" />
                                    <asp:TemplateField HeaderText="Título">
                                        <ItemTemplate>
                                            <asp:Label Text='<%#Eval("tesina_tema_recortado")%>' ToolTip='<%#Eval("tesina_tema_completo") %>' runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="tesina_plan_fch_presentacion" HeaderText="Fecha Presentación" DataFormatString="{0:d}" ReadOnly="true" />
                                    <asp:BoundField DataField="tesina_estado" HeaderText="Estado" ReadOnly="true" />
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
            modal.find('.modal-body #texto_a_mostrar').text('Esta por eliminar ' + introduccion + ' ' + nombre + '. Desea continuar?')
        })

        function disableF5(e) { if ((e.which || e.keyCode) == 116) e.preventDefault(); };
        // To disable f5
        /* jQuery < 1.7 */
        $(document).bind("keydown", disableF5);
        /* OR jQuery >= 1.7 */
        $(document).on("keydown", disableF5);

        // To re-enable f5
        /* jQuery < 1.7 */
        $(document).unbind("keydown", disableF5);
        /* OR jQuery >= 1.7 */
        $(document).off("keydown", disableF5);

        $(document).ready(function () {
            $('#<%= gv_directores.ClientID %>').DataTable({
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

        $(document).ready(function () {
            $('#<%= gv_tesinas.ClientID %>').DataTable({
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

        $('#panel_ver_director').on('shown.bs.modal', function () {
            var table = $('#<%= gv_tesinas.ClientID %>').DataTable();
            table.draw();
        })
    </script>
    <script>
        $(document).ready(function () {
            $('[data-toggle="tooltip"]').tooltip();
        });
    </script>

</asp:Content>
