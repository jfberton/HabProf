<%@ Page Title="" Language="C#" Async="true" MasterPageFile="~/Aplicativo/Site1.Master" AutoEventWireup="true" CodeBehind="prueba.aspx.cs" Inherits="WebApplication1.Aplicativo.prueba" %>

<%@ Register Src="~/Aplicativo/Menues/menu_admin.ascx" TagPrefix="uc1" TagName="menu_admin" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=9.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CPH_Menues" runat="server">
    <uc1:menu_admin runat="server" ID="menu_admin" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CPH_Body" runat="server">
    <asp:Button Text="Verificar correos automáticos" ID="btn_verificar_correos" OnClick="btn_verificar_correos_Click" runat="server" />
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="CPH_Scripts" runat="server">
</asp:Content>
