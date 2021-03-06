﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="menu_admin.ascx.cs" Inherits="WebApplication1.Aplicativo.Menues.menu_admin" %>

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
            <a class="navbar-brand" >SEGUITES</a>
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
            <ul class="nav navbar-nav"><%--si uso el runat server tengo que quitar el path aplicativo--%>
                <li><a href="../admin_tesistas.aspx" runat="server" id="li_admin_tesistas">Tesistas</a></li>
                <li><a href="../admin_directores.aspx" runat="server" id="li_admin_directores">Directores</a></li>
                <li><a href="../admin_jueces.aspx" runat="server" id="li_admin_jueces">Jurados</a></li>
                <li runat="server" id="li_admin_tesinas">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">Tesinas <b class="caret"></b></a>
                    <ul class="dropdown-menu multi-level">
                        <li><a href="../Aplicativo/admin_tesinas.aspx">Listado de Tesinas</a></li>
                        <li><a href="../recordatorios.aspx" runat="server" id="li_generar_recordatorios">Generar recordatorios</a></li>
                    </ul>

                </li>
                <li><a href="../verificar_coincidencias.aspx" runat="server" id="li_comprobar_tema">Comprobar Título</a></li>
                <li><a href="../admin_mesas.aspx" runat="server" id="li_admin_mesa">Mesas</a></li>
                <li runat="server" id="li_importar">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">Importar <b class="caret"></b></a>
                    <ul class="dropdown-menu multi-level">
                        <li><a href="../Aplicativo/importar_tesistas.aspx">Tesistas</a></li>
                        <li><a href="../Aplicativo/importar_directores.aspx">Directores</a></li>
                    </ul>
                </li>
                <li><a href="../admin_tesistas_eliminar_limpieza.aspx" runat="server" id="li_limpieza">Limpieza</a></li>
            </ul>
        </div>
        <!--/.nav-collapse -->
    </div>
</div>
