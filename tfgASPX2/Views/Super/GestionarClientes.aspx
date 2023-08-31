<%@ Page Language="C#" MasterPageFile="~/Master/Master1.Master" AutoEventWireup="true" CodeBehind="GestionarClientes.aspx.cs" Inherits="tfgASPX2.Views.Super.GestionarClientes" %>

<asp:Content ID="GestionarClientesHead" ContentPlaceHolderID="head" runat="server">
    <link href="../../Styles/GestionarClientesStyle.css" rel="stylesheet" />
    <link href="../../Styles/ComunesStyle.css" rel="stylesheet" />
    <style type="text/css">
        .auto-style5 {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            margin-top: 40px;
            height: 818px;
        }

        .auto-style6 {
            height: 404px;
        }

        .auto-style7 {
            display: block;
            width: 100%;
            font-size: 1rem;
            font-weight: 400;
            line-height: 1.5;
            color: #212529;
            background-clip: padding-box;
            -webkit-appearance: none;
            -moz-appearance: none;
            appearance: none;
            border-radius: .25rem;
            transition: none;
            height: 310px;
            border: 1px solid #ced4da;
            background-color: #fff;
        }
    </style>
</asp:Content>

<asp:Content ID="GestionarClientesNavegacion" ContentPlaceHolderID="ContentPlaceHolderNavegacion" runat="server">
    <a href="MenuSuper.aspx">Menú</a>
</asp:Content>

<asp:Content ID="GestionarClientesBody" ContentPlaceHolderID="ContentPlaceHolderContenido" runat="server">
    <div class="auto-style1">
        <h2 class="font-weight-bold">Gestión Clientes</h2>

        <div style="width: 250px">
            <div class="row">
                <div class="col">
                    <asp:Button ID="ButtonInsertarCliente" class="form-control btn-secondary btn-sm btn-block  mt-1" runat="server" Text="Insertar Cliente" OnClick="ButtonInsertarCliente_Click" />
                </div>
            </div>
            <div class="row">
                <div class="col">
                    <asp:Button ID="ButtonFiltros" class="form-control btn-secondary btn-sm btn-block  mt-1" runat="server" Text="Filtros" OnClick="ButtonFiltros_Click" />
                </div>
            </div>

            <asp:Panel ID="PanelFiltros" runat="server" Visible="False">
                <hr style="height: 2px; width: auto; border-width: 0; color: whitesmoke; background-color: whitesmoke">

                <%--Filtros--%>
                <div>
                    <div class="row">
                        <div class="col">
                            <%--Entidad--%>
                            <asp:Label ID="LabelFiltroEntidad" class="text-light" runat="server" Text="Entidad:"></asp:Label>
                            <asp:TextBox ID="TextBoxFiltradoEntidad" class="form-control" runat="server"></asp:TextBox>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col">
                            <%--Ubicacion D.F--%>
                            <asp:Label ID="LabelFiltroUbicacionDF" class="text-light" runat="server" Text="Ubicacion DF:"></asp:Label>
                            <asp:DropDownList ID="DropDownListUbicacionDF" class="form-control" runat="server"></asp:DropDownList>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col">
                            <%--Ubicacion D.E--%>
                            <asp:Label ID="LabelFiltroUbicacionDE" class="text-light" runat="server" Text="Ubicacion DE:"></asp:Label>
                            <asp:DropDownList ID="DropDownListUbicacionDE" class="form-control" runat="server"></asp:DropDownList>
                        </div>
                    </div>

                    <div class="text-center mt-2">
                        <asp:Button ID="ButtonFiltrado" class="form-control btn btn-primary btn-sm btn-block buttonFilter" runat="server" Text="Filtrar" OnClick="ButtonFiltrado_Click" />
                        <asp:Button runat="server" class="form-control btn-secondary btn-sm btn-block buttonFilter mt-1" Text="Limpiar" OnClick="Limpiar_Click"></asp:Button>
                    </div>
                </div>
            </asp:Panel>
        </div>

        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>" 
            DeleteCommand="DELETE FROM [Cliente] WHERE [codigoCliente] = @codigoCliente" 
            InsertCommand="INSERT INTO [Cliente] ([nombreEntidad], [DireccionDF], [CodigoPostalDF], [UbicacionDF], [BancoDF], [DireccionDE], [CodigoPostalDE], [UbicacionDE]) VALUES (@nombreEntidad, @DireccionDF, @CodigoPostalDF, @UbicacionDF, @BancoDF, @DireccionDE, @CodigoPostalDE, @UbicacionDE)" 
            SelectCommand="SELECT * FROM [Cliente] order by codigoCliente DESC"
            UpdateCommand="UPDATE [Cliente] SET [nombreEntidad] = @nombreEntidad, [DireccionDF] = @DireccionDF, [CodigoPostalDF] = @CodigoPostalDF, [UbicacionDF] = @UbicacionDF, [BancoDF] = @BancoDF, [DireccionDE] = @DireccionDE, [CodigoPostalDE] = @CodigoPostalDE, [UbicacionDE] = @UbicacionDE WHERE [codigoCliente] = @codigoCliente">
            <DeleteParameters>
                <asp:Parameter Name="codigoCliente" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="nombreEntidad" Type="String" />
                <asp:Parameter Name="DireccionDF" Type="String" />
                <asp:Parameter Name="CodigoPostalDF" Type="String" />
                <asp:Parameter Name="UbicacionDF" Type="String" />
                <asp:Parameter Name="BancoDF" Type="String" />
                <asp:Parameter Name="DireccionDE" Type="String" />
                <asp:Parameter Name="CodigoPostalDE" Type="String" />
                <asp:Parameter Name="UbicacionDE" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="nombreEntidad" Type="String" />
                <asp:Parameter Name="DireccionDF" Type="String" />
                <asp:Parameter Name="CodigoPostalDF" Type="String" />
                <asp:Parameter Name="UbicacionDF" Type="String" />
                <asp:Parameter Name="BancoDF" Type="String" />
                <asp:Parameter Name="DireccionDE" Type="String" />
                <asp:Parameter Name="CodigoPostalDE" Type="String" />
                <asp:Parameter Name="UbicacionDE" Type="String" />
                <asp:Parameter Name="codigoCliente" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:GridView ID="GridView1" class="mt-3 table tamanio-cliente" runat="server" AllowPaging="True" AllowSorting="true" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" DataKeyNames="codigoCliente" DataSourceID="SqlDataSource1" ForeColor="Black" GridLines="Vertical">
            <AlternatingRowStyle BackColor="#CCCCCC" />
            <Columns>
                <asp:BoundField DataField="codigoCliente" HeaderText="ID" InsertVisible="False" ReadOnly="True" />
                <asp:TemplateField HeaderText="Entidad" SortExpression="nombreEntidad">
                    <ItemTemplate>
                        <%# Eval("nombreEntidad") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox Text='<%# Bind("nombreEntidad") %>' class="form-control edit-textbox" runat="server" ID="nombreEntidadTextBox" />
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Domicilio Fiscal">
                    <ItemTemplate>
                        <%# Eval("DireccionDF") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox Text='<%# Bind("DireccionDF") %>' class="form-control edit-textbox" runat="server" ID="direccionDFTextBox" />
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Codigo Postal D.F">
                    <ItemTemplate>
                        <%# Eval("CodigoPostalDF") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox Text='<%# Bind("CodigoPostalDF") %>' class="form-control edit-textbox" runat="server" ID="codigoPostalDFTextBox" />
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Ubicacion D.F" SortExpression="UbicacionDF">
                    <ItemTemplate>
                        <%# Eval("UbicacionDF") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:DropDownList Text='<%# Bind("UbicacionDF") %>' class="form-control edit-dropdown" runat="server" ID="ubicacionDFDropDownList">
                            <asp:ListItem Text="Álava" Value="Álava" />
                            <asp:ListItem Text="Albacete" Value="Albacete" />
                            <asp:ListItem Text="Alicante" Value="Alicante" />
                            <asp:ListItem Text="Almería" Value="Almería" />
                            <asp:ListItem Text="Asturias" Value="Asturias" />
                            <asp:ListItem Text="Ávila" Value="Ávila" />
                            <asp:ListItem Text="Badajoz" Value="Badajoz" />
                            <asp:ListItem Text="Barcelona" Value="Barcelona" />
                            <asp:ListItem Text="Burgos" Value="Burgos" />
                            <asp:ListItem Text="Cáceres" Value="Cáceres" />
                            <asp:ListItem Text="Cádiz" Value="Cádiz" />
                            <asp:ListItem Text="Cantabria" Value="Cantabria" />
                            <asp:ListItem Text="Castellón" Value="Castellón" />
                            <asp:ListItem Text="Ciudad Real" Value="Ciudad Real" />
                            <asp:ListItem Text="Córdoba" Value="Córdoba" />
                            <asp:ListItem Text="Cuenca" Value="Cuenca" />
                            <asp:ListItem Text="Gerona" Value="Gerona" />
                            <asp:ListItem Text="Granada" Value="Granada" />
                            <asp:ListItem Text="Guadalajara" Value="Guadalajara" />
                            <asp:ListItem Text="Guipúzcoa" Value="Guipúzcoa" />
                            <asp:ListItem Text="Huelva" Value="Huelva" />
                            <asp:ListItem Text="Huesca" Value="Huesca" />
                            <asp:ListItem Text="Islas Baleares" Value="Islas Baleares" />
                            <asp:ListItem Text="Jaén" Value="Jaén" />
                            <asp:ListItem Text="La Coruña" Value="La Coruña" />
                            <asp:ListItem Text="La Rioja" Value="La Rioja" />
                            <asp:ListItem Text="Las Palmas" Value="Las Palmas" />
                            <asp:ListItem Text="León" Value="León" />
                            <asp:ListItem Text="Lérida" Value="Lérida" />
                            <asp:ListItem Text="Lugo" Value="Lugo" />
                            <asp:ListItem Text="Madrid" Value="Madrid" />
                            <asp:ListItem Text="Málaga" Value="Málaga" />
                            <asp:ListItem Text="Murcia" Value="Murcia" />
                            <asp:ListItem Text="Navarra" Value="Navarra" />
                            <asp:ListItem Text="Orense" Value="Orense" />
                            <asp:ListItem Text="Palencia" Value="Palencia" />
                            <asp:ListItem Text="Pontevedra" Value="Pontevedra" />
                            <asp:ListItem Text="Salamanca" Value="Salamanca" />
                            <asp:ListItem Text="Santa Cruz de Tenerife" Value="Santa Cruz de Tenerife" />
                            <asp:ListItem Text="Segovia" Value="Segovia" />
                            <asp:ListItem Text="Sevilla" Value="Sevilla" />
                            <asp:ListItem Text="Soria" Value="Soria" />
                            <asp:ListItem Text="Tarragona" Value="Tarragona" />
                            <asp:ListItem Text="Teruel" Value="Teruel" />
                            <asp:ListItem Text="Toledo" Value="Toledo" />
                            <asp:ListItem Text="Valencia" Value="Valencia" />
                            <asp:ListItem Text="Valladolid" Value="Valladolid" />
                            <asp:ListItem Text="Vizcaya" Value="Vizcaya" />
                            <asp:ListItem Text="Zamora" Value="Zamora" />
                            <asp:ListItem Text="Zaragoza" Value="Zaragoza" />
                        </asp:DropDownList>
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Banco D.F">
                    <ItemTemplate>
                        <%# Eval("BancoDF") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox Text='<%# Bind("BancoDF") %>' class="form-control edit-textbox" runat="server" ID="bancoDFTextBox" />
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Direccion D.E">
                    <ItemTemplate>
                        <%# Eval("DireccionDE") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox Text='<%# Bind("DireccionDE") %>' class="form-control edit-textbox" runat="server" ID="direccionDETextBox" />
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="CodigoPostal D.E">
                    <ItemTemplate>
                        <%# Eval("CodigoPostalDE") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox Text='<%# Bind("CodigoPostalDE") %>' class="form-control edit-textbox" runat="server" ID="codigoPostalDETextBox" />
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Ubicacion D.E" SortExpression="UbicacionDE">
                    <ItemTemplate>
                        <%# Eval("UbicacionDE") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:DropDownList Text='<%# Bind("UbicacionDE") %>' class="form-control edit-dropdown" runat="server" ID="ubicacionDEDropDownList">
                            <asp:ListItem Text="Álava" Value="Álava" />
                            <asp:ListItem Text="Albacete" Value="Albacete" />
                            <asp:ListItem Text="Alicante" Value="Alicante" />
                            <asp:ListItem Text="Almería" Value="Almería" />
                            <asp:ListItem Text="Asturias" Value="Asturias" />
                            <asp:ListItem Text="Ávila" Value="Ávila" />
                            <asp:ListItem Text="Badajoz" Value="Badajoz" />
                            <asp:ListItem Text="Barcelona" Value="Barcelona" />
                            <asp:ListItem Text="Burgos" Value="Burgos" />
                            <asp:ListItem Text="Cáceres" Value="Cáceres" />
                            <asp:ListItem Text="Cádiz" Value="Cádiz" />
                            <asp:ListItem Text="Cantabria" Value="Cantabria" />
                            <asp:ListItem Text="Castellón" Value="Castellón" />
                            <asp:ListItem Text="Ciudad Real" Value="Ciudad Real" />
                            <asp:ListItem Text="Córdoba" Value="Córdoba" />
                            <asp:ListItem Text="Cuenca" Value="Cuenca" />
                            <asp:ListItem Text="Gerona" Value="Gerona" />
                            <asp:ListItem Text="Granada" Value="Granada" />
                            <asp:ListItem Text="Guadalajara" Value="Guadalajara" />
                            <asp:ListItem Text="Guipúzcoa" Value="Guipúzcoa" />
                            <asp:ListItem Text="Huelva" Value="Huelva" />
                            <asp:ListItem Text="Huesca" Value="Huesca" />
                            <asp:ListItem Text="Islas Baleares" Value="Islas Baleares" />
                            <asp:ListItem Text="Jaén" Value="Jaén" />
                            <asp:ListItem Text="La Coruña" Value="La Coruña" />
                            <asp:ListItem Text="La Rioja" Value="La Rioja" />
                            <asp:ListItem Text="Las Palmas" Value="Las Palmas" />
                            <asp:ListItem Text="León" Value="León" />
                            <asp:ListItem Text="Lérida" Value="Lérida" />
                            <asp:ListItem Text="Lugo" Value="Lugo" />
                            <asp:ListItem Text="Madrid" Value="Madrid" />
                            <asp:ListItem Text="Málaga" Value="Málaga" />
                            <asp:ListItem Text="Murcia" Value="Murcia" />
                            <asp:ListItem Text="Navarra" Value="Navarra" />
                            <asp:ListItem Text="Orense" Value="Orense" />
                            <asp:ListItem Text="Palencia" Value="Palencia" />
                            <asp:ListItem Text="Pontevedra" Value="Pontevedra" />
                            <asp:ListItem Text="Salamanca" Value="Salamanca" />
                            <asp:ListItem Text="Santa Cruz de Tenerife" Value="Santa Cruz de Tenerife" />
                            <asp:ListItem Text="Segovia" Value="Segovia" />
                            <asp:ListItem Text="Sevilla" Value="Sevilla" />
                            <asp:ListItem Text="Soria" Value="Soria" />
                            <asp:ListItem Text="Tarragona" Value="Tarragona" />
                            <asp:ListItem Text="Teruel" Value="Teruel" />
                            <asp:ListItem Text="Toledo" Value="Toledo" />
                            <asp:ListItem Text="Valencia" Value="Valencia" />
                            <asp:ListItem Text="Valladolid" Value="Valladolid" />
                            <asp:ListItem Text="Vizcaya" Value="Vizcaya" />
                            <asp:ListItem Text="Zamora" Value="Zamora" />
                            <asp:ListItem Text="Zaragoza" Value="Zaragoza" />
                        </asp:DropDownList>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
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

        <asp:Panel ID="PanelInsertar" class="mt-3" runat="server" Height="348px" Visible="False">
            <div class="auto-style7">
                <asp:FormView ID="FormViewInsertarCliente" class="form-control" runat="server" DataSourceID="SqlDataSource1" DataKeyNames="codigoCliente" DefaultMode="Insert" CellPadding="4" ForeColor="#333333" OnItemInserting="FormViewInsertarCliente_ItemInserting" OnItemCommand="FormViewInsertarCliente_ItemCommand">
                    <FooterStyle BackColor="#990000" ForeColor="White" Font-Bold="True" />
                    <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                    <InsertItemTemplate>
                        <div class="row">
                            <div class="col text-center">
                                <h3>Insertar Cliente</h3>
                            </div>
                        </div>

                        <div class="row mt-3">
                            <div class="col">
                                Entidad:
                                    <asp:TextBox ID="nombreEntidadTextBox" class="form-control" data-toggle="tooltip" title="Nombre de la entidad" runat="server" Text='<%# Bind("nombreEntidad") %>' />
                            </div>
                            <div class="col">
                                DireccionDF:
                                    <asp:TextBox ID="DireccionDFTextBox" class="form-control" data-toggle="tooltip" title="Dirección del domicilio fiscal" runat="server" Text='<%# Bind("DireccionDF") %>' />
                            </div>
                        </div>

                        <div class="row">
                            <div class="col">
                                CodigoPostalDF:
                                    <asp:TextBox ID="CodigoPostalDFTextBox" class="form-control" data-toggle="tooltip" title="Codigo postal del domicilio fiscal" runat="server" Text='<%# Bind("CodigoPostalDF") %>' />
                            </div>
                            <div class="col">
                                UbicacionDF:
                                <asp:DropDownList Text='<%# Bind("UbicacionDF") %>' class="form-control edit-dropdown" runat="server" ID="ubicacionDFDropDownList">
                                    <asp:ListItem Text="Álava" Value="Álava" />
                                    <asp:ListItem Text="Albacete" Value="Albacete" />
                                    <asp:ListItem Text="Alicante" Value="Alicante" />
                                    <asp:ListItem Text="Almería" Value="Almería" />
                                    <asp:ListItem Text="Asturias" Value="Asturias" />
                                    <asp:ListItem Text="Ávila" Value="Ávila" />
                                    <asp:ListItem Text="Badajoz" Value="Badajoz" />
                                    <asp:ListItem Text="Barcelona" Value="Barcelona" />
                                    <asp:ListItem Text="Burgos" Value="Burgos" />
                                    <asp:ListItem Text="Cáceres" Value="Cáceres" />
                                    <asp:ListItem Text="Cádiz" Value="Cádiz" />
                                    <asp:ListItem Text="Cantabria" Value="Cantabria" />
                                    <asp:ListItem Text="Castellón" Value="Castellón" />
                                    <asp:ListItem Text="Ciudad Real" Value="Ciudad Real" />
                                    <asp:ListItem Text="Córdoba" Value="Córdoba" />
                                    <asp:ListItem Text="Cuenca" Value="Cuenca" />
                                    <asp:ListItem Text="Gerona" Value="Gerona" />
                                    <asp:ListItem Text="Granada" Value="Granada" />
                                    <asp:ListItem Text="Guadalajara" Value="Guadalajara" />
                                    <asp:ListItem Text="Guipúzcoa" Value="Guipúzcoa" />
                                    <asp:ListItem Text="Huelva" Value="Huelva" />
                                    <asp:ListItem Text="Huesca" Value="Huesca" />
                                    <asp:ListItem Text="Islas Baleares" Value="Islas Baleares" />
                                    <asp:ListItem Text="Jaén" Value="Jaén" />
                                    <asp:ListItem Text="La Coruña" Value="La Coruña" />
                                    <asp:ListItem Text="La Rioja" Value="La Rioja" />
                                    <asp:ListItem Text="Las Palmas" Value="Las Palmas" />
                                    <asp:ListItem Text="León" Value="León" />
                                    <asp:ListItem Text="Lérida" Value="Lérida" />
                                    <asp:ListItem Text="Lugo" Value="Lugo" />
                                    <asp:ListItem Text="Madrid" Value="Madrid" />
                                    <asp:ListItem Text="Málaga" Value="Málaga" />
                                    <asp:ListItem Text="Murcia" Value="Murcia" />
                                    <asp:ListItem Text="Navarra" Value="Navarra" />
                                    <asp:ListItem Text="Orense" Value="Orense" />
                                    <asp:ListItem Text="Palencia" Value="Palencia" />
                                    <asp:ListItem Text="Pontevedra" Value="Pontevedra" />
                                    <asp:ListItem Text="Salamanca" Value="Salamanca" />
                                    <asp:ListItem Text="Santa Cruz de Tenerife" Value="Santa Cruz de Tenerife" />
                                    <asp:ListItem Text="Segovia" Value="Segovia" />
                                    <asp:ListItem Text="Sevilla" Value="Sevilla" />
                                    <asp:ListItem Text="Soria" Value="Soria" />
                                    <asp:ListItem Text="Tarragona" Value="Tarragona" />
                                    <asp:ListItem Text="Teruel" Value="Teruel" />
                                    <asp:ListItem Text="Toledo" Value="Toledo" />
                                    <asp:ListItem Text="Valencia" Value="Valencia" />
                                    <asp:ListItem Text="Valladolid" Value="Valladolid" />
                                    <asp:ListItem Text="Vizcaya" Value="Vizcaya" />
                                    <asp:ListItem Text="Zamora" Value="Zamora" />
                                    <asp:ListItem Text="Zaragoza" Value="Zaragoza" />
                                </asp:DropDownList>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col">
                                BancoDF:
                                    <asp:TextBox ID="BancoDFTextBox" class="form-control" data-toggle="tooltip" title="Banco asignado al domicilio fiscal" runat="server" Text='<%# Bind("BancoDF") %>' />
                            </div>
                            <div class="col">
                                DireccionDE:
                                    <asp:TextBox ID="DireccionDETextBox" class="form-control" data-toggle="tooltip" title="Direccion del domicilio empresarial" runat="server" Text='<%# Bind("DireccionDE") %>' />
                            </div>
                        </div>

                        <div class="row">
                            <div class="col">
                                CodigoPostalDE:
                                    <asp:TextBox ID="CodigoPostalDETextBox" class="form-control" data-toggle="tooltip" title="Codigo postal del domicilio empresarial" runat="server" Text='<%# Bind("CodigoPostalDE") %>' />
                            </div>
                            <div class="col">
                                UbicacionDE:
                                <asp:DropDownList Text='<%# Bind("UbicacionDE") %>' class="form-control edit-dropdown" runat="server" ID="ubicacionDEDropDownList">
                                    <asp:ListItem Text="Álava" Value="Álava" />
                                    <asp:ListItem Text="Albacete" Value="Albacete" />
                                    <asp:ListItem Text="Alicante" Value="Alicante" />
                                    <asp:ListItem Text="Almería" Value="Almería" />
                                    <asp:ListItem Text="Asturias" Value="Asturias" />
                                    <asp:ListItem Text="Ávila" Value="Ávila" />
                                    <asp:ListItem Text="Badajoz" Value="Badajoz" />
                                    <asp:ListItem Text="Barcelona" Value="Barcelona" />
                                    <asp:ListItem Text="Burgos" Value="Burgos" />
                                    <asp:ListItem Text="Cáceres" Value="Cáceres" />
                                    <asp:ListItem Text="Cádiz" Value="Cádiz" />
                                    <asp:ListItem Text="Cantabria" Value="Cantabria" />
                                    <asp:ListItem Text="Castellón" Value="Castellón" />
                                    <asp:ListItem Text="Ciudad Real" Value="Ciudad Real" />
                                    <asp:ListItem Text="Córdoba" Value="Córdoba" />
                                    <asp:ListItem Text="Cuenca" Value="Cuenca" />
                                    <asp:ListItem Text="Gerona" Value="Gerona" />
                                    <asp:ListItem Text="Granada" Value="Granada" />
                                    <asp:ListItem Text="Guadalajara" Value="Guadalajara" />
                                    <asp:ListItem Text="Guipúzcoa" Value="Guipúzcoa" />
                                    <asp:ListItem Text="Huelva" Value="Huelva" />
                                    <asp:ListItem Text="Huesca" Value="Huesca" />
                                    <asp:ListItem Text="Islas Baleares" Value="Islas Baleares" />
                                    <asp:ListItem Text="Jaén" Value="Jaén" />
                                    <asp:ListItem Text="La Coruña" Value="La Coruña" />
                                    <asp:ListItem Text="La Rioja" Value="La Rioja" />
                                    <asp:ListItem Text="Las Palmas" Value="Las Palmas" />
                                    <asp:ListItem Text="León" Value="León" />
                                    <asp:ListItem Text="Lérida" Value="Lérida" />
                                    <asp:ListItem Text="Lugo" Value="Lugo" />
                                    <asp:ListItem Text="Madrid" Value="Madrid" />
                                    <asp:ListItem Text="Málaga" Value="Málaga" />
                                    <asp:ListItem Text="Murcia" Value="Murcia" />
                                    <asp:ListItem Text="Navarra" Value="Navarra" />
                                    <asp:ListItem Text="Orense" Value="Orense" />
                                    <asp:ListItem Text="Palencia" Value="Palencia" />
                                    <asp:ListItem Text="Pontevedra" Value="Pontevedra" />
                                    <asp:ListItem Text="Salamanca" Value="Salamanca" />
                                    <asp:ListItem Text="Santa Cruz de Tenerife" Value="Santa Cruz de Tenerife" />
                                    <asp:ListItem Text="Segovia" Value="Segovia" />
                                    <asp:ListItem Text="Sevilla" Value="Sevilla" />
                                    <asp:ListItem Text="Soria" Value="Soria" />
                                    <asp:ListItem Text="Tarragona" Value="Tarragona" />
                                    <asp:ListItem Text="Teruel" Value="Teruel" />
                                    <asp:ListItem Text="Toledo" Value="Toledo" />
                                    <asp:ListItem Text="Valencia" Value="Valencia" />
                                    <asp:ListItem Text="Valladolid" Value="Valladolid" />
                                    <asp:ListItem Text="Vizcaya" Value="Vizcaya" />
                                    <asp:ListItem Text="Zamora" Value="Zamora" />
                                    <asp:ListItem Text="Zaragoza" Value="Zaragoza" />
                                </asp:DropDownList>
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
            </div>
        </asp:Panel>
    </div>
</asp:Content>

