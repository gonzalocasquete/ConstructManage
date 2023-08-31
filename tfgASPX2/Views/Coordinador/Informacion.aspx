<%@ Page Language="C#" MasterPageFile="~/Master/Master1.Master" AutoEventWireup="true" CodeBehind="Informacion.aspx.cs" Inherits="tfgASPX2.Views.Coordinador.Informacion" %>

<asp:Content ID="GestionarProyectosHead" ContentPlaceHolderID="head" runat="server">
    <link href="../../Styles/InformacionStyle.css" rel="stylesheet" />
    <link href="../../Styles/ComunesStyle.css" rel="stylesheet" />
    <link href="../../Styles/ComunCoordinadorStyle.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="GestionarProyectosNavegacion" ContentPlaceHolderID="ContentPlaceHolderNavegacion" runat="server">
    <a href="InicialCoordinador.aspx">Inicio</a>
    <a href="ConsularProyectos.aspx">Proyectos</a>
    <a href="Presupuestos.aspx">Balance</a>
    <a href="Informacion.aspx.cs">Estudio</a>
    <a href="../Comun/Perfil.aspx">Perfil</a>
</asp:Content>

<asp:Content ID="GestionarProyectosBody" ContentPlaceHolderID="ContentPlaceHolderContenido" runat="server">
    <div class="auto-style1">
        <h2>Informacion</h2>

        <iframe title="Proyecto-Partida" width="1140" height="541.25" src="https://app.powerbi.com/reportEmbed?reportId=214c1e79-ad26-452c-b4f1-de5e5c9b252a&autoAuth=true&ctid=523c5590-88ac-498d-ae92-bc3f4f3f7b28" frameborder="0" allowfullscreen="true"></iframe>

    </div>
</asp:Content>
