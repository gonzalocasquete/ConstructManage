<%@ Page Language="C#" MasterPageFile="~/Master/Master1.Master" AutoEventWireup="true" CodeBehind="InicialTrabajador.aspx.cs" Inherits="tfgASPX2.Views.Super.IndexSuper" %>

<asp:Content ID="TrabajadorHead" ContentPlaceHolderID="head" runat="server">
   
</asp:Content>

<asp:Content ID="TrabajadorNavegacion" ContentPlaceHolderID="ContentPlaceHolderNavegacion" runat="server">
    <a href="InicialTrabajador.aspx">Menu</a>
    <a href="PerfilTrabajador.aspx">Perfil</a>
</asp:Content>

<asp:Content ID="TrabajadorBody" ContentPlaceHolderID="ContentPlaceHolderContenido" runat="server">
        <h1>Bienvenido <%= Session["nombreUsuario"] %></h1>
</asp:Content>
