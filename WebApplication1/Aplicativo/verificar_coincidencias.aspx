<%@ Page Title="" Language="C#" Async="true" MasterPageFile="~/Aplicativo/Site1.Master" AutoEventWireup="true" CodeBehind="verificar_coincidencias.aspx.cs" Inherits="WebApplication1.Aplicativo.verificar_coincidencias" %>

<%@ Register Src="~/Aplicativo/Menues/menu_admin.ascx" TagPrefix="uc1" TagName="menu_admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CPH_Menues" runat="server">
    <uc1:menu_admin runat="server" ID="menu_admin" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CPH_Body" runat="server">
     <h1>Buscar en Título y Descripción de las Tesinas presentadas</h1>

    <div class="row">
        <div class="col-md-12">
            <input type="text" runat="server" class="form-control" id="tb_palabras_buscadas" />
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <asp:Button Text="Buscar coincidencias!" class="btn btn-primary" runat="server"  ID="btn_buscar" OnClick="btn_buscar_Click"/>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12" runat="server" id="div_coincidencias">
             
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="CPH_Scripts" runat="server">
</asp:Content>
