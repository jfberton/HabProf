<%@ Page Title="" Language="C#" MasterPageFile="~/Aplicativo/Site1.Master" AutoEventWireup="true" CodeBehind="Prueba.aspx.cs" Inherits="WebApplication1.Aplicativo.Prueba" %>

<%@ Register Src="~/Aplicativo/Menues/MenuDemo.ascx" TagPrefix="uc1" TagName="MenuDemo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CPH_Menues" runat="server">
    <uc1:MenuDemo runat="server" ID="MenuDemo" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CPH_Body" runat="server">
    <br />
   
</asp:Content>



<asp:Content ID="Content4" ContentPlaceHolderID="CPH_Scripts" runat="server">
</asp:Content>
