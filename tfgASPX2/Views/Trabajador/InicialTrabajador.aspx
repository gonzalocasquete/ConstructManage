<%@ Page Language="C#" MasterPageFile="~/Master/Master1.Master" AutoEventWireup="true" CodeBehind="InicialTrabajador.aspx.cs" Inherits="tfgASPX2.Views.Trabajador.InicialTrabajador" %>

<asp:Content ID="TrabajadorHead" ContentPlaceHolderID="head" runat="server">
    <link href="../../Styles/InicialTrabajadorStyle.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="TrabajadorNavegacion" ContentPlaceHolderID="ContentPlaceHolderNavegacion" runat="server">
    <link href="../../Styles/ComunesStyle.css" rel="stylesheet" />
    <a href="InicialTrabajador.aspx">Inicio</a>
    <a href="../Comun/Perfil.aspx">Perfil</a>
</asp:Content>

<asp:Content ID="TrabajadorBody" ContentPlaceHolderID="ContentPlaceHolderContenido" runat="server">
    <div class="auto-style1">
        <h2>
            <asp:Label ID="LabelMensajeBienvenida" runat="server"></asp:Label>
        </h2>

        <%--Bloque div para los filtros--%>
        <div style="width: 250px">
            <div class="row">
                <div class="col">
                    <asp:Button ID="ButtonCalcularHoras" class="form-control btn-secondary btn-sm btn-block buttonFilter mt-1" runat="server" Text="CalcularHoras" OnClick="ButtonCalcularHoras_Click" />
                </div>
            </div>
            <div class="row">
                <div class="col">
                    <asp:Button ID="ButtonFiltros" class="form-control btn-secondary btn-sm btn-block mt-1" runat="server" Text="Filtros" OnClick="ButtonFiltros_Click" />
                </div>
            </div>

            <asp:Panel ID="PanelFiltros" runat="server" Visible="False">
                <hr style="height: 2px; width: auto; border-width: 0; color: whitesmoke; background-color: whitesmoke">


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
                        <%-- Partida--%>
                        <asp:Label ID="LabelPartida" class="text-light" runat="server" Text="Partida:"></asp:Label>
                        <asp:TextBox ID="TextBoxPartida" class="form-control" runat="server"></asp:TextBox>
                    </div>
                    <div class="col">
                        <%--Naturaleza--%>
                        <asp:Label ID="LabelNaturaleza" class="text-light" runat="server" Text="Naturaleza:"></asp:Label>
                        <asp:TextBox ID="TextBoxNaturaleza" class="form-control" runat="server"></asp:TextBox>
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
                    <asp:Button ID="ButtonFiltrado" class="form-control btn btn-primary btn-sm btn-block buttonFilter" runat="server" Text="Filtrar" OnClick="ButtonFiltrado_Click" />
                    <asp:Button runat="server" class="form-control btn-secondary btn-sm btn-block buttonFilter mt-1" Text="Limpiar" OnClick="Todos_Click"></asp:Button>
                </div>

            </asp:Panel>

            <%--Bloque div para el numero de horas totales del trabajador--%>
            <asp:Panel ID="PanelCalcularHoras" runat="server" Visible="false">
                <div class="row mt-2">
                    <div class="col-md-5">
                        <asp:Label ID="LabelCalculoHoras" class="text-light" runat="server" Text="Horas totales:"></asp:Label>
                        <asp:TextBox ID="TextBoxHorasTotales" class="form-control" runat="server" ReadOnly="true"></asp:TextBox>
                    </div>

                    <div class="col">
                        <div class="row">
                            <asp:Label ID="LabelTipoHoras" class="text-light" runat="server" Text="Tipo de horas:"></asp:Label>

                        </div>

                        <div class="row">
                            <div class="col">
                                <asp:CheckBox ID="CheckBoxHorasNormales" runat="server" OnCheckedChanged="CheckBoxHorasNormales_CheckedChanged" AutoPostBack="True" />

                                <label class="form-check-label text-light" for="<%= CheckBoxHorasNormales.ClientID %>">
                                    Horas normales
                                </label>

                            </div>

                        </div>
                        <div class="row">
                            <div class="col">
                                <asp:CheckBox ID="CheckBoxHorasExtra" runat="server" OnCheckedChanged="CheckBoxHorasExtra_CheckedChanged" AutoPostBack="True" />

                                <label class="form-check-label text-light" for="<%= CheckBoxHorasExtra.ClientID %>">
                                    Horas extra
                                </label>

                            </div>
                        </div>
                    </div>
                </div>
            </asp:Panel>
        </div>

        <%--Bloque de sqldatasource y tabla para listado--%>

        <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>"
            SelectCommand="SELECT LT.codigoLinea,P.nombrePartida AS nombrePartida,N.nombre AS nombreNaturaleza,LT.horasNormales,LT.horasExtra FROM LineaTrabajo LT LEFT JOIN Partida P ON LT.codigoPartida = P.codigoPartida JOIN Naturaleza N ON LT.codigoNaturaleza = N.codigoNaturaleza WHERE ([codigoTrabajador] = @codigoTrabajador); ">
            <SelectParameters>
                <asp:SessionParameter SessionField="codigoTrabajador" Name="codigoTrabajador"></asp:SessionParameter>
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:GridView ID="GridView1" class="table mt-3 tamanio-lineas" runat="server" DataSourceID="SqlDataSource1" AutoGenerateColumns="False" DataKeyNames="codigoLinea" AllowPaging="True" AllowSorting="True" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical">
            <AlternatingRowStyle BackColor="#CCCCCC" />
            <Columns>
                <asp:BoundField DataField="codigoLinea" HeaderText="Linea" ReadOnly="True" InsertVisible="False" SortExpression="codigoLinea"></asp:BoundField>
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

    </div>
</asp:Content>

