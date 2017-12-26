<%@ Page Title="" Language="C#" MasterPageFile="~/Aplicativo/Site1.Master" AutoEventWireup="true" CodeBehind="usuario_preferencias.aspx.cs" Inherits="WebApplication1.Aplicativo.usuario_preferencias" %>

<%@ Register Src="~/Aplicativo/Menues/MenuDemo.ascx" TagPrefix="uc1" TagName="MenuDemo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CPH_Menues" runat="server">
    <uc1:MenuDemo runat="server" ID="MenuDemo" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CPH_Body" runat="server">
    <h1>Seleccione un tema</h1>
     <div class="row">
        <div class="col-md-12">
            <asp:Button CommandArgument="../Content/bootstrap-theme-Cerulean.min.css" Text="Cerulean" ID="changeStyleButton" OnClick="changeStyleButton_Click" runat="server" />
            <asp:Button CommandArgument="../Content/bootstrap-theme-Cosmo.min.css" Text="Cosmo" ID="Button1" OnClick="changeStyleButton_Click" runat="server" />
            <asp:Button CommandArgument="../Content/bootstrap-theme-Cyborg.min.css" Text="Cyborg" ID="Button2" OnClick="changeStyleButton_Click" runat="server" />
            <asp:Button CommandArgument="../Content/bootstrap-theme-Darkly.min.css" Text="Darkly" ID="Button3" OnClick="changeStyleButton_Click" runat="server" />
            <asp:Button CommandArgument="../Content/bootstrap-theme-Flatly.min.css" Text="Flatly" ID="Button4" OnClick="changeStyleButton_Click" runat="server" />
            <asp:Button CommandArgument="../Content/bootstrap-theme-Journal.min.css" Text="Journal" ID="Button5" OnClick="changeStyleButton_Click" runat="server" />
            <asp:Button CommandArgument="../Content/bootstrap-theme-Lumen.min.css" Text="Lumen" ID="Button6" OnClick="changeStyleButton_Click" runat="server" />
            <asp:Button CommandArgument="../Content/bootstrap-theme-Paper.min.css" Text="Paper" ID="Button7" OnClick="changeStyleButton_Click" runat="server" />
            <asp:Button CommandArgument="../Content/bootstrap-theme-Readable.min.css" Text="Readable" ID="Button8" OnClick="changeStyleButton_Click" runat="server" />
            <asp:Button CommandArgument="../Content/bootstrap-theme-Sandstone.min.css" Text="Sandstone" ID="Button9" OnClick="changeStyleButton_Click" runat="server" />
            <asp:Button CommandArgument="../Content/bootstrap-theme-Simplex.min.css" Text="Simplex" ID="Button10" OnClick="changeStyleButton_Click" runat="server" />
            <asp:Button CommandArgument="../Content/bootstrap-theme-Slate.min.css" Text="Slate" ID="Button11" OnClick="changeStyleButton_Click" runat="server" />
            <asp:Button CommandArgument="../Content/bootstrap-theme-Spacelab.min.css" Text="Spacelab" ID="Button12" OnClick="changeStyleButton_Click" runat="server" />
            <asp:Button CommandArgument="../Content/bootstrap-theme-Superhero.min.css" Text="Superhero" ID="Button13" OnClick="changeStyleButton_Click" runat="server" />
            <asp:Button CommandArgument="../Content/bootstrap-theme-United.min.css" Text="United" ID="Button14" OnClick="changeStyleButton_Click" runat="server" />
            <asp:Button CommandArgument="../Content/bootstrap-theme-Yeti.min.css" Text="Yeti" ID="Button15" OnClick="changeStyleButton_Click" runat="server" />
        </div>
    </div>

    <h1>Cambio de contraseña</h1>
    <br />
    <div class="row">
        <div class="col-md-3" style="text-align: right">Contraseña actual</div>
        <div class="col-md-3">
            <asp:TextBox runat="server" CssClass="form-control" ID="tb_clave_actual" TextMode="Password" />
        </div>
    </div>
    <div class="row">
        <div class="col-md-3" style="text-align: right">Nueva contraseña</div>
        <div class="col-md-3">
            <asp:TextBox runat="server" CssClass="form-control" ID="tb_clave_nueva" TextMode="Password" />
        </div>
    </div>
    <div class="row">
        <div class="col-md-3" style="text-align: right">Repetir nueva contraseña</div>
        <div class="col-md-3">
            <asp:TextBox runat="server" CssClass="form-control" ID="tb_clave_nueva_repite" TextMode="Password" />
        </div>
    </div>
    <div class="row">
        <div class="col-md-6" style="text-align:right">
            <asp:Button Text="Aplicar!" CssClass="btn btn-default" id="btn_cambiar_clave" OnClick="btn_cambiar_clave_Click" runat="server" />
        </div>
    </div>


</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="CPH_Scripts" runat="server">
</asp:Content>
