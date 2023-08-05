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
                    <%--Nombre Trabajador--%>
                    <asp:Label ID="LabelFiltroNombreTrabajador" runat="server" Text="Nombre:"></asp:Label>
                    <asp:TextBox ID="TextBoxFiltradoNombre" class="form-control" runat="server"></asp:TextBox>
                </div>
                <div class="col">
                    <%--Apellido Trabajador--%>
                    <asp:Label ID="LabelFiltroApellidoTrabajador" runat="server" Text="Apellido:"></asp:Label>
                    <asp:TextBox ID="TextBoxFiltradoApellido" class="form-control" runat="server"></asp:TextBox>
                </div>
            </div>

            <div class="row">
                <div class="col">
                    <%--Categorias para los trabajadores--%>
                    <asp:Label ID="LabelFiltroCategorias" runat="server" Text="Categorias:"></asp:Label>
                    <asp:DropDownList ID="DropDownListCategorias" class="dropdown form-control" runat="server" DataTextField="nombreCategoria" DataValueField="codigoCategoria" DataSourceID="SqlDataSourceCategorias" AppendDataBoundItems="true">
                        <asp:ListItem Text="" Value=""></asp:ListItem>
                    </asp:DropDownList>
                    <asp:SqlDataSource runat="server" ID="SqlDataSourceCategorias" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>" SelectCommand="SELECT [codigoCategoria], [nombreCategoria] FROM [CategoriaProfesional] ORDER BY [nombreCategoria]"></asp:SqlDataSource>
                </div>
                <div class="col">
                    <%--Rol--%>
                    <asp:Label ID="LabelFiltroRoles" runat="server" Text="Roles:"></asp:Label>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="CheckBoxTrabajador" runat="server">
                        <label class="form-check-label" for="flexCheckDefault">
                            Trabajador
                        </label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="CheckBoxCoordinador" runat="server">
                        <label class="form-check-label" for="CheckBoxCoordinador">
                            Coordinador
                        </label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="CheckBoxSuper" runat="server">
                        <label class="form-check-label" for="CheckBoxSuper">
                            Super
                        </label>
                    </div>
                </div>
            </div>

            <div class="text-center mt-2">
                <asp:Button ID="ButtonFiltrado" class="form-control btn btn-primary btn-sm btn-block buttonFilter" runat="server" Text="Filtrar" OnClick="ButtonFiltrado_Click" />
                <asp:Button ID="ButtonLimpiar" class="form-control btn-secondary btn-sm btn-block buttonFilter mt-1" runat="server"  Text="Limpiar" OnClick="Limpiar_Click"></asp:Button>
            </div>
        </div>

        <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>" 
            DeleteCommand="DELETE FROM Trabajador WHERE (codigoTrabajador = @codigoTrabajador)" 
            SelectCommand="SELECT Trabajador.codigoTrabajador, Trabajador.nombre, Trabajador.apellido, Trabajador.codigoUsuario, Trabajador.codigoCategoria, Usuario.nombreUsuario, CategoriaProfesional.nombreCategoria, Usuario.rol FROM Trabajador INNER JOIN Usuario ON Trabajador.codigoUsuario = Usuario.codigoUsuario INNER JOIN CategoriaProfesional ON Trabajador.codigoCategoria = CategoriaProfesional.codigoCategoria" 
            UpdateCommand="UPDATE Trabajador SET nombre =@nombre, apellido =@apellido, codigoUsuario =@codigoUsuario, codigoCategoria =@codigoCategoria">
            <DeleteParameters>
                <asp:Parameter Name="codigoTrabajador"></asp:Parameter>
            </DeleteParameters>
            <UpdateParameters>
                <asp:Parameter Name="nombre" Type="String"></asp:Parameter>
                <asp:Parameter Name="apellido" Type="String"></asp:Parameter>
                <asp:Parameter Name="codigoUsuario" Type="Int32"></asp:Parameter>
                <asp:Parameter Name="codigoCategoria" Type="Int32"></asp:Parameter>
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:GridView ID="GridView1" runat="server" class="table mt-3" DataSourceID="SqlDataSource1" AutoGenerateColumns="False" DataKeyNames="codigoTrabajador" AllowPaging="True">
            <AlternatingRowStyle BackColor="#CCCCCC" />
            <Columns>
                <asp:BoundField DataField="codigoTrabajador" HeaderText="Codigo" ReadOnly="True" InsertVisible="False"></asp:BoundField>
                <asp:BoundField DataField="nombre" HeaderText="Nombre" SortExpression="nombre"></asp:BoundField>
                <asp:BoundField DataField="apellido" HeaderText="Apellido" SortExpression="apellido"></asp:BoundField>

                <asp:TemplateField HeaderText="Usuario">
                    <ItemTemplate>
                        <%# Eval("nombreUsuario") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:DropDownList Text='<%# Bind("codigoUsuario") %>' class="dropdown form-control" ID="idUsuariosDropDownList" runat="server" DataSourceID="UsuariosSqlDataSource" DataTextField="nombreUsuario" DataValueField="codigoUsuario"></asp:DropDownList>
                        <asp:SqlDataSource ID="UsuariosSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>" SelectCommand="SELECT codigoUsuario, nombreUsuario FROM Usuario order by nombreUsuario"></asp:SqlDataSource>
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Categoria">
                    <ItemTemplate>
                        <%# Eval("nombreCategoria") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:DropDownList Text='<%# Bind("codigoCategoria") %>' class="dropdown form-control" ID="idCategoriasDropDownList" runat="server" DataSourceID="CategoriasSqlDataSource" DataTextField="nombreCategoria" DataValueField="codigoCategoria"></asp:DropDownList>
                        <asp:SqlDataSource ID="CategoriasSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>" SelectCommand="SELECT codigoCategoria, nombreCategoria FROM CategoriaProfesional order by nombreCategoria"></asp:SqlDataSource>
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:BoundField DataField="rol" HeaderText="rol" ReadOnly="True" InsertVisible="False"></asp:BoundField>
                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True"></asp:CommandField>
            </Columns>
            <FooterStyle BackColor="#CCCCCC" />
            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#F1F1F1" />
            <SortedAscendingHeaderStyle BackColor="#808080" />
            <SortedDescendingCellStyle BackColor="#CAC9C9" />
            <SortedDescendingHeaderStyle BackColor="#383838" />
        </asp:GridView>

        <asp:Button ID="ButtonInsertar" class="ButtonStyle button1 mt-3" runat="server" Text="Insertar" OnClick="Button1_Click" />
        <asp:SqlDataSource runat="server" ID="SqlDataSourceInsertarTrabajador" DataSourceMode="DataReader" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>" DeleteCommand="DELETE FROM [Trabajador] WHERE [codigoTrabajador] = @codigoTrabajador" InsertCommand="INSERT INTO [Trabajador] ([nombre], [apellido], [codigoUsuario], [codigoCategoria]) VALUES (@nombre, @apellido, @codigoUsuario, @codigoCategoria)" SelectCommand="SELECT * FROM [Trabajador]" UpdateCommand="UPDATE [Trabajador] SET [nombre] = @nombre, [apellido] = @apellido, [codigoUsuario] = @codigoUsuario, [codigoCategoria] = @codigoCategoria WHERE [codigoTrabajador] = @codigoTrabajador">
            <DeleteParameters>
                <asp:Parameter Name="codigoTrabajador" Type="Int32"></asp:Parameter>
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
                <asp:Parameter Name="codigoTrabajador" Type="Int32"></asp:Parameter>
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:Panel ID="PanelInsertar" class="mt-3" runat="server" Visible="False">

            <asp:FormView ID="FormViewInsertarTrabajador" class="form-control" runat="server" DataSourceID="SqlDataSourceInsertarTrabajador" DataKeyNames="codigoTrabajador" DefaultMode="Insert">
                <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <InsertItemTemplate>
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
                            Usuario:
                           <asp:DropDownList Text='<%# Bind("codigoUsuario") %>' class="dropdown form-control" ID="idUsuariosDropDownList" runat="server" DataSourceID="UsuariosSqlDataSourceInsertar" DataTextField="nombreUsuario" DataValueField="codigoUsuario"></asp:DropDownList>
                            <asp:SqlDataSource ID="UsuariosSqlDataSourceInsertar" runat="server" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>" SelectCommand="SELECT codigoUsuario, nombreUsuario FROM Usuario order by nombreUsuario"></asp:SqlDataSource>
                        </div>
                        <div class="col">
                            Categoria:
                              <asp:DropDownList Text='<%# Bind("codigoCategoria") %>' class="dropdown form-control" ID="idCategoriasDropDownList" runat="server" DataSourceID="CategoriasSqlDataSourceInsertar" DataTextField="nombreCategoria" DataValueField="codigoCategoria"></asp:DropDownList>
                            <asp:SqlDataSource ID="CategoriasSqlDataSourceInsertar" runat="server" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>" SelectCommand="SELECT codigoCategoria, nombreCategoria FROM CategoriaProfesional order by nombreCategoria"></asp:SqlDataSource>
                        </div>
                    </div>
                    <div class="mt-3 text-center">
                        <asp:LinkButton ID="InsertButton" class="btn btn-success" runat="server" CausesValidation="True" CommandName="Insert" Text="Insertar" />
                        &nbsp;
                        <asp:LinkButton ID="InsertCancelButton" class="btn btn-danger" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancelar" />
                    </div>
                </InsertItemTemplate>
                <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
            </asp:FormView>
        </asp:Panel>
    </div>

</asp:Content>

