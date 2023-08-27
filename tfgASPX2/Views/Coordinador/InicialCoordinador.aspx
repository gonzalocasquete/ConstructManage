<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Master1.Master" AutoEventWireup="true" CodeBehind="InicialCoordinador.aspx.cs" Inherits="tfgASPX2.Views.Coordinador.InicialCoordinador" %>

<asp:Content ID="InicialCoordinadorHead" ContentPlaceHolderID="head" runat="server">
    <link href="../../Styles/InicialCoordinadorStyle.css" rel="stylesheet" />
    <link href="../../Styles/ComunesStyle.css" rel="stylesheet" />
    <script src="../../Scripts/Views/InicialCoordinadorScript.js"></script>
</asp:Content>

<asp:Content ID="InicialCoordinadorNavegacion" ContentPlaceHolderID="ContentPlaceHolderNavegacion" runat="server">
    <a href="InicialCoordinador.aspx">Inicio</a>
    <a href="ConsularProyectos.aspx">Proyectos</a>
    <a href="../Comun/Perfil.aspx">Perfil</a>
</asp:Content>

<asp:Content ID="InicialCoordinadorBody" ContentPlaceHolderID="ContentPlaceHolderContenido" runat="server">
    <div class="auto-style1">

        <h2 class="font-weight-bold">
            <asp:Label ID="LabelMensajeBienvenida" runat="server"></asp:Label>
        </h2>

        <%--  Filtros--%>
        <div style="width: 250px">

            <div class="row">
                <div class="col">
                    <asp:Button ID="ButtonInsertarParte" class="form-control btn-secondary btn-sm btn-block buttonFilter mt-1" runat="server" Text="Insertar Parte" OnClick="ButtonInsertarParte_Click" />
                </div>
            </div>

            <div class="row">
                <div class="col">
                    <asp:Button ID="ButtonFiltros" class="form-control btn-secondary btn-sm btn-block buttonFilter mt-1" runat="server" Text="Filtros" OnClick="ButtonFiltros_Click" />
                </div>
            </div>

            <div class="row">
                <div class="col">
                    <asp:Button ID="ButtonInsertarLinea" class="form-control btn-info btn-sm btn-block buttonFilter mt-1" runat="server" Text="Insertar Linea" OnClick="ButtonInsertarLinea_Click" Visible="false" />
                </div>
            </div>

            <div class="row">
                <div class="col">
                    <asp:Button ID="ButtonVolver" class="form-control btn-warning btn-sm btn-block mt-1" runat="server" Text="Volver" OnClick="ButtonVolver_Click" Visible="false" />
                </div>
            </div>



            <asp:Panel ID="PanelFiltros" runat="server" Visible="False">
                <hr style="margin-bottom: 2px;" />
                <div>
                    <div class="row">
                        <div class="col">
                            <%-- Proyecto--%>
                            <asp:Label ID="LabelFiltroProyecto" class="text-light" runat="server" Text="Proyecto:"></asp:Label>
                            <asp:TextBox ID="TextBoxFiltradoProyecto" class="form-control" runat="server"></asp:TextBox>
                        </div>
                        <div class="col">
                            <%--Cliente--%>
                            <asp:Label ID="LabelCliente" class="text-light" runat="server" Text="Cliente:"></asp:Label>
                            <asp:TextBox ID="TextBoxFiltradoCliente" class="form-control" runat="server"></asp:TextBox>
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
                            <input id="fechaMaxima" class="form-control" runat="server" type="date" name="fechaMaxima" max="2023-12-31" onclick="showDatePicker()">
                        </div>
                    </div>

                    <div class="row">
                        <div class="col">
                            <%--Tipo--%>
                            <asp:Label ID="LabelFiltroTipo" class="text-light" runat="server" Text="Tipo:"></asp:Label>
                            <asp:DropDownList ID="DropDownListTipo" class="dropdown form-control" runat="server" DataTextField="nombreCategoria" DataValueField="codigoCategoria" AppendDataBoundItems="true">
                                <asp:ListItem Text="" Value=""></asp:ListItem>
                                <asp:ListItem Text="Asociado" Value="1"></asp:ListItem>
                                <asp:ListItem Text="No Asociado" Value="2"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>

                    <div class="text-center mt-2">
                        <asp:Button ID="ButtonFiltrado" class="form-control btn-primary btn-sm btn-block buttonFilter" runat="server" Text="Filtrar" OnClick="ButtonFiltrado_Click" />
                        <asp:Button runat="server" class="form-control btn-secondary btn-sm btn-block buttonFilter mt-1" Text="Limpiar" OnClick="Limpiar_Click"></asp:Button>
                    </div>
                </div>
            </asp:Panel>
        </div>

        <asp:SqlDataSource runat="server" ID="SqlDataSource1"
            ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>"
            DeleteCommand="DELETE FROM [Parte] WHERE [codigoParte] = @codigoParte"
            InsertCommand="INSERT INTO [Parte] ([codigoProyecto], [codigoCliente], [fecha], [tipo], [codigoTrabajador]) VALUES (@codigoProyecto, @codigoCliente, @fecha, @tipo, @codigoTrabajador)"
            SelectCommand="SELECT Parte.*, Proyecto.NombreProyecto, Cliente.nombreEntidad FROM Parte INNER JOIN Proyecto ON Parte.codigoProyecto = Proyecto.codigoProyecto INNER JOIN Cliente ON Parte.codigoCliente = Cliente.codigoCliente WHERE [codigoTrabajador] = @codigoUsuario"
            UpdateCommand="UPDATE [Parte] SET [codigoProyecto] = @codigoProyecto, [codigoCliente] = @codigoCliente, [fecha] = @fecha, [tipo] = @tipo, [codigoTrabajador] = @codigoTrabajador WHERE [codigoParte] = @codigoParte">
            <DeleteParameters>
                <asp:Parameter Name="codigoParte" Type="Int32"></asp:Parameter>
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="codigoProyecto" Type="Int32"></asp:Parameter>
                <asp:Parameter Name="codigoCliente" Type="Int32"></asp:Parameter>
                <asp:Parameter DbType="Date" Name="fecha"></asp:Parameter>
                <asp:Parameter Name="tipo" Type="Int32"></asp:Parameter>
                <asp:Parameter Name="codigoTrabajador" Type="Int32"></asp:Parameter>
            </InsertParameters>
            <SelectParameters>
                <asp:SessionParameter SessionField="codigoTrabajador" Name="codigoUsuario" Type="Int32"></asp:SessionParameter>
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="codigoProyecto" Type="Int32"></asp:Parameter>
                <asp:Parameter Name="codigoCliente" Type="Int32"></asp:Parameter>
                <asp:Parameter DbType="Date" Name="fecha"></asp:Parameter>
                <asp:Parameter Name="tipo" Type="Int32"></asp:Parameter>
                <asp:Parameter Name="codigoTrabajador" Type="Int32"></asp:Parameter>
                <asp:Parameter Name="codigoParte" Type="Int32"></asp:Parameter>
            </UpdateParameters>
        </asp:SqlDataSource>

        <asp:GridView ID="GridView1" class="table mt-3 tamanio-partes" runat="server" DataSourceID="SqlDataSource1" AutoGenerateColumns="False" DataKeyNames="codigoParte" AllowPaging="True" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical" AllowSorting="True" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
            <AlternatingRowStyle BackColor="#CCCCCC" />
            <Columns>
                <asp:BoundField DataField="codigoParte" HeaderText="ID" ReadOnly="True" InsertVisible="False"></asp:BoundField>
                <asp:BoundField DataField="codigoProyecto" HeaderText="ID Proyecto" ReadOnly="True" InsertVisible="False" Visible="false"></asp:BoundField>

                <asp:TemplateField HeaderText="Proyecto" SortExpression="NombreProyecto">
                    <ItemTemplate>
                        <%# Eval("NombreProyecto") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:DropDownList Text='<%# Bind("codigoProyecto") %>' class="dropdown form-control edit-dropdown" ID="idProyectosDropDownList" runat="server" DataSourceID="ProyectosSqlDataSource" DataTextField="NombreProyecto" DataValueField="codigoProyecto"></asp:DropDownList>
                        <asp:SqlDataSource ID="ProyectosSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>" SelectCommand="SELECT [codigoProyecto], [NombreProyecto] FROM [Proyecto] WHERE ([codigoCoordinador] = @codigoCoordinador)">
                            <SelectParameters>
                                <asp:SessionParameter SessionField="codigoUsuario" Name="codigoCoordinador" Type="Int32"></asp:SessionParameter>
                            </SelectParameters>
                        </asp:SqlDataSource>

                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Cliente" SortExpression="nombreEntidad">
                    <ItemTemplate>
                        <%# Eval("nombreEntidad") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:DropDownList Text='<%# Bind("codigoCliente") %>' class="dropdown form-control edit-dropdown" ID="idClientesDropDownList" runat="server" DataSourceID="ClientesSqlDataSource" DataTextField="nombreEntidad" DataValueField="codigoCliente"></asp:DropDownList>
                        <asp:SqlDataSource ID="ClientesSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>" SelectCommand="SELECT codigoCliente,nombreEntidad FROM Cliente order by nombreEntidad"></asp:SqlDataSource>
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Fecha" SortExpression="fecha">
                    <ItemTemplate>
                        <%# Eval("fecha", "{0:dd/MM/yyyy}") %>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Tipo" SortExpression="tipo">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="tipoLabel" Text='<%# GetTipoText(Eval("tipo")) %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:CommandField SelectText="Consultar" ShowDeleteButton="True" ShowEditButton="True" ShowSelectButton="True"></asp:CommandField>

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

        <asp:Panel ID="PanelInsertarParte" class="mt-3" runat="server" Visible="False">
            <asp:SqlDataSource runat="server" ID="SqlDataSourceInsertarParte" DataSourceMode="DataReader" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>" DeleteCommand="DELETE FROM [Parte] WHERE [codigoParte] = @codigoParte" InsertCommand="INSERT INTO [Parte] ([codigoProyecto], [codigoCliente], [fecha], [tipo], [codigoTrabajador]) VALUES (@codigoProyecto, @codigoCliente, @fecha, @tipo, @codigoTrabajador)" SelectCommand="SELECT * FROM [Parte]" UpdateCommand="UPDATE [Parte] SET [codigoProyecto] = @codigoProyecto, [codigoCliente] = @codigoCliente, [fecha] = @fecha, [tipo] = @tipo, [codigoTrabajador] = @codigoTrabajador WHERE [codigoParte] = @codigoParte">
                <DeleteParameters>
                    <asp:Parameter Name="codigoParte" Type="Int32"></asp:Parameter>
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="codigoProyecto" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="codigoCliente" Type="Int32"></asp:Parameter>
                    <asp:Parameter DbType="Date" Name="fecha"></asp:Parameter>
                    <asp:Parameter Name="tipo" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="codigoTrabajador" Type="Int32"></asp:Parameter>
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="codigoProyecto" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="codigoCliente" Type="Int32"></asp:Parameter>
                    <asp:Parameter DbType="Date" Name="fecha"></asp:Parameter>
                    <asp:Parameter Name="tipo" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="codigoTrabajador" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="codigoParte" Type="Int32"></asp:Parameter>
                </UpdateParameters>
            </asp:SqlDataSource>

            <asp:FormView ID="FormViewInsertarParte" class="form-control" runat="server" DataSourceID="SqlDataSourceInsertarParte" DefaultMode="Insert" DataKeyNames="codigoParte" OnItemInserting="FormViewInsertarParte_ItemInserting">
                <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <InsertItemTemplate>
                    <div class="row">
                        <div class="col text-center">
                            <h3>Insertar Parte</h3>
                        </div>
                    </div>

                    <asp:TextBox Text='<%# Bind("codigoTrabajador") %>' runat="server" ID="codigoTrabajadorTextBox" Visible="false" />

                    <div class="row">
                        <div class="col">
                            Tipo:
                            <asp:DropDownList Text='<%# Bind("tipo") %>' class="form-control" runat="server" ClientIDMode="Static" ID="tipoDropDownList">
                                <asp:ListItem Text="Asociado" Value="1"></asp:ListItem>
                                <asp:ListItem Text="No Asociado" Value="2"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col">
                            Proyecto:
                            <asp:DropDownList Text='<%# Bind("codigoProyecto") %>' class="dropdown form-control edit-dropdown" ID="idProyectosDropDownList" runat="server" DataSourceID="ProyectosSqlDataSource" DataTextField="NombreProyecto" DataValueField="codigoProyecto" ClientIDMode="Static">
                                <asp:ListItem Text="" Value=""></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="ProyectosSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>" SelectCommand="SELECT [codigoProyecto], [NombreProyecto], [codigoCliente] FROM [Proyecto] WHERE ([codigoCoordinador] = @codigoCoordinador)">
                                <SelectParameters>
                                    <asp:SessionParameter SessionField="codigoUsuario" Name="codigoCoordinador" Type="Int32"></asp:SessionParameter>
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </div>
                        <div class="col">
                            Cliente:
                            <asp:DropDownList Text='<%# Bind("codigoCliente") %>' class="dropdown form-control edit-dropdown" ID="idClientesDropDownList" runat="server" DataSourceID="ClientesSqlDataSource" DataTextField="nombreEntidad" DataValueField="codigoCliente" ClientIDMode="Static">
                                <asp:ListItem Text="" Value=""></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="ClientesSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>" SelectCommand="SELECT codigoCliente,nombreEntidad FROM Cliente order by nombreEntidad"></asp:SqlDataSource>
                        </div>
                    </div>

                    <input type="date" class="form-control" runat="server" id="fechaTextBox" value='<%# Bind("fecha", "{0:yyyy-MM-dd}") %>' visible="false" />

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

        <%--Bloque div para la consulta de un parte--%>
        <asp:Panel ID="PanelConsultarLineasParte" runat="server" Visible="false">
            <asp:SqlDataSource runat="server" ID="SqlDataSourceLineas" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>"
                SelectCommand="SELECT LineaTrabajo.*, Trabajador.nombre, Trabajador.apellido, Partida.nombrePartida, Naturaleza.nombre AS nombreNaturaleza FROM LineaTrabajo INNER JOIN Trabajador ON LineaTrabajo.codigoTrabajador = Trabajador.codigoTrabajador INNER JOIN Partida ON LineaTrabajo.codigoPartida = Partida.codigoPartida INNER JOIN Naturaleza ON LineaTrabajo.codigoNaturaleza = Naturaleza.codigoNaturaleza WHERE ([codigoParte] = @codigoParte)"
                DeleteCommand="DELETE FROM [LineaTrabajo] WHERE [codigoLinea] = @codigoLinea"
                InsertCommand="INSERT INTO [LineaTrabajo] ([codigoParte], [codigoTrabajador], [codigoPartida], [codigoNaturaleza], [horasNormales], [horasExtra]) VALUES (@codigoParte, @codigoTrabajador, @codigoPartida, @codigoNaturaleza, @horasNormales, @horasExtra)"
                UpdateCommand="UPDATE [LineaTrabajo] SET [codigoParte] = @codigoParte, [codigoTrabajador] = @codigoTrabajador, [codigoPartida] = @codigoPartida, [codigoNaturaleza] = @codigoNaturaleza, [horasNormales] = @horasNormales, [horasExtra] = @horasExtra WHERE [codigoLinea] = @codigoLinea">
                <DeleteParameters>
                    <asp:Parameter Name="codigoLinea" Type="Int32"></asp:Parameter>
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="codigoParte" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="codigoTrabajador" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="codigoPartida" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="codigoNaturaleza" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="horasNormales" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="horasExtra" Type="Int32"></asp:Parameter>
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="GridView1" PropertyName="SelectedValue" Name="codigoParte" Type="Int32"></asp:ControlParameter>
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="codigoParte" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="codigoTrabajador" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="codigoPartida" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="codigoNaturaleza" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="horasNormales" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="horasExtra" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="codigoLinea" Type="Int32"></asp:Parameter>
                </UpdateParameters>
            </asp:SqlDataSource>

            <asp:GridView ID="GridView2" runat="server" class="table mt-3 tamanio-lineas" DataSourceID="SqlDataSourceLineas" AutoGenerateColumns="False" DataKeyNames="codigoLinea" AllowPaging="True" AllowSorting="True" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical">
                <AlternatingRowStyle BackColor="#CCCCCC" />
                <Columns>
                    <asp:BoundField DataField="codigoLinea" HeaderText="ID" ReadOnly="True" InsertVisible="False" SortExpression="codigoLinea"></asp:BoundField>
                    <asp:TemplateField HeaderText="Parte" SortExpression="codigoParte">
                        <ItemTemplate>
                            <%# Eval("codigoParte") %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList Text='<%# Bind("codigoParte") %>' class="dropdown form-control edit-dropdown" ID="idPartesDropDownList" runat="server" DataSourceID="PartesSqlDataSource" DataTextField="codigoParte" DataValueField="codigoParte"></asp:DropDownList>
                            <asp:SqlDataSource ID="PartesSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>" SelectCommand="SELECT [codigoParte], [codigoProyecto] FROM [Parte] WHERE ([codigoTrabajador] = @codigoTrabajador)">
                                <SelectParameters>
                                    <asp:SessionParameter SessionField="codigoUsuario" Name="codigoTrabajador" Type="Int32"></asp:SessionParameter>
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Trabajador" SortExpression="nombre">
                        <ItemTemplate>
                            <%# Eval("nombre") %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList Text='<%# Bind("codigoTrabajador") %>' class="dropdown form-control edit-dropdown" ID="idTrabajadoresDropDownList" runat="server" DataSourceID="TrabajadorSqlDataSource" DataTextField="nombre" DataValueField="codigoTrabajador"></asp:DropDownList>
                            <asp:SqlDataSource ID="TrabajadorSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>" SelectCommand="SELECT [codigoTrabajador], [nombre] FROM [Trabajador]"></asp:SqlDataSource>
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Partida" SortExpression="nombrePartida">
                        <ItemTemplate>
                            <%# Eval("nombrePartida") %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList Text='<%# Bind("codigoPartida") %>' class="dropdown form-control edit-dropdown" ID="idPartidasDropDownList" runat="server" DataSourceID="SqlDataSourcePartidasLinea" DataTextField="nombrePartida" DataValueField="codigoPartida"></asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSourcePartidasLinea" runat="server" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>" SelectCommand="SELECT Partida.[codigoPartida], Partida.[nombrePartida] FROM Partida INNER JOIN Proyecto ON Partida.codigoProyecto = Proyecto.codigoProyecto INNER JOIN Parte ON Proyecto.codigoProyecto = Parte.codigoProyecto WHERE Parte.codigoParte = @codigoParte">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="GridView1" PropertyName="SelectedValue" Name="codigoParte" Type="Int32"></asp:ControlParameter>
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Naturaleza" SortExpression="nombreNaturaleza">
                        <ItemTemplate>
                            <%# Eval("nombreNaturaleza") %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList Text='<%# Bind("codigoNaturaleza") %>' class="dropdown form-control edit-dropdown" ID="idNaturalezasDropDownList" runat="server" DataSourceID="NaturalezasSqlDataSource" DataTextField="nombre" DataValueField="codigoNaturaleza"></asp:DropDownList>
                            <asp:SqlDataSource ID="NaturalezasSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>" SelectCommand="SELECT codigoNaturaleza, nombre FROM Naturaleza order by nombre"></asp:SqlDataSource>
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="horasNormales" SortExpression="horasNormales">
                        <ItemTemplate>
                            <%# Eval("horasNormales") %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox Text='<%# Bind("horasNormales") %>' class="form-control edit-textbox" runat="server" ID="horasNormalesTextBox" />
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="horasExtra" SortExpression="horasExtra">
                        <ItemTemplate>
                            <%# Eval("horasExtra") %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox Text='<%# Bind("horasExtra") %>' class="form-control edit-textbox" runat="server" ID="horasExtraTextBox" />
                        </EditItemTemplate>
                    </asp:TemplateField>

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
        </asp:Panel>

        <%--Bloque div para la inserción de una nueva línea--%>
        <asp:Panel ID="PanelInsertarLinea" runat="server" Visible="false">
            <asp:SqlDataSource runat="server" ID="SqlDataSourceInsertarLinea"
                ConnectionString='<%$ ConnectionStrings:mibasededatostfgConnectionString %>'
                DeleteCommand="DELETE FROM [LineaTrabajo] WHERE [codigoLinea] = @codigoLinea"
                InsertCommand="INSERT INTO [LineaTrabajo] ([codigoParte], [codigoTrabajador], [codigoPartida], [codigoNaturaleza], [horasNormales], [horasExtra]) VALUES (@codigoParteLinea, @codigoTrabajadorLinea, @codigoPartidaLinea, @codigoNaturalezaLinea, @horasNormalesLinea, @horasExtraLinea)"
                SelectCommand="SELECT * FROM [LineaTrabajo]"
                UpdateCommand="UPDATE [LineaTrabajo] SET [codigoParte] = @codigoParte, [codigoTrabajador] = @codigoTrabajador, [codigoPartida] = @codigoPartida, [codigoNaturaleza] = @codigoNaturaleza, [horasNormales] = @horasNormales, [horasExtra] = @horasExtra WHERE [codigoLinea] = @codigoLinea">
                <DeleteParameters>
                    <asp:Parameter Name="codigoLinea" Type="Int32"></asp:Parameter>
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="codigoParteLinea" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="codigoTrabajadorLinea" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="codigoPartidaLinea" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="codigoNaturalezaLinea" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="horasNormalesLinea" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="horasExtraLinea" Type="Int32"></asp:Parameter>
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="codigoParte" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="codigoTrabajador" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="codigoPartida" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="codigoNaturaleza" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="horasNormales" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="horasExtra" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="codigoLinea" Type="Int32"></asp:Parameter>
                </UpdateParameters>
            </asp:SqlDataSource>

            <asp:FormView ID="FormViewInsertarLinea" class="form-control mt-4" runat="server" DataKeyNames="codigoLinea" DataSourceID="SqlDataSourceInsertarLinea" DefaultMode="Insert">
                <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <InsertItemTemplate>

                    <asp:TextBox Text='<%# Bind("codigoParteLinea") %>' class="form-control" runat="server" ID="TextBoxCodigoParteLinea" ReadOnly="true" Visible="true" />

                    <label for="DropDownListTrabajadorLinea">Trabajador:</label>
                    <asp:DropDownList Text='<%# Bind("codigoTrabajadorLinea") %>' class="form-control" ID="DropDownListTrabajadorLinea" runat="server" DataSourceID="SqlDataSourceCodigosTrabajadoresLinea" DataTextField="nombre_completo" DataValueField="codigoTrabajador" AppendDataBoundItems="true">
                        <asp:ListItem Text="" Value=""></asp:ListItem>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSourceCodigosTrabajadoresLinea" runat="server" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>" SelectCommand="SELECT CONCAT(nombre, ' ', apellido) AS nombre_completo, codigoTrabajador  FROM Trabajador  ORDER BY nombre_completo;"></asp:SqlDataSource>

                    <label for="DropDownListPartidaLinea">Partida:</label>
                    <asp:DropDownList Text='<%# Bind("codigoPartidaLinea") %>' class="form-control" ID="DropDownListPartidaLinea" runat="server" DataSourceID="SqlDataSourcePartidasLineaInsertar" DataTextField="nombrePartida" DataValueField="codigoPartida" AppendDataBoundItems="true">
                        <asp:ListItem Text="" Value=""></asp:ListItem>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSourcePartidasLineaInsertar" runat="server" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>" SelectCommand="SELECT Partida.[codigoPartida], Partida.[nombrePartida] FROM Partida INNER JOIN Proyecto ON Partida.codigoProyecto = Proyecto.codigoProyecto INNER JOIN Parte ON Proyecto.codigoProyecto = Parte.codigoProyecto WHERE Parte.codigoParte = @codigoParte">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="GridView1" PropertyName="SelectedValue" Name="codigoParte" Type="Int32"></asp:ControlParameter>
                        </SelectParameters>
                    </asp:SqlDataSource>

                    <label for="DropDownListNaturalezaLinea">Naturaleza:</label>
                    <asp:DropDownList Text='<%# Bind("codigoNaturalezaLinea") %>' class="form-control" ID="DropDownListNaturalezaLinea" runat="server" DataSourceID="SqlDataSourceCodigosNaturalezasLinea" DataTextField="nombre" DataValueField="codigoNaturaleza" AppendDataBoundItems="true">
                        <asp:ListItem Text="" Value=""></asp:ListItem>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSourceCodigosNaturalezasLinea" runat="server" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>" SelectCommand="SELECT codigoNaturaleza, nombre FROM Naturaleza ORDER BY nombre"></asp:SqlDataSource>

                    <label for="InputHorasNormalesLinea">Horas normales:</label>
                    <input type="number" class="form-control" id="InputHorasNormalesLinea" runat="server" value='<%# Bind("horasNormalesLinea") %>' />

                    <label for="InputHorasExtraLinea">Horas extra:</label>
                    <input type="number" class="form-control" id="InputHorasExtraLinea" runat="server" value='<%# Bind("horasExtraLinea") %>' />

                    <div class="row mt-3">
                        <div class="col-md-12 text-center">
                            <asp:LinkButton ID="InsertButton" class="btn btn-success" runat="server" CausesValidation="True" CommandName="Insert" Text="Insertar" />
                            <asp:LinkButton ID="InsertCancelButton" class="btn btn-danger" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancelar" />
                        </div>
                    </div>
                    </div>
                </InsertItemTemplate>
                <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
            </asp:FormView>
        </asp:Panel>
    </div>

    <script type="text/javascript">
        window.onload = function () {
            var tipoDropDown = document.getElementById('tipoDropDownList');
            var proyectoDropDown = document.getElementById('idProyectosDropDownList');
            var clienteDropDown = document.getElementById('idClientesDropDownList');

            tipoDropDown.addEventListener('change', function () {
                if (tipoDropDown.value === "2") { // "No Asociado"
                    proyectoDropDown.value = "";
                    proyectoDropDown.disabled = true;

                } else {
                    proyectoDropDown.disabled = false;
                    clienteDropDown.value = "";
                    clienteDropDown.disabled = true;
                }
            });
        };
    </script>

</asp:Content>
