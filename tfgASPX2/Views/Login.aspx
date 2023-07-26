<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="tfgASPX.Login" %>

<!DOCTYPE html>

<link href="../Styles/LoginStyle.css" rel="stylesheet" />
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
</head>
<body>
    <div class="wrapper fadeInDown">
        <div id="formContent">

            <!-- Icon -->
            <div class="fadeIn first">
            </div>

            <!-- Login Form -->
            <form id="form1" runat="server">
                &nbsp;
                <asp:TextBox ID="TextBoxUsuario" CssClass="input_focus" runat="server" placeholder="usuario"></asp:TextBox>
                <asp:TextBox ID="TextBoxContraseña" CssClass="password_input input_focus" runat="server" placeholder="contraseña" TextMode="Password"></asp:TextBox>
                <asp:Button ID="Entrar" runat="server" OnClick="Entrar_Click" Text="Entrar" />
                &nbsp;
            </form>

            <!-- Remind Passowrd -->
            <div id="formFooter">
                <a class="underlineHover" href="#">Forgot Password?</a>
            </div>
        </div>
    </div>
</body>
</html>

