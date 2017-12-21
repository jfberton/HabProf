<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="WebApplication1._default" %>

<!DOCTYPE html>


<html xmlns="http://www.w3.org/1999/xhtml">
<head>

    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title></title>

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

</head>
<body>
    <!-- Top content -->
    <div class="top-content">

        <div class="inner-bg">
            <div class="container">
                <div class="row">
                    <div class="col-sm-8 col-sm-offset-2 text">
                        <h1><strong>Habilitación Profesional</strong> 
                            <br />
                            Sistema de administración de Tesis
                        </h1>
                        <div class="description">
                            <p>
                                Sistema de gestión y seguimiento del desarrollo de la Tesina Final de la carrera Licenciatura en Tecnología Educativa dictada en la <a href="http://www.frre.utn.edu.ar" target="_blank"><strong>Universidad Tecnológica Nacional - Facultad Regional Resistencia</strong></a>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6 col-sm-offset-3 form-box">
                        <div class="form-top">
                            <div class="form-top-left">
                                <h3>Acceso al sitio</h3>
                                <p>Ingrese su usuario y contraseña:</p>
                            </div>
                            <div class="form-top-right">
                                <i class="fa fa-lock"></i>
                            </div>
                        </div>
                        <div class="form-bottom">
                            <form id="form1" runat="server" class="login-form">
                                <div class="form-group">
                                    <label class="sr-only" for="form-username">Usuario</label>
                                    <input type="text" name="form-username" placeholder="Usuario..." class="form-username form-control" id="form-username"/>
                                </div>
                                <div class="form-group">
                                    <label class="sr-only" for="form-password">Contraseña</label>
                                    <input type="password" name="form-password" placeholder="Contraseña..." class="form-password form-control" id="form-password"/>
                                </div>
                                <button type="submit" class="btn">Ingresar!</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


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

