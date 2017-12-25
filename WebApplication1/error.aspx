<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="error.aspx.cs" Inherits="WebApplication1.error" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title></title>

    <!-- Le styles -->
    <link href="Content/errorStyle.css" rel="stylesheet" />

    <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="js/html5shiv.js"></script>
    <![endif]-->

    <!-- Fav and touch icons -->
    <link rel="shortcut icon" href="favicon.ico" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="background">
            <div class="wrapper">

                <div class="description">
                    <h1>Oops!</h1>
                    <h2>Parece que algo salio completamente mal.</h2>
                    <p>
                       Por favor intente ingresar nuevamente desde <asp:LinkButton Text="aquí" ID="btn_VolverAEmpezar" OnClick="btn_VolverAEmpezar_Click" runat="server" /> 
                    </p>
                </div>

                <img src="images/turtle.png" class="turtle" alt=""/>
                <div class="shadow"></div>

                <img src="images/wall-power-connection.png" class="wall-p-c" alt=""/>

                <div class="sidebar">
                    <%--<div class="links" id="fila_error" runat="server">
                        <div class="title"><u>Error N° <asp:Label Text="" ID="lbl_numero_error" runat="server" /></u>:</div>
                        <table>
                            <tr>
                                <td style="color:white">Mensage del error:</td>
                                <td><asp:Label Text="" ID="lbl_Message" runat="server" /></td>
                            </tr>
                            <tr>
                                <td style="color:white">Source:</td>
                                <td><asp:Label Text="" ID="lbl_Source" runat="server" /></td>
                            </tr>
                            <tr>
                                <td style="color:white">Instance:</td>
                                <td><asp:Label Text="" ID="lbl_Instance" runat="server" /></td>
                            </tr>
                            <tr>
                                <td style="color:white">Data:</td>
                                <td><asp:Label Text="" ID="lbl_Data" runat="server" /></td>
                            </tr>
                            <tr>
                                <td style="color:white">URL:</td>
                                <td><asp:Label Text="" ID="lbl_URL" runat="server" /></td>
                            </tr>
                            <tr>
                                <td style="color:white">Target Site:</td>
                                <td><asp:Label Text="" ID="lbl_TargetSite" runat="server" /></td>
                            </tr>
                            <tr>
                                <td style="color:white">Stack Trace:</td>
                                <td><asp:Label Text="" ID="lbl_StackTrace" runat="server" /></td>
                            </tr>
                        </table>
                    </div>--%>
                </div>

            </div>
        </div>
    </form>
</body>
</html>
