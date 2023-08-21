<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="tfgASPX.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" lang="es">
<head runat="server">
    <link href="../Styles/LoginStyle.css" rel="stylesheet" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Login</title> 
</head>
<body>
    <form runat="server" class="form-box">
        <h1 class="form-title">ConstructManage</h1>
        <input id="InputUsuario" type ="text" placeholder="Username" runat="server"/>
        <input id="InputPassword" type="password" placeholder="Password" runat="server"/>
        <asp:Button ID="ButtonEntrar" class="form-button" runat="server" Text="Entrar" OnClick="Entrar_Click"/>
    </form>
</body>
</html>

