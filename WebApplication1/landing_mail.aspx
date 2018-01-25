<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="landing_mail.aspx.cs" Inherits="WebApplication1.landing_mail" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="Content/bootstrap-theme-Spacelab.min.css" rel="stylesheet" />
    <script src="Scripts/jquery-1.9.1.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <div class="jumbotron" runat="server" id="div_error_generico">
                <div class="container">
                    <h1 class="text-primary" style="color: darkred">Oops!</h1>
                    <p>
                        Lamentamos informarle que no encontramos la solicitud buscada
                    </p>
                    <p><a class="btn btn-primary btn-lg" href="default.aspx" role="button">Ingresar al sistema &raquo;</a></p>
                </div>
            </div>

            <div class="jumbotron" runat="server" id="div_validar_correo">
                <div class="container">
                    <h1 class="text-primary">
                        <asp:Label Text="" ID="lbl_titulo" runat="server" /></h1>
                    <p runat="server" id="texto">
                    </p>
                    <p><a class="btn btn-primary btn-lg" href="#" runat="server" id="btn_redireccionar" role="button">Llevame al sistema! &raquo;</a></p>
                </div>
            </div>

            <div class="jumbotron" runat="server" id="div_recuperar_contraseña">
                <div class="container">
                    <h1 class="text-primary">
                        <asp:Label Text="" ID="lbl_recuperar_contraseña" runat="server" /></h1>
                    <p runat="server" id="textp_recuperar_contraseña">
                    </p>

                    <div class="row">
                        <div cass="col-md-12">
                            <asp:ValidationSummary ID="validation_summary" runat="server" DisplayMode="BulletList" ValidationGroup="pass"
                                CssClass="validationsummary panel panel-danger" HeaderText="<div class='panel-heading'>&nbsp;Corrija los siguientes errores antes de continuar:</div>" />
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-2">
                            <span>Nueva contraseña</span>
                        </div>
                        <div class="col-md-9">
                            <asp:TextBox runat="server" CssClass="form-control" ID="tb_pass" TextMode="Password" />
                        </div>
                        <div class="col-md-1">
                            <asp:RequiredFieldValidator ControlToValidate="tb_pass" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                ID="RequiredFieldValidator1" runat="server" ErrorMessage="Debe ingresar la nueva contraseña" ValidationGroup="pass">
                            </asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ValidationExpression="^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{4,8}$" ControlToValidate="tb_pass" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                ID="regx_pass" runat="server" ErrorMessage="La contraseña debe tener entre 4 y 8 caracteres, al menos una mayúscula, una minúscula y un número" ValidationGroup="pass" />
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-2">
                            <span>Repetir contraseña</span>
                        </div>
                        <div class="col-md-9">
                            <asp:TextBox runat="server" CssClass="form-control" ID="tb_pass1" TextMode="Password" />
                        </div>
                        <div class="col-md-1">
                            <asp:CompareValidator ControlToValidate="tb_pass1" ControlToCompare="tb_pass" Type="String" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                ID="compare_validator" runat="server" ErrorMessage="Las contraseñas ingresadas no coinciden" ValidationGroup="pass" />
                        </div>
                    </div>
                    <p>
                        <asp:LinkButton Text="Modificar!" CssClass="btn btn-primary btn-lg" OnClick="btn_recuperar_contraseña_Click" CausesValidation="true" ValidationGroup="pass" ID="btn_recuperar_contraseña" role="button" runat="server" />
                    </p>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
