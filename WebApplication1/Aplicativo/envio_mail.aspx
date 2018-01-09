<%@ Page Title="" Language="C#" MasterPageFile="~/Aplicativo/Site1.Master" AutoEventWireup="true" CodeBehind="envio_mail.aspx.cs" Inherits="WebApplication1.Aplicativo.envio_mail" %>

<%@ Register Src="~/Aplicativo/Menues/menu_admin.ascx" TagPrefix="uc1" TagName="menu_admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CPH_Menues" runat="server">
    <uc1:menu_admin runat="server" ID="menu_admin" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CPH_Body" runat="server">
    <h1>Envio de mail <small>Página de prueba de envío de mails</small></h1>
    <%--<div class="row">
        <div class="col-md-2">De:</div>
        <div class="col-md-4">
            <asp:TextBox runat="server" CssClass="form-control" ID="tb_de" />
        </div>
        <div class="col-md-2">contraseña:</div>
        <div class="col-md-4">
            <asp:TextBox runat="server" CssClass="form-control" ID="tb_pass" />
        </div>
    </div>--%>
    <%--<div class="row">
        <div class="col-md-2">Para:</div>
        <div class="col-md-10">
            <asp:TextBox runat="server" CssClass="form-control" ID="tb_para" />
        </div>
    </div>
    <div class="row">
        <div class="col-md-2">Asunto:</div>
        <div class="col-md-10">
            <asp:TextBox runat="server" CssClass="form-control" ID="tb_asunto" />
        </div>
    </div>
    <div class="row">
        <div class="col-md-2">Adjunto:</div>
        <div class="col-md-10">
            <asp:FileUpload ID="fuAttachment" runat="server" />
        </div>
    </div>
    <div class="row">
        <div class="col-md-2">Contenido:</div>
        <div class="col-md-10">
            <asp:TextBox runat="server" CssClass="form-control" ID="tb_contenido" TextMode="MultiLine" Rows="10" />
        </div>
    </div>--%>
    <asp:Button Text="Enviar" CssClass="btn btn-lg btn-default" OnClick="SendEmail" runat="server" />


</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="CPH_Scripts" runat="server">
</asp:Content>
