<%@ Page Title="" Language="C#" MasterPageFile="~/Aplicativo/Site1.Master" AutoEventWireup="true" CodeBehind="importar_directores.aspx.cs" Inherits="WebApplication1.Aplicativo.importar_directores" %>

<%@ Register Src="~/Aplicativo/Menues/menu_admin.ascx" TagPrefix="uc1" TagName="menu_admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CPH_Menues" runat="server">
    <uc1:menu_admin runat="server" ID="menu_admin" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CPH_Body" runat="server">
    <ol class="breadcrumb">
        <li><a href="admin_home.aspx">Inicio</a></li>
        <li>Importar</li>
        <li>Importar Directores</li>
    </ol>

    <h1>Importar Directores
        <br />
        <small>Permite la importación de Directores a través de la carga de un archivo excel.</small></h1>


    <div class="row">
        <div class="col-md-6">
            <asp:FileUpload runat="server" ID="archivo_directores" />
            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" ControlToValidate="archivo_directores" runat="server" ErrorMessage="Únicamente archivos .xls, .xlsx" ValidationExpression="^.*\.(xls|xlsx|XLS|XLSX)$"></asp:RegularExpressionValidator>
        </div>

        <div class="col-md-4">
            <div class="btn-group" role="group" aria-label="...">
                <asp:Button Text="Procesar !" ID="btn_procesar" OnClick="btn_procesar_Click" CssClass="btn btn-primary" runat="server" />
                <button type="button" class="btn btn-warning" data-toggle="modal" data-target=".bs-example-modal-lg"><span class="glyphicon glyphicon-question-sign"></span></button>
            </div>
        </div>
    </div>

    <div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content panel-warning">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <strong>ATENCIÓN!</strong> el archivo excel tiene que tener 5 campos por fila.
                </div>
                <div class="modal-body">
                    <strong><u>Estructura de la fila</u></strong><br />
                    <div class="row">
                        <div class="col-md-2"><strong><u>Campo</u></strong></div>
                        <div class="col-md-4"><strong><u>Valor</u></strong></div>
                        <div class="col-md-6"><strong><u>Tipo de dato</u></strong></div>
                    </div>
                    <div class="row">
                        <div class="col-md-2">1</div>
                        <div class="col-md-4">DNI</div>
                        <div class="col-md-6">Numérico de 8 posiciones</div>
                    </div>
                    <div class="row">
                        <div class="col-md-2">2</div>
                        <div class="col-md-4">Nombre y Apellido</div>
                        <div class="col-md-6">Cadena</div>
                    </div>
                    <div class="row">
                        <div class="col-md-2">3</div>
                        <div class="col-md-4">E-mail</div>
                        <div class="col-md-6">correo electronico</div>
                    </div>
                    <div class="row">
                        <div class="col-md-2">4</div>
                        <div class="col-md-4">Domicilio</div>
                        <div class="col-md-6">Cadena</div>
                    </div>
                    <div class="row">
                        <div class="col-md-2">5</div>
                        <div class="col-md-4">Teléfono</div>
                        <div class="col-md-6">Numerico entre 6 y 11 dígitos</div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <asp:ValidationSummary ID="ValidationSummary3" runat="server" DisplayMode="BulletList" ValidationGroup="director"
                CssClass="validationsummary panel panel-danger" HeaderText="<div class='panel-heading'>&nbsp;Corrija los siguientes errores antes de continuar:</div>" />
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <asp:GridView ID="gv_directores" runat="server" OnPreRender="gv_tesinas_PreRender"
                AutoGenerateColumns="False" GridLines="None">
                <Columns>
                    <asp:TemplateField HeaderText="DNI">
                        <ItemTemplate>
                            <table style="margin: 0">
                                <tr>
                                    <td style="width: auto">
                                        <input type="text" id="tb_dni_director" runat="server" value='<%#Eval("DNI")%>' placeholder="DNI del director" />
                                    </td>
                                    <td>
                                        <div style="position: relative;">
                                            <div style="position: absolute; z-index: 0; top: 0">
                                                <asp:RequiredFieldValidator ControlToValidate="tb_dni_director" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                    ID="RequiredFieldValidator1" runat="server" ErrorMessage="Debe ingresar el DNI del director" ValidationGroup="director">
                                                </asp:RequiredFieldValidator>
                                            </div>
                                            <div style="position: absolute; z-index: 1; top: 0">
                                                <asp:RegularExpressionValidator ValidationExpression="\d{7,8}" ControlToValidate="tb_dni_director" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                    ID="RegularExpressionValidator2" runat="server" ErrorMessage="Debe ingresar un DNI válido (solo números entre 7 y 8 caracteres)" ValidationGroup="director" />
                                            </div>
                                            <div style="position: absolute; z-index: 2; top: 0">
                                                <asp:CustomValidator ControlToValidate="tb_dni_director" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                    ID="cv_dni_duplicado" runat="server" ErrorMessage="Ya existe un director con ese DNI" OnServerValidate="cv_dni_duplicado_ServerValidate" ValidationGroup="director" />
                                            </div>
                                            <div style="position: absolute; z-index: 3; top: 0">
                                                <asp:CustomValidator ControlToValidate="tb_dni_director" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                    ID="cv_dni_duplicado_grilla" runat="server" ErrorMessage="Ya existe un director con ese DNI en la grilla" OnServerValidate="cv_dni_duplicado_grilla_ServerValidate" ValidationGroup="director" />
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Nombre y Apellido">
                        <ItemTemplate>
                            <table style="margin: 0">
                                <tr>
                                    <td style="width: auto">
                                        <input type="text" id="tb_nombre_director" runat="server" value='<%#Eval("nomyap")%>' placeholder="Nombre y apellido del director" /></td>
                                    <td>
                                        <div style="position: relative;">
                                            <div style="position: absolute; z-index: 0; top: 0">
                                                <asp:RequiredFieldValidator ControlToValidate="tb_nombre_director" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                    ID="rv_nombre_director" runat="server" ErrorMessage="Debe ingresar el nombre del director" ValidationGroup="director">
                                                </asp:RequiredFieldValidator>
                                            </div>
                                            <div style="position: absolute; z-index: 1; top: 0">
                                                <asp:RegularExpressionValidator ControlToValidate="tb_nombre_director" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                    ID="regular_nombre_director" runat="server" ValidationExpression="^([^0-9]*)$" ErrorMessage="El nombre no debe contener números" ValidationGroup="director" />
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Correo">
                        <ItemTemplate>
                            <table style="margin: 0">
                                <tr>
                                    <td style="width: auto">
                                        <input type="text" id="tb_email" runat="server" value='<%#Eval("email")%>' placeholder="E-mail del director" /></td>

                                    <td>
                                        <div style="position: relative;">
                                            <div style="position: absolute; z-index: 0; top: 0">
                                                <asp:RequiredFieldValidator ControlToValidate="tb_email" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                    ID="RequiredFieldValidator2" runat="server" ErrorMessage="Debe ingresar el e-mail del director" ValidationGroup="director">
                                                </asp:RequiredFieldValidator>
                                            </div>
                                            <asp:RegularExpressionValidator ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="tb_email" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                ID="regex_email" runat="server" ErrorMessage="Debe ingresar un e-mail valido" ValidationGroup="director" />
                                            <div style="position: absolute; z-index: 0; top: 0">
                                                <asp:CustomValidator ControlToValidate="tb_email" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                    ID="cv_correo_duplicado" runat="server" ErrorMessage="Ya existe una persona con ese correo" OnServerValidate="cv_correo_duplicado_ServerValidate" ValidationGroup="director" />
                                            </div>
                                            <div style="position: absolute; z-index: 0; top: 0">
                                                <asp:CustomValidator ControlToValidate="tb_email" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                    ID="cv_correo_duplicado_grilla" runat="server" ErrorMessage="Ya existe una persona con ese correo en la grilla" OnServerValidate="cv_correo_duplicado_grilla_ServerValidate" ValidationGroup="director" />
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Domicilio">
                        <ItemTemplate>
                            <table style="margin: 0">
                                <tr>
                                    <td style="width: auto">
                                        <input type="text" id="tb_domicilio" value='<%#Eval("domicilio")%>' runat="server" placeholder="Domicilio del director" /></td>
                                    <td>
                                        <asp:RequiredFieldValidator ControlToValidate="tb_domicilio" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                            ID="RequiredFieldValidator3" runat="server" ErrorMessage="Debe ingresar el domicilio del director" ValidationGroup="director">
                                        </asp:RequiredFieldValidator></td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Teléfono">
                        <ItemTemplate>
                            <table style="margin: 0">
                                <tr>
                                    <td style="width: auto">
                                        <input type="text" id="tb_telefono" value='<%#Eval("telefono")%>' runat="server" placeholder="Teléfono del director" /></td>
                                    <td>
                                        <div style="position: relative;">
                                            <div style="position: absolute; z-index: 0; top: 0">
                                                <asp:RequiredFieldValidator ControlToValidate="tb_telefono" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                    ID="RequiredFieldValidator4" runat="server" ErrorMessage="Debe ingresar el teléfono del director" ValidationGroup="director">
                                                </asp:RequiredFieldValidator>
                                            </div>
                                            <div style="position: absolute; z-index: 0; top: 0">
                                                <asp:RegularExpressionValidator ValidationExpression="\d{6,11}" ControlToValidate="tb_telefono" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                                    ID="RegularExpressionValidator1" runat="server" ErrorMessage="Debe ingresar un teléfono válido (solo números entre 6 y 11 dígitos)" ValidationGroup="director" />
                                            </div>
                                    </td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </asp:TemplateField>

                </Columns>
            </asp:GridView>
        </div>
    </div>

    <asp:Button Text="Importar" CssClass="btn btn-lg btn-primary" ID="btn_importar" OnClick="btn_importar_Click" ValidationGroup="director" runat="server" />
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="CPH_Scripts" runat="server">
    <script>
        $(":file").filestyle({ buttonBefore: false, buttonText: "Seleccionar archivo" });

        $(document).ready(function () {
            $('#<%= gv_directores.ClientID %>').DataTable({
                "scrollY": "400px",
                "scrollX": "800px",
                "scrollCollapse": true,
                "searching": false,
                "paging": false,
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
    </script>
</asp:Content>
