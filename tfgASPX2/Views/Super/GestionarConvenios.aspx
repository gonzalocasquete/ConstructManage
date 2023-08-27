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
                            <input id="fechaMinima" class="form-control" runat="server" type="date" name="fechaMinima">
                        </div>
                        <div class="col">
                            <%--Fecha de Fin--%>
                            <asp:Label ID="LabelFechaMaxima" class="text-light" for="fechaMaxima" runat="server" Text="Fecha Maxima:"></asp:Label>
                            <input id="fechaMaxima" class="form-control" runat="server" type="date" name="fechaMaxima" onchange="validarFechaMaxima(this)">
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
            SelectCommand="SELECT * FROM [Convenio] order by codigoConvenio DESC"
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
                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" ShowSelectButton="True" SelectText="Detalles"></asp:CommandField>
            </Columns>
            <FooterStyle BackColor="#CCCCCC" />
            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
        </asp:GridView>

        <div class="mt-3">
            <asp:Panel ID="PanelMostrarAsociaciones" runat="server" Visible="False">
                <asp:SqlDataSource runat="server" ID="SqlDataSource2" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>"
                    DeleteCommand="DELETE FROM [AsociacionCostes] WHERE [codigoAsociacionCoste] = @codigoAsociacionCoste"
                    InsertCommand="INSERT INTO [AsociacionCostes] ([codigoConvenio], [codigoCategoria], [precioHora], [precioHoraExtra], [horasMaxDia]) VALUES (@codigoConvenio, @codigoCategoria, @precioHora, @precioHoraExtra, @horasMaxDia)"
                    SelectCommand="SELECT A.*, C.nombreConvenio, Ca.nombreCategoria FROM AsociacionCostes A INNER JOIN Convenio C ON A.codigoConvenio = C.codigoConvenio INNER JOIN CategoriaProfesional Ca ON A.codigoCategoria = Ca.codigoCategoria WHERE A.codigoConvenio = @codigoConvenio  ORDER BY A.codigoAsociacionCoste DESC;"
                    UpdateCommand="UPDATE [AsociacionCostes] SET [codigoConvenio] = @codigoConvenio, [codigoCategoria] = @codigoCategoria, [precioHora] = @precioHora, [precioHoraExtra] = @precioHoraExtra, [horasMaxDia] = @horasMaxDia WHERE [codigoAsociacionCoste] = @codigoAsociacionCoste">
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

                <asp:GridView ID="GridView2" class="table mt-3 tamanio-asociacion" runat="server" DataSourceID="SqlDataSource2" AutoGenerateColumns="False" DataKeyNames="codigoAsociacionCoste" AllowPaging="True" BackColor="WhiteSmoke" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical" AllowSorting="True">
                    <AlternatingRowStyle BackColor="#CCCCCC" />
                    <Columns>
                        <asp:BoundField DataField="codigoAsociacionCoste" HeaderText="ID" ReadOnly="True" InsertVisible="False" SortExpression="codigoAsociacionCoste"></asp:BoundField>
                        <asp:TemplateField HeaderText="Convenio" SortExpression="codigoConvenio">
                            <ItemTemplate>
                                <%# Eval("nombreConvenio") %>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList Text='<%# Bind("codigoConvenio") %>' class="dropdown form-control edit-dropdown" ID="idConveniosDropDownList" runat="server" DataSourceID="ConveniosSqlDataSource" DataTextField="nombreConvenio" DataValueField="codigoConvenio"></asp:DropDownList>
                                <asp:SqlDataSource ID="ConveniosSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>" SelectCommand="SELECT codigoConvenio, nombreConvenio FROM Convenio order by nombreConvenio"></asp:SqlDataSource>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Categoria" SortExpression="codigoCategoria">
                            <ItemTemplate>
                                <%# Eval("nombreCategoria") %>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList Text='<%# Bind("codigoCategoria") %>' class="dropdown form-control edit-dropdown" ID="idCategoriasDropDownList" runat="server" DataSourceID="CategoriasSqlDataSource" DataTextField="nombreCategoria" DataValueField="codigoCategoria"></asp:DropDownList>
                                <asp:SqlDataSource ID="CategoriasSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>" SelectCommand="SELECT codigoCategoria, nombreCategoria FROM CategoriaProfesional order by nombreCategoria"></asp:SqlDataSource>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="PrecioHora" SortExpression="precioHora">
                            <ItemTemplate>
                                <%# Eval("precioHora") %>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <input type="number" step="any" class="form-control edit-textbox" id="txtPrecioHora" runat="server" value='<%# Bind("precioHora", "{0:F2}") %>' />
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="PrecioHoraExtra" SortExpression="precioHoraExtra">
                            <ItemTemplate>
                                <%# Eval("precioHoraExtra") %>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <input type="number" step="any" class="form-control edit-textbox" id="txtPrecioHoraExtra" runat="server" value='<%# Bind("precioHoraExtra", "{0:F2}") %>' />
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="HorasMaxDia" SortExpression="horasMaxDia">
                            <ItemTemplate>
                                <%# Eval("horasMaxDia") %>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <input type="number" class="form-control edit-textbox" id="txtHorasMaxDia" runat="server" value='<%# Bind("horasMaxDia") %>' />
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True"></asp:CommandField>
                    </Columns>
                    <FooterStyle BackColor="#CCCCCC" />
                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                </asp:GridView>

            </asp:Panel>
        </div>

        <asp:Panel ID="PanelInsertarAsociacion" class="mt-3" runat="server" Visible="False">

            <asp:SqlDataSource runat="server" ID="SqlDataSourceInsertarAsociacion" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>" DeleteCommand="DELETE FROM [AsociacionCostes] WHERE [codigoAsociacionCoste] = @codigoAsociacionCoste" InsertCommand="INSERT INTO [AsociacionCostes] ([codigoConvenio], [codigoCategoria], [precioHora], [precioHoraExtra], [horasMaxDia]) VALUES (@codigoConvenio, @codigoCategoria, @precioHora, @precioHoraExtra, @horasMaxDia)" SelectCommand="SELECT * FROM [AsociacionCostes]" UpdateCommand="UPDATE [AsociacionCostes] SET [codigoConvenio] = @codigoConvenio, [codigoCategoria] = @codigoCategoria, [precioHora] = @precioHora, [precioHoraExtra] = @precioHoraExtra, [horasMaxDia] = @horasMaxDia WHERE [codigoAsociacionCoste] = @codigoAsociacionCoste">
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

            <asp:FormView ID="FormViewInsertarAsociacion" class="form-control" runat="server" DataSourceID="SqlDataSourceInsertarAsociacion" DefaultMode="Insert" DataKeyNames="codigoAsociacionCoste" OnItemInserting="FormViewInsertarAsociacion_ItemInserting" OnItemCommand="FormViewInsertarAsociacion_ItemCommand">
                <FooterStyle BackColor="#990000" ForeColor="White" Font-Bold="True" />
                <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <InsertItemTemplate>
                    <div class="row">
                        <div class="col text-center">
                            <h3>Insertar Asociacion</h3>
                        </div>
                    </div>

                    <asp:TextBox Text='<%# Bind("codigoConvenio") %>' class="form-control" runat="server" ID="codigoConvenioTextBoxInsertarAsociacion" Visible="false" /><br />

                    <div class="row">
                        <div class="col">
                            Convenio:
                            <asp:DropDownList Text='<%# Bind("codigoConvenio") %>' class="dropdown form-control" ID="idConveniosDropDownList" runat="server" DataSourceID="ConveniosSqlDataSourceInsertar" DataTextField="nombreConvenio" DataValueField="codigoConvenio" AppendDataBoundItems="true"></asp:DropDownList>
                            <asp:SqlDataSource ID="ConveniosSqlDataSourceInsertar" runat="server" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>" SelectCommand="SELECT nombreConvenio, codigoConvenio FROM Convenio;"></asp:SqlDataSource>
                        </div>
                        <div class="col">
                            Horas Máximas Día:
                            <input type="number" value='<%# Bind("horasMaxDia") %>' class="form-control" runat="server" id="HorasMaxDiaInput" />
                        </div>
                    </div>

                    <div class="row">
                        <div class="col">
                            Precio Hora:
                            <input type="text" value='<%# Bind("precioHora") %>' class="form-control" runat="server" id="PrecioHoraInput" onblur="replaceCommaWithDot(this)" />
                        </div>
                        <div class="col">
                            Precio Hora Extra:
                            <input type="text" value='<%# Bind("precioHoraExtra") %>' class="form-control" runat="server" id="PrecioHoraExtraInput" onblur="replaceCommaWithDot(this)" />
                        </div>
                    </div>

                    <div class="mt-3 text-center">
                        <asp:LinkButton runat="server" class="btn btn-success" Text="Insertar" CommandName="Insert" ID="InsertButton" CausesValidation="True" />
                        &nbsp;
                       <asp:LinkButton runat="server" class="btn btn-danger" Text="Cancelar" CommandName="Cancel" ID="InsertCancelButton" CausesValidation="False" />
                    </div>
                </InsertItemTemplate>
                <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                <RowStyle BackColor="#6c757d" ForeColor="White" />
            </asp:FormView>
        </asp:Panel>

        <asp:Panel ID="PanelInsertarConvenio" class="mt-3" runat="server" Visible="False">
            <asp:SqlDataSource runat="server" ID="SqlDataSourceInsertarConvenio" ConnectionString='<%$ ConnectionStrings:mibasededatostfgConnectionString %>' DeleteCommand="DELETE FROM [Convenio] WHERE [codigoConvenio] = @codigoConvenio" InsertCommand="INSERT INTO [Convenio] ([fechaInicio], [fechaFin], [nombreConvenio], [Ubicacion]) VALUES (@fechaInicio, @fechaFin, @nombreConvenio, @Ubicacion)" SelectCommand="SELECT * FROM [Convenio]" UpdateCommand="UPDATE [Convenio] SET [fechaInicio] = @fechaInicio, [fechaFin] = @fechaFin, [nombreConvenio] = @nombreConvenio, [Ubicacion] = @Ubicacion WHERE [codigoConvenio] = @codigoConvenio">
                <DeleteParameters>
                    <asp:Parameter Name="codigoConvenio" Type="Int32"></asp:Parameter>
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter DbType="Date" Name="fechaInicio"></asp:Parameter>
                    <asp:Parameter DbType="Date" Name="fechaFin"></asp:Parameter>
                    <asp:Parameter Name="nombreConvenio" Type="String"></asp:Parameter>
                    <asp:Parameter Name="Ubicacion" Type="String"></asp:Parameter>
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter DbType="Date" Name="fechaInicio"></asp:Parameter>
                    <asp:Parameter DbType="Date" Name="fechaFin"></asp:Parameter>
                    <asp:Parameter Name="nombreConvenio" Type="String"></asp:Parameter>
                    <asp:Parameter Name="Ubicacion" Type="String"></asp:Parameter>
                    <asp:Parameter Name="codigoConvenio" Type="Int32"></asp:Parameter>
                </UpdateParameters>
            </asp:SqlDataSource>

            <asp:FormView ID="FormViewInsertarConvenio" class="form-control" runat="server" DataKeyNames="codigoConvenio" DataSourceID="SqlDataSourceInsertarConvenio" DefaultMode="Insert" OnItemInserting="FormViewInsertarConvenio_ItemInserting" OnItemCommand="FormViewInsertarConvenio_ItemCommand">
                <FooterStyle BackColor="#990000" ForeColor="White" Font-Bold="True" />
                <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <InsertItemTemplate>

                    <div class="row">
                        <div class="col text-center">
                            <h3>Insertar Convenio</h3>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col">
                            Convenio:
                            <asp:TextBox Text='<%# Bind("nombreConvenio") %>' class="form-control" runat="server" ID="nombreConvenioTextBoxInsertarConvenio" />
                        </div>
                        <div class="col">
                            Ubicacion:
                            <asp:TextBox Text='<%# Bind("Ubicacion") %>' class="form-control" runat="server" ID="UbicacionTextBox" />
                        </div>
                    </div>

                    <div class="row">
                        <div class="col">
                            Fecha Inicio:
                            <input type="date" id="fechaInicioTextBoxInsertarConvenio" class="form-control" data-toggle="tooltip" title="Fecha de alta del convenio" runat="server" value='<%# Bind("fechaInicio", "{0:yyyy-MM-dd}") %>' />
                        </div>
                        <div class="col">
                            Fecha Fin:
                            <input type="date" id="fechaFinTextBoxInsertarConvenio" class="form-control" data-toggle="tooltip" title="Fecha en la que el convenio ya no es válido" runat="server" value='<%# Bind("fechaFin", "{0:yyyy-MM-dd}") %>' />
                        </div>
                    </div>

                    <div class="mt-3 text-center">
                        <asp:LinkButton runat="server" class="btn btn-success" Text="Insertar" CommandName="Insert" ID="InsertButtonConvenio" CausesValidation="True" />
                        &nbsp;
                        <asp:LinkButton runat="server" class="btn btn-danger" Text="Cancelar" CommandName="Cancel" ID="InsertCancelButtonConvenio" CausesValidation="False" />
                    </div>
                </InsertItemTemplate>
                <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                <RowStyle BackColor="#6c757d" ForeColor="White" />
            </asp:FormView>
        </asp:Panel>
    </div>

    <script>
        function replaceCommaWithDot(input) {
            input.value = input.value.replace(",", ".");
        }
    </script>

</asp:Content>
