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

        <div style="width: 250px">
            <div class="row">
                <div class="col">
                    <asp:Button ID="ButtonInsertar" class="form-control btn-secondary btn-sm btn-block mt-1" runat="server" Text="Insertar" OnClick="Button1_Click" />
                </div>
            </div>

            <div class="row">
                <div class="col">
                    <asp:Button ID="ButtonFiltros" class="form-control btn-secondary btn-sm btn-block mt-1" runat="server" Text="Filtros" OnClick="ButtonFiltros_Click" />
                </div>
            </div>

            <asp:Panel ID="PanelFiltros" runat="server" Visible="False">
                <%--Filtros--%>
                <hr style="height: 2px; width: auto; border-width: 0; color: whitesmoke; background-color: whitesmoke">
                <div>
                    <div class="row">
                        <div class="col">
                            <%--Nombre Partida--%>
                            <asp:Label ID="LabelFiltroPartida" class="text-light" runat="server" Text="Partida:"></asp:Label>
                            <asp:TextBox ID="TextBoxFiltradoPartida" class="form-control" runat="server"></asp:TextBox>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <%--Proyectos para el filtro--%>
                            <asp:Label ID="LabelFiltroPartidaProyectos" class="text-light" runat="server" Text="Proyectos:"></asp:Label>
                            <asp:DropDownList ID="DropDownListProyectos" class="dropdown form-control" runat="server" DataTextField="NombreProyecto" DataValueField="codigoProyecto" DataSourceID="SqlDataSourceProyectos" AppendDataBoundItems="true">
                                <asp:ListItem Text="" Value=""></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource runat="server" ID="SqlDataSourceProyectos" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>" SelectCommand="SELECT [codigoProyecto], [NombreProyecto] FROM [Proyecto] ORDER BY [codigoProyecto]"></asp:SqlDataSource>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col">
                            <%--Fecha de Inicio--%>
                            <asp:Label ID="LabelFechaInicio" class="text-light" for="fechaInicio" runat="server" Text="Fecha mínima:"></asp:Label>
                            <input id="fechaInicio" class="form-control" runat="server" type="date" name="fecha">
                        </div>
                        <div class="col">
                            <%--Fecha de Fin--%>
                            <asp:Label ID="LabelFechaFin" class="text-light" for="fechaFin" runat="server" Text="Fecha máxima:"></asp:Label>
                            <input id="fechaFin" class="form-control" runat="server" type="date" name="fecha">
                        </div>
                    </div>

                    <div class="row">
                        <div class="col">
                            <%--Presupuesto Minimo--%>
                            <asp:Label ID="LabelPresupuestoMinimo" class="text-light" for="costeMinimo" runat="server" Text="Presupuesto mínimo:"></asp:Label>
                            <input id="presupuestoMinimo" class="form-control" runat="server" type="number">
                        </div>
                        <div class="col">
                            <%--Presupuesto Maximo--%>
                            <asp:Label ID="LabelPresupuestoMaximo" class="text-light" for="costeMaximo" runat="server" Text="Presupuesto máximo:"></asp:Label>
                            <input id="presupuestoMaximo" class="form-control" runat="server" type="number">
                        </div>
                    </div>

                    <div class="text-center mt-2">
                        <asp:Button ID="ButtonFiltrado" class="form-control btn btn-primary btn-sm btn-block buttonFilter" runat="server" Text="Filtrar" OnClick="ButtonFiltrado_Click" />
                        <asp:Button runat="server" class="form-control btn-secondary btn-sm btn-block buttonFilter mt-1" Text="Limpiar" OnClick="Todos_Click"></asp:Button>
                    </div>
                </div>
            </asp:Panel>
        </div>

        <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>"
            SelectCommand="SELECT P.*, Pr.nombreProyecto FROM Partida P INNER JOIN Proyecto Pr ON P.codigoProyecto = Pr.codigoProyecto order by P.codigoPartida DESC;"
            DeleteCommand="DELETE FROM [Partida] WHERE [codigoPartida] = @original_codigoPartida"
            InsertCommand="INSERT INTO [Partida] ([nombrePartida], [fechaInicio], [fechaFin], [Presupuesto], [codigoProyecto]) VALUES (@nombrePartida, @FechaInicio, @FechaFin, @Presupuesto, @codigoProyecto)"
            OldValuesParameterFormatString="original_{0}"
            UpdateCommand="UPDATE [Partida] SET [nombrePartida] = @nombrePartida, [fechaInicio] = @FechaInicio, [fechaFin] = @FechaFin, [Presupuesto] = @Presupuesto, [codigoProyecto] = @codigoProyecto WHERE [codigoPartida] = @codigoPartida">
            <DeleteParameters>
                <asp:Parameter Name="original_codigoPartida" Type="Int32"></asp:Parameter>
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="nombrePartida" Type="String"></asp:Parameter>
                <asp:Parameter DbType="Date" Name="FechaInicio"></asp:Parameter>
                <asp:Parameter DbType="Date" Name="FechaFin"></asp:Parameter>
                <asp:Parameter Name="Presupuesto" Type="Decimal"></asp:Parameter>
                <asp:Parameter Name="codigoProyecto" Type="Int32"></asp:Parameter>
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="nombrePartida" Type="String"></asp:Parameter>
                <asp:Parameter DbType="Date" Name="FechaInicio"></asp:Parameter>
                <asp:Parameter DbType="Date" Name="FechaFin"></asp:Parameter>
                <asp:Parameter Name="Presupuesto" Type="Decimal"></asp:Parameter>
                <asp:Parameter Name="codigoProyecto" Type="Int32"></asp:Parameter>
                <asp:Parameter Name="codigoPartida" Type="Int32"></asp:Parameter>
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:GridView ID="GridView1" class="table mt-3 tamanio-partida" runat="server" AllowPaging="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" DataKeyNames="codigoPartida" DataSourceID="SqlDataSource1" ForeColor="Black" GridLines="Vertical" AllowSorting="True">
            <AlternatingRowStyle BackColor="#CCCCCC" />
            <Columns>
                <asp:BoundField DataField="codigoPartida" HeaderText="ID" ReadOnly="True" InsertVisible="False"></asp:BoundField>

                <asp:TemplateField HeaderText="Nombre">
                    <ItemTemplate>
                        <asp:Label ID="LabelNombrePartida" runat="server" Text='<%# Bind("nombrePartida") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBoxNombrePartida" class="form-control edit-textbox" runat="server" Text='<%# Bind("nombrePartida") %>'></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Fecha Inicio" SortExpression="fechaInicio">
                    <ItemTemplate>
                        <%# Eval("fechaInicio", "{0:dd/MM/yy}") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <input type="date" id="txtFechaInicio" class="form-control edit-textbox" runat="server" value='<%# Bind("FechaInicio", "{0:yyyy-MM-dd}") %>' />
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Fecha Fin" SortExpression="fechaFin">
                    <ItemTemplate>
                        <%# Eval("fechaFin", "{0:dd/MM/yy}") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <input type="date" id="txtFechaFin" class="form-control edit-textbox" runat="server" value='<%# Bind("FechaFin", "{0:yyyy-MM-dd}") %>' />
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Presupuesto" SortExpression="Presupuesto">
                    <ItemTemplate>
                        <asp:Label ID="LabelPresupuesto" runat="server" Text='<%# Bind("Presupuesto") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBoxPresupuesto" class="form-control edit-textbox" runat="server" Text='<%# Bind("Presupuesto") %>'></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Proyecto">
                    <ItemTemplate>
                        <%# Eval("nombreProyecto") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:DropDownList Text='<%# Bind("codigoProyecto") %>' class="dropdown form-control edit-dropdown" ID="idProyectoDropDownList" runat="server" DataSourceID="idProyecto2SqlDataSource" DataTextField="NombreProyecto" DataValueField="codigoProyecto"></asp:DropDownList>
                        <asp:SqlDataSource ID="idProyecto2SqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>" SelectCommand="SELECT codigoProyecto, NombreProyecto FROM Proyecto order by NombreProyecto"></asp:SqlDataSource>
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True"></asp:CommandField>
            </Columns>
            <FooterStyle BackColor="#CCCCCC" />
            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
        </asp:GridView>

        <asp:Panel ID="Panel1" runat="server" Visible="False">
            <asp:FormView class="form-control mt-3" ID="FormViewInsertarPartida" runat="server" DataKeyNames="codigoPartida" DataSourceID="SqlDataSource1" DefaultMode="Insert" OnItemInserting="FormViewInsertarPartida_ItemInserting">
                <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <InsertItemTemplate>
                    <div class="row">
                        <div class="col text-center">
                            <h3>Insertar Partida</h3>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col">
                            Nombre:
                            <asp:TextBox class="form-control" Text='<%# Bind("nombrePartida") %>' data-toggle="tooltip" title="Nombre de la partida" runat="server" ID="nombrePartidaTextBox" />
                        </div>
                        <div class="col">
                            Presupuesto:
                            <input type="number" value='<%# Bind("Presupuesto") %>' class="form-control" runat="server" ID="PresupuestoInputNumber" />
                        </div>

                    </div>

                    <div class="row">
                        <div class="col">
                            Fecha de Inicio:
                            <input type="date" class="form-control" data-toggle="tooltip" title="Fecha de alta de la partida" runat="server" ID="FechaInicioTextBox" value='<%# Bind("FechaInicio", "{0:yyyy-MM-dd}") %>' />
                        </div>
                        <div class="col">
                            Fecha Fin:
                            <input type="date" class="form-control" data-toggle="tooltip" title="Fecha de baja de la partida" runat="server" ID="FechaFinTextBox" value='<%# Bind("fechaFin", "{0:yyyy-MM-dd}") %>' />
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
