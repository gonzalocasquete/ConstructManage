<%@ Page Language="C#" MasterPageFile="~/Master/Master1.Master" AutoEventWireup="true" CodeBehind="GestionarPartidas.aspx.cs" Inherits="tfgASPX2.Views.Super.GestionarPartidas" %>

<asp:Content ID="GestionarPartidasHead" ContentPlaceHolderID="head" runat="server">
    <link href="../../Styles/GestionarPartidas.css" rel="stylesheet" />
    <link href="../../Styles/ComunesStyle.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="GestionarPartidasNavegacion" ContentPlaceHolderID="ContentPlaceHolderNavegacion" runat="server">
    <a href="MenuSuper.aspx">Menú</a>
</asp:Content>

<asp:Content ID="GestionarPartidasBody" ContentPlaceHolderID="ContentPlaceHolderContenido" runat="server">
    <div class="auto-style1">
        <h2 class="font-weight-bold">Gestión de Partidas</h2>

        <div style="width: 200px">
            <div class="row">
                <div class="col">
                    <asp:Button ID="ButtonFiltros" class="form-control btn-secondary btn-sm btn-block buttonFilter mt-1" runat="server" Text="Filtros" OnClick="ButtonFiltros_Click" />
                </div>
            </div>

            <asp:Panel ID="PanelFiltros" runat="server" Visible="False">
                <%--Filtros--%>
                <hr />
                <div>

                    <div class="row">
                        <div class="col">
                            <%--Nombre Partida--%>
                            <asp:Label ID="LabelFiltroPartida" runat="server" Text="Partida:"></asp:Label>
                            <asp:TextBox ID="TextBoxFiltradoPartida" class="form-control" runat="server"></asp:TextBox>
                        </div>
                        <div class="col">
                            <%--Proyectos para el filtro--%>
                            <asp:Label ID="LabelFiltroPartidaProyectos" runat="server" Text="Proyectos:"></asp:Label>
                            <asp:DropDownList ID="DropDownListProyectos" class="dropdown form-control" runat="server" DataTextField="NombreProyecto" DataValueField="codigoProyecto" DataSourceID="SqlDataSourceProyectos" AppendDataBoundItems="true">
                                <asp:ListItem Text="" Value=""></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource runat="server" ID="SqlDataSourceProyectos" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>" SelectCommand="SELECT [codigoProyecto], [NombreProyecto] FROM [Proyecto] ORDER BY [codigoProyecto]"></asp:SqlDataSource>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col">
                            <%--Fecha de Inicio--%>
                            <asp:Label ID="LabelFechaInicio" for="fechaInicio" runat="server" Text="Fecha mínima:"></asp:Label>
                            <input id="fechaInicio" class="form-control" runat="server" type="date" name="fecha">
                        </div>
                        <div class="col">
                            <%--Fecha de Fin--%>
                            <asp:Label ID="LabelFechaFin" for="fechaFin" runat="server" Text="Fecha máxima:"></asp:Label>
                            <input id="fechaFin" class="form-control" runat="server" type="date" name="fecha">
                        </div>
                    </div>

                    <div class="row">
                        <div class="col">
                            <%--Coste Minimo--%>
                            <asp:Label ID="LabelCosteMinimo" for="costeMinimo" runat="server" Text="Coste mínimo:"></asp:Label>
                            <input id="costeMinimo" class="form-control" runat="server" type="number" name="costeMinimo">
                        </div>
                        <div class="col">
                            <%--Coste Maximo--%>
                            <asp:Label ID="LabelCosteMaximo" for="costeMaximo" runat="server" Text="Coste máximo:"></asp:Label>
                            <input id="costeMaximo" class="form-control" runat="server" type="number" name="costeMaximo">
                        </div>
                    </div>

                    <div class="text-center mt-2">
                        <asp:Button ID="ButtonFiltrado" class="form-control btn btn-primary btn-sm btn-block buttonFilter" runat="server" Text="Filtrar" OnClick="ButtonFiltrado_Click" />
                        <asp:Button runat="server" class="form-control btn-secondary btn-sm btn-block buttonFilter mt-1" Text="Limpiar" OnClick="Todos_Click"></asp:Button>
                    </div>
                </div>
            </asp:Panel>
        </div>

        <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>" SelectCommand="SELECT * FROM [Partida]" DeleteCommand="DELETE FROM [Partida] WHERE [codigoPartida] = @original_codigoPartida" InsertCommand="INSERT INTO [Partida] ([nombrePartida], [fechaInicio], [fechaFin], [Costo], [codigoProyecto]) VALUES (@nombrePartida, @FechaInicio, @FechaFin, @Costo, @codigoProyecto)" OldValuesParameterFormatString="original_{0}" UpdateCommand="UPDATE [Partida] SET [nombrePartida] = @nombrePartida, [fechaInicio] = @FechaInicio, [fechaFin] = @FechaFin, [Costo] = @Costo, [codigoProyecto] = @codigoProyecto WHERE [codigoPartida] = @original_codigoPartida">
            <DeleteParameters>
                <asp:Parameter Name="original_codigoPartida" Type="Int32"></asp:Parameter>
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="nombrePartida" Type="String"></asp:Parameter>
                <asp:Parameter DbType="Date" Name="FechaInicio"></asp:Parameter>
                <asp:Parameter DbType="Date" Name="FechaFin"></asp:Parameter>
                <asp:Parameter Name="Costo" Type="Decimal"></asp:Parameter>
                <asp:Parameter Name="codigoProyecto" Type="Int32"></asp:Parameter>
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="nombrePartida" Type="String"></asp:Parameter>
                <asp:Parameter DbType="Date" Name="FechaInicio"></asp:Parameter>
                <asp:Parameter DbType="Date" Name="FechaFin"></asp:Parameter>
                <asp:Parameter Name="Costo" Type="Decimal"></asp:Parameter>
                <asp:Parameter Name="codigoProyecto" Type="Int32"></asp:Parameter>
                <asp:Parameter Name="original_codigoPartida" Type="Int32"></asp:Parameter>
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:GridView ID="GridView1" class="mt-3 table mi-gridview" runat="server" AllowPaging="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" DataKeyNames="codigoPartida" DataSourceID="SqlDataSource1" ForeColor="Black" GridLines="Vertical" AllowSorting="True">
            <AlternatingRowStyle BackColor="#CCCCCC" />
            <Columns>
                <asp:BoundField DataField="codigoPartida" HeaderText="ID" ReadOnly="True" InsertVisible="False"></asp:BoundField>
                <asp:BoundField DataField="nombrePartida" HeaderText="Partida" SortExpression="nombrePartida"></asp:BoundField>

                <asp:TemplateField HeaderText="Fecha Inicio" SortExpression="fechaInicio">
                    <ItemTemplate>
                        <%# Eval("fechaInicio", "{0:dd/MM/yy}") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <input type="date" id="txtFechaInicio" runat="server" value='<%# Bind("FechaInicio", "{0:yyyy-MM-dd}") %>' />
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Fecha Fin" SortExpression="fechaFin">
                    <ItemTemplate>
                        <%# Eval("fechaFin", "{0:dd/MM/yy}") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <input type="date" id="txtFechaFin" runat="server" value='<%# Bind("FechaFin", "{0:yyyy-MM-dd}") %>' />
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:BoundField DataField="Costo" HeaderText="Costo" SortExpression="Costo"></asp:BoundField>

                <asp:TemplateField HeaderText="Proyecto">
                    <ItemTemplate>
                        <%# Eval("codigoProyecto") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:DropDownList Text='<%# Bind("codigoProyecto") %>' class="dropdown form-control" ID="idProyectoDropDownList" runat="server" DataSourceID="idProyecto2SqlDataSource" DataTextField="NombreProyecto" DataValueField="codigoProyecto"></asp:DropDownList>
                        <asp:SqlDataSource ID="idProyecto2SqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>" SelectCommand="SELECT codigoProyecto, NombreProyecto FROM Proyecto order by NombreProyecto"></asp:SqlDataSource>
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True"></asp:CommandField>
            </Columns>
            <FooterStyle BackColor="#CCCCCC" />
            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
        </asp:GridView>
        <asp:Button ID="ButtonInsertar" CssClass="ButtonStyle button1 mt-3" runat="server" Text="Insertar" OnClick="Button1_Click" />
        <asp:Panel ID="Panel1" runat="server" Visible="False">
            <asp:FormView class="form-control mt-3" ID="FormView1" runat="server" DataKeyNames="codigoPartida" DataSourceID="SqlDataSource1" DefaultMode="Insert">
                <InsertItemTemplate>
                    <footerstyle backcolor="#990000" font-bold="True" forecolor="White" />
                    <headerstyle backcolor="#990000" font-bold="True" forecolor="White" />
                    <div class="row">

                        <div class="col">
                            Nombre:
                            <asp:TextBox class="form-control" Text='<%# Bind("nombrePartida") %>' data-toggle="tooltip" title="Nombre de la partida" runat="server" ID="nombrePartidaTextBox" />
                        </div>
                        <div class="col">
                            Costo:
                            <asp:TextBox class="form-control" Text='<%# Bind("Costo") %>' data-toggle="tooltip" title="Costo de realizar la partida" runat="server" ID="CostoTextBox" />

                        </div>
                    </div>

                    <div class="row">
                        <div class="col">
                            Fecha de Inicio:
                            <input type="date" class="form-control" data-toggle="tooltip" title="Fecha de alta de la partida" runat="server" id="FechaInicioTextBox" value='<%# Bind("FechaInicio", "{0:yyyy-MM-dd}") %>' />
                        </div>
                        <div class="col">
                            Fecha Fin:
                            <input type="date" class="form-control" data-toggle="tooltip" title="Fecha de baja de la partida" runat="server" id="FechaFinTextBox" value='<%# Bind("fechaFin", "{0:yyyy-MM-dd}") %>' />
                        </div>
                    </div>

                    <div class="row">
                        <div class="col">
                            Proyecto:
                            <asp:DropDownList Text='<%# Bind("codigoProyecto") %>' class="dropdown form-control" ID="idProyectoDropDownList" runat="server" DataSourceID="idProyectoSqlDataSource" DataTextField="NombreProyecto" DataValueField="codigoProyecto"></asp:DropDownList>
                            <asp:SqlDataSource ID="idProyectoSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>" SelectCommand="SELECT codigoProyecto, NombreProyecto FROM Proyecto"></asp:SqlDataSource>
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
