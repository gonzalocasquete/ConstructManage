<%@ Page Language="C#" MasterPageFile="~/Master/Master1.Master" AutoEventWireup="true" CodeBehind="GestionarUsuarios.aspx.cs" Inherits="tfgASPX2.Views.Super.GestionarUsuarios" %>

<asp:Content ID="GestionarUsuariosHead" ContentPlaceHolderID="head" runat="server">
    <link href="../../Styles/GestionarUsuariosStyle.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css"
        rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x"
        crossorigin="anonymous" />
</asp:Content>

<asp:Content ID="GestionarUsuariosNavegacion" ContentPlaceHolderID="ContentPlaceHolderNavegacion" runat="server">
    <a href="MenuSuper.aspx">Menú</a>
</asp:Content>

<asp:Content ID="GestionarUsuariosBody" ContentPlaceHolderID="ContentPlaceHolderContenido" runat="server">
    <div class="auto-style1">
        <h2 class="font-weight-bold">Gestión Usuarios</h2>

        <%--Filtros--%>
        <hr />
        <div>
            <%--Usuario--%>
            <asp:Label ID="LabelFiltroUsuario" runat="server" Text="Usuario:"></asp:Label>
            <asp:TextBox ID="TextBoxFiltradoUsuario" class="form-control" runat="server"></asp:TextBox>

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

            <div class="text-center">
                <asp:Button ID="ButtonFiltrado" class="form-control btn-primary btn-sm btn-block buttonFilter" runat="server" Text="Filtrar" OnClick="ButtonFiltrado_Click" />
                <asp:Button runat="server" class="form-control btn-secondary btn-sm btn-block buttonFilter mt-1" Text="Limpiar" OnClick="Limpiar_Click"></asp:Button>
            </div>
        </div>

        <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>" DeleteCommand="DELETE FROM [Usuario] WHERE [idUsuario] = @idUsuario" InsertCommand="INSERT INTO [Usuario] ([nombreUsuario], [contraseñaUsuario], [rol]) VALUES (@nombreUsuario, @contraseñaUsuario, @rol)" SelectCommand="SELECT * FROM [Usuario]" UpdateCommand="UPDATE [Usuario] SET [nombreUsuario] = @nombreUsuario, [contraseñaUsuario] = @contraseñaUsuario, [rol] = @rol WHERE [idUsuario] = @idUsuario">
            <DeleteParameters>
                <asp:Parameter Name="idUsuario" Type="Int32"></asp:Parameter>
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
                <asp:Parameter Name="idUsuario" Type="Int32"></asp:Parameter>
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:GridView ID="GridView1" class="table mt-3" runat="server" AllowPaging="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" DataKeyNames="idUsuario" DataSourceID="SqlDataSource1" ForeColor="Black" GridLines="Vertical" AllowSorting="True">
            <AlternatingRowStyle BackColor="#CCCCCC" />
            <Columns>
                <asp:BoundField DataField="idUsuario" HeaderText="ID" ReadOnly="True" InsertVisible="False"></asp:BoundField>
                <asp:BoundField DataField="nombreUsuario" HeaderText="Usuario" SortExpression="nombreUsuario"></asp:BoundField>
                <asp:BoundField DataField="contrase&#241;aUsuario" HeaderText="Password"></asp:BoundField>

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

        <asp:Button ID="ButtonInsertar" CssClass="ButtonStyle button1 mt-3" runat="server" Text="Insertar" OnClick="Button1_Click" />
        <asp:SqlDataSource runat="server" ID="SqlDataSource2" DataSourceMode="DataReader" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>" DeleteCommand="DELETE FROM [Usuario] WHERE [idUsuario] = @idUsuario" InsertCommand="INSERT INTO [Usuario] ([nombreUsuario], [contraseñaUsuario], [rol]) VALUES (@nombreUsuario, @contraseñaUsuario, @rol)" SelectCommand="SELECT * FROM [Usuario]" UpdateCommand="UPDATE [Usuario] SET [nombreUsuario] = @nombreUsuario, [contraseñaUsuario] = @contraseñaUsuario, [rol] = @rol WHERE [idUsuario] = @idUsuario">
            <DeleteParameters>
                <asp:Parameter Name="idUsuario" Type="Int32"></asp:Parameter>
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
                <asp:Parameter Name="idUsuario" Type="Int32"></asp:Parameter>
            </UpdateParameters>
        </asp:SqlDataSource>

        <asp:Panel ID="Panel1" class="mt-3" runat="server" Height="196px" Visible="False">
            <asp:FormView ID="FormView1" class="form-control" runat="server" DataSourceID="SqlDataSource2" DataKeyNames="idUsuario" DefaultMode="Insert">
                <InsertItemTemplate>
                    <footerstyle backcolor="#990000" font-bold="True" forecolor="White" />
                    <headerstyle backcolor="#990000" font-bold="True" forecolor="White" />
                    <div class="row">
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
                <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
            </asp:FormView>
        </asp:Panel>

    </div>
</asp:Content>
