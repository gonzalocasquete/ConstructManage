<%@ Page Language="C#" MasterPageFile="~/Master/Master1.Master" AutoEventWireup="true" CodeBehind="GestionarTrabajadores.aspx.cs" Inherits="tfgASPX2.Views.Super.GestionarTrabajadores" %>

<asp:Content ID="GestionarTrabajadoresHead" ContentPlaceHolderID="head" runat="server">
    <link href="../../Styles/GestionarTrabajadoresStyle.css" rel="stylesheet" />
    <link href="../../Styles/ComunesStyle.css" rel="stylesheet" />
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
        <div style="width: 250px">
            <div class="row">
                <div class="col">
                    <asp:Button ID="ButtonInsertarTrabajador" class="form-control btn-secondary btn-sm btn-block mt-1" runat="server" Text="Insertar Trabajador" OnClick="ButtonInsertarTrabajador_Click" />
                </div>
            </div>
            <div class="row">
                <div class="col">
                    <asp:Button ID="ButtonFiltros" class="form-control btn-secondary btn-sm btn-block mt-1" runat="server" Text="Filtros" OnClick="ButtonFiltros_Click" />
                </div>
            </div>

            <div class="row">
                <div class="col">
                    <asp:Button ID="ButtonInsertarUsuario" class="form-control btn-info btn-sm btn-block mt-1" runat="server" Text="Insertar Usuario" OnClick="ButtonInsertarUsuario_Click" Visible="false" />
                </div>
            </div>

            <asp:Panel ID="PanelFiltros" runat="server" Visible="False">
                <hr style="height: 2px; width: auto; border-width: 0; color: whitesmoke; background-color: whitesmoke">
                <div>

                    <div class="row">
                        <div class="col">
                            <%--Nombre Trabajador--%>
                            <asp:Label ID="LabelFiltroNombreTrabajador" class="text-light" runat="server" Text="Nombre:"></asp:Label>
                            <asp:TextBox ID="TextBoxFiltradoNombre" class="form-control" runat="server"></asp:TextBox>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col">
                            <%--Apellido Trabajador--%>
                            <asp:Label ID="LabelFiltroApellidoTrabajador" class="text-light" runat="server" Text="Apellido:"></asp:Label>
                            <asp:TextBox ID="TextBoxFiltradoApellido" class="form-control" runat="server"></asp:TextBox>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col">
                            <%--Categorias para los trabajadores--%>
                            <asp:Label ID="LabelFiltroCategorias" runat="server" class="text-light" Text="Categorias:"></asp:Label>
                            <asp:DropDownList ID="DropDownListCategorias" class="dropdown form-control" runat="server" DataTextField="nombreCategoria" DataValueField="codigoCategoria" DataSourceID="SqlDataSourceCategorias" AppendDataBoundItems="true">
                                <asp:ListItem Text="" Value=""></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource runat="server" ID="SqlDataSourceCategorias" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>" SelectCommand="SELECT [codigoCategoria], [nombreCategoria] FROM [CategoriaProfesional] ORDER BY [nombreCategoria]"></asp:SqlDataSource>
                        </div>
                        <div class="col">
                            <%--Rol--%>
                            <asp:Label ID="LabelFiltroRoles" runat="server" class="text-light" Text="Roles:"></asp:Label>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="CheckBoxTrabajador" runat="server">
                                <label class="form-check-label text-light" for="flexCheckDefault">
                                    Trabajador
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="CheckBoxCoordinador" runat="server">
                                <label class="form-check-label text-light" for="CheckBoxCoordinador">
                                    Coordinador
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="CheckBoxSuper" runat="server">
                                <label class="form-check-label text-light" for="CheckBoxSuper">
                                    Super
                                </label>
                            </div>
                        </div>
                    </div>

                    <div class="text-center mt-2">
                        <asp:Button ID="ButtonFiltrado" class="form-control btn btn-primary btn-sm btn-block buttonFilter" runat="server" Text="Filtrar" OnClick="ButtonFiltrado_Click" />
                        <asp:Button ID="ButtonLimpiar" class="form-control btn-secondary btn-sm btn-block buttonFilter mt-1" runat="server" Text="Limpiar" OnClick="Limpiar_Click"></asp:Button>
                    </div>
                </div>
            </asp:Panel>
        </div>

        <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>"
            DeleteCommand="DELETE FROM Trabajador WHERE codigoTrabajador = @codigoTrabajador;"
            SelectCommand="SELECT Trabajador.codigoTrabajador, Trabajador.nombre, Trabajador.apellido, Trabajador.codigoUsuario, Trabajador.codigoCategoria, Usuario.nombreUsuario, CategoriaProfesional.nombreCategoria, Usuario.rol FROM Trabajador INNER JOIN Usuario ON Trabajador.codigoUsuario = Usuario.codigoUsuario INNER JOIN CategoriaProfesional ON Trabajador.codigoCategoria = CategoriaProfesional.codigoCategoria order by codigoTrabajador DESC"
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
        <asp:GridView ID="GridView1" runat="server" class="table mt-3 fixed-table" DataSourceID="SqlDataSource1" AutoGenerateColumns="False" DataKeyNames="codigoTrabajador" AllowPaging="True" AllowSorting="True" BackColor="WhiteSmoke" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical">
            <AlternatingRowStyle BackColor="#CCCCCC" />

            <Columns>
                <asp:BoundField DataField="codigoTrabajador" HeaderText="ID" ReadOnly="True" InsertVisible="False" ItemStyle-CssClass="small-column"></asp:BoundField>
                <asp:TemplateField HeaderText="Nombre" SortExpression="nombre">
                    <ItemTemplate>
                        <%# Eval("nombre") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox Text='<%# Bind("nombre") %>' class="form-control edit-textbox" Style="width: 125px;" runat="server" ID="nombreTextBox" />
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Apellido" SortExpression="apellido">
                    <ItemTemplate>
                        <%# Eval("apellido") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox Text='<%# Bind("apellido") %>' class="form-control edit-textbox" Style="width: 125px;" runat="server" ID="apellidoTextBox" />
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Usuario" SortExpression="nombreUsuario">
                    <ItemTemplate>
                        <%# Eval("nombreUsuario") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:DropDownList Text='<%# Bind("codigoUsuario") %>' class="dropdown form-control edit-dropdown" ID="idUsuariosDropDownList" runat="server" DataSourceID="UsuariosSqlDataSourceEditarTrabajador" DataTextField="nombreUsuario" DataValueField="codigoUsuario"></asp:DropDownList>
                        <asp:SqlDataSource ID="UsuariosSqlDataSourceEditarTrabajador" runat="server" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>" SelectCommand="SELECT codigoUsuario, nombreUsuario FROM Usuario WHERE rol <> 'super'"></asp:SqlDataSource>
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Categoria" SortExpression="nombreCategoria">
                    <ItemTemplate>
                        <%# Eval("nombreCategoria") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:DropDownList Text='<%# Bind("codigoCategoria") %>' class="dropdown form-control edit-dropdown" ID="idCategoriasDropDownList" runat="server" DataSourceID="CategoriasSqlDataSource" DataTextField="nombreCategoria" DataValueField="codigoCategoria"></asp:DropDownList>
                        <asp:SqlDataSource ID="CategoriasSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>" SelectCommand="SELECT codigoCategoria, nombreCategoria FROM CategoriaProfesional order by nombreCategoria"></asp:SqlDataSource>
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:BoundField DataField="rol" HeaderText="rol" ReadOnly="True" InsertVisible="False" SortExpression="rol"></asp:BoundField>
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

            <asp:FormView ID="FormViewInsertarTrabajador" class="form-control" runat="server" DataSourceID="SqlDataSourceInsertarTrabajador" DataKeyNames="codigoTrabajador" DefaultMode="Insert" OnItemInserting="FormViewInsertarTrabajador_ItemInserting" OnItemInserted="FormViewInsertarTrabajador_ItemInserted" OnItemCommand="FormViewInsertarTrabajador_ItemCommand">
                <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <InsertItemTemplate>
                    <div class="row">
                        <div class="col text-center">
                            <h3>Insertar Trabajador</h3>
                        </div>
                    </div>

                    <div class="row mt-3">
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
                           <asp:DropDownList Text='<%# Bind("codigoUsuario") %>' class="dropdown form-control" ID="idUsuariosDropDownList" runat="server" DataSourceID="UsuariosSqlDataSourceInsertar" DataTextField="nombreUsuario" DataValueField="codigoUsuario" AppendDataBoundItems="true">
                               <asp:ListItem Text="" Value=""></asp:ListItem>
                           </asp:DropDownList>
                            <asp:SqlDataSource ID="UsuariosSqlDataSourceInsertar" runat="server" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>" SelectCommand="SELECT codigoUsuario, nombreUsuario FROM Usuario WHERE codigoUsuario NOT IN (SELECT codigoUsuario FROM Trabajador) AND rol <> 'super' ORDER BY nombreUsuario;"></asp:SqlDataSource>
                        </div>
                        <div class="col">
                            Categoria:
                              <asp:DropDownList Text='<%# Bind("codigoCategoria") %>' class="dropdown form-control" ID="idCategoriasDropDownList" runat="server" DataSourceID="CategoriasSqlDataSourceInsertar" DataTextField="nombreCategoria" DataValueField="codigoCategoria" AppendDataBoundItems="true">
                                  <asp:ListItem Text="" Value=""></asp:ListItem>
                              </asp:DropDownList>
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
                <RowStyle BackColor="#6c757d" ForeColor="White" />
            </asp:FormView>
        </asp:Panel>

         <asp:SqlDataSource runat="server" ID="SqlDataSourceInsertarUsuario" DataSourceMode="DataReader" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>" DeleteCommand="DELETE FROM [Usuario] WHERE [codigoUsuario] = @codigoUsuario" InsertCommand="INSERT INTO [Usuario] ([nombreUsuario], [contraseñaUsuario], [rol]) VALUES (@nombreUsuario, @contraseñaUsuario, @rol)" SelectCommand="SELECT * FROM [Usuario]" UpdateCommand="UPDATE [Usuario] SET [nombreUsuario] = @nombreUsuario, [contraseñaUsuario] = @contraseñaUsuario, [rol] = @rol WHERE [codigoUsuario] = @codigoUsuario">
            <DeleteParameters>
                <asp:Parameter Name="codigoUsuario" Type="Int32"></asp:Parameter>
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="nombreUsuario" Type="String"></asp:Parameter>
                <asp:Parameter Name="contrase&#241;aUsuario" Type="String"></asp:Parameter>
                <asp:Parameter Name="rol" Type="String"></asp:Parameter>
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="nombreUsuario" Type="String"></asp:Parameter>
                <asp:Parameter Name="contrase&#241;aUsuario" Type="String"></asp:Parameter>
                <asp:Parameter Name="rol" Type="String"></asp:Parameter>
                <asp:Parameter Name="codigoUsuario" Type="Int32"></asp:Parameter>
            </UpdateParameters>
        </asp:SqlDataSource>

        <asp:Panel ID="PanelInsertarUsuario" class="mt-3" runat="server" Height="196px" Visible="False">
            <asp:FormView ID="FormViewInsertarUsuario" class="form-control" runat="server" DataSourceID="SqlDataSourceInsertarUsuario" DataKeyNames="codigoUsuario" DefaultMode="Insert" OnItemInserting="FormViewInsertarUsuario_ItemInserting" OnItemInserted="FormViewInsertarUsuario_ItemInserted" OnItemCommand="FormViewInsertarUsuario_ItemCommand">
                <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <InsertItemTemplate>
                    <div class="row">
                        <div class="col text-center">
                            <h3>Insertar Usuario</h3>
                        </div>
                    </div>

                    <div class="row mt-3">
                        <div class="col">
                            Usuario:
                            <asp:TextBox Text='<%# Bind("nombreUsuario") %>' class="form-control" runat="server" ID="nombreUsuarioTextBox" data-toggle="tooltip" title="Usuario" />
                        </div>
                        <div class="col">
                            Contraseña:
                            <asp:TextBox Text='<%# Bind("contraseñaUsuario") %>' class="form-control" runat="server" ID="contraseñaUsuarioTextBox" data-toggle="tooltip" title="Contraseña" />
                        </div>
                    </div>

                    <div class="row">

                        <div class="col">
                            Rol:
                            <asp:DropDownList Text='<%# Bind("rol") %>' class="form-control" runat="server" ID="rolDropDownList">
                                <asp:ListItem Text="trabajador" Value="trabajador"></asp:ListItem>
                                <asp:ListItem Text="coordinador" Value="coordinador"></asp:ListItem>    
                            </asp:DropDownList>
                        </div>
                    </div>

                    <div class="mt-3 text-center">
                        <asp:LinkButton class="btn btn-success" runat="server" Text="Insertar" CommandName="Insert" ID="InsertButton" CausesValidation="True" />
                        &nbsp;
                        <asp:LinkButton class="btn btn-danger" runat="server" Text="Cancelar" CommandName="Cancel" ID="InsertCancelButton" CausesValidation="False" />
                    </div>
                </InsertItemTemplate>
                <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                <RowStyle BackColor="#6c757d" ForeColor="White" />
            </asp:FormView>
        </asp:Panel>

    </div>

</asp:Content>

