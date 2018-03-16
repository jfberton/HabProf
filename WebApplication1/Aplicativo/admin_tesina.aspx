<%@ Page Title="" Language="C#" Async="true" MasterPageFile="~/Aplicativo/Site1.Master" AutoEventWireup="true" CodeBehind="admin_tesina.aspx.cs" Inherits="WebApplication1.Aplicativo.admin_tesina" %>

<%@ Register Src="~/Aplicativo/Menues/menu_admin.ascx" TagPrefix="uc1" TagName="menu_admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .black {
            color: black;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CPH_Menues" runat="server">
    <uc1:menu_admin runat="server" ID="menu_admin" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CPH_Body" runat="server">
    <ol class="breadcrumb">
        <li><a href="admin_home.aspx">Inicio</a></li>
        <li><a href="admin_tesinas.aspx">Administrar Tesinas</a></li>
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
        <div class="col-md-2">Título</div>
        <div class="col-md-9">
            <input type="text" runat="server" id="tb_tema" class="form-control" />
        </div>
        <div class="col-md-1">
            <asp:RequiredFieldValidator ControlToValidate="tb_tema" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                ID="RequiredFieldValidator6" runat="server" ErrorMessage="Debe ingresar tema de la tesina" ValidationGroup="tesina">
            </asp:RequiredFieldValidator>
        </div>
    </div>

    <%--DESCRIPCION--%>
    <div class="row" runat="server" id="div_descripcion">
        <div class="col-md-2">Descripción</div>
        <div class="col-md-9">
            <textarea runat="server" id="tb_descripcion" rows="2" class="form-control" placeholder="Ingrese la descripción del contenido de la tesina.-"></textarea>
        </div>
        <div class="col-md-1">
            <asp:RequiredFieldValidator ControlToValidate="tb_descripcion" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                ID="RequiredFieldValidator3" runat="server" ErrorMessage="Debe ingresar la descripción de la tesina" ValidationGroup="tesina">
            </asp:RequiredFieldValidator>
        </div>
    </div>
    <br />
    <%--FECHA INICIO--%>
    <div class="row">
        <div class="col-md-2">Fecha inicio</div>
        <div class="col-md-3">
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

        <div class="col-md-2">
            Categoría
        </div>
        <div class="col-md-3">
            <asp:DropDownList runat="server" ID="ddl_categoria" CssClass="form-control">
                <asp:ListItem Text="Categoria 1" />
                <asp:ListItem Text="Categoria 2" />
                <asp:ListItem Text="Categoria 3" />
                <asp:ListItem Text="Categoria 4" />
                <asp:ListItem Text="Categoria 5" />
            </asp:DropDownList>
        </div>
        <div class="col-md-1">
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
                <input type="text" class="form-control" readonly="true" runat="server" id="tb_tesista" />
                <span class="input-group-btn">
                    <button class="btn btn-default" type="button" runat="server" id="btn_buscar_tesista" onserverclick="btn_buscar_tesista_ServerClick"><span class="glyphicon glyphicon-search"></span></button>
                </span>
            </div>
        </div>
        <div class="col-md-1">
            <asp:RequiredFieldValidator ControlToValidate="tb_tesista" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                ID="RequiredFieldValidator1" runat="server" ErrorMessage="Debe seleccionar el tesista responsable de la tesina" ValidationGroup="tesina">
            </asp:RequiredFieldValidator>
        </div>
        <div class="col-md-2">
            Director
        </div>
        <div class="col-md-3">
            <asp:HiddenField runat="server" ID="hidden_director_id" />
            <div class="input-group">
                <input type="text" class="form-control" readonly="true" runat="server" id="tb_director" />
                <span class="input-group-btn">
                    <button class="btn btn-default" type="button" runat="server" id="btn_buscar_director" onserverclick="btn_buscar_director_ServerClick"><span class="glyphicon glyphicon-search"></span></button>
                </span>
            </div>
        </div>
        <div class="col-md-1">
            <asp:RequiredFieldValidator ControlToValidate="tb_director" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                ID="RequiredFieldValidator7" runat="server" ErrorMessage="Debe seleccionar el director asociado a la tesina" ValidationGroup="tesina">
            </asp:RequiredFieldValidator>
        </div>

        <div class="modal fade" id="buscar_tesista" tabindex="-1" role="dialog">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">Seleccionar tesista</h4>
                    </div>
                    <div class="modal-body">

                        <div class="row">
                            <div class="col-md-8">
                                <asp:Label Text="No existen tesistas en condiciones de presentar una tesis." Visible="false" ID="lbl_sin_tesistas_habilitados" runat="server" />
                            </div>
                            <div class="col-md-4 text-right">
                                <div class="btn-group" role="group" aria-label="...">
                                    <button type="button" class="btn btn-default" id="btn_agregar_tesista" runat="server" onserverclick="btn_agregar_tesista_ServerClick">
                                        <span class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span>&nbsp; Agregar nuevo
                                    </button>
                                </div>
                            </div>


                        </div>

                        <asp:GridView ID="gv_tesistas" runat="server" OnPreRender="gv_PreRender"
                            AutoGenerateColumns="False" GridLines="None" CssClass="display black">
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
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="agregar_tesista" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header panel-heading">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title panel-title">
                            <asp:Label Text="text" ID="lbl_agregar_actualizar_tesista" runat="server" />
                            Tesista</h4>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" runat="server" id="hidden_id_tesista_editar" />
                        <div class="row">
                            <div class="col-md-12">
                                <asp:ValidationSummary ID="ValidationSummary1" runat="server" DisplayMode="BulletList" ValidationGroup="tesista"
                                    CssClass="validationsummary panel panel-danger" HeaderText="<div class='panel-heading'>&nbsp;Corrija los siguientes errores antes de continuar:</div>" />
                                <asp:ValidationSummary ID="ValidationSummary2" runat="server" DisplayMode="BulletList" ValidationGroup="dni_persona"
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
                                                ID="RequiredFieldValidator8" runat="server" ErrorMessage="Debe ingresar el DNI del tesista" ValidationGroup="dni_persona">
                                            </asp:RequiredFieldValidator>

                                            <asp:RegularExpressionValidator ValidationExpression="\d{7,8}" ControlToValidate="tb_dni_tesista" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                ID="RegularExpressionValidator3" runat="server" ErrorMessage="Debe ingresar un DNI válido (solo números entre 7 y 8 caracteres)" ValidationGroup="dni_persona" />

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
                                                ID="RequiredFieldValidator9" runat="server" ErrorMessage="Debe ingresar el e-mail del tesista" ValidationGroup="tesista">
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
                                                ID="RequiredFieldValidator10" runat="server" ErrorMessage="Debe ingresar el domicilio del tesista" ValidationGroup="tesista">
                                            </asp:RequiredFieldValidator></td>
                                    </tr>
                                    <tr>
                                        <td>Teléfono</td>
                                        <td style="width: auto">
                                            <input type="text" id="tb_telefono" class="form-control" runat="server" placeholder="Teléfono del tesista" /></td>
                                        <td>
                                            <asp:RequiredFieldValidator ControlToValidate="tb_telefono" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                ID="RequiredFieldValidator11" runat="server" ErrorMessage="Debe ingresar el teléfono del tesista" ValidationGroup="tesista">
                                            </asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator ValidationExpression="\d{6,11}" ControlToValidate="tb_telefono" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                ID="RegularExpressionValidator4" runat="server" ErrorMessage="Debe ingresar un teléfono válido (solo números entre 6 y 11 dígitos)" ValidationGroup="tesista" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Legajo</td>
                                        <td style="width: auto">
                                            <input type="text" id="tb_legajo" class="form-control" runat="server" placeholder="Legajo del tesista" /></td>
                                        <td>
                                            <asp:RequiredFieldValidator ControlToValidate="tb_legajo" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                ID="RequiredFieldValidator12" runat="server" ErrorMessage="Debe ingresar el legajo del tesista" ValidationGroup="tesista">
                                            </asp:RequiredFieldValidator></td>
                                    </tr>
                                    <tr>
                                        <td>Sede</td>
                                        <td style="width: auto">
                                            <input type="text" id="tb_sede" class="form-control" runat="server" placeholder="Sede del tesista" /></td>
                                        <td>
                                            <asp:RequiredFieldValidator ControlToValidate="tb_sede" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                ID="RequiredFieldValidator13" runat="server" ErrorMessage="Debe ingresar la sede del tesista" ValidationGroup="tesista">
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
                                                ID="RequiredFieldValidator14" runat="server" ErrorMessage="Debe ingresar el usuario del tesista" ValidationGroup="tesista">
                                            </asp:RequiredFieldValidator></td>
                                    </tr>
                                    <tr>
                                        <td>Plan de tesina</td>
                                        <td style="width: auto">
                                            <asp:FileUpload runat="server" ID="file_tesis" />
                                        </td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3">
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ControlToValidate="file_tesis" ErrorMessage="Únicamente archivos .pdf, .doc, .docx" ValidationExpression="^.*\.(doc|DOC|pdf|PDF|docx|DOCX)$" ValidationGroup="tesista"></asp:RegularExpressionValidator>
                                        </td>
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
                                                            ID="RequiredFieldValidator15" runat="server" ErrorMessage="Debe asignar uan contraseña o destilde la opción de cambiar contraseña" ValidationGroup="tesista">
                                                        </asp:RequiredFieldValidator>
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

        <div class="modal fade" id="buscar_director" tabindex="-1" role="dialog">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">Seleccionar director</h4>
                    </div>
                    <div class="modal-body">
                        <asp:Label Text="No existen directores disponibles para realizar asesoramiento al tesista." Visible="false" ID="lbl_sin_directores" runat="server" />
                        <asp:GridView ID="gv_directores" runat="server" OnPreRender="gv_PreRender"
                            AutoGenerateColumns="False" GridLines="None" CssClass="display black">
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
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <div class="row">
        <div class="col-md-6">
        </div>
        <div class="col-md-2">
            Codirector
        </div>
        <div class="col-md-3">
            <asp:HiddenField runat="server" ID="hidden_codirector_id" />
            <div class="input-group">
                <input type="text" class="form-control" readonly="true" runat="server" id="tb_codirector" />
                <span class="input-group-btn">
                    <button class="btn btn-default" type="button" runat="server" id="btn_buscar_codirector" onserverclick="btn_buscar_codirector_ServerClick"><span class="glyphicon glyphicon-search"></span></button>
                    <button class="btn btn-danger" type="button" runat="server" id="btn_eliminar_codirector" onserverclick="btn_eliminar_codirector_ServerClick"><span class="glyphicon glyphicon-remove"></span></button>
                </span>
            </div>
        </div>
        <div class="col-md-1">
            <asp:CustomValidator ControlToValidate="tb_codirector" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                ID="cv_codirector" runat="server" ErrorMessage="El director y el co-director deben ser personas distintas" OnServerValidate="cv_codirector_ServerValidate" ValidationGroup="tesina" />
        </div>

        <div class="modal fade" id="buscar_codirector" tabindex="-1" role="dialog">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">Seleccionar codirector</h4>
                    </div>
                    <div class="modal-body">
                        <asp:Label Text="No existen codirectores disponibles para realizar asesoramiento al tesista." Visible="false" ID="lbl_sin_codirectores" runat="server" />
                        <asp:GridView ID="gv_codirectores" runat="server" OnPreRender="gv_PreRender"
                            AutoGenerateColumns="False" GridLines="None" CssClass="display black">
                            <Columns>
                                <asp:BoundField DataField="persona_nomyap" HeaderText="Nombre" ReadOnly="true" />
                                <asp:BoundField DataField="persona_dni" HeaderText="DNI" ReadOnly="true" />
                                <asp:BoundField DataField="persona_email" HeaderText="E-mail" ReadOnly="true" />
                                <asp:BoundField DataField="codirector_calificacion" HeaderText="Calificación" ReadOnly="true" />
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <button runat="server" class="btn btn-sm btn-default" id="btn_seleccionar_codirector" causesvalidation="false" onserverclick="btn_seleccionar_codirector_ServerClick" data-id='<%#Eval("codirector_id")%>'>
                                            Seleccionar
                                        </button>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <br />
    <%--DURACION MESES PERIODO ENTRE NOTIFICACIONES--%>
    <div class="row" runat="server" id="div_duracion_y_notificaciones">
        <div class="col-md-3">Plazo hasta la entrega final</div>
        <div class="col-md-2">
            <div class="input-group">
                <input type="text" class="form-control" value="12" disabled="disabled" runat="server" id="tb_duracion" />
                <span class="input-group-addon">meses</span>
            </div>
        </div>
        <div class="col-md-1">
            <asp:RequiredFieldValidator ControlToValidate="tb_duracion" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                ID="RequiredFieldValidator4" runat="server" ErrorMessage="Debe ingresar los meses de duración para la entrega final de la tesina" ValidationGroup="tesina">
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
                ID="RequiredFieldValidator5" runat="server" ErrorMessage="Debe ingresar los meses entre recordatorios automáticos" ValidationGroup="tesina">
            </asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ValidationExpression="\d{1}" ControlToValidate="tb_notificacion" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                ID="RegularExpressionValidator1" runat="server" ErrorMessage="Debe ingresar un numero entero de un dígito" ValidationGroup="tesina" />
            <asp:CustomValidator ControlToValidate="tb_notificacion" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                ID="cv_notificacion" runat="server" ErrorMessage="El valor ingresado debe ser menor o igual a el plazo para la entrega de la tesina" OnServerValidate="cv_notificacion_ServerValidate" ValidationGroup="tesina" />
        </div>
    </div>
    <br />

    <%--VERIFICAR GUARDAR, CANCELAR--%>
    <div class="row">
        <div class="col-md-12 text-right">
            <asp:Button Text="Guardar" OnClick="btn_guardar_tesina_ServerClick" ID="btn_guardar_tesina" CssClass="btn btn-primary" Enabled="true" runat="server" />
            <button type="button" class="btn btn-default" runat="server" id="btn_cancelar" onserverclick="btn_cancelar_ServerClick">Cancelar</button>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="CPH_Scripts" runat="server">
    <script>
        //$(document).ready(function () {
        //    $('.select2').select2();
        //});

        $(document).ready(function () {

            <%-- $('#<%= gv_historial.ClientID %>').DataTable({
                "scrollY": "400px",
                "scrollCollapse": true,
                "paging": false,
                "searching": false,
                "language": {
                    "search": "Buscar:",
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
            });--%>

            $(":file").filestyle({ buttonBefore: false, buttonText: "Seleccionar archivo" });

            $('#<%= gv_tesistas.ClientID %>').DataTable({
                "scrollY": "400px",
                "scrollCollapse": true,
                "paging": false,
                "language": {
                    "search": "Buscar:",
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

            $('#<%= gv_directores.ClientID %>').DataTable({
                "scrollY": "400px",
                "scrollCollapse": true,
                "paging": false,
                "language": {
                    "search": "Buscar:",
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

            $('#<%= gv_codirectores.ClientID %>').DataTable({
                "scrollY": "400px",
                "scrollCollapse": true,
                "paging": false,
                "language": {
                    "search": "Buscar:",
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

       <%-- $('#ver_historial_de_estados').on('shown.bs.modal', function () {
            var table = $('#<%= gv_historial.ClientID %>').DataTable();
            table.draw();
        })--%>

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
        });

            $('#buscar_director').on('shown.bs.modal', function () {
                var table = $('#<%= gv_directores.ClientID %>').DataTable();
                table.draw();
            });

            $('#buscar_codirector').on('shown.bs.modal', function () {
                var table = $('#<%= gv_codirectores.ClientID %>').DataTable();
                table.draw();
            });
    </script>
</asp:Content>
