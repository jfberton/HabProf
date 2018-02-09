<%@ Page Title="" Language="C#" MasterPageFile="~/Aplicativo/Site1.Master" AutoEventWireup="true" CodeBehind="importar_tesistas.aspx.cs" Inherits="WebApplication1.Aplicativo.importar_tesistas" %>

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
        <li>Importar Tesistas</li>
    </ol>

    <h1>Importar Tesistas
        <br />
        <small>Permite la importación de Tesistas a través de la carga de un archivo csv.</small></h1>


    <div class="row">
        <div class="col-md-6">
            <asp:FileUpload runat="server" ID="archivo_tesistas" />
            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" ControlToValidate="archivo_tesistas" runat="server" ErrorMessage="Únicamente archivos .csv" ValidationExpression="^([a-zA-Z].*|[1-9].*)\.(((c|C)(s|S)(v|V)))$"></asp:RegularExpressionValidator>
        </div>

        <div class="col-md-4">
            <div class="btn-group" role="group" aria-label="...">
               <asp:Button Text="Procesar !" CssClass="btn btn-primary" runat="server" />
                <button type="button" class="btn btn-warning" data-toggle="modal" data-target=".bs-example-modal-lg"><span class="glyphicon glyphicon-question-sign"></span>&nbsp;Ayuda</button>
            </div>
        </div>
    </div>

    <div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content panel-warning">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <strong>ATENCIÓN!</strong> el archivo csv tiene que tener 7 campos por linea.
                </div>
                <div class="modal-body">
                    <strong><u>Estructura de la linea</u></strong><br />
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
                    <div class="row">
                        <div class="col-md-2">6</div>
                        <div class="col-md-4">Legajo</div>
                        <div class="col-md-6">Cadena</div>
                    </div>
                    <div class="row">
                        <div class="col-md-2">7</div>
                        <div class="col-md-4">Sede</div>
                        <div class="col-md-6">Cadena</div>
                    </div>
                </div>
            </div>
        </div>
    </div>




</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="CPH_Scripts" runat="server">
    <script>
        $(":file").filestyle({ buttonBefore: false, buttonText: "Seleccionar archivo" });
    </script>
</asp:Content>
