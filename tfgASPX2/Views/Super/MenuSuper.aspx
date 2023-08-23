<%@ Page Language="C#" MasterPageFile="~/Master/Master1.Master" AutoEventWireup="true" CodeBehind="MenuSuper.aspx.cs" Inherits="tfgASPX2.Views.Super.IndexSuper" %>

<asp:Content ID="MenuSuperHead" ContentPlaceHolderID="head" runat="server">
    <link href="../../Styles/MenuSuperStyle.css" rel="stylesheet" />
    <link href="../../Styles/ComunesStyle.css" rel="stylesheet" />
    <title>MenuAdmin</title> 
</asp:Content>

<asp:Content ID="MenuSuperNavegacion" ContentPlaceHolderID="ContentPlaceHolderNavegacion" runat="server">
    <a href="MenuSuper.aspx">Menú</a>
</asp:Content>

<asp:Content ID="MenuSuperBody" ContentPlaceHolderID="ContentPlaceHolderContenido" runat="server">
    <div class="vertical-menu">
        <a href="GestionarUsuarios.aspx">Gestionar Usuarios</a>
        <a href="GestionarTrabajadores.aspx">Gestionar Trabajadores</a>
        <a href="GestionarCategoriasProfesionales.aspx">Gestionar Categorias</a>
        <a href="GestionarClientes.aspx">Gestionar Clientes</a>
        <a href="GestionarProyectos.aspx">Gestionar Proyectos</a>
        <a href="GestionarPartidas.aspx">Gestionar Partida</a>
        <a href="GestionarConvenios.aspx">Gestionar Convenios</a>
    </div> 
</asp:Content>
