<%@ Page Language="C#" MasterPageFile="~/Master/Master1.Master" AutoEventWireup="true" CodeBehind="GestionarTrabajadores.aspx.cs" Inherits="tfgASPX2.Views.Super.GestionarTrabajadores" %>

<asp:Content ID="GestionarTrabajadoresHead" ContentPlaceHolderID="head" runat="server">
    <link href="../../Styles/GestionarTrabajadoresStyle.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css"
        rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x"
        crossorigin="anonymous" />

    <style type="text/css">
        .auto-style5 {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            margin-top: 40px;
            height: 372px;
        }
    </style>

</asp:Content>

<asp:Content ID="GestionarTrabajadoresNavegacion" ContentPlaceHolderID="ContentPlaceHolderNavegacion" runat="server">
    <a href="MenuSuper.aspx">Menú</a>
</asp:Content>

<asp:Content ID="GestionarTrabajadoresBody" ContentPlaceHolderID="ContentPlaceHolderContenido" runat="server">
    <div class="auto-style1">
        <h2 class="font-weight-bold">Gestión Trabajadores</h2>

        <%--Filtros--%>
        <hr />
        <div>
            <div class="row">
                <div class="col">
                    <%--Nombre--%>
                    <asp:Label ID="LabelFiltroTrabajador" runat="server" Text="Nombre o Apellido:"></asp:Label>
                    <asp:TextBox ID="TextBoxFiltradoTrabajador" class="form-control" runat="server"></asp:TextBox>
                </div>
                <div class="col">
                    <%--Usuario--%>
                    <asp:Label ID="LabelUsuario" runat="server" Text="Usuario:"></asp:Label>
                    <asp:TextBox ID="TextBoxUsuario" class="form-control" runat="server"></asp:TextBox>
                </div>
            </div>

            <div class="row">         
                <div class="col">
                    <%--Categoria--%>
                    <asp:Label ID="LabelCategoria" for="categoria" runat="server" Text="Categoria:"></asp:Label>
                    <asp:DropDownList class="form-control" data-toggle="tooltip" title="Categoria del trabajador" ID="DropDownListFiltroCategorias" runat="server" DataSourceID="CategoriaFiltroSqlDataSource" DataTextField="nombreCategoria" DataValueField="nombreCategoria" AppendDataBoundItems="true">
                         <asp:ListItem Text="" Value=""></asp:ListItem>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="CategoriaFiltroSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>" SelectCommand="SELECT codigoCategoria, nombreCategoria FROM CategoriaProfesional ORDER BY nombreCategoria"></asp:SqlDataSource>

                </div>
            </div>

            <div class="text-center mt-2">
                <asp:Button ID="ButtonFiltrado" class="form-control btn btn-primary btn-sm btn-block buttonFilter" runat="server" Text="Filtrar" OnClick="ButtonFiltrado_Click" />
                <asp:Button runat="server" class="form-control btn-secondary btn-sm btn-block buttonFilter mt-1" Text="Limpiar" OnClick="Todos_Click"></asp:Button>
            </div>
        </div>

        <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>" SelectCommand="SELECT * FROM [Vista_trabajor]"></asp:SqlDataSource>
        <asp:GridView ID="GridView1" class="mt-3" runat="server" AllowPaging="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" DataKeyNames="codTrabajador" DataSourceID="SqlDataSource1" ForeColor="Black" GridLines="Vertical">
            <AlternatingRowStyle BackColor="#CCCCCC" />
            <Columns>
                <asp:BoundField DataField="nombre" HeaderText="Nombre" SortExpression="nombre"></asp:BoundField>
                <asp:BoundField DataField="apellido" HeaderText="Apellido" SortExpression="apellido"></asp:BoundField>
                <asp:BoundField DataField="codTrabajador" HeaderText="ID" ReadOnly="True" SortExpression="codTrabajador"></asp:BoundField>
                <asp:BoundField DataField="nombreUsuario" HeaderText="Usuario" SortExpression="nombreUsuario"></asp:BoundField>
                <asp:BoundField DataField="nombreCategoria" HeaderText="Categoria Profesional" SortExpression="nombreCategoria"></asp:BoundField>
            </Columns>
            <FooterStyle BackColor="#CCCCCC" />
            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
        </asp:GridView>
        <asp:Button ID="Button1" class="ButtonStyle button1 mt-3" runat="server" Text="Insertar" OnClick="Button1_Click" />

        <asp:Panel ID="Panel1" class="mt-3" runat="server" Visible="False">
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>"
                DeleteCommand="DELETE FROM [Trabajador] WHERE [codTrabajador] = @codTrabajador"
                InsertCommand="INSERT INTO [Trabajador] ([nombre], [apellido], [codigoUsuario], [codigoCategoria]) VALUES (@nombre, @apellido, @codigoUsuario, @codigoCategoria)"
                SelectCommand="SELECT * FROM [Trabajador]"
                UpdateCommand="UPDATE [Trabajador] SET [nombre] = @nombre, [apellido] = @apellido, [codigoUsuario] = @codigoUsuario, [codigoCategoria] = @codigoCategoria WHERE [codTrabajador] = @codTrabajador">
                <DeleteParameters>
                    <asp:Parameter Name="codTrabajador" Type="Int32"></asp:Parameter>
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="nombre" Type="String"></asp:Parameter>
                    <asp:Parameter Name="apellido" Type="String"></asp:Parameter>
                    <asp:Parameter Name="codigoUsuario" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="codigoCategoria" Type="Int32"></asp:Parameter>
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="nombre" Type="String"></asp:Parameter>
                    <asp:Parameter Name="apellido" Type="String"></asp:Parameter>
                    <asp:Parameter Name="codigoUsuario" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="codigoCategoria" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="codTrabajador" Type="Int32"></asp:Parameter>
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:FormView ID="FormView1" class="form-control" runat="server" DataSourceID="SqlDataSource2" DataKeyNames="codTrabajador" DefaultMode="Insert" EnableViewState="False">
                <InsertItemTemplate>
                    <footerstyle backcolor="#990000" font-bold="True" forecolor="White" />
                    <headerstyle backcolor="#990000" font-bold="True" forecolor="White" />
                    <div class="row">
                        <div class="col">
                            Nombre:
                            <asp:TextBox class="form-control" data-toggle="tooltip" title="Nombre" Text='<%# Bind("nombre") %>' runat="server" ID="nombreTextBox" />
                        </div>
                        <div class="col">
                            Apellido:
                             <asp:TextBox class="form-control" data-toggle="tooltip" title="Apellido" Text='<%# Bind("apellido") %>' runat="server" ID="apellidoTextBox" />
                        </div>

                    </div>

                    <div class="row">
                        <div class="col">
                            Cuenta de Usuario:
                            <asp:DropDownList class="form-control" data-toggle="tooltip" title="Usuario" ID="codigoUsuarioDropDownList" Text='<%# Bind("codigoUsuario") %>' runat="server" DataSourceID="codigoUsuarioSqlDataSource" DataTextField="nombreUsuario" DataValueField="codigoUsuario"></asp:DropDownList>
                            <asp:SqlDataSource ID="codigoUsuarioSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>" SelectCommand="SELECT codigoUsuario, nombreUsuario FROM Usuario"></asp:SqlDataSource>
                        </div>
                        <div class="col">
                            Categoria Profesional:
                            <asp:DropDownList class="form-control" data-toggle="tooltip" title="Contraseña" ID="DropDownList2" Text='<%# Bind("codigoCategoria") %>' runat="server" DataSourceID="CategoriaSqlDataSource" DataTextField="nombreCategoria" DataValueField="codigoCategoria"></asp:DropDownList>
                            <asp:SqlDataSource ID="CategoriaSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>" SelectCommand="SELECT codigoCategoria, nombreCategoria FROM CategoriaProfesional"></asp:SqlDataSource>
                        </div>
                    </div>

                    <div class="mt-3 text-center">
                        <asp:LinkButton class="btn btn-success" runat="server" Text="Insertar" CommandName="Insert" ID="InsertButton" CausesValidation="True" />
                        &nbsp;
                        <asp:LinkButton class="btn btn-danger" runat="server" Text="Cancelar" CommandName="Cancel" ID="InsertCancelButton" CausesValidation="False" />
                    </div>

                </InsertItemTemplate>
                <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
            </asp:FormView>
        </asp:Panel>

    </div>
</asp:Content>

