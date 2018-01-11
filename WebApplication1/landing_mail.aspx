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
            <div class="jumbotron" runat="server" id="div_validar_correo">
                <div class="container">
                    <h1 class="text-primary">
                        <asp:Label Text="" id="lbl_titulo" runat="server" /></h1>
                    <p runat="server" id="texto">
                       
                    </p>
                    <p><a class="btn btn-primary btn-lg" href="#" runat="server" id="btn_redireccionar" role="button">Llevame al sistema! &raquo;</a></p>
                </div>
            </div>

            <div class="jumbotron" runat="server" id="div_recuperar_contraseña">
                <div class="container">
                    <h1 class="text-primary">
                        <asp:Label Text="" id="lbl_recuperar_contraseña" runat="server" /></h1>
                    <p runat="server" id="textp_recuperar_contraseña">
                       
                    </p>

                    <div class="row">
                        <div class="col-md-2">
                            <span>Nueva contraseña</span>
                        </div>
                        <div class="col-md-10">
                            <input type="password" class="form-control" runat="server" id="tb_pass" />
                        </div>
                    </div>
                     <div class="row">
                        <div class="col-md-2">
                            <span>Repetir contraseña</span>
                        </div>
                        <div class="col-md-10">
                            <input type="password" class="form-control" runat="server" id="tb_pass1" />
                        </div>
                    </div>
                    <p>
                        <asp:LinkButton Text="Modificar!" CssClass="btn btn-primary btn-lg" OnClick="btn_recuperar_contraseña_Click" id="btn_recuperar_contraseña" role="button" runat="server" />
                        </p>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
