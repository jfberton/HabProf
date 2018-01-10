<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="menu_admin.ascx.cs" Inherits="WebApplication1.Aplicativo.Menues.menu_admin" %>

<style>
    body {
        padding-top: 50px;
    }
</style>

<div class="navbar navbar-default navbar-fixed-top" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="../Aplicativo/admin_home.aspx">UnNombre</a>
        </div>
        <div class="collapse navbar-collapse">
            <ul class="nav navbar-nav navbar-right">
                <li>
                    <a href="../Aplicativo/usuario_preferencias.aspx">Bienvenido,
                       
                        <asp:Label Text="" ID="lbl_usuario" runat="server" /></a>
                </li>
                <li>
                    <asp:LinkButton Text="Salir" ID="btn_salir" OnClick="btn_salir_Click" runat="server" />
                </li>
            </ul>
            <ul class="nav navbar-nav">
                <li>
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">Personas <b class="caret"></b></a>
                    <ul class="dropdown-menu multi-level">
                        <li><a href="../Aplicativo/admin_tesistas.aspx">Administrar tesistas</a></li>
                        <li><a href="../Aplicativo/admin_directores.aspx">Administrar directores</a></li>
                    </ul>
                </li>
            </ul>
        </div>
        <!--/.nav-collapse -->
    </div>
</div>
