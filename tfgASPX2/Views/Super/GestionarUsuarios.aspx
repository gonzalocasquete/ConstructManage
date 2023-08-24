<%@ Page Language="C#" MasterPageFile="~/Master/Master1.Master" AutoEventWireup="true" CodeBehind="GestionarUsuarios.aspx.cs" Inherits="tfgASPX2.Views.Super.GestionarUsuarios" %>

<asp:Content ID="GestionarUsuariosHead" ContentPlaceHolderID="head" runat="server">
    <link href="../../Styles/GestionarUsuariosStyle.css" rel="stylesheet" />
    <link href="../../Styles/ComunesStyle.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="GestionarUsuariosNavegacion" ContentPlaceHolderID="ContentPlaceHolderNavegacion" runat="server">
    <a href="MenuSuper.aspx">Menú</a>
</asp:Content>

<asp:Content ID="GestionarUsuariosBody" ContentPlaceHolderID="ContentPlaceHolderContenido" runat="server">
    <div class="auto-style1">
        <h2>Gestión Usuarios</h2>
        <%--  Filtros--%>
        <div style="width: 250px">
            <div class="row">
                <div class="col">
                    <asp:Button ID="ButtonInsertar" class="form-control btn-secondary btn-sm btn-block mt-1" runat="server" Text="Insertar Usuario" OnClick="Button1_Click" />
                </div>
            </div>
            <div class="row">
                <div class="col">
                    <asp:Button ID="ButtonFiltros" class="form-control btn-secondary btn-sm btn-block mt-1" runat="server" Text="Filtros" OnClick="ButtonFiltros_Click" />
                </div>
            </div>

            <asp:Panel ID="PanelFiltros" runat="server" Visible="False">
                <hr style="height: 2px; width: auto; border-width: 0; color: whitesmoke; background-color: whitesmoke">
                <div>
                    <div class="row">
                        <div class="col">
                            <%-- Usuario--%>
                            <asp:Label ID="LabelFiltroUsuario" class="text-light" for="TextBoxFiltradoUsuario" runat="server" Text="Usuario:"></asp:Label>
                            <asp:TextBox ID="TextBoxFiltradoUsuario" class="form-control" runat="server"></asp:TextBox>
                        </div>
                    </div>

                    <div class="row mt-2">
                        <div class="col">
                            <%--Rol--%>
                            <asp:Label ID="LabelFiltroRoles" class="text-light" runat="server" Text="Roles:"></asp:Label>
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
                        <asp:Button ID="ButtonFiltrado" class="form-control btn-primary btn-sm btn-block buttonFilter" runat="server" Text="Filtrar" OnClick="ButtonFiltrado_Click" />
                        <asp:Button runat="server" class="form-control btn-secondary btn-sm btn-block buttonFilter mt-1" Text="Limpiar" OnClick="Limpiar_Click"></asp:Button>
                    </div>
                </div>
            </asp:Panel>
        </div>

        <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>" DeleteCommand="DELETE FROM [Usuario] WHERE [codigoUsuario] = @codigoUsuario" InsertCommand="INSERT INTO [Usuario] ([nombreUsuario], [contraseñaUsuario], [rol]) VALUES (@nombreUsuario, @contraseñaUsuario, @rol)" SelectCommand="SELECT * FROM [Usuario]" UpdateCommand="UPDATE [Usuario] SET [nombreUsuario] = @nombreUsuario, [contraseñaUsuario] = @contraseñaUsuario, [rol] = @rol WHERE [codigoUsuario] = @codigoUsuario">
            <DeleteParameters>
                <asp:Parameter Name="codigoUsuario" Type="Int32"></asp:Parameter>
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="nombreUsuario" Type="String"></asp:Parameter>
                <asp:Parameter Name="contraseñaUsuario" Type="String"></asp:Parameter>
                <asp:Parameter Name="rol" Type="String"></asp:Parameter>
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="nombreUsuario" Type="String"></asp:Parameter>
                <asp:Parameter Name="contrase&#241;aUsuario" Type="String"></asp:Parameter>
                <asp:Parameter Name="rol" Type="String"></asp:Parameter>
                <asp:Parameter Name="codigoUsuario" Type="Int32"></asp:Parameter>
            </UpdateParameters>
        </asp:SqlDataSource>

        <asp:GridView ID="GridView1" class="table mt-3 tamanio-usuario" runat="server" AllowPaging="True" AutoGenerateColumns="False" BackColor="WhiteSmoke" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" DataKeyNames="codigoUsuario" DataSourceID="SqlDataSource1" ForeColor="Black" GridLines="Vertical" AllowSorting="True" OnRowDataBound="GridView1_RowDataBound">
            <AlternatingRowStyle BackColor="#CCCCCC" />
            <Columns>
                <asp:BoundField DataField="codigoUsuario" HeaderText="ID" ReadOnly="True" InsertVisible="False"></asp:BoundField>

                <asp:TemplateField HeaderText="Usuario" SortExpression="nombreUsuario">
                    <ItemTemplate>
                        <%# Eval("nombreUsuario") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox Text='<%# Bind("nombreUsuario") %>' class="form-control edit-textbox" runat="server" ID="nombreUsuarioTextBox" />
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Contraseña">
                    <ItemTemplate>
                        <%# Eval("contraseñaUsuario") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox Text='<%# Bind("contraseñaUsuario") %>' class="form-control edit-textbox" runat="server" ID="contraseñaUsuarioTextBox" />
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Rol" SortExpression="rol">
                    <ItemTemplate>
                        <%# Eval("rol") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:DropDownList Text='<%# Bind("rol") %>' class="form-control" runat="server" ID="rolDropDownList">
                            <asp:ListItem Text="trabajador" Value="trabajador"></asp:ListItem>
                            <asp:ListItem Text="coordinador" Value="coordinador"></asp:ListItem>
                            <asp:ListItem Text="super" Value="super"></asp:ListItem>
                        </asp:DropDownList>
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True"></asp:CommandField>
            </Columns>
            <FooterStyle BackColor="#CCCCCC" />
            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
        </asp:GridView>

        <asp:SqlDataSource runat="server" ID="SqlDataSource2" DataSourceMode="DataReader" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>" DeleteCommand="DELETE FROM [Usuario] WHERE [codigoUsuario] = @codigoUsuario" InsertCommand="INSERT INTO [Usuario] ([nombreUsuario], [contraseñaUsuario], [rol]) VALUES (@nombreUsuario, @contraseñaUsuario, @rol)" SelectCommand="SELECT * FROM [Usuario]" UpdateCommand="UPDATE [Usuario] SET [nombreUsuario] = @nombreUsuario, [contraseñaUsuario] = @contraseñaUsuario, [rol] = @rol WHERE [codigoUsuario] = @codigoUsuario">
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

        <asp:Panel ID="Panel1" class="mt-3" runat="server" Height="196px" Visible="False">
            <asp:FormView ID="FormViewInsertarUsuario" class="form-control" runat="server" DataSourceID="SqlDataSource2" DataKeyNames="codigoUsuario" DefaultMode="Insert" OnItemInserting="FormViewInsertarUsuario_ItemInserting" OnItemInserted="FormViewInsertarUsuario_ItemInserted" OnItemCommand="FormViewInsertarUsuario_ItemCommand">
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
                                <asp:ListItem Text="super" Value="super"></asp:ListItem>
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
    ipt>
</asp:Content>
