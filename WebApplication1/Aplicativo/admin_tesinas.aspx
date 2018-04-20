<%@ Page Title="" Language="C#" Async="true" MasterPageFile="~/Aplicativo/Site1.Master" EnableEventValidation="true" ValidateRequest="false" AutoEventWireup="true" CodeBehind="admin_tesinas.aspx.cs" Inherits="WebApplication1.Aplicativo.admin_tesinas" %>

<%@ Register Src="~/Aplicativo/Menues/menu_admin.ascx" TagPrefix="uc1" TagName="menu_admin" %>
<%@ Register Assembly="OptionDropDownList" Namespace="OptionDropDownList" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CPH_Menues" runat="server">
    <uc1:menu_admin runat="server" ID="menu_admin" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CPH_Body" runat="server">
    <ol class="breadcrumb">
        <li><a href="admin_home.aspx">Inicio</a></li>
        <li>Tesinas</li>
        <li>Listado tesinas</li>
    </ol>

    <h1>Tesinas <small>
        <asp:Label Text="Listado de Tesinas de la Licenciatura" runat="server" ID="lbl_small_titulo" /></small></h1>
    <div class="row">
        <div class="col-md-10">
            <div class="alert alert-warning" role="alert" runat="server" id="lbl_sin_tesinas">
                <p runat="server" id="lbl_no_existe_tesina"></p>
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="row" runat="server" id="div_filtro_categorias">
                <div class="col-md-2" style="vertical-align: central">
                    <label style="color: #333">Filtro categorias</label>
                </div>
                <div class="col-md-6">
                    <cc1:OptionGroupSelect ID="ddl_categorias" CssClass="form-control" runat="server" AutoPostBack="true" OnValueChanged="ddl_categorias_ValueChanged" EnableViewState="False">
                        <cc1:OptionGroupItem ID="OptionGroupItem" runat="server" Value="Todas las categorias" Text="Todas las categorias" OptionGroup="" />
                        <cc1:OptionGroupItem ID="OptionGroupItem1" runat="server" Value="100 - Varios –ENERGiA- (Especificar)" Text="100 - Varios –ENERGÍA- (Especificar)" OptionGroup="01 ENERGIA (Producción)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem2" runat="server" Value="110 - Nuclear" Text="110 - Nuclear" OptionGroup="01 ENERGIA (Producción)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem3" runat="server" Value="111 - Centrales de produccion" Text="111 - Centrales de producción" OptionGroup="01 ENERGIA (Producción)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem4" runat="server" Value="112 - Reactores" Text="112 - Reactores" OptionGroup="01 ENERGIA (Producción)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem5" runat="server" Value="113 - Combustibles" Text="113 - Combustibles" OptionGroup="01 ENERGIA (Producción)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem6" runat="server" Value="119 - Otros – Energia Nuclear (Especificar)" Text="119 - Otros – Energía Nuclear (Especificar)" OptionGroup="01 ENERGIA (Producción)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem7" runat="server" Value="120 - Hidraulica" Text="120 - Hidráulica" OptionGroup="01 ENERGIA (Producción)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem8" runat="server" Value="130 - Termica" Text="130 - Térmica" OptionGroup="01 - ENERGIA (Producción)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem9" runat="server" Value="131 - Hidrocarburos" Text="131 - Hidrocarburos" OptionGroup="01 - ENERGIA (Producción)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem10" runat="server" Value="132 - Combustibles" Text="132 - Combustibles" OptionGroup="01 - ENERGIA (Producción)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem11" runat="server" Value="140 - Solar" Text="140 - Solar" OptionGroup="01 - ENERGIA (Producción)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem12" runat="server" Value="150 - Geotermica" Text="150 - Geotérmica" OptionGroup="01 - ENERGIA (Producción)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem13" runat="server" Value="160 - Eolica" Text="160 - Eólica" OptionGroup="01 - ENERGIA (Producción)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem14" runat="server" Value="170 - Electrica" Text="170 - Eléctrica" OptionGroup="01 - ENERGIA (Producción)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem15" runat="server" Value="180 - Bioenergia" Text="180 - Bioenergía" OptionGroup="01 - ENERGIA (Producción)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem16" runat="server" Value="190 - Sistema de transmision, distribucion, transformacion" Text="190 - Sistema de transmisión, distribución, transformación" OptionGroup="01 - ENERGIA (Producción)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem17" runat="server" Value="199 - Otros –ENERGiA- (especificar)" Text="199 - Otros –ENERGÍA- (especificar)" OptionGroup="01 - ENERGIA (Producción)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem18" runat="server" Value="200 - Varios –ESPACIO- (Especificar)" Text="200 - Varios –ESPACIO- (Especificar)" OptionGroup="02 - ESPACIO (Exploración y explotación)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem19" runat="server" Value="210 - Vehiculos y proyectos" Text="210 - Vehículos y proyectos" OptionGroup="02 - ESPACIO (Exploración y explotación)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem20" runat="server" Value="220 - Cargas" Text="220 - Cargas" OptionGroup="02 - ESPACIO (Exploración y explotación)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem21" runat="server" Value="230 - Combustibles y propulsantes" Text="230 - Combustibles y propulsantes" OptionGroup="02 - ESPACIO (Exploración y explotación)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem22" runat="server" Value="299 - Otros –ESPACIO- (Especificar)" Text="299 - Otros –ESPACIO- (Especificar)" OptionGroup="02 - ESPACIO (Exploración y explotación)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem23" runat="server" Value="300 - Varios –DEFENSA Y SEGURIDAD- (Especificar)" Text="300 - Varios –DEFENSA Y SEGURIDAD- (Especificar)" OptionGroup="03 - DEFENSA Y SEGURIDAD" />
                        <cc1:OptionGroupItem ID="OptionGroupItem24" runat="server" Value="310 - Defensa" Text="310 - Defensa" OptionGroup="03 - DEFENSA Y SEGURIDAD" />
                        <cc1:OptionGroupItem ID="OptionGroupItem25" runat="server" Value="320 - Seguridad" Text="320 - Seguridad" OptionGroup="03 - DEFENSA Y SEGURIDAD" />
                        <cc1:OptionGroupItem ID="OptionGroupItem26" runat="server" Value="399 - Otros –DEFENSA Y SEGURIDAD- (Especificar)" Text="399 - Otros –DEFENSA Y SEGURIDAD- (Especificar)" OptionGroup="03 - DEFENSA Y SEGURIDAD" />
                        <cc1:OptionGroupItem ID="OptionGroupItem27" runat="server" Value="400 - Varios –MEDIOS TERRESTRES- (Especificar)" Text="400 - Varios –MEDIOS TERRESTRES- (Especificar)" OptionGroup="04 - MEDIO TERRESTRE (Exploración y explotación)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem28" runat="server" Value="410 - Suelos" Text="410 - Suelos" OptionGroup="04 - MEDIO TERRESTRE (Exploración y explotación)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem29" runat="server" Value="411 - aridos y semiaridos" Text="411 - Áridos y semiáridos" OptionGroup="04 - MEDIO TERRESTRE (Exploración y explotación)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem30" runat="server" Value="412 - Degradacion" Text="412 - Degradación" OptionGroup="04 - MEDIO TERRESTRE (Exploración y explotación)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem31" runat="server" Value="413 - Fertilizacion" Text="413 - Fertilización" OptionGroup="04 - MEDIO TERRESTRE (Exploración y explotación)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem32" runat="server" Value="414 - Conservacion" Text="414 - Conservación" OptionGroup="04 - MEDIO TERRESTRE (Exploración y explotación)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem33" runat="server" Value="419 - Otros –Suelos- (Especificar)" Text="419 - Otros –Suelos- (Especificar)" OptionGroup="04 - MEDIO TERRESTRE (Exploración y explotación)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem34" runat="server" Value="420 - Recursos naturales no renovables" Text="420 - Recursos naturales no renovables" OptionGroup="04 - MEDIO TERRESTRE (Exploración y explotación)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem35" runat="server" Value="421 - Minas de carbon (incluye: concentracion)" Text="421 - Minas de carbón (incluye: concentración)" OptionGroup="04 - MEDIO TERRESTRE (Exploración y explotación)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem36" runat="server" Value="422 - Petroleo crudo y gas natural (incluye: exploracion)" Text="422 - Petróleo crudo y gas natural (incluye: exploración)" OptionGroup="04 - MEDIO TERRESTRE (Exploración y explotación)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem37" runat="server" Value="423 - Minerales metalicos (incluye: concentracion)" Text="423 - Minerales metálicos (incluye: concentración)" OptionGroup="04 - MEDIO TERRESTRE (Exploración y explotación)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem38" runat="server" Value="424 - Minerales no metalicos (incluye: rocas de aplicacion)" Text="424 - Minerales no metálicos (incluye: rocas de aplicación)" OptionGroup="04 - MEDIO TERRESTRE (Exploración y explotación)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem39" runat="server" Value="429 - Otros –Rec. nat. no renov.- (Especificar)" Text="429 - Otros –Rec. nat. no renov.- (Especificar)" OptionGroup="04 - MEDIO TERRESTRE (Exploración y explotación)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem40" runat="server" Value="430 - Recursos hidricos" Text="430 - Recursos hídricos" OptionGroup="04 - MEDIO TERRESTRE (Exploración y explotación)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem41" runat="server" Value="431 - Cuencas superficiales" Text="431 - Cuencas superficiales" OptionGroup="04 - MEDIO TERRESTRE (Exploración y explotación)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem42" runat="server" Value="432 - Cuencas subterraneas" Text="432 - Cuencas subterráneas" OptionGroup="04 - MEDIO TERRESTRE (Exploración y explotación)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem43" runat="server" Value="433 - Cuencas oceanicas" Text="433 - Cuencas oceánicas" OptionGroup="04 - MEDIO TERRESTRE (Exploración y explotación)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem44" runat="server" Value="434 - Riego y drenaje (ver 0771)" Text="434 - Riego y drenaje (ver 0771)" OptionGroup="04 - MEDIO TERRESTRE (Exploración y explotación)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem45" runat="server" Value="435 - Crecidas, inundaciones y sequias" Text="435 - Crecidas, inundaciones y sequías" OptionGroup="04 - MEDIO TERRESTRE (Exploración y explotación)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem46" runat="server" Value="436 - Calidad de aguas: medicion y control (ver 0553)" Text="436 - Calidad de aguas: medición y control (ver 0553)" OptionGroup="04 - MEDIO TERRESTRE (Exploración y explotación)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem47" runat="server" Value="437 - Contaminacion y saneamiento (ver 0541)" Text="437 - Contaminación y saneamiento (ver 0541)" OptionGroup="04 - MEDIO TERRESTRE (Exploración y explotación)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem48" runat="server" Value="439 - Otros –Recursos hidricos- (Especificar)" Text="439 - Otros –Recursos hídricos- (Especificar)" OptionGroup="04 - MEDIO TERRESTRE (Exploración y explotación)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem49" runat="server" Value="440 - Atmosfera" Text="440 - Atmósfera" OptionGroup="04 - MEDIO TERRESTRE (Exploración y explotación)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem50" runat="server" Value="441 - Meteorologia" Text="441 - Meteorología" OptionGroup="04 - MEDIO TERRESTRE (Exploración y explotación)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem51" runat="server" Value="442 - Modificacion artificial del clima" Text="442 - Modificación artificial del clima" OptionGroup="04 - MEDIO TERRESTRE (Exploración y explotación)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem52" runat="server" Value="443 - Contaminacion y saneamiento (ver 0542)" Text="443 - Contaminación y saneamiento (ver 0542)" OptionGroup="04 - MEDIO TERRESTRE (Exploración y explotación)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem53" runat="server" Value="449 - Otros –Atmosfera- (Especificar)" Text="449 - Otros –Atmósfera- (Especificar)" OptionGroup="04 - MEDIO TERRESTRE (Exploración y explotación)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem54" runat="server" Value="450 - Recursos naturales renovables" Text="450 - Recursos naturales renovables" OptionGroup="04 - MEDIO TERRESTRE (Exploración y explotación)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem55" runat="server" Value="451 - Explotacion" Text="451 - Explotación" OptionGroup="04 - MEDIO TERRESTRE (Exploración y explotación)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem56" runat="server" Value="452 - Conservacion y preservacion" Text="452 - Conservación y preservación" OptionGroup="04 - MEDIO TERRESTRE (Exploración y explotación)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem57" runat="server" Value="459 - Otros –Recursos nat. renovables- (Especificar)" Text="459 - Otros –Recursos nat. renovables- (Especificar)" OptionGroup="04 - MEDIO TERRESTRE (Exploración y explotación)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem58" runat="server" Value="499 - Otros – MEDIOS TERRESTRES- (Especificar)" Text="499 - Otros – MEDIOS TERRESTRES- (Especificar)" OptionGroup="04 - MEDIO TERRESTRE (Exploración y explotación)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem59" runat="server" Value="500 - Varios –SALUD HUMANA- (Especificar)" Text="500 - Varios –SALUD HUMANA- (Especificar)" OptionGroup="05 - SALUD HUMANA (Desarrollo, protección y mejoramiento)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem60" runat="server" Value="510 - Enfermedades no endemicas (Prevencion, diagnostico)" Text="510 - Enfermedades no endémicas (Prevención, diagnóstico)" OptionGroup="05 - SALUD HUMANA (Desarrollo, protección y mejoramiento)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem61" runat="server" Value="511 - Transmisibles" Text="511 - Transmisibles" OptionGroup="05 - SALUD HUMANA (Desarrollo, protección y mejoramiento)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem62" runat="server" Value="512 - Prenatales, neonatales y perinatales" Text="512 - Prenatales, neonatales y perinatales" OptionGroup="05 - SALUD HUMANA (Desarrollo, protección y mejoramiento)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem63" runat="server" Value="513 - Degenerativas" Text="513 - Degenerativas" OptionGroup="05 - SALUD HUMANA (Desarrollo, protección y mejoramiento)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem64" runat="server" Value="514 - Psiquicas" Text="514 - Psíquicas" OptionGroup="05 - SALUD HUMANA (Desarrollo, protección y mejoramiento)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem65" runat="server" Value="515 - De nacimiento y perinatales" Text="515 - De nacimiento y perinatales" OptionGroup="05 - SALUD HUMANA (Desarrollo, protección y mejoramiento)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem66" runat="server" Value="516 - Heridas y traumatismos accidentales" Text="516 - Heridas y traumatismos accidentales" OptionGroup="05 - SALUD HUMANA (Desarrollo, protección y mejoramiento)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem67" runat="server" Value="519 - Otros –Enfermedades no endemicas- (Especificar)" Text="519 - Otros –Enfermedades no endémicas- (Especificar)" OptionGroup="05 - SALUD HUMANA (Desarrollo, protección y mejoramiento)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem68" runat="server" Value="520 - Enfermedades endemicas (Prevencion, diagnostico y" Text="520 - Enfermedades endémicas (Prevención, diagnóstico y" OptionGroup="05 - SALUD HUMANA (Desarrollo, protección y mejoramiento)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem69" runat="server" Value="521 - Mal de Chagas" Text="521 - Mal de Chagas" OptionGroup="05 - SALUD HUMANA (Desarrollo, protección y mejoramiento)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem70" runat="server" Value="522 - Fiebre hemorragica argentina" Text="522 - Fiebre hemorrágica argentina" OptionGroup="05 - SALUD HUMANA (Desarrollo, protección y mejoramiento)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem71" runat="server" Value="523 - Diarreas de infancia" Text="523 - Diarreas de infancia" OptionGroup="05 - SALUD HUMANA (Desarrollo, protección y mejoramiento)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem72" runat="server" Value="524 - Enfermedades infecciosas respiratorias agudas" Text="524 - Enfermedades infecciosas respiratorias agudas" OptionGroup="05 - SALUD HUMANA (Desarrollo, protección y mejoramiento)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem73" runat="server" Value="525 - Uncinariosis" Text="525 - Uncinariosis" OptionGroup="05 - SALUD HUMANA (Desarrollo, protección y mejoramiento)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem74" runat="server" Value="529 - Otras –Enfermedades endemicas- (Especificar)" Text="529 - Otras –Enfermedades endémicas- (Especificar)" OptionGroup="05 - SALUD HUMANA (Desarrollo, protección y mejoramiento)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem75" runat="server" Value="530 - Higiene, alimentacion y nutricion" Text="530 - Higiene, alimentación y nutrición" OptionGroup="05 - SALUD HUMANA (Desarrollo, protección y mejoramiento)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem76" runat="server" Value="531 - Sanidad perinatal" Text="531 - Sanidad perinatal" OptionGroup="05 - SALUD HUMANA (Desarrollo, protección y mejoramiento)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem77" runat="server" Value="532 - Nutricion y desnutricion" Text="532 - Nutrición y desnutrición" OptionGroup="05 - SALUD HUMANA (Desarrollo, protección y mejoramiento)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem78" runat="server" Value="533 - Educacion sanitaria" Text="533 - Educación sanitaria" OptionGroup="05 - SALUD HUMANA (Desarrollo, protección y mejoramiento)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem79" runat="server" Value="539 - Otros –Higiene, alimentacion y nutr.- (Especificar)" Text="539 - Otros –Higiene, alimentación y nutr.- (Especificar)" OptionGroup="05 - SALUD HUMANA (Desarrollo, protección y mejoramiento)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem80" runat="server" Value="540 - Sanidad ambiental" Text="540 - Sanidad ambiental" OptionGroup="05 - SALUD HUMANA (Desarrollo, protección y mejoramiento)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem81" runat="server" Value="541 - Preservacion de los recursos hidricos (ver 0437)" Text="541 - Preservación de los recursos hídricos (ver 0437)" OptionGroup="05 - SALUD HUMANA (Desarrollo, protección y mejoramiento)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem82" runat="server" Value="542 - Preservacion de la atmosfera (ver 0443)" Text="542 - Preservación de la atmósfera (ver 0443)" OptionGroup="05 - SALUD HUMANA (Desarrollo, protección y mejoramiento)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem83" runat="server" Value="543 - Proteccion contra el ruido" Text="543 - Protección contra el ruido" OptionGroup="05 - SALUD HUMANA (Desarrollo, protección y mejoramiento)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem84" runat="server" Value="544 - Proteccion contra radiaciones" Text="544 - Protección contra radiaciones" OptionGroup="05 - SALUD HUMANA (Desarrollo, protección y mejoramiento)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem85" runat="server" Value="549 - Otros –Sanidad ambiental- (Especificar)" Text="549 - Otros –Sanidad ambiental- (Especificar)" OptionGroup="05 - SALUD HUMANA (Desarrollo, protección y mejoramiento)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem86" runat="server" Value="550 - Presentaciones sanitarias" Text="550 - Presentaciones sanitarias" OptionGroup="05 - SALUD HUMANA (Desarrollo, protección y mejoramiento)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem87" runat="server" Value="551 - Medicina preventiva (incluye dentistica)" Text="551 - Medicina preventiva (incluye dentística)" OptionGroup="05 - SALUD HUMANA (Desarrollo, protección y mejoramiento)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem88" runat="server" Value="552 - Medicina curativa (incluye dentistica)" Text="552 - Medicina curativa (incluye dentística)" OptionGroup="05 - SALUD HUMANA (Desarrollo, protección y mejoramiento)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem89" runat="server" Value="553 - Servicios sanitarios (agua potable) (ver 0436)" Text="553 - Servicios sanitarios (agua potable) (ver 0436)" OptionGroup="05 - SALUD HUMANA (Desarrollo, protección y mejoramiento)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem90" runat="server" Value="559 - Otros –Presentaciones sanitarias- (Especificar)" Text="559 - Otros –Presentaciones sanitarias- (Especificar)" OptionGroup="05 - SALUD HUMANA (Desarrollo, protección y mejoramiento)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem91" runat="server" Value="560 - Cirugia, injertos y transplantes" Text="560 - Cirugía, injertos y transplantes" OptionGroup="05 - SALUD HUMANA (Desarrollo, protección y mejoramiento)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem92" runat="server" Value="561 - Cirugia de organos" Text="561 - Cirugía de órganos" OptionGroup="05 - SALUD HUMANA (Desarrollo, protección y mejoramiento)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem93" runat="server" Value="562 - Injertos" Text="562 - Injertos" OptionGroup="05 - SALUD HUMANA (Desarrollo, protección y mejoramiento)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem94" runat="server" Value="563 - Transplantes" Text="563 - Transplantes" OptionGroup="05 - SALUD HUMANA (Desarrollo, protección y mejoramiento)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem95" runat="server" Value="569 - Otros –Cirugia, inj. y transp.- (Especificar)" Text="569 - Otros –Cirugía, inj. y transp.- (Especificar)" OptionGroup="05 - SALUD HUMANA (Desarrollo, protección y mejoramiento)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem96" runat="server" Value="570 - Desarrollo de tecnologia sanitaria y curativa" Text="570 - Desarrollo de tecnología sanitaria y curativa" OptionGroup="05 - SALUD HUMANA (Desarrollo, protección y mejoramiento)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem97" runat="server" Value="571 - Instrumental medico y odontologico" Text="571 - Instrumental médico y odontológico" OptionGroup="05 - SALUD HUMANA (Desarrollo, protección y mejoramiento)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem98" runat="server" Value="572 - Protesis" Text="572 - Prótesis" OptionGroup="05 - SALUD HUMANA (Desarrollo, protección y mejoramiento)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem99" runat="server" Value="573 - Instrumental de rehabilitacion" Text="573 - Instrumental de rehabilitación" OptionGroup="05 - SALUD HUMANA (Desarrollo, protección y mejoramiento)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem100" runat="server" Value="574 - Medicamentos (ver 0855)" Text="574 - Medicamentos (ver 0855)" OptionGroup="05 - SALUD HUMANA (Desarrollo, protección y mejoramiento)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem101" runat="server" Value="579 - Otros –Des. de tecn. sanit. u cur.- (Especificar)" Text="579 - Otros –Des. de tecn. sanit. u cur.- (Especificar)" OptionGroup="05 - SALUD HUMANA (Desarrollo, protección y mejoramiento)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem102" runat="server" Value="599 - Otros –SALUD HUMANA- (Especificar)" Text="599 - Otros –SALUD HUMANA- (Especificar)" OptionGroup="05 - SALUD HUMANA (Desarrollo, protección y mejoramiento)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem103" runat="server" Value="610 - Urbanismo y desarrollo regional" Text="610 - Urbanismo y desarrollo regional" OptionGroup="06 - ORDENAMIENTO TERRITORIAL" />
                        <cc1:OptionGroupItem ID="OptionGroupItem104" runat="server" Value="611 - Urbanismo" Text="611 - Urbanismo" OptionGroup="06 - ORDENAMIENTO TERRITORIAL" />
                        <cc1:OptionGroupItem ID="OptionGroupItem105" runat="server" Value="612 - Desarrollo regional" Text="612 - Desarrollo regional" OptionGroup="06 - ORDENAMIENTO TERRITORIAL" />
                        <cc1:OptionGroupItem ID="OptionGroupItem106" runat="server" Value="619 - Otros –Urbanismo y des. regional- (Especificar)" Text="619 - Otros –Urbanismo y des. regional- (Especificar)" OptionGroup="06 - ORDENAMIENTO TERRITORIAL" />
                        <cc1:OptionGroupItem ID="OptionGroupItem107" runat="server" Value="620 - Vivienda" Text="620 - Vivienda" OptionGroup="06 - ORDENAMIENTO TERRITORIAL" />
                        <cc1:OptionGroupItem ID="OptionGroupItem108" runat="server" Value="621 - Economica" Text="621 - Económica" OptionGroup="06 - ORDENAMIENTO TERRITORIAL" />
                        <cc1:OptionGroupItem ID="OptionGroupItem109" runat="server" Value="622 - Materiales de construccion" Text="622 - Materiales de construcción" OptionGroup="06 - ORDENAMIENTO TERRITORIAL" />
                        <cc1:OptionGroupItem ID="OptionGroupItem110" runat="server" Value="623 - Tecnicas de construccion" Text="623 - Técnicas de construcción" OptionGroup="06 - ORDENAMIENTO TERRITORIAL" />
                        <cc1:OptionGroupItem ID="OptionGroupItem111" runat="server" Value="629 - Otros –Vivienda- (Especificar)" Text="629 - Otros –Vivienda- (Especificar)" OptionGroup="06 - ORDENAMIENTO TERRITORIAL" />
                        <cc1:OptionGroupItem ID="OptionGroupItem112" runat="server" Value="630 - Construccion y equipamiento de obras publicas" Text="630 - Construcción y equipamiento de obras públicas" OptionGroup="06 - ORDENAMIENTO TERRITORIAL" />
                        <cc1:OptionGroupItem ID="OptionGroupItem113" runat="server" Value="631 - Viales: puentes y caminos" Text="631 - Viales: puentes y caminos" OptionGroup="06 - ORDENAMIENTO TERRITORIAL" />
                        <cc1:OptionGroupItem ID="OptionGroupItem114" runat="server" Value="632 - Educativas" Text="632 - Educativas" OptionGroup="06 - ORDENAMIENTO TERRITORIAL" />
                        <cc1:OptionGroupItem ID="OptionGroupItem115" runat="server" Value="639 - Otros –Constr. y equip. de ob. pub.- (Especificar)" Text="639 - Otros –Constr. y equip. de ob. pub.- (Especificar)" OptionGroup="06 - ORDENAMIENTO TERRITORIAL" />
                        <cc1:OptionGroupItem ID="OptionGroupItem116" runat="server" Value="640 - Sistema  de transporte" Text="640 - Sistema  de transporte" OptionGroup="06 - ORDENAMIENTO TERRITORIAL" />
                        <cc1:OptionGroupItem ID="OptionGroupItem117" runat="server" Value="641 - Terrestres" Text="641 - Terrestres" OptionGroup="06 - ORDENAMIENTO TERRITORIAL" />
                        <cc1:OptionGroupItem ID="OptionGroupItem118" runat="server" Value="642 - Aereos" Text="642 - Aéreos" OptionGroup="06 - ORDENAMIENTO TERRITORIAL" />
                        <cc1:OptionGroupItem ID="OptionGroupItem119" runat="server" Value="643 - Maritimos" Text="643 - Marítimos" OptionGroup="06 - ORDENAMIENTO TERRITORIAL" />
                        <cc1:OptionGroupItem ID="OptionGroupItem120" runat="server" Value="649 - Otros –Sistemas de transporte- (Especificar)" Text="649 - Otros –Sistemas de transporte- (Especificar)" OptionGroup="06 - ORDENAMIENTO TERRITORIAL" />
                        <cc1:OptionGroupItem ID="OptionGroupItem121" runat="server" Value="650 - Sistemas de comunicaciones" Text="650 - Sistemas de comunicaciones" OptionGroup="06 - ORDENAMIENTO TERRITORIAL" />
                        <cc1:OptionGroupItem ID="OptionGroupItem122" runat="server" Value="651 - Telecomunicaciones" Text="651 - Telecomunicaciones" OptionGroup="06 - ORDENAMIENTO TERRITORIAL" />
                        <cc1:OptionGroupItem ID="OptionGroupItem123" runat="server" Value="652 - Postal" Text="652 - Postal" OptionGroup="06 - ORDENAMIENTO TERRITORIAL" />
                        <cc1:OptionGroupItem ID="OptionGroupItem124" runat="server" Value="659 - Otros –Sistemas de comunicaciones- (Especificar)" Text="659 - Otros –Sistemas de comunicaciones- (Especificar)" OptionGroup="06 - ORDENAMIENTO TERRITORIAL" />
                        <cc1:OptionGroupItem ID="OptionGroupItem125" runat="server" Value="699 - Otros –ORDENAMIENTO TERRITORIAL- (Especificar)" Text="699 - Otros –ORDENAMIENTO TERRITORIAL- (Especificar)" OptionGroup="06 - ORDENAMIENTO TERRITORIAL" />
                        <cc1:OptionGroupItem ID="OptionGroupItem126" runat="server" Value="700 - Varios –AGROPECUARIA- (Especificar)" Text="700 - Varios –AGROPECUARIA- (Especificar)" OptionGroup="07 - AGROPECUARIA (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem127" runat="server" Value="710 - Produccion animal" Text="710 - Producción animal" OptionGroup="07 - AGROPECUARIA (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem128" runat="server" Value="711 - Caza y repoblacion de la fauna silvestre" Text="711 - Caza y repoblación de la fauna silvestre" OptionGroup="07 - AGROPECUARIA (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem129" runat="server" Value="712 - Pesca (Tecnologica, viveros, recursos maritimos, e" Text="712 - Pesca (Tecnológica, viveros, recursos marítimos, e" OptionGroup="07 - AGROPECUARIA (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem130" runat="server" Value="713 - Bovina (incluye cueros)" Text="713 - Bovina (incluye cueros)" OptionGroup="07 - AGROPECUARIA (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem131" runat="server" Value="714 - Porcina" Text="714 - Porcina" OptionGroup="07 - AGROPECUARIA (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem132" runat="server" Value="715 - Ovina (incluye lanas)" Text="715 - Ovina (incluye lanas)" OptionGroup="07 - AGROPECUARIA (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem133" runat="server" Value="716 - Crias de otros ganados (caballar, caprino, etc.)" Text="716 - Crías de otros ganados (caballar, caprino, etc.)" OptionGroup="07 - AGROPECUARIA (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem134" runat="server" Value="717 - Cria de animales y productos de granja (aves, conejos)" Text="717 - Cría de animales y productos de granja (aves, conejos)" OptionGroup="07 - AGROPECUARIA (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem135" runat="server" Value="718 - Leche (tecnicas de produccion, etc.)" Text="718 - Leche (técnicas de producción, etc.)" OptionGroup="07 - AGROPECUARIA (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem136" runat="server" Value="719 - Otros –Produccion animal- (Especificar)" Text="719 - Otros –Producción animal- (Especificar)" OptionGroup="07 - AGROPECUARIA (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem137" runat="server" Value="720 - Sanidad animal" Text="720 - Sanidad animal" OptionGroup="07 - AGROPECUARIA (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem138" runat="server" Value="721 - Enfermedades infecciosas bacterianas" Text="721 - Enfermedades infecciosas bacterianas" OptionGroup="07 - AGROPECUARIA (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem139" runat="server" Value="722 - Enfermedades infecciosas trasmitidas por artropodo" Text="722 - Enfermedades infecciosas trasmitidas por artrópodo" OptionGroup="07 - AGROPECUARIA (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem140" runat="server" Value="723 - Enfermedades de virus" Text="723 - Enfermedades de virus" OptionGroup="07 - AGROPECUARIA (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem141" runat="server" Value="724 - Enfermedades parasitarias" Text="724 - Enfermedades parasitarias" OptionGroup="07 - AGROPECUARIA (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem142" runat="server" Value="725 - Enfermedades no transmisibles" Text="725 - Enfermedades no transmisibles" OptionGroup="07 - AGROPECUARIA (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem143" runat="server" Value="726 - Proteccion y asistencia veterinaria" Text="726 - Protección y asistencia veterinaria" OptionGroup="07 - AGROPECUARIA (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem144" runat="server" Value="727 - Prevencion y profilaxis" Text="727 - Prevención y profilaxis" OptionGroup="07 - AGROPECUARIA (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem145" runat="server" Value="729 - Otros –Sanidad animal- (Especificar)" Text="729 - Otros –Sanidad animal- (Especificar)" OptionGroup="07 - AGROPECUARIA (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem146" runat="server" Value="730 - Produccion vegetal" Text="730 - Producción vegetal" OptionGroup="07 - AGROPECUARIA (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem147" runat="server" Value="731 - Cereales" Text="731 - Cereales" OptionGroup="07 - AGROPECUARIA (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem148" runat="server" Value="732 - Oleaginosos" Text="732 - Oleaginosos" OptionGroup="07 - AGROPECUARIA (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem149" runat="server" Value="733 - Cultivos industriales excepto oleaginosos(caña de" Text="733 - Cultivos industriales excepto oleaginosos(caña de" OptionGroup="07 - AGROPECUARIA (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem150" runat="server" Value="734 - Semillas" Text="734 - Semillas" OptionGroup="07 - AGROPECUARIA (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem151" runat="server" Value="735 - Frutas" Text="735 - Frutas" OptionGroup="07 - AGROPECUARIA (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem152" runat="server" Value="736 - Hortalizas" Text="736 - Hortalizas" OptionGroup="07 - AGROPECUARIA (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem153" runat="server" Value="737 - Pasturas" Text="737 - Pasturas" OptionGroup="07 - AGROPECUARIA (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem154" runat="server" Value="738 - Forrajes" Text="738 - Forrajes" OptionGroup="07 - AGROPECUARIA (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem155" runat="server" Value="739 - Otros –Produccion vegetal- (Especificar)" Text="739 - Otros –Producción vegetal- (Especificar)" OptionGroup="07 - AGROPECUARIA (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem156" runat="server" Value="740 - Sanidad vegetal" Text="740 - Sanidad vegetal" OptionGroup="07 - AGROPECUARIA (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem157" runat="server" Value="741 - Plagas" Text="741 - Plagas" OptionGroup="07 - AGROPECUARIA (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem158" runat="server" Value="742 - Prevencion" Text="742 - Prevención" OptionGroup="07 - AGROPECUARIA (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem159" runat="server" Value="749 - Otros –Sanidad vegetal- (Especificar)" Text="749 - Otros –Sanidad vegetal- (Especificar)" OptionGroup="07 - AGROPECUARIA (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem160" runat="server" Value="750 - Produccion y sanidad forestal" Text="750 - Producción y sanidad forestal" OptionGroup="07 - AGROPECUARIA (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem161" runat="server" Value="751 - Forestacion" Text="751 - Forestación" OptionGroup="07 - AGROPECUARIA (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem162" runat="server" Value="752 - Proteccion de bosques" Text="752 - Protección de bosques" OptionGroup="07 - AGROPECUARIA (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem163" runat="server" Value="753 - Tecnicas forestales" Text="753 - Técnicas forestales" OptionGroup="07 - AGROPECUARIA (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem164" runat="server" Value="759 - Otros –Produccion y san. forestal- (Especificar)" Text="759 - Otros –Producción y san. forestal- (Especificar)" OptionGroup="07 - AGROPECUARIA (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem165" runat="server" Value="760 - Servicios agropecuarios" Text="760 - Servicios agropecuarios" OptionGroup="07 - AGROPECUARIA (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem166" runat="server" Value="761 - Labores culturales" Text="761 - Labores culturales" OptionGroup="07 - AGROPECUARIA (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem167" runat="server" Value="762 - Cosecha" Text="762 - Cosecha" OptionGroup="07 - AGROPECUARIA (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem168" runat="server" Value="763 - Faenamiento y esquila" Text="763 - Faenamiento y esquila" OptionGroup="07 - AGROPECUARIA (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem169" runat="server" Value="764 - Tecnica de fertilizacion y saneamiento" Text="764 - Técnica de fertilización y saneamiento" OptionGroup="07 - AGROPECUARIA (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem170" runat="server" Value="765 - Almacenamiento" Text="765 - Almacenamiento" OptionGroup="07 - AGROPECUARIA (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem171" runat="server" Value="766 - Preindustrializacion (tecnica de conservacion, emp" Text="766 - Preindustrialización (técnica de conservación, emp" OptionGroup="07 - AGROPECUARIA (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem172" runat="server" Value="767 - Comercializacion" Text="767 - Comercialización" OptionGroup="07 - AGROPECUARIA (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem173" runat="server" Value="769 - Otros –Servicios agropecuarios- (Especificar)" Text="769 - Otros –Servicios agropecuarios- (Especificar)" OptionGroup="07 - AGROPECUARIA (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem174" runat="server" Value="770 - Proteccion agropecuaria" Text="770 - Protección agropecuaria" OptionGroup="07 - AGROPECUARIA (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem175" runat="server" Value="771 - Sistemas de riego (ver 0434)" Text="771 - Sistemas de riego (ver 0434)" OptionGroup="07 - AGROPECUARIA (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem176" runat="server" Value="772 - Lucha antigranizo" Text="772 - Lucha antigranizo" OptionGroup="07 - AGROPECUARIA (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem177" runat="server" Value="773 - Lucha contra heladas" Text="773 - Lucha contra heladas" OptionGroup="07 - AGROPECUARIA (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem178" runat="server" Value="779 - Otros –Proteccion agropecuaria- (Especificar)" Text="779 - Otros –Protección agropecuaria- (Especificar)" OptionGroup="07 - AGROPECUARIA (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem179" runat="server" Value="799 - Otros –AGROPECUARIA- (Especificar)" Text="799 - Otros –AGROPECUARIA- (Especificar)" OptionGroup="07 - AGROPECUARIA (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem180" runat="server" Value="800 - Varios –INDUSTRIAL- (Especificar)" Text="800 - Varios –INDUSTRIAL- (Especificar)" OptionGroup="08 - INDUSTRIAL (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem181" runat="server" Value="810 - Alimentos, bebidas y tabaco" Text="810 - Alimentos, bebidas y tabaco" OptionGroup="08 - INDUSTRIAL (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem182" runat="server" Value="811 - Carnes y derivados" Text="811 - Carnes y derivados" OptionGroup="08 - INDUSTRIAL (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem183" runat="server" Value="812 - Productos lacteos" Text="812 - Productos lácteos" OptionGroup="08 - INDUSTRIAL (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem184" runat="server" Value="813 - Productos agrarios (excepto bebidas)" Text="813 - Productos agrarios (excepto bebidas)" OptionGroup="08 - INDUSTRIAL (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem185" runat="server" Value="814 - Productos marinos" Text="814 - Productos marinos" OptionGroup="08 - INDUSTRIAL (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem186" runat="server" Value="815 - Dulces y confituras" Text="815 - Dulces y confituras" OptionGroup="08 - INDUSTRIAL (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem187" runat="server" Value="816 - Industrias vinicolas" Text="816 - Industrias vinícolas" OptionGroup="08 - INDUSTRIAL (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem188" runat="server" Value="817 - Otras bebidas" Text="817 - Otras bebidas" OptionGroup="08 - INDUSTRIAL (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem189" runat="server" Value="818 - Tabaco" Text="818 - Tabaco" OptionGroup="08 - INDUSTRIAL (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem190" runat="server" Value="819 - Otros –Alimentos, bebidas y tabaco- (Especificar)" Text="819 - Otros –Alimentos, bebidas y tabaco- (Especificar)" OptionGroup="08 - INDUSTRIAL (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem191" runat="server" Value="820 - Textiles, vestidos y cueros" Text="820 - Textiles, vestidos y cueros" OptionGroup="08 - INDUSTRIAL (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem192" runat="server" Value="821 - Textiles" Text="821 - Textiles" OptionGroup="08 - INDUSTRIAL (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem193" runat="server" Value="822 - Industrializacion del cuero y pieles (excepto confeccion)" Text="822 - Industrialización del cuero y pieles (excepto confección)" OptionGroup="08 - INDUSTRIAL (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem194" runat="server" Value="823 - Vestidos" Text="823 - Vestidos" OptionGroup="08 - INDUSTRIAL (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem195" runat="server" Value="824 - Calzado" Text="824 - Calzado" OptionGroup="08 - INDUSTRIAL (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem196" runat="server" Value="829 - Otros –Textiles, vestidos y cueros- (Especificar)" Text="829 - Otros –Textiles, vestidos y cueros- (Especificar)" OptionGroup="08 - INDUSTRIAL (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem197" runat="server" Value="830 - Madera y corcho" Text="830 - Madera y corcho" OptionGroup="08 - INDUSTRIAL (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem198" runat="server" Value="831 - Aserraderos y talleres" Text="831 - Aserraderos y talleres" OptionGroup="08 - INDUSTRIAL (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem199" runat="server" Value="832 - Muebles y accesorios" Text="832 - Muebles y accesorios" OptionGroup="08 - INDUSTRIAL (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem200" runat="server" Value="833 - Fabricacion de envases" Text="833 - Fabricación de envases" OptionGroup="08 - INDUSTRIAL (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem201" runat="server" Value="839 - Otros –Madera y corcho- (Especificar)" Text="839 - Otros –Madera y corcho- (Especificar)" OptionGroup="08 - INDUSTRIAL (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem202" runat="server" Value="840 - Celulosa y papel" Text="840 - Celulosa y papel" OptionGroup="08 - INDUSTRIAL (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem203" runat="server" Value="841 - Industrias celulosicas (pulpa, papel, carton, etc.)" Text="841 - Industrias celulósicas (pulpa, papel, cartón, etc.)" OptionGroup="08 - INDUSTRIAL (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem204" runat="server" Value="842 - Fabricacion de envases" Text="842 - Fabricación de envases" OptionGroup="08 - INDUSTRIAL (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem205" runat="server" Value="843 - Imprentas y editoriales" Text="843 - Imprentas y editoriales" OptionGroup="08 - INDUSTRIAL (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem206" runat="server" Value="849 - Otros –Celulosa y papel- (Especificar)" Text="849 - Otros –Celulosa y papel- (Especificar)" OptionGroup="08 - INDUSTRIAL (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem207" runat="server" Value="850 - Quimica, petroquimica y carboquimica" Text="850 - Química, petroquímica y carboquímica" OptionGroup="08 - INDUSTRIAL (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem208" runat="server" Value="851 - Petroquimica" Text="851 - Petroquímica" OptionGroup="08 - INDUSTRIAL (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem209" runat="server" Value="852 - Carboquimica" Text="852 - Carboquímica" OptionGroup="08 - INDUSTRIAL (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem210" runat="server" Value="853 - Industria del caucho" Text="853 - Industria del caucho" OptionGroup="08 - INDUSTRIAL (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem211" runat="server" Value="854 - Fertilizantes y plaguicidas" Text="854 - Fertilizantes y plaguicidas" OptionGroup="08 - INDUSTRIAL (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem212" runat="server" Value="855 - Medicamentos. Industria farmaceutica (ver 0574)" Text="855 - Medicamentos. Industria farmacéutica (ver 0574)" OptionGroup="08 - INDUSTRIAL (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem213" runat="server" Value="856 - Pinturas y revestimientos (lacas, barnices, etc.)" Text="856 - Pinturas y revestimientos (lacas, barnices, etc.)" OptionGroup="08 - INDUSTRIAL (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem214" runat="server" Value="857 - Perfumes, cosmeticos, jabones, etc." Text="857 - Perfumes, cosméticos, jabones, etc." OptionGroup="08 - INDUSTRIAL (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem215" runat="server" Value="858 - Sustancias quimicas basicas (resinas, sinteticas)" Text="858 - Sustancias químicas básicas (resinas, sintéticas)" OptionGroup="08 - INDUSTRIAL (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem216" runat="server" Value="859 - Otros –Quim., petroq. y carboq.- (Especificar)" Text="859 - Otros –Quím., petroq. y carboq.- (Especificar)" OptionGroup="08 - INDUSTRIAL (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem217" runat="server" Value="860 - Minerales no metalicos (excepto petroleo y carbon)" Text="860 - Minerales no metálicos (excepto petróleo y carbón)" OptionGroup="08 - INDUSTRIAL (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem218" runat="server" Value="861 - Vidrio" Text="861 - Vidrio" OptionGroup="08 - INDUSTRIAL (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem219" runat="server" Value="862 - Barro, loza y porcelana" Text="862 - Barro, loza y porcelana" OptionGroup="08 - INDUSTRIAL (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem220" runat="server" Value="863 - Materiales para construccion (cemento, cal, etc.)" Text="863 - Materiales para construcción (cemento, cal, etc.)" OptionGroup="08 - INDUSTRIAL (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem221" runat="server" Value="869 - Otros –Minerales no metalicos- (Especificar)" Text="869 - Otros –Minerales no metálicos- (Especificar)" OptionGroup="08 - INDUSTRIAL (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem222" runat="server" Value="870 - Metalurgia. Industrias metalicas basicas" Text="870 - Metalurgia. Industrias metálicas básicas" OptionGroup="08 - INDUSTRIAL (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem223" runat="server" Value="871 - Metales ferrosos" Text="871 - Metales ferrosos" OptionGroup="08 - INDUSTRIAL (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem224" runat="server" Value="872 - Metales no ferrosos (excepto uranio y otros radiactivos)" Text="872 - Metales no ferrosos (excepto uranio y otros radiactivos)" OptionGroup="08 - INDUSTRIAL (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem225" runat="server" Value="873 - Metales radiactivos (uranio, torio, etc.)" Text="873 - Metales radiactivos (uranio, torio, etc.)" OptionGroup="08 - INDUSTRIAL (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem226" runat="server" Value="879 - Otros –Metal. Ind. met. basicas- (Especificar)" Text="879 - Otros –Metal. Ind. met. básicas- (Especificar)" OptionGroup="08 - INDUSTRIAL (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem227" runat="server" Value="880 - Productos metalicos, maquinaria y equipos" Text="880 - Productos metálicos, maquinaria y equipos" OptionGroup="08 - INDUSTRIAL (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem228" runat="server" Value="881 - Productos metalicos (excepto maquinarias y equipos)" Text="881 - Productos metálicos (excepto maquinarias y equipos)" OptionGroup="08 - INDUSTRIAL (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem229" runat="server" Value="882 - Maquinaria (excepto electrica)" Text="882 - Maquinaria (excepto eléctrica)" OptionGroup="08 - INDUSTRIAL (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem230" runat="server" Value="883 - Productos y maquinarias electrica (excepto electronica)" Text="883 - Productos y maquinarias eléctrica (excepto electrónica)" OptionGroup="08 - INDUSTRIAL (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem231" runat="server" Value="884 - Componentes electronicos" Text="884 - Componentes electrónicos" OptionGroup="08 - INDUSTRIAL (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem232" runat="server" Value="885 - Equipos de procesamiento (hardware)" Text="885 - Equipos de procesamiento (hardware)" OptionGroup="08 - INDUSTRIAL (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem233" runat="server" Value="886 - Equipos de comunicacion, audio y television" Text="886 - Equipos de comunicación, audio y televisión" OptionGroup="08 - INDUSTRIAL (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem234" runat="server" Value="887 - Equipos de transporte" Text="887 - Equipos de transporte" OptionGroup="08 - INDUSTRIAL (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem235" runat="server" Value="888 - Equipos e instrumentos cientificos de medicion y control" Text="888 - Equipos e instrumentos científicos de medición y control" OptionGroup="08 - INDUSTRIAL (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem236" runat="server" Value="889 - Otros –Prod. met., maquinaria y equip.- (Especificar)" Text="889 - Otros –Prod. met., maquinaria y equip.- (Especificar)" OptionGroup="08 - INDUSTRIAL (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem237" runat="server" Value="899 - Otros –INDUSTRIAL- (Especificar)" Text="899 - Otros –INDUSTRIAL- (Especificar)" OptionGroup="08 - INDUSTRIAL (Producción y tecnología)" />
                        <cc1:OptionGroupItem ID="OptionGroupItem238" runat="server" Value="900 - Varios –DES. SOCIOEC. Y SERVICIOS- (Especificar)" Text="900 - Varios –DES. SOCIOEC. Y SERVICIOS- (Especificar)" OptionGroup="09 - DESARROLLO SOCIOECONÓMICO Y SERVICIOS" />
                        <cc1:OptionGroupItem ID="OptionGroupItem239" runat="server" Value="910 - Organizacion y administracion del desarrollo" Text="910 - Organización y administración del desarrollo" OptionGroup="09 - DESARROLLO SOCIOECONÓMICO Y SERVICIOS" />
                        <cc1:OptionGroupItem ID="OptionGroupItem240" runat="server" Value="920 - Politica y planificacion del desarrollo" Text="920 - Política y planificación del desarrollo" OptionGroup="09 - DESARROLLO SOCIOECONÓMICO Y SERVICIOS" />
                        <cc1:OptionGroupItem ID="OptionGroupItem241" runat="server" Value="930 - Condiciones de trabajo" Text="930 - Condiciones de trabajo" OptionGroup="09 - DESARROLLO SOCIOECONÓMICO Y SERVICIOS" />
                        <cc1:OptionGroupItem ID="OptionGroupItem242" runat="server" Value="940 - Desarrollo de los servicios socioeconomicos (nivel" Text="940 - Desarrollo de los servicios socioeconómicos (nivel" OptionGroup="09 - DESARROLLO SOCIOECONÓMICO Y SERVICIOS" />
                        <cc1:OptionGroupItem ID="OptionGroupItem243" runat="server" Value="950 - Organizacion politica, legal e institucional" Text="950 - Organización política, legal e institucional" OptionGroup="09 - DESARROLLO SOCIOECONÓMICO Y SERVICIOS" />
                        <cc1:OptionGroupItem ID="OptionGroupItem244" runat="server" Value="960 - Relaciones internacionales" Text="960 - Relaciones internacionales" OptionGroup="09 - DESARROLLO SOCIOECONÓMICO Y SERVICIOS" />
                        <cc1:OptionGroupItem ID="OptionGroupItem245" runat="server" Value="970 - Comercio. Sistemas de comercializacion" Text="970 - Comercio. Sistemas de comercialización" OptionGroup="09 - DESARROLLO SOCIOECONÓMICO Y SERVICIOS" />
                        <cc1:OptionGroupItem ID="OptionGroupItem246" runat="server" Value="999 - Otros –DES. SOCIOEC. Y SERVICIOS- (Especificar)" Text="999 - Otros –DES. SOCIOEC. Y SERVICIOS- (Especificar)" OptionGroup="09 - DESARROLLO SOCIOECONÓMICO Y SERVICIOS" />
                        <cc1:OptionGroupItem ID="OptionGroupItem247" runat="server" Value="1000 - Varios –DES. EDUC., CIENCIA Y CULT.- (Especificar)" Text="1000 - Varios –DES. EDUC., CIENCIA Y CULT.- (Especificar)" OptionGroup="10 - DESARROLLO DE LA EDUCACIÓN, LA CIENCIA Y LA CULTURA" />
                        <cc1:OptionGroupItem ID="OptionGroupItem248" runat="server" Value="1010 - Sistema educativo (organizacion, administracion y" Text="1010 - Sistema educativo (organización, administración y" OptionGroup="10 - DESARROLLO DE LA EDUCACIÓN, LA CIENCIA Y LA CULTURA" />
                        <cc1:OptionGroupItem ID="OptionGroupItem249" runat="server" Value="1020 - Politica y planificacion educativa" Text="1020 - Política y planificación educativa" OptionGroup="10 - DESARROLLO DE LA EDUCACIÓN, LA CIENCIA Y LA CULTURA" />
                        <cc1:OptionGroupItem ID="OptionGroupItem250" runat="server" Value="1030 - Metodologia de la educacion" Text="1030 - Metodología de la educación" OptionGroup="10 - DESARROLLO DE LA EDUCACIÓN, LA CIENCIA Y LA CULTURA" />
                        <cc1:OptionGroupItem ID="OptionGroupItem251" runat="server" Value="1040 - Ciencia y tecnologia" Text="1040 - Ciencia y tecnología" OptionGroup="10 - DESARROLLO DE LA EDUCACIÓN, LA CIENCIA Y LA CULTURA" />
                        <cc1:OptionGroupItem ID="OptionGroupItem252" runat="server" Value="1050 - Informacion y documentacion" Text="1050 - Información y documentación" OptionGroup="10 - DESARROLLO DE LA EDUCACIÓN, LA CIENCIA Y LA CULTURA" />
                        <cc1:OptionGroupItem ID="OptionGroupItem253" runat="server" Value="1060 - Cultura" Text="1060 - Cultura" OptionGroup="10 - DESARROLLO DE LA EDUCACIÓN, LA CIENCIA Y LA CULTURA" />
                        <cc1:OptionGroupItem ID="OptionGroupItem254" runat="server" Value="1099 - Otros –DES. EDUC., CIENCIA Y CULT.- (Especificar)" Text="1099 - Otros –DES. EDUC., CIENCIA Y CULT.- (Especificar)" OptionGroup="10 - DESARROLLO DE LA EDUCACIÓN, LA CIENCIA Y LA CULTURA" />
                        <cc1:OptionGroupItem ID="OptionGroupItem255" runat="server" Value="1110 - Ciencia exactas y naturales" Text="1110 - Ciencia exactas y naturales" OptionGroup="11 - PROMOCIÓN GENERAL DEL CONOCIMIENTO" />
                        <cc1:OptionGroupItem ID="OptionGroupItem256" runat="server" Value="1120 - Ciencias de la ingenieria y arquitectura" Text="1120 - Ciencias de la ingeniería y arquitectura" OptionGroup="11 - PROMOCIÓN GENERAL DEL CONOCIMIENTO" />
                        <cc1:OptionGroupItem ID="OptionGroupItem257" runat="server" Value="1130 - Ciencias medicas" Text="1130 - Ciencias médicas" OptionGroup="11 - PROMOCIÓN GENERAL DEL CONOCIMIENTO" />
                        <cc1:OptionGroupItem ID="OptionGroupItem258" runat="server" Value="1140 - Ciencias agropecuarias y veterinarias" Text="1140 - Ciencias agropecuarias y veterinarias" OptionGroup="11 - PROMOCIÓN GENERAL DEL CONOCIMIENTO" />
                        <cc1:OptionGroupItem ID="OptionGroupItem259" runat="server" Value="1150 - Ciencias Sociales" Text="1150 - Ciencias Sociales" OptionGroup="11 - PROMOCIÓN GENERAL DEL CONOCIMIENTO" />
                        <cc1:OptionGroupItem ID="OptionGroupItem260" runat="server" Value="1160 - Ciencias humanas" Text="1160 - Ciencias humanas" OptionGroup="11 - PROMOCIÓN GENERAL DEL CONOCIMIENTO" />
                        <cc1:OptionGroupItem ID="OptionGroupItem261" runat="server" Value="1170 - Otras ciencias (Especificar)" Text="1170 - Otras ciencias (Especificar)" OptionGroup="11 - PROMOCIÓN GENERAL DEL CONOCIMIENTO" />
                        <cc1:OptionGroupItem ID="OptionGroupItem262" runat="server" Value="1180 - Varias ciencias (Especificar)" Text="1180 - Varias ciencias (Especificar)" OptionGroup="11 - PROMOCIÓN GENERAL DEL CONOCIMIENTO" />
                        <cc1:OptionGroupItem ID="OptionGroupItem263" runat="server" Value="1190 - No corresponde (Especificar)" Text="1190 - No corresponde (Especificar)" OptionGroup="11 - PROMOCIÓN GENERAL DEL CONOCIMIENTO" />
                        <cc1:OptionGroupItem ID="OptionGroupItem264" runat="server" Value="1200 - OTROS CAMPOS (Especificar)" Text="1200 - OTROS CAMPOS (Especificar)" OptionGroup="12 - OTROS" />
                        <cc1:OptionGroupItem ID="OptionGroupItem265" runat="server" Value="1300 - VARIOS CAMPOS (Especificar)" Text="1300 - VARIOS CAMPOS (Especificar)" OptionGroup="13 - VARIOS" />
                    </cc1:OptionGroupSelect>
                </div>
            </div>
        </div>
        <div class="col-md-2">
            <button type="button" class="btn btn-default pull-right" id="btn_agregar_tesina" runat="server" onserverclick="btn_agregar_tesina_ServerClick">
                <span class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span>Nueva Tesina
            </button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <label runat="server" id="lbl_categoria_seleccionada" style="color: #333;"></label>
            <div class="alert alert-warning" role="alert" runat="server" id="lbl_no_existen_tesinas_con_ese_filtro">
                <p>No existen tesinas asociadas a la categoria seleccionada.</p>
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <asp:GridView ID="gv_tesinas" runat="server" OnPreRender="gv_tesinas_PreRender"
                AutoGenerateColumns="False" GridLines="None" CssClass="display">
                <Columns>
                    <asp:BoundField DataField="prioridad_orden" HeaderText="Orden" ReadOnly="true" />
                    <asp:BoundField DataField="tesista" HeaderText="Tesista" ReadOnly="true" />
                    <asp:BoundField DataField="categoria" HeaderText="Categoria" ReadOnly="true" />
                    <asp:TemplateField HeaderText="Título">
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server"
                                ToolTip='<%# Eval("tema_completo") %>'
                                Text='<%# Eval("tema_recortado") %>'>
                            </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="estado" HeaderText="Estado" ReadOnly="true" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <button runat="server" class="btn btn-sm btn-default" id="btn_ver" causesvalidation="false" onserverclick="btn_ver_ServerClick" data-id='<%#Eval("tesis_id")%>'>
                                <span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span>&nbsp;Ver-Tratar
                            </button>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <button runat="server" class="btn btn-sm btn-warning" id="btn_editar" causesvalidation="false" onserverclick="btn_editar_ServerClick" data-id='<%#Eval("tesis_id")%>'>
                                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>&nbsp;Editar
                            </button>
                            <button
                                type="button" class="btn btn-sm btn-danger"
                                data-toggle="modal"
                                data-target="#advertencia_eliminacion"
                                data-id='<%#Eval("tesis_id")%>'
                                data-introduccion="la tesina del tesista"
                                data-nombre='<%#Eval("tesista")%>'>
                                <span class="glyphicon glyphicon-remove-circle" aria-hidden="true"></span>&nbsp;Eliminar
                            </button>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

            <div class="modal fade" id="advertencia_eliminacion" role="dialog" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content panel-danger">
                        <div class="modal-header panel-heading">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title panel-title" style="color: white; font-weight: bold;">ATENCIÓN!!</h4>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-md-12">
                                    <input type="hidden" runat="server" id="id_item_por_eliminar" />
                                    <p id="texto_a_mostrar"></p>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <asp:Button Text="Aceptar" CssClass="btn btn-primary" CausesValidation="false" ID="btn_aceptar_eliminacion" OnClick="btn_aceptar_eliminacion_Click" runat="server" />
                            <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="panel_ver_tesina" role="dialog" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content panel-default">
                        <div class="modal-header panel-heading">
                            <h3 class="panel-title text-center">
                                <asp:Label Text="" ID="lbl_tema" runat="server" /></h3>
                            <h3 class="modal-title panel-title text-center"><small>
                                <asp:Label Text="" ID="lbl_descripcion" runat="server" /></small></h3>
                        </div>
                        <div class="modal-body">
                            <asp:HiddenField runat="server" ID="hidden_tesina_id" />
                            <div class="row">
                                <div class="col-md-4">
                                    <strong>Tesista:</strong>
                                    <asp:Label Text="" ID="lbl_tesista" runat="server" />
                                </div>
                                <div class="col-md-4">
                                    <strong>Director:</strong>
                                    <asp:Label Text="" ID="lbl_director" runat="server" />
                                </div>
                                <div class="col-md-4">
                                    <strong>Co-Director:</strong>
                                    <asp:Label Text="" ID="lbl_codirector" runat="server" />
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-4">
                                    <strong>Fecha de inicio:</strong>
                                    <asp:Label Text="" ID="lbl_alta" runat="server" />
                                </div>
                                <div class="col-md-4">
                                    <strong>Duración:</strong>
                                    <asp:Label Text="" ID="lbl_duracion" runat="server" />
                                </div>
                                <div class="col-md-4">
                                    <strong>Notificaciones cada:</strong>
                                    <asp:Label Text="" ID="lbl_periodo_notificaciones" runat="server" />
                                </div>
                            </div>

                            <div class="row">

                                <div class="col-md-4">
                                    <strong>Calificación final Tesina:</strong>
                                    <asp:Label Text="" ID="lbl_calificacion" runat="server" />
                                </div>
                                <div class="col-md-4">
                                    <strong>Calificación Director:</strong>
                                    <asp:Label Text="" ID="lbl_calificacion_director" runat="server" />
                                </div>
                                <div class="col-md-4">
                                    <strong>Calificación Co-Director:</strong>
                                    <asp:Label Text="" ID="lbl_calificacion_codirector" runat="server" />
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <strong>Estado:</strong>
                                    <asp:Label Text="" ID="lbl_estado" runat="server" />
                                </div>
                                <div class="col-md-8">
                                    <strong>Observaciones:</strong>
                                    <asp:Label Text="" ID="lbl_observaciones_estado" runat="server" />
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <strong>Plan Tesina:</strong> <a href="#" target="_blank" runat="server" id="lbl_plan_tesina">sin presentar</a>
                                </div>
                                <div class="col-md-6">
                                    <strong>Archivo Tesina:</strong> <a href="#" target="_blank" runat="server" id="lbl_archivo_subido">sin presentar</a>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <strong>Jurado: </strong>
                                    <asp:Label Text="" ID="lbl_jueces_tesina_visualizacion" runat="server" />
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <u><strong>Historial de estados</strong></u>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <asp:GridView ID="gv_historial" runat="server" OnPreRender="gv_tesinas_PreRender"
                                        AutoGenerateColumns="False" GridLines="None" CssClass="display compact black">
                                        <Columns>
                                            <asp:BoundField DataField="fecha" HeaderText="Fecha" DataFormatString="{0:d}" ReadOnly="true" />
                                            <asp:BoundField DataField="estado" HeaderText="Estado" ReadOnly="true" />
                                            <asp:BoundField DataField="observacion_completa" HeaderText="Observaciones" ReadOnly="true" />
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </div>

                        </div>
                        <div class="modal-footer">
                            <div class="row">
                                <div class="col-md-10 text-right">
                                    <div class="btn-group" role="group" aria-label="...">
                                        <button type="button" class="btn btn-default" runat="server" id="btn_realizar_entrega" onserverclick="btn_realizar_entrega_ServerClick" title="Sube un nuevo archivo de tesina.">Realizar entrega</button>
                                        <button type="button" class="btn btn-default" data-toggle="modal" runat="server" id="btn_lista_para_presentar" data-target="#lista_para_presentar" title="Pasa al estado lista para presentar, no se puede editar más.">Lista para presentar</button>
                                        <button type="button" class="btn btn-default" data-toggle="modal" runat="server" id="btn_devolver_para_corregir" data-target="#devolver_a_corregir" title="Rechaza la entrega y para al estado A Corregir.">Devolver a corregir</button>
                                        <button type="button" class="btn btn-default" data-toggle="modal" runat="server" id="btn_prorroga" data-target="#generar_prorroga" title="Modifica los valores de la tesina y la deja con estado prorroga.">Prorroga</button>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="realizar_entrega" role="dialog" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">Pasar a estado Entregada</h4>
                        </div>
                        <div class="modal-body">
                            <p>Suba el archivo de tesina para que el mismo esté disponible para su corrección por parte del Director.</p>
                            <p>Una vez guardado el cambio no podrá editar el archivo.</p>
                            <h4>Archivo:</h4>
                            <asp:FileUpload runat="server" ID="file_tesis" />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="file_tesis" ErrorMessage="Únicamente archivos .pdf, .doc, .docx" ValidationExpression="^.*\.(doc|DOC|pdf|PDF|docx|DOCX)$"></asp:RegularExpressionValidator>
                        </div>
                        <div class="modal-footer">
                            <asp:Button Text="Subir archivo" runat="server" ID="btn_subir_archivo" CssClass="btn btn-success" OnClick="btn_subir_archivo_Click" />
                            <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="devolver_a_corregir" role="dialog" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">Observar entrega</h4>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-md-12">
                                    <asp:ValidationSummary ID="validation_summary" runat="server" DisplayMode="BulletList" ValidationGroup="rechazar"
                                        CssClass="validationsummary panel panel-danger" HeaderText="<div class='panel-heading'>&nbsp;Corrija los siguientes errores antes de continuar:</div>" />
                                </div>
                            </div>
                            <p>El archivo de tesina que subio el tesista no esta apto para su presentación.</p>
                            <p>Seleccione cual de las opciones se ajusta al observar la entrega</p>
                            <div class="row" runat="server" id="div_descripcion">
                                <div class="col-md-11">
                                    <%--<textarea runat="server" id="tb_descripcion_rechazo" rows="2" class="form-control" placeholder="Ingrese las observaciones del cambio de estado.-"></textarea>--%>
                                    <asp:RadioButton Text="Esta correcto, continuar" GroupName="opciones_rechazo" runat="server" ID="opcion_1" CssClass="form-control" Checked="true" />
                                    <asp:RadioButton Text="Tiene errores, se envian las correcciones por mail" GroupName="opciones_rechazo" runat="server" ID="opcion_2" CssClass="form-control" />
                                    <asp:RadioButton Text="Tiene errores, rehacer" GroupName="opciones_rechazo" runat="server" ID="opcion_3" CssClass="form-control" />
                                </div>
                                <%--<div class="col-md-1">
                                    <asp:RequiredFieldValidator ControlToValidate="tb_descripcion_rechazo" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                        ID="RequiredFieldValidator3" runat="server" ErrorMessage="Debe ingresar las observaciones para poder continuar" ValidationGroup="rechazar">
                                    </asp:RequiredFieldValidator>
                                </div>--%>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <asp:Button Text="Enviar a corregir!" CssClass="btn btn-success" ID="btn_enviar_a_corregir" OnClick="btn_enviar_a_corregir_Click" ValidationGroup="rechazar" runat="server" />
                            <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="lista_para_presentar" role="dialog" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">Lista para presentar</h4>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-md-12">
                                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" DisplayMode="BulletList" ValidationGroup="lista_par_presentar"
                                        CssClass="validationsummary panel panel-danger" HeaderText="<div class='panel-heading'>&nbsp;Corrija los siguientes errores antes de continuar:</div>" />
                                </div>
                            </div>
                            <p>El archivo de tesina que subio el tesista esta apto para su presentación.</p>
                        </div>
                        <div class="modal-footer">
                            <asp:Button Text="Lista para evaluar!" CssClass="btn btn-success" ID="btn_pasar_a_lista_para_presentar" OnClick="btn_pasar_a_lista_para_presentar_Click" ValidationGroup="lista_par_presentar" runat="server" />
                            <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="generar_prorroga" role="dialog" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">Cargar prorroga</h4>
                        </div>
                        <div class="modal-body">
                            <div class="col-md-12">
                                <asp:ValidationSummary ID="ValidationSummary2" runat="server" DisplayMode="BulletList" ValidationGroup="prorroga"
                                    CssClass="validationsummary panel panel-danger" HeaderText="<div class='panel-heading'>&nbsp;Corrija los siguientes errores antes de continuar:</div>" />
                            </div>
                            <%--FECHA INICIO--%>
                            <div class="row" runat="server" id="div_fecha_inicio">
                                <div class="col-md-2">Fecha inicio</div>
                                <div class="col-md-9">
                                    <div class='input-group date' id='datetimepicker1'>
                                        <input type='text' runat="server" id="tb_fecha_inicio" class="form-control" />
                                        <span class="input-group-addon">
                                            <span class="glyphicon glyphicon-calendar"></span>
                                        </span>
                                    </div>
                                </div>
                                <div class="col-md-1">
                                    <asp:RequiredFieldValidator ControlToValidate="tb_fecha_inicio" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                        ID="RequiredFieldValidator2" runat="server" ErrorMessage="Debe ingresar la fecha de inicio de la tesina" ValidationGroup="prorroga">
                                    </asp:RequiredFieldValidator>
                                    <asp:CustomValidator ControlToValidate="tb_fecha_inicio" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                        ID="cv_fecha_inicio" runat="server" ErrorMessage="Debe ingresar una fecha válida" OnServerValidate="cv_fecha_inicio_ServerValidate" ValidationGroup="prorroga" />
                                </div>
                            </div>

                            <br />
                            <%--DURACION MESES PERIODO ENTRE NOTIFICACIONES--%>
                            <div class="row" runat="server" id="div_duracion_y_notificaciones">
                                <div class="col-md-2">Plazo</div>
                                <div class="col-md-3">
                                    <div class="input-group">
                                        <input type="text" class="form-control" runat="server" id="tb_duracion" />
                                        <span class="input-group-addon">meses</span>
                                    </div>
                                </div>
                                <div class="col-md-1">
                                    <asp:RequiredFieldValidator ControlToValidate="tb_duracion" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                        ID="RequiredFieldValidator4" runat="server" ErrorMessage="Debe ingresar los meses de duración para la entrega final de la tesina" ValidationGroup="prorroga">
                                    </asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ValidationExpression="\d{1,2}" ControlToValidate="tb_duracion" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                        ID="RegularExpressionValidator2" runat="server" ErrorMessage="Debe ingresar un numero entero de hasta dos dígitos" ValidationGroup="prorroga" />
                                </div>
                                <div class="col-md-2">
                                    Período entre notificaciones
                                </div>
                                <div class="col-md-3">
                                    <div class="input-group">
                                        <input type="text" class="form-control" runat="server" id="tb_notificacion" />
                                        <span class="input-group-addon">meses</span>
                                    </div>
                                </div>
                                <div class="col-md-1">
                                    <asp:RequiredFieldValidator ControlToValidate="tb_notificacion" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                        ID="RequiredFieldValidator5" runat="server" ErrorMessage="Debe ingresar los meses entre recordatorios automáticos" ValidationGroup="prorroga">
                                    </asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ValidationExpression="\d{1}" ControlToValidate="tb_notificacion" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                        ID="RegularExpressionValidator1" runat="server" ErrorMessage="Debe ingresar un numero entero de un dígito" ValidationGroup="prorroga" />
                                    <asp:CustomValidator ControlToValidate="tb_notificacion" Text="<span class='glyphicon glyphicon-exclamation-sign' style='color: red;'></span>"
                                        ID="cv_notificacion" runat="server" ErrorMessage="El valor ingresado debe ser menor o igual a el plazo para la entrega de la tesina" OnServerValidate="cv_notificacion_ServerValidate" ValidationGroup="prorroga" />
                                </div>
                            </div>
                            <br />
                        </div>
                        <div class="modal-footer">
                            <asp:Button Text="Generar prorroga" CssClass="btn btn-success" ID="btn_prorrogar" OnClick="btn_prorrogar_Click" ValidationGroup="prorroga" runat="server" />
                            <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="CPH_Scripts" runat="server">
    <script>

        var d = new Date();
        d.getDate();
        $(function () {
            $('#datetimepicker1').datetimepicker({
                maxDate: d,
                locale: 'es',
                format: 'L'
            });
        });



        $(":file").filestyle({ buttonBefore: false, buttonText: "Seleccionar archivo" });

        $('#advertencia_eliminacion').on('show.bs.modal', function (event) {
            // Button that triggered the modal
            var button = $(event.relatedTarget)
            // Extract info from data-* attributes
            var id = button.data('id')
            var introduccion = button.data('introduccion')
            var nombre = button.data('nombre')
            // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
            var modal = $(this)
            modal.find('.modal-body #' + '<%= id_item_por_eliminar.ClientID %>').val(id)
            modal.find('.modal-body #texto_a_mostrar').text('Esta por eliminar ' + introduccion + ' ' + nombre + '. Esta acción enviará correos de notificación al tesista y su director. Desea continuar?')
        })


        $(document).ready(function () {

            $('select').select2();

            $('#<%= gv_tesinas.ClientID %>').DataTable({
                "scrollY": "400px",
                "scrollCollapse": true,
                "language": {
                    "search": "Buscar:",
                    "emptyTable": "Sin registros",
                    "lengthMenu": "Mostrando _MENU_ registros",
                    "zeroRecords": "No se encontraron registros",
                    "info": "Mostrando _START_ de _END_ de _TOTAL_ registros",
                    "infoEmpty": "No hay registros disponibles",
                    "infoFiltered": "(filtrado de _MAX_ registros totales)",
                    "paginate": {
                        "first": "primero",
                        "last": "último",
                        "next": "próximo",
                        "previous": "anterior"
                    },
                }
            });

            $('#<%= gv_historial.ClientID %>').DataTable({
                "scrollY": "400px",
                "scrollCollapse": true,
                "paging": false,
                "searching": false,
                "language": {
                    "search": "Buscar:",
                    "zeroRecords": "No se encontraron registros",
                    "info": "Mostrando _START_ de _END_ de _TOTAL_ registros",
                    "infoEmpty": "No hay registros disponibles",
                    "infoFiltered": "(filtrado de _MAX_ registros totales)"
                }
            });

        });

        $('#panel_ver_tesina').on('shown.bs.modal', function () {
            var table = $('#<%= gv_historial.ClientID %>').DataTable();
            table.draw();
        });

    </script>

</asp:Content>
