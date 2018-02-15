<%@ Page Title="" Language="C#" MasterPageFile="~/Aplicativo/Site1.Master" AutoEventWireup="true" CodeBehind="usuario_preferencias.aspx.cs" Inherits="WebApplication1.Aplicativo.usuario_preferencias" Async="True" %>

<%@ Register Src="~/Aplicativo/Menues/menu_admin.ascx" TagPrefix="uc1" TagName="menu_admin" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CPH_Menues" runat="server">
    <uc1:menu_admin runat="server" ID="menu_admin" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CPH_Body" runat="server">
    <ol class="breadcrumb">
        <li><a href="admin_home.aspx">Inicio</a></li>
        <li>Preferencias</li>
    </ol>
    <h2>Estilo <br /><small>seleccione el estilo que le sienta más cómodo, el mismo se aplicará cada vez que ingrese</small></h2>
    <div class="row">
        <div class="row">
            <div class="col-md-12">
                <nav class="navbar navbar-inverse">
                    <div class="container-fluid">
                        <div id="navbar_styles" class="navbar-collapse collapse">
                            <ul class="nav navbar-nav">
                                <li>
                                    <asp:LinkButton CommandArgument="../Content/bootstrap-theme-Cerulean.min.css" Text="Cerulean" ID="LinkButton1" OnClick="changeStyleButton_Click" runat="server" /></li>
                                <li>
                                    <asp:LinkButton CommandArgument="../Content/bootstrap-theme-Cosmo.min.css" Text="Cosmo" ID="LinkButton2" OnClick="changeStyleButton_Click" runat="server" /></li>
                                <li>
                                    <asp:LinkButton CommandArgument="../Content/bootstrap-theme-Cyborg.min.css" Text="Cyborg" ID="LinkButton3" OnClick="changeStyleButton_Click" runat="server" /></li>
                                <li>
                                    <asp:LinkButton CommandArgument="../Content/bootstrap-theme-Darkly.min.css" Text="Darkly" ID="LinkButton4" OnClick="changeStyleButton_Click" runat="server" /></li>
                                <li>
                                    <asp:LinkButton CommandArgument="../Content/bootstrap-theme-Flatly.min.css" Text="Flatly" ID="LinkButton5" OnClick="changeStyleButton_Click" runat="server" /></li>
                                <li>
                                    <asp:LinkButton CommandArgument="../Content/bootstrap-theme-Journal.min.css" Text="Journal" ID="LinkButton6" OnClick="changeStyleButton_Click" runat="server" /></li>
                                <li>
                                    <asp:LinkButton CommandArgument="../Content/bootstrap-theme-Lumen.min.css" Text="Lumen" ID="LinkButton7" OnClick="changeStyleButton_Click" runat="server" /></li>
                                <li>
                                    <asp:LinkButton CommandArgument="../Content/bootstrap-theme-Paper.min.css" Text="Paper" ID="LinkButton8" OnClick="changeStyleButton_Click" runat="server" /></li>
                                <li>
                                    <asp:LinkButton CommandArgument="../Content/bootstrap-theme-Readable.min.css" Text="Readable" ID="LinkButton9" OnClick="changeStyleButton_Click" runat="server" /></li>
                                <li>
                                    <asp:LinkButton CommandArgument="../Content/bootstrap-theme-Sandstone.min.css" Text="Sandstone" ID="LinkButton10" OnClick="changeStyleButton_Click" runat="server" /></li>
                                <li>
                                    <asp:LinkButton CommandArgument="../Content/bootstrap-theme-Simplex.min.css" Text="Simplex" ID="LinkButton11" OnClick="changeStyleButton_Click" runat="server" /></li>
                                <li>
                                    <asp:LinkButton CommandArgument="../Content/bootstrap-theme-Slate.min.css" Text="Slate" ID="LinkButton12" OnClick="changeStyleButton_Click" runat="server" /></li>
                                <li>
                                    <asp:LinkButton CommandArgument="../Content/bootstrap-theme-Spacelab.min.css" Text="Spacelab" ID="LinkButton13" OnClick="changeStyleButton_Click" runat="server" /></li>
                                <li>
                                    <asp:LinkButton CommandArgument="../Content/bootstrap-theme-Superhero.min.css" Text="Superhero" ID="LinkButton14" OnClick="changeStyleButton_Click" runat="server" /></li>
                                <li>
                                    <asp:LinkButton CommandArgument="../Content/bootstrap-theme-United.min.css" Text="United" ID="LinkButton15" OnClick="changeStyleButton_Click" runat="server" /></li>
                                <li>
                                    <asp:LinkButton CommandArgument="../Content/bootstrap-theme-Yeti.min.css" Text="Yeti" ID="LinkButton16" OnClick="changeStyleButton_Click" runat="server" /></li>
                            </ul>
                        </div>
                    </div>
                </nav>
            </div>
        </div>
    </div>

    <h2>Contraseña <br /><small>aquí podrá cambiar su contraseña</small></h2>
    <br />
    <div class="row">
        <div class="col-md-3" style="text-align: right">Contraseña actual</div>
        <div class="col-md-3">
            <asp:TextBox runat="server" CssClass="form-control" ID="tb_clave_actual" TextMode="Password" />
        </div>
    </div>
    <div class="row">
        <div class="col-md-3" style="text-align: right">Nueva contraseña</div>
        <div class="col-md-3">
            <asp:TextBox runat="server" CssClass="form-control" ID="tb_clave_nueva" TextMode="Password" />
        </div>
    </div>
    <div class="row">
        <div class="col-md-3" style="text-align: right">Repetir nueva contraseña</div>
        <div class="col-md-3">
            <asp:TextBox runat="server" CssClass="form-control" ID="tb_clave_nueva_repite" TextMode="Password" />
        </div>
    </div>
    <div class="row">
        <div class="col-md-6" style="text-align: right">
            <asp:Button Text="Aplicar!" CssClass="btn btn-default" ID="btn_cambiar_clave" OnClick="btn_cambiar_clave_Click" runat="server" />
        </div>
    </div>
    <h2>Correo <br /><small>se muestra información del correo actual y su estado. Aquí podra modificar su correo y validarlo.</small></h2>
    <div class="row">
        <div class="col-md-12">
            <nav class="navbar navbar-inverse">
                <div class="container-fluid">
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                            <span class="sr-only">Toggle navigation</span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                        <a class="navbar-brand" href="#" data-toggle="modal" data-target="#modificar_mail">
                            <asp:Label Text="" ID="lbl_email" runat="server" /></a>
                    </div>
                    <div id="navbar" class="navbar-collapse collapse">
                        <ul class="nav navbar-nav">
                            <li>
                                <asp:Label CssClass="navbar-text" Text="" ID="lbl_validado" runat="server" /></li>
                            <li class="active">
                                <asp:LinkButton Text="Validar!" ID="lnk_enviar_validacion" OnClick="lnk_enviar_validacion_Click" runat="server" /></li>
                        </ul>
                    </div>
                </div>
            </nav>
        </div>
    </div>

    <div class="modal fade" id="modificar_mail" role="dialog" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">Modificar correo electrónico</h4>
                </div>
                <div class="modal-body">
                    <input type="hidden" runat="server" id="hidden_id_persona_editar" />
                    <div class="row">
                        <div class="col-md-12">
                            <p>
                                Usted tiene asociado el correo <strong>
                                    <asp:Label Text="" ID="lbl_correo_a_editar" runat="server" /></strong>
                                - <strong><span runat="server" id="p_validado_mail_editar" class="text-danger">
                                    <asp:Label Text="text" ID="lbl_estado_mail_a_editar" runat="server" /></span>
                                </strong>
                            </p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <asp:ValidationSummary ID="validation_summary" runat="server" DisplayMode="BulletList" ValidationGroup="email"
                                CssClass="validationsummary panel panel-danger" HeaderText="<div class='panel-heading'>&nbsp;Corrija los siguientes errores antes de continuar:</div>" />
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <table class="table-condensed" style="width: 100%">
                                <tr>
                                    <td>Nuevo correo</td>
                                    <td style="width: auto">
                                        <input type="text" id="tb_email" class="form-control" runat="server" placeholder="Ingrese su correo" /></td>
                                    <td>
                                        <asp:RequiredFieldValidator ControlToValidate="tb_email" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                            ID="RequiredFieldValidator2" runat="server" ErrorMessage="Debe ingresar su nuevo correo" ValidationGroup="email">
                                                </asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="tb_email" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                            ID="regex_email" runat="server" ErrorMessage="Debe ingresar un correo valido" ValidationGroup="email" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button id="btn_guardar_nuevo_mail" runat="server" onserverclick="btn_guardar_nuevo_mail_ServerClick" class="btn btn-primary" validationgroup="director">
                        <span class="glyphicon glyphicon-floppy-disk" aria-hidden="true"></span>Guardar!
                           
                    </button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="CPH_Scripts" runat="server">
</asp:Content>
