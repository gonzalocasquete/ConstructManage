<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Master1.Master" AutoEventWireup="true" CodeBehind="InicialCoordinador.aspx.cs" Inherits="tfgASPX2.Views.Coordinador.InicialCoordinador" %>

<asp:Content ID="InicialCoordinadorHead" ContentPlaceHolderID="head" runat="server">
    <link href="../../Styles/InicialCoordinadorStyle.css" rel="stylesheet" />
    <link href="../../Styles/ComunesStyle.css" rel="stylesheet" />
    <script src="../../Scripts/Views/InicialCoordinadorScript.js"></script>
</asp:Content>

<asp:Content ID="InicialCoordinadorNavegacion" ContentPlaceHolderID="ContentPlaceHolderNavegacion" runat="server">
    <a href="InicialCoordinador.aspx">Inicio</a>
    <a href="../Comun/Perfil.aspx">Perfil</a>
</asp:Content>

<asp:Content ID="InicialCoordinadorBody" ContentPlaceHolderID="ContentPlaceHolderContenido" runat="server">
    <div class="auto-style1">

        <%--  Filtros--%>
        <div style="width: 250px">
            <div class="row">
                <div class="col">
                    <asp:Button ID="ButtonFiltros" class="form-control btn-secondary btn-sm btn-block buttonFilter mt-1" runat="server" Text="Filtros" OnClick="ButtonFiltros_Click" />
                </div>
            </div>

            <asp:Panel ID="PanelFiltros" runat="server" Visible="False">
                <hr style="margin-bottom: 2px;" />
                <div>
                    <div class="row">
                        <div class="col">
                            <%-- Proyecto--%>
                            <asp:Label ID="LabelFiltroProyecto" runat="server" Text="Proyecto:"></asp:Label>
                            <asp:TextBox ID="TextBoxFiltradoProyecto" class="form-control" runat="server"></asp:TextBox>
                        </div>
                        <div class="col">
                            <%--Cliente--%>
                            <asp:Label ID="LabelCliente" runat="server" Text="Cliente:"></asp:Label>
                            <asp:TextBox ID="TextBoxFiltradoCliente" class="form-control" runat="server"></asp:TextBox>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col">
                            <%--Fecha de Inicio--%>
                            <asp:Label ID="LabelFechaMinima" for="fechaMinima" runat="server" Text="Fecha Minima:"></asp:Label>
                            <input id="fechaMinima" class="form-control" runat="server" type="date" name="fechaMinima">
                        </div>
                        <div class="col">
                            <%--Fecha de Fin--%>
                            <asp:Label ID="LabelFechaMaxima" for="fechaMaxima" runat="server" Text="Fecha Maxima:"></asp:Label>
                            <input id="fechaMaxima" class="form-control" runat="server" type="date" name="fechaMaxima" max="2023-12-31" onclick="showDatePicker()">
                        </div>
                    </div>

                    <div class="row">
                        <div class="col">
                            <%--Tipo--%>
                            <asp:Label ID="LabelFiltroTipo" runat="server" Text="Tipo:"></asp:Label>
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


        <div>
            <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>"
                SelectCommand="SELECT Parte.codigoParte, Parte.fecha, Parte.tipo, Parte.codigoTrabajador, Proyecto.NombreProyecto, Cliente.nombreEntidad FROM Parte LEFT JOIN Proyecto ON Parte.codigoProyecto = Proyecto.codigoProyecto LEFT JOIN Cliente ON Parte.codigoCliente = Cliente.codigoCliente WHERE ([codigoTrabajador] = @codigoTrabajador)">
                <SelectParameters>
                    <asp:SessionParameter SessionField="codigoTrabajador" Name="codigoTrabajador" Type="Int32"></asp:SessionParameter>
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:GridView ID="GridView1" class="table mt-3" runat="server" DataSourceID="SqlDataSource1" AutoGenerateColumns="False" DataKeyNames="codigoParte" AllowPaging="True" AllowSorting="True" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                <AlternatingRowStyle BackColor="#CCCCCC" />
                <Columns>
                    <asp:BoundField DataField="codigoParte" HeaderText="ID" ReadOnly="True" InsertVisible="False"></asp:BoundField>
                    <asp:BoundField DataField="NombreProyecto" HeaderText="Proyecto"></asp:BoundField>
                    <asp:BoundField DataField="nombreEntidad" HeaderText="Cliente"></asp:BoundField>
                    <asp:TemplateField HeaderText="Tipo" SortExpression="tipo">
                        <ItemTemplate>
                            <asp:Label ID="lblTipo" runat="server" Text='<%# Eval("tipo").ToString() == "1" ? "Asociado" : "No asociado" %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="fecha" DataFormatString="{0:dd/MM/yy}" HeaderText="Fecha" SortExpression="fecha"></asp:BoundField>
                    <asp:CommandField SelectText="Consultar" ShowSelectButton="True"></asp:CommandField>
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
        </div>

        <%--Bloque para la insercion de un parte--%>
        <asp:Button ID="ButtonInsertarParte" class="ButtonStyle button1" runat="server" Text="Insertar Parte" OnClick="ButtonInsertarParte_Click" />
        <asp:Panel ID="PanelInsertarParte" runat="server" Visible="false">
            <asp:SqlDataSource runat="server" ID="SqlDataSourceInsertarParte" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>" DeleteCommand="DELETE FROM [Parte] WHERE [codigoParte] = @codigoParte" InsertCommand="INSERT INTO [Parte] ([codigoProyecto], [codigoCliente], [fecha], [tipo], [codigoTrabajador]) VALUES (@codigoProyecto, @codigoCliente, @fecha, @tipo, @codigoTrabajador)" SelectCommand="SELECT * FROM [Parte]" UpdateCommand="UPDATE [Parte] SET [codigoProyecto] = @codigoProyecto, [codigoCliente] = @codigoCliente, [fecha] = @fecha, [tipo] = @tipo, [codigoTrabajador] = @codigoTrabajador WHERE [codigoParte] = @codigoParte">
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

            <asp:FormView ID="FormViewInsertarParte" class="form-control mt-3" runat="server" DataSourceID="SqlDataSourceInsertarParte" DataKeyNames="codigoParte" DefaultMode="Insert" OnDataBound="FormViewInsertarParte_DataBound">
                <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <InsertItemTemplate>
                    <div class="container">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="DropDownListProyectos">Proyecto:</label>
                                    <asp:DropDownList Text='<%# Bind("codigoProyecto") %>' class="form-control" ID="DropDownListProyectos" runat="server" DataSourceID="SqlDataSourceCodigoProyecto" DataTextField="NombreProyecto" DataValueField="codigoProyecto" AppendDataBoundItems="true" onchange="handleFieldsProyecto()">
                                        <asp:ListItem Text="" Value=""></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="SqlDataSourceCodigoProyecto" runat="server" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>" SelectCommand="SELECT codigoProyecto, NombreProyecto FROM Proyecto order by NombreProyecto"></asp:SqlDataSource>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="DropDownListClientes">Cliente:</label>
                                    <asp:DropDownList Text='<%# Bind("codigoCliente") %>' class="form-control" ID="DropDownListClientes" runat="server" DataSourceID="SqlDataSourceCodigoCliente" DataTextField="nombreEntidad" DataValueField="codigoCliente" AppendDataBoundItems="true" onchange="handleFieldsCliente()">
                                        <asp:ListItem Text="" Value=""></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="SqlDataSourceCodigoCliente" runat="server" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>" SelectCommand="SELECT codigoCliente, nombreEntidad FROM Cliente"></asp:SqlDataSource>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="FechaTextBox">Fecha:</label>
                                    <input type="date" class="form-control" data-toggle="tooltip" title="Fecha" runat="server" id="FechaTextBox" value='<%# Bind("fecha", "{0:yyyy-MM-dd}") %>' />
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="tipoDropDownList">Tipo:</label>
                                    <asp:DropDownList runat="server" class="form-control" ID="tipoDropDownList" SelectedValue='<%# Bind("tipo") %>' Enabled="false">
                                        <asp:ListItem Text="" Value="" />
                                        <asp:ListItem Text="Asociado" Value="1" />
                                        <asp:ListItem Text="No asociado" Value="2" />
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <asp:TextBox Text='<%# Bind("codigoTrabajador") %>' class="form-control" runat="server" ID="codigoTrabajadorTextBox" ReadOnly="true" Visible="false" />
                            </div>
                        </div>
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

        <%--Bloque div para la consulta de un parte--%>
        <asp:Panel ID="PanelConsultarLineasParte" runat="server" Visible="false">
            <div class="auto-style1">
                <asp:SqlDataSource runat="server" ID="SqlDataSourceLineasParte" DataSourceMode="DataSet" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>" SelectCommand="SELECT LineaTrabajo.codigoLinea, LineaTrabajo.horasNormales, LineaTrabajo.horasExtra, Trabajador.nombre AS nombreTrabajador, Trabajador.apellido AS apellidoTrabajador, Partida.nombrePartida AS nombrePartida, Naturaleza.nombre AS nombreNaturaleza FROM LineaTrabajo INNER JOIN Trabajador ON LineaTrabajo.codigoTrabajador = Trabajador.codigoTrabajador INNER JOIN Partida ON LineaTrabajo.codigoPartida = Partida.codigoPartida  INNER JOIN Naturaleza ON LineaTrabajo.codigoNaturaleza = Naturaleza.codigoNaturaleza WHERE LineaTrabajo.codigoParte = @codigoParte;">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="GridView1" PropertyName="SelectedValue" Name="codigoParte"></asp:ControlParameter>
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:GridView ID="GridView2" class="table" runat="server" DataSourceID="SqlDataSourceLineasParte" AutoGenerateColumns="False" DataKeyNames="codigoLinea" AllowPaging="True" AllowSorting="True">
                    <AlternatingRowStyle BackColor="#CCCCCC" />
                    <Columns>
                        <asp:BoundField DataField="codigoLinea" HeaderText="Linea" ReadOnly="True" InsertVisible="False"></asp:BoundField>
                        <asp:BoundField DataField="nombreTrabajador" HeaderText="Trabajador" SortExpression="nombreTrabajador"></asp:BoundField>
                        <asp:BoundField DataField="apellidoTrabajador" HeaderText="Apellido" SortExpression="apellidoTrabajador"></asp:BoundField>
                        <asp:BoundField DataField="nombrePartida" HeaderText="Partida"></asp:BoundField>
                        <asp:BoundField DataField="nombreNaturaleza" HeaderText="Naturaleza"></asp:BoundField>
                        <asp:BoundField DataField="horasNormales" HeaderText="Horas Normales" SortExpression="horasNormales"></asp:BoundField>
                        <asp:BoundField DataField="horasExtra" HeaderText="Horas Extra" SortExpression="horasExtra"></asp:BoundField>
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

                <asp:Button ID="ButtonInsertarLinea" class="ButtonStyle button1 mt-3" runat="server" Text="Insertar Linea" OnClick="ButtonInsertarLinea_Click" />
                <%--Bloque div para la inserción de una nueva línea--%>
                <asp:Panel ID="PanelInsertarLinea" runat="server" Visible="false">
                    <asp:SqlDataSource runat="server" ID="SqlDataSourceInsertarLinea" ConnectionString='<%$ ConnectionStrings:mibasededatostfgConnectionString %>' DeleteCommand="DELETE FROM [LineaTrabajo] WHERE [codigoLinea] = @codigoLinea" InsertCommand="INSERT INTO [LineaTrabajo] ([codigoParte], [codigoTrabajador], [codigoPartida], [codigoNaturaleza], [horasNormales], [horasExtra]) VALUES (@codigoParte, @codigoTrabajador, @codigoPartida, @codigoNaturaleza, @horasNormales, @horasExtra)" SelectCommand="SELECT * FROM [LineaTrabajo]" UpdateCommand="UPDATE [LineaTrabajo] SET [codigoParte] = @codigoParte, [codigoTrabajador] = @codigoTrabajador, [codigoPartida] = @codigoPartida, [codigoNaturaleza] = @codigoNaturaleza, [horasNormales] = @horasNormales, [horasExtra] = @horasExtra WHERE [codigoLinea] = @codigoLinea">
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
                            <asp:DropDownList Text='<%# Bind("codigoPartidaLinea") %>' class="form-control" ID="DropDownListPartidaLinea" runat="server" DataSourceID="SqlDataSourceCodigosPartidasLinea" DataTextField="nombrePartida" DataValueField="codigoPartida" AppendDataBoundItems="true">
                                <asp:ListItem Text="" Value=""></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSourceCodigosPartidasLinea" runat="server" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>" SelectCommand="SELECT codigoPartida, nombrePartida FROM Partida ORDER BY nombrePartida"></asp:SqlDataSource>

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
        </asp:Panel>
    </div>

    <%--Bloque de Scripts--%>
    <script type="text/javascript">

        //Controles para la insercion de nuevos parte
        function handleFieldsProyecto() {
            var proyectoDropdown = document.getElementById('<%= FormViewInsertarParte.FindControl("DropDownListProyectos").ClientID %>');
            var clienteDropdown = document.getElementById('<%= FormViewInsertarParte.FindControl("DropDownListClientes").ClientID %>');
            var tipoDropdown = document.getElementById('<%= FormViewInsertarParte.FindControl("tipoDropDownList").ClientID %>');

            clienteDropdown.value = ""; // Establecer cliente en null si se selecciona proyecto
            tipoDropdown.value = "1"; // Establecer tipo como "Asociado"
        }

        function handleFieldsCliente() {
            var proyectoDropdown = document.getElementById('<%= FormViewInsertarParte.FindControl("DropDownListProyectos").ClientID %>');
            var clienteDropdown = document.getElementById('<%= FormViewInsertarParte.FindControl("DropDownListClientes").ClientID %>');
            var tipoDropdown = document.getElementById('<%= FormViewInsertarParte.FindControl("tipoDropDownList").ClientID %>');

            proyectoDropdown.value = ""; // Establecer proyecto en null si se selecciona cliente
            tipoDropdown.value = "2"; // Establecer tipo como "No asociado"
        }

        //Controles para la manipulacion de los filtros
        var proyectoField = document.getElementById('<%= TextBoxFiltradoProyecto.ClientID %>');
        var clienteField = document.getElementById('<%= TextBoxFiltradoCliente.ClientID %>');

        function handleProyectoInputChange() {
            if (proyectoField.value !== "") {
                clienteField.value = "";
            }
        }

        function handleClienteInputChange() {
            if (clienteField.value !== "") {
                proyectoField.value = "";
            }
        }

        proyectoField.addEventListener('input', handleProyectoInputChange);
        clienteField.addEventListener('input', handleClienteInputChange);

    </script>
</asp:Content>
