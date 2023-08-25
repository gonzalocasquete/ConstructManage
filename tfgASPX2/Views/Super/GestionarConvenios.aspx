<%@ Page Language="C#" MasterPageFile="~/Master/Master1.Master" AutoEventWireup="true" CodeBehind="GestionarConvenios.aspx.cs" Inherits="tfgASPX2.Views.Super.GestionarConvenios" %>

<asp:Content ID="GestionarConveniosHead" ContentPlaceHolderID="head" runat="server">
    <link href="../../Styles/GestionarConveniosStyles.css" rel="stylesheet" />
    <link href="../../Styles/ComunesStyle.css" rel="stylesheet" />
    <script src="../../Scripts/Views/GestionarConvenioStyle.js"></script>
</asp:Content>

<asp:Content ID="GestionarConveniosNavegacion" ContentPlaceHolderID="ContentPlaceHolderNavegacion" runat="server">
    <a href="MenuSuper.aspx">Menú</a>
</asp:Content>

<asp:Content ID="GestionarConveniosBody" ContentPlaceHolderID="ContentPlaceHolderContenido" runat="server">
    <div class="auto-style1">

        <h2 class="font-weight-bold">Gestión de Convenios</h2>

        <div style="width: 250px">
            <div class="row">
                <div class="col">
                    <asp:Button ID="ButtonInsertarConvenio" class="form-control btn-secondary btn-sm btn-block mt-1" runat="server" Text="Insertar Convenio" OnClick="ButtonInsertarConvenio_Click" />
                </div>
            </div>

            <div class="row">
                <div class="col">
                    <asp:Button ID="ButtonFiltros" class="form-control btn-secondary btn-sm btn-block mt-1" runat="server" Text="Filtros" OnClick="ButtonFiltros_Click" />
                </div>
            </div>

            <div class="row">
                <div class="col">
                    <asp:Button ID="ButtonInsertarAsociacion" class="form-control btn-info btn-sm btn-block mt-1" runat="server" Text="Insertar Partida" OnClick="ButtonInsertarAsociacion_Click" Visible="false" />
                </div>
            </div>

            <div class="row">
                <div class="col">
                    <asp:Button ID="ButtonVolver" class="form-control btn-warning btn-sm btn-block mt-1" runat="server" Text="Volver" OnClick="ButtonVolver_Click" Visible="false" />
                </div>
            </div>

            <asp:Panel ID="PanelFiltros" runat="server" Visible="False">
                <%--Filtros--%>
                <hr style="height: 2px; width: auto; border-width: 0; color: whitesmoke; background-color: whitesmoke">
                <div>
                    <div class="row">
                        <div class="col">
                            <%--Nombre Convenio--%>
                            <asp:Label ID="LabelFiltroConvenio" class="text-light" runat="server" Text="Convenio:"></asp:Label>
                            <asp:TextBox ID="TextBoxFiltradoConvenio" class="form-control" runat="server"></asp:TextBox>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col">
                            <%--Fecha de Inicio--%>
                            <asp:Label ID="LabelFechaMinima" class="text-light" for="fechaMinima" runat="server" Text="Fecha Minima:"></asp:Label>
                            <%--                    <input id="fechaMinima" class="form-control" runat="server" type="date" name="fechaMinima">--%>
                        </div>
                        <div class="col">
                            <%--Fecha de Fin--%>
                            <asp:Label ID="LabelFechaMaxima" class="text-light" for="fechaMaxima" runat="server" Text="Fecha Maxima:"></asp:Label>
                            <%--                    <input id="fechaMaxima" class="form-control" runat="server" type="date" name="fechaMaxima" onchange="validarFechaMaxima(this)">--%>
                        </div>
                    </div>

                    <div class="text-center mt-2">
                        <asp:Button ID="ButtonFiltrado" class="form-control btn btn-primary btn-sm btn-block buttonFilter" runat="server" Text="Filtrar" OnClick="ButtonFiltrado_Click" />
                        <asp:Button runat="server" class="form-control btn-secondary btn-sm btn-block buttonFilter mt-1" Text="Limpiar" OnClick="Todos_Click"></asp:Button>
                    </div>
                </div>
            </asp:Panel>
        </div>

        <asp:SqlDataSource runat="server" ID="SqlDataSource1"
            ConnectionString='<%$ ConnectionStrings:mibasededatostfgConnectionString %>'
            DeleteCommand="DELETE FROM [Convenio] WHERE [codigoConvenio] = @codigoConvenio"
            InsertCommand="INSERT INTO [Convenio] ([fechaInicio], [fechaFin], [nombreConvenio], [Ubicacion]) VALUES (@fechaInicio, @fechaFin, @nombreConvenio, @Ubicacion)"
            SelectCommand="SELECT * FROM [Convenio]"
            UpdateCommand="UPDATE [Convenio] SET [fechaInicio] = @fechaInicio, [fechaFin] = @fechaFin, [nombreConvenio] = @nombreConvenio WHERE [codigoConvenio] = @codigoConvenio">
            <DeleteParameters>
                <asp:Parameter Name="codigoConvenio" Type="Int32"></asp:Parameter>
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter DbType="Date" Name="fechaInicio"></asp:Parameter>
                <asp:Parameter DbType="Date" Name="fechaFin"></asp:Parameter>
                <asp:Parameter Name="Ubicacion" Type="String"></asp:Parameter>
                <asp:Parameter Name="nombreConvenio" Type="String"></asp:Parameter>
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter DbType="Date" Name="fechaInicio"></asp:Parameter>
                <asp:Parameter DbType="Date" Name="fechaFin"></asp:Parameter>
                <asp:Parameter Name="nombreConvenio" Type="String"></asp:Parameter>
                <asp:Parameter Name="Ubicacion" Type="String"></asp:Parameter>
                <asp:Parameter Name="codigoConvenio" Type="Int32"></asp:Parameter>
            </UpdateParameters>
        </asp:SqlDataSource>

        <asp:GridView ID="GridView1" class="table mt-3 tamanio-convenio" runat="server" AutoGenerateColumns="False" DataKeyNames="codigoConvenio" DataSourceID="SqlDataSource1" AllowPaging="True" AllowSorting="True" BackColor="WhiteSmoke" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
            <AlternatingRowStyle BackColor="#CCCCCC" />
            <Columns>
                <asp:BoundField DataField="codigoConvenio" HeaderText="ID" ReadOnly="True" InsertVisible="False" SortExpression="codigoConvenio"></asp:BoundField>

                <asp:TemplateField HeaderText="Convenio">
                    <ItemTemplate>
                        <%# Eval("nombreConvenio") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox runat="server" class="form-control edit-textbox" ID="txtNombreConvenio" Text='<%# Bind("nombreConvenio") %>' />
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Fecha Inicio">
                    <ItemTemplate>
                        <%# Eval("fechaInicio", "{0:dd/MM/yyyy}") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox runat="server" class="form-control edit-textbox" ID="txtFechaInicio" Text='<%# Bind("fechaInicio", "{0:dd/MM/yyyy}") %>' />
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Fecha Fin">
                    <ItemTemplate>
                        <%# Eval("fechaFin", "{0:dd/MM/yyyy}") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox runat="server" class="form-control edit-textbox" ID="txtFechaFin" Text='<%# Bind("fechaFin", "{0:dd/MM/yyyy}") %>' />
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Ubicacion">
                    <ItemTemplate>
                        <%# Eval("Ubicacion") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:DropDownList Text='<%# Bind("Ubicacion") %>' class="form-control edit-dropdown" runat="server" ID="IDUbicacion">
                            <asp:ListItem Text="Andalucía" Value="Andalucía" />
                            <asp:ListItem Text="Aragón" Value="Aragón" />
                            <asp:ListItem Text="Asturias" Value="Asturias" />
                            <asp:ListItem Text="Islas Baleares" Value="Islas Baleares" />
                            <asp:ListItem Text="Canarias" Value="Canarias" />
                            <asp:ListItem Text="Cantabria" Value="Cantabria" />
                            <asp:ListItem Text="Castilla-La Mancha" Value="Castilla-La Mancha" />
                            <asp:ListItem Text="Castilla y León" Value="Castilla y León" />
                            <asp:ListItem Text="Cataluña" Value="Cataluña" />
                            <asp:ListItem Text="Extremadura" Value="Extremadura" />
                            <asp:ListItem Text="Galicia" Value="Galicia" />
                            <asp:ListItem Text="La Rioja" Value="La Rioja" />
                            <asp:ListItem Text="Comunidad de Madrid" Value="Comunidad de Madrid" />
                            <asp:ListItem Text="Región de Murcia" Value="Región de Murcia" />
                            <asp:ListItem Text="Navarra" Value="Navarra" />
                            <asp:ListItem Text="País Vasco" Value="País Vasco" />
                            <asp:ListItem Text="Comunidad Valenciana" Value="Comunidad Valenciana" />
                        </asp:DropDownList>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" ShowSelectButton="True" SelectText="AsociacionCategorias"></asp:CommandField>
            </Columns>
            <FooterStyle BackColor="#CCCCCC" />
            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
        </asp:GridView>

        <div class="mt-3">
            <asp:Panel ID="PanelMostrarAsociaciones" runat="server" Visible="False">
                <asp:SqlDataSource runat="server" ID="SqlDataSource2" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>" DeleteCommand="DELETE FROM [AsociacionCostes] WHERE [codigoAsociacionCoste] = @codigoAsociacionCoste" InsertCommand="INSERT INTO [AsociacionCostes] ([codigoConvenio], [codigoCategoria], [precioHora], [precioHoraExtra], [horasMaxDia]) VALUES (@codigoConvenio, @codigoCategoria, @precioHora, @precioHoraExtra, @horasMaxDia)" SelectCommand="SELECT * FROM [AsociacionCostes] WHERE ([codigoConvenio] = @codigoConvenio)" UpdateCommand="UPDATE [AsociacionCostes] SET [codigoConvenio] = @codigoConvenio, [codigoCategoria] = @codigoCategoria, [precioHora] = @precioHora, [precioHoraExtra] = @precioHoraExtra, [horasMaxDia] = @horasMaxDia WHERE [codigoAsociacionCoste] = @codigoAsociacionCoste">
                    <DeleteParameters>
                        <asp:Parameter Name="codigoAsociacionCoste" Type="Int32"></asp:Parameter>
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="codigoConvenio" Type="Int32"></asp:Parameter>
                        <asp:Parameter Name="codigoCategoria" Type="Int32"></asp:Parameter>
                        <asp:Parameter Name="precioHora" Type="Decimal"></asp:Parameter>
                        <asp:Parameter Name="precioHoraExtra" Type="Decimal"></asp:Parameter>
                        <asp:Parameter Name="horasMaxDia" Type="Int32"></asp:Parameter>
                    </InsertParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="GridView1" PropertyName="SelectedValue" DefaultValue="" Name="codigoConvenio" Type="Int32"></asp:ControlParameter>
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="codigoConvenio" Type="Int32"></asp:Parameter>
                        <asp:Parameter Name="codigoCategoria" Type="Int32"></asp:Parameter>
                        <asp:Parameter Name="precioHora" Type="Decimal"></asp:Parameter>
                        <asp:Parameter Name="precioHoraExtra" Type="Decimal"></asp:Parameter>
                        <asp:Parameter Name="horasMaxDia" Type="Int32"></asp:Parameter>
                        <asp:Parameter Name="codigoAsociacionCoste" Type="Int32"></asp:Parameter>
                    </UpdateParameters>
                </asp:SqlDataSource>

                <asp:GridView ID="GridView2" runat="server" DataSourceID="SqlDataSource2" AutoGenerateColumns="False" DataKeyNames="codigoAsociacionCoste" AllowPaging="True" BackColor="WhiteSmoke" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical" AllowSorting="True">
                    <Columns>
                        <asp:BoundField DataField="codigoAsociacionCoste" HeaderText="ID" ReadOnly="True" InsertVisible="False" SortExpression="codigoAsociacionCoste"></asp:BoundField>
                        <asp:BoundField DataField="codigoConvenio" HeaderText="Convenio" SortExpression="codigoConvenio"></asp:BoundField>
                        <asp:BoundField DataField="codigoCategoria" HeaderText="Categoria" SortExpression="codigoCategoria"></asp:BoundField>
                        <asp:BoundField DataField="precioHora" HeaderText="PrecioHora" SortExpression="precioHora"></asp:BoundField>
                        <asp:BoundField DataField="precioHoraExtra" HeaderText="PrecioHoraExtra" SortExpression="precioHoraExtra"></asp:BoundField>
                        <asp:BoundField DataField="horasMaxDia" HeaderText="HorasMaxDia" SortExpression="horasMaxDia"></asp:BoundField>
                        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True"></asp:CommandField>
                    </Columns>
                    <FooterStyle BackColor="#CCCCCC" />
                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                </asp:GridView>
            </asp:Panel>
        </div>

        <asp:Panel ID="PanelInsertarAsociacion" runat="server" Visible="false">
            HolaMundo
        </asp:Panel>

        <asp:Panel ID="PanelInsertarConvenio" class="mt-3" runat="server" Visible="False">
        </asp:Panel>
    </div>

    <asp:SqlDataSource runat="server" ID="SqlDataSource3" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>" DeleteCommand="DELETE FROM [AsociacionCostes] WHERE [codigoAsociacionCoste] = @codigoAsociacionCoste" InsertCommand="INSERT INTO [AsociacionCostes] ([codigoConvenio], [codigoCategoria], [precioHora], [precioHoraExtra], [horasMaxDia]) VALUES (@codigoConvenio, @codigoCategoria, @precioHora, @precioHoraExtra, @horasMaxDia)" SelectCommand="SELECT * FROM [AsociacionCostes]" UpdateCommand="UPDATE [AsociacionCostes] SET [codigoConvenio] = @codigoConvenio, [codigoCategoria] = @codigoCategoria, [precioHora] = @precioHora, [precioHoraExtra] = @precioHoraExtra, [horasMaxDia] = @horasMaxDia WHERE [codigoAsociacionCoste] = @codigoAsociacionCoste">
        <DeleteParameters>
            <asp:Parameter Name="codigoAsociacionCoste" Type="Int32"></asp:Parameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="codigoConvenio" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="codigoCategoria" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="precioHora" Type="Decimal"></asp:Parameter>
            <asp:Parameter Name="precioHoraExtra" Type="Decimal"></asp:Parameter>
            <asp:Parameter Name="horasMaxDia" Type="Int32"></asp:Parameter>
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="codigoConvenio" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="codigoCategoria" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="precioHora" Type="Decimal"></asp:Parameter>
            <asp:Parameter Name="precioHoraExtra" Type="Decimal"></asp:Parameter>
            <asp:Parameter Name="horasMaxDia" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="codigoAsociacionCoste" Type="Int32"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:FormView ID="FormView1" runat="server" DataSourceID="SqlDataSource3" DefaultMode="Insert" DataKeyNames="codigoAsociacionCoste">
        <InsertItemTemplate>
            codigoConvenio:
            <asp:TextBox Text='<%# Bind("codigoConvenio") %>' runat="server" ID="codigoConvenioTextBox" /><br />
            codigoCategoria:
            <asp:TextBox Text='<%# Bind("codigoCategoria") %>' runat="server" ID="codigoCategoriaTextBox" /><br />
            precioHora:
            <asp:TextBox Text='<%# Bind("precioHora") %>' runat="server" ID="precioHoraTextBox" /><br />
            precioHoraExtra:
            <asp:TextBox Text='<%# Bind("precioHoraExtra") %>' runat="server" ID="precioHoraExtraTextBox" /><br />
            horasMaxDia:
            <asp:TextBox Text='<%# Bind("horasMaxDia") %>' runat="server" ID="horasMaxDiaTextBox" /><br />
            <asp:LinkButton runat="server" Text="Insertar" CommandName="Insert" ID="InsertButton" CausesValidation="True" />&nbsp;<asp:LinkButton runat="server" Text="Cancelar" CommandName="Cancel" ID="InsertCancelButton" CausesValidation="False" />
        </InsertItemTemplate>

    </asp:FormView>

</asp:Content>
