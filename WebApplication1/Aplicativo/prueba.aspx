<%@ Page Title="" Language="C#" Async="true" MasterPageFile="~/Aplicativo/Site1.Master" AutoEventWireup="true" CodeBehind="prueba.aspx.cs" Inherits="WebApplication1.Aplicativo.prueba" %>

<%@ Register Src="~/Aplicativo/Menues/menu_admin.ascx" TagPrefix="uc1" TagName="menu_admin" %>

<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=9.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CPH_Menues" runat="server">
    <uc1:menu_admin runat="server" ID="menu_admin" />
    <rsweb:ReportViewer ID="ReportViewer1" runat="server"><LocalReport ReportPath=' "~/Reportes/reporte_mesa.rdlc"' EnableExternalImages="True"></LocalReport></rsweb:ReportViewer>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CPH_Body" runat="server">

    </asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="CPH_Scripts" runat="server">
</asp:Content>
