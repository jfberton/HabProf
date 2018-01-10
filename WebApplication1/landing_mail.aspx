<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="landing_mail.aspx.cs" Inherits="WebApplication1.landing_mail" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="Content/bootstrap-theme-Spacelab.min.css" rel="stylesheet" />
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div class="jumbotron">
                <div class="container">
                    <h1 class="text-primary">
                        <asp:Label Text="" id="lbl_titulo" runat="server" /></h1>
                    <p runat="server" id="texto">
                       
                    </p>
                    <p><a class="btn btn-primary btn-lg" href="#" runat="server" id="btn_redireccionar" role="button">Llevame al sistema! &raquo;</a></p>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
