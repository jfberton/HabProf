<%@ Page Language="C#" Async="true" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="WebApplication1._default" %>

<!DOCTYPE html>


<html xmlns="http://www.w3.org/1999/xhtml">
<head>

    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Tesina</title>

    <!-- CSS -->
    <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto:400,100,300,500" />
    <link rel="stylesheet" href="assets-default-login/bootstrap/css/bootstrap.min.css" />
    <link rel="stylesheet" href="assets-default-login/font-awesome/css/font-awesome.min.css" />
    <link rel="stylesheet" href="assets-default-login/css/form-elements.css" />
    <link rel="stylesheet" href="assets-default-login/css/style.css" />

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
            <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
            <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->

    <!-- Favicon and touch icons -->
    <link rel="shortcut icon" href="assets-default-login/ico/UTN.ico" />
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="assets-default-login/ico/apple-touch-icon-144-precomposed.png" />
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="assets-default-login/ico/apple-touch-icon-114-precomposed.png" />
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="assets-default-login/ico/apple-touch-icon-72-precomposed.png" />
    <link rel="apple-touch-icon-precomposed" href="assets-default-login/ico/apple-touch-icon-57-precomposed.png" />

    <!-- Javascript -->
    <script src="assets-default-login/js/jquery-1.11.1.min.js"></script>
    <script src="assets-default-login/bootstrap/js/bootstrap.min.js"></script>
    <script src="assets-default-login/js/jquery.backstretch.min.js"></script>
    <script src="assets-default-login/js/scripts.js"></script>

    <!--[if lt IE 10]>
            <script src="assets/js/placeholder.js"></script>
        <![endif]-->

</head>
<body>


    <!-- Top content -->
    <div class="top-content">
        <div class="inner-bg">
            <div class="container">
                <div class="row">
                    <div class="col-sm-8 col-sm-offset-2 text">
                        <h1><strong>Sistema de Administración de Tesis</strong></h1>
                        <div class="description">
                            <p>
                                <%--Gestión y seguimiento del desarrollo de la Tesina Final de la carrera --%><strong>Licenciatura en Tecnología Educativa</strong>
                                <br />
                                <a href="http://www.frre.utn.edu.ar" target="_blank"><strong>Universidad Tecnológica Nacional - Facultad Regional Resistencia</strong></a>
                            </p>
                        </div>
                    </div>
                </div>


                <div class="row">
                    <div class="col-sm-6 col-sm-offset-3 form-box">
                        <div class="form-top">
                            <div class="form-top-left">
                                <h3 id="texto_titulo">Acceso al sitio</h3>
                                <p id="texto_encabezado">
                                    Ingrese su usuario y contraseña:
                                </p>
                            </div>
                            <div class="form-top-right">
                                <i class="fa fa-lock"></i>
                            </div>
                        </div>
                        <div class="form-bottom">
                            <form id="form1" runat="server" class="login-form">
                                <asp:ScriptManager runat="server" />

                                <div class="tab-content">
                                    <div id="ingreso" class="tab-pane fade in active">
                                        <div class="form-group">
                                            <label class="sr-only" for="form-username">Usuario</label>
                                            <input type="text" runat="server" name="form-username" placeholder="Usuario..." class="form-username form-control" id="form_username" />
                                        </div>
                                        <div class="form-group">
                                            <label class="sr-only" for="form-password">Contraseña</label>
                                            <input type="password" runat="server" name="form-password" placeholder="Contraseña..." class="form-password form-control" id="form_password" />
                                        </div>
                                        <button type="submit" runat="server" id="btn_ingresar" onserverclick="btn_ingresar_ServerClick" class="btn">Ingresar!</button>
                                    </div>
                                    <div id="recuperar" class="tab-pane fade">
                                        <div class="form-group">
                                            <label class="sr-only" for="form-username">Usuario o correo</label>
                                            <input type="text" runat="server" name="form-username" placeholder="Usuario o correo..." class="form-username form-control" id="tb_recuperar_clave" />
                                        </div>
                                        <button type="submit" runat="server" id="btn_recuperar_clave" onserverclick="btn_recuperar_clave_ServerClick" class="btn">Recuperar!</button>
                                    </div>
                                </div>
                                <a data-toggle="tab" href="#recuperar" onclick="Ocultar('recuperar')" id="olvide_mi_clave">Olvide mi clave >></a>
                                <a data-toggle="tab" href="#ingreso" onclick="Ocultar('ingreso')" style="display: none;" id="volver"><< Volver</a>


                                <div class="modal fade" id="modal_perfil" role="dialog" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content panel-default text-center">
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                <h4 class="modal-title">Seleccione el perfil</h4>
                                            </div>
                                            <div class="modal-body">
                                                <asp:HiddenField runat="server" ID="hidden_id_usuario" />
                                                <p>
                                                    <asp:Label Text="" ID="lbl_bienvenida_perfil" runat="server" />
                                                </p>
                                                <p>Usted posee más de un perfil asociado, por favor seleccione con cual de ellos desea ingresar.</p>
                                                <asp:DropDownList runat="server" ID="ddl_perfil" CssClass="form-control">
                                                </asp:DropDownList>
                                            </div>
                                            <div class="modal-footer">
                                                <button id="btn_acceder_con_perfil" runat="server" onserverclick="btn_acceder_con_perfil_ServerClick" visible="true" class="btn btn-success" validationgroup="director">
                                                    Ingresar!
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>




    <script>
        function Ocultar(id) {
            if (id == "recuperar") {
                //ocurre cuando selecciona recuperar
                document.getElementById('olvide_mi_clave').style.display = 'none';
                document.getElementById('volver').style.display = 'block';
                document.getElementById('texto_titulo').innerText = 'Recuperar contraseña';
                document.getElementById('texto_encabezado').innerText = 'Ingrese su usuario o correo:';
            }
            else {
                //ocurre cuando selecciona volver
                document.getElementById('olvide_mi_clave').style.display = 'block';
                document.getElementById('volver').style.display = 'none';
                document.getElementById('texto_titulo').innerText = 'Acceso al sistema';
                document.getElementById('texto_encabezado').innerText = 'Ingrese su usuario y contraseña:';
            }

        }
    </script>




    <!-- Javascript -->
    <script src="assets-default-login/js/jquery-1.11.1.min.js"></script>
    <script src="assets-default-login/bootstrap/js/bootstrap.min.js"></script>
    <script src="assets-default-login/js/jquery.backstretch.min.js"></script>
    <script src="assets-default-login/js/scripts.js"></script>

    <!--[if lt IE 10]>
            <script src="assets/js/placeholder.js"></script>
        <![endif]-->


</body>
</html>

