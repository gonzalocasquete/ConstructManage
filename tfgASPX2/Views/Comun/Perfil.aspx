<%@ Page Language="C#" MasterPageFile="~/Master/Master1.Master" AutoEventWireup="true" CodeBehind="Perfil.aspx.cs" Inherits="tfgASPX2.Views.Trabajador.PerfilTrabajador" %>

<asp:Content ID="PerfilTrabajadorHead" ContentPlaceHolderID="head" runat="server">
    <link href="../../Styles/PerfilTrabajadorStyle.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css"
        rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x"
        crossorigin="anonymous" />
    <script src="../../Scripts/Views/PerfilTrabajadorScripts.js"></script>
</asp:Content>

<asp:Content ID="PerfilTrabajadorNavegacion" ContentPlaceHolderID="ContentPlaceHolderNavegacion" runat="server">
    <% if (Session["rol"] == null)
        { %>
    <!-- Código para mostrar enlaces cuando la sesión "rol" es nula o no está definida -->
    <a href="../Login.aspx">Logout</a>
    <% }
        else if (Session["rol"].ToString() == "trabajador")
        { %>
    <!-- Código para mostrar enlaces cuando la sesión "rol" es "trabajador" -->
    <a href="../Trabajador/InicialTrabajador.aspx">Inicio</a>
    <a href="Perfil.aspx">Perfil</a>
    <% }
        else if (Session["rol"].ToString() == "coordinador")
        { %>
    <!-- Código para mostrar enlaces cuando la sesión "rol" es "coordinador" -->
    <a href="../Coordinador/InicialCoordinador.aspx">Inicio</a>
    <a href="Perfil.aspx">Perfil</a>
    <% } %>
</asp:Content>

<asp:Content ID="PerfilTrabajadorBody" ContentPlaceHolderID="ContentPlaceHolderContenido" runat="server">
    <div class="auto-style1">
        <asp:SqlDataSource runat="server" ID="SqlDataSource1" DataSourceMode="DataReader" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>"
            SelectCommand="SELECT Trabajador.nombre, Trabajador.apellido, Trabajador.codigoUsuario, Trabajador.codigoCategoria, Usuario.nombreUsuario, Usuario.contraseñaUsuario FROM Trabajador INNER JOIN Usuario ON Trabajador.codigoUsuario = Usuario.codigoUsuario WHERE (Trabajador.codigoUsuario = @codigoUsuario)"
            UpdateCommand="UPDATE Trabajador JOIN Usuario ON Trabajador.codigoUsuario = Usuario.codigoUsuario SET Trabajador.nombre = @nombre, Trabajador.apellido = @apellido, Trabajador.codigoCategoria = @codigoCategoria, Usuario.nombreUsuario = @nombreUsuario, Usuario.contraseñaUsuario = @contraseñaUsuario WHERE Trabajador.codigoUsuario = @codigoUsuario;">
            <SelectParameters>
                <asp:SessionParameter SessionField="codigoUsuario" Name="codigoUsuario"></asp:SessionParameter>
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="nombre"></asp:Parameter>
                <asp:Parameter Name="apellido"></asp:Parameter>
                <asp:Parameter Name="codigoCategoria"></asp:Parameter>
                <asp:Parameter Name="nombreUsuario"></asp:Parameter>
                <asp:Parameter Name="contrase&#241;aUsuario"></asp:Parameter>
                <asp:Parameter Name="codigoUsuario"></asp:Parameter>
            </UpdateParameters>
        </asp:SqlDataSource>

        <asp:FormView ID="FormView1" runat="server" DataSourceID="SqlDataSource1" DefaultMode="Edit">
            <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
            <EditItemTemplate>
                <div class="row">
                    <div class="col">
                        Nombre:
                        <asp:TextBox Text='<%# Bind("nombre") %>' class="form-control" runat="server" ID="nombreTextBox" /><br />
                    </div>
                    <div class="col">
                        Apellido:
                        <asp:TextBox Text='<%# Bind("apellido") %>' class="form-control" runat="server" ID="apellidoTextBox" /><br />
                    </div>
                </div>

                <div class="row">
                    <div class="col">
                        Categoria Profesional:
                        <asp:DropDownList class="form-control" ID="DropDownList2" Text='<%# Bind("codigoCategoria") %>' runat="server" DataSourceID="CategoriaSqlDataSource" DataTextField="nombreCategoria" DataValueField="codigoCategoria"></asp:DropDownList>
                        <asp:SqlDataSource ID="CategoriaSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>"
                            SelectCommand="SELECT codigoCategoria, nombreCategoria FROM CategoriaProfesional"></asp:SqlDataSource>
                        <br />
                    </div>

                </div>

                <div class="row">
                    <div class="col">
                        Usuario:
                        <asp:TextBox Text='<%# Bind("nombreUsuario") %>' class="form-control" runat="server" ID="nombreUsuarioTextBox" /><br />
                    </div>
                    <div class="col">
                        Contraseña:
                        <asp:TextBox Text='<%# Bind("contraseñaUsuario") %>' class="form-control" runat="server" ID="contraseñaUsuarioTextBox" TextMode="Password" /><br />
                    </div>
                </div>

                <asp:TextBox Text='<%# Bind("codigoUsuario") %>' class="invisible" runat="server" ID="codigoUsuarioTextBox" />

                <div class="mt-3 text-center">
                    <asp:LinkButton runat="server" class="btn btn-success" Text="Actualizar" CommandName="Update" ID="UpdateButton" CausesValidation="True" />
                    &nbsp;
                    <asp:LinkButton runat="server" class="btn btn-danger" Text="Cancelar" CommandName="Cancel" ID="UpdateCancelButton" CausesValidation="False" />
                </div>

            </EditItemTemplate>
            <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
            <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
        </asp:FormView>

    </div>
</asp:Content>
