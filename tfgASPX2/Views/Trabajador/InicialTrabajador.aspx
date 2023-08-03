<%@ Page Language="C#" MasterPageFile="~/Master/Master1.Master" AutoEventWireup="true" CodeBehind="InicialTrabajador.aspx.cs" Inherits="tfgASPX2.Views.Trabajador.InicialTrabajador" %>

<asp:Content ID="TrabajadorHead" ContentPlaceHolderID="head" runat="server">
    <link href="../../Styles/InicialTrabajadorStyle.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css"
        rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x"
        crossorigin="anonymous" />
</asp:Content>

<asp:Content ID="TrabajadorNavegacion" ContentPlaceHolderID="ContentPlaceHolderNavegacion" runat="server">
    <a href="InicialTrabajador.aspx">Menu</a>
    <a href="PerfilTrabajador.aspx">Perfil</a>
</asp:Content>

<asp:Content ID="TrabajadorBody" ContentPlaceHolderID="ContentPlaceHolderContenido" runat="server">
    <div class="auto-style1">
        <div>
            <asp:Label ID="LabelMensajeBienvenida" runat="server" Text=""></asp:Label>
        </div>

        <%--Bloque div para los filtros--%>
        <hr />
        <div>
            <asp:Label ID="LabelFiltroHoras" runat="server" Text="Horas:"></asp:Label>
            <asp:TextBox ID="TextBoxFiltrado" class="form-control" runat="server"></asp:TextBox>

            <div class="text-center mt-2">
                <asp:Button ID="ButtonFiltrado" class="form-control btn btn-primary btn-sm btn-block buttonFilter" runat="server" Text="Filtrar" OnClick="ButtonFiltrado_Click" />
                <asp:Button runat="server" class="form-control btn-secondary btn-sm btn-block buttonFilter mt-1" Text="Limpiar" OnClick="Todos_Click"></asp:Button>
            </div>
        </div>

        <%--Bloque div para el numero de horas totales del trabajador--%>
        <div class="mt-2">
            <asp:Label ID="LabelCalculoHoras" runat="server" Text="Horas totales:"></asp:Label>
            <asp:TextBox ID="TextBoxHorasTotales" class="form-control" runat="server" ReadOnly="true"></asp:TextBox>
            <asp:Label ID="LabelTipoHoras" runat="server" Text="Tipo de horas:"></asp:Label>
            <div>
                <asp:CheckBox ID="CheckBoxHorasNormales" runat="server" OnCheckedChanged="CheckBoxHorasNormales_CheckedChanged" AutoPostBack="True" />
                <label class="form-check-label" for="<%= CheckBoxHorasNormales.ClientID %>">
                    Horas Normales
                </label>
            </div>
            <div>
                <asp:CheckBox ID="CheckBoxHorasExtra" runat="server" OnCheckedChanged="CheckBoxHorasExtra_CheckedChanged" AutoPostBack="True" />
                <label class="form-check-label" for="<%= CheckBoxHorasExtra.ClientID %>">
                  Horas extra
                </label>
            </div>
        </div>

        <%--Bloque de sqldatasource y tabla para listado--%>
        <div>
            <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>"
                SelectCommand="SELECT LT.codigoLinea,P.nombrePartida AS nombrePartida,N.nombre AS nombreNaturaleza,LT.horasNormales,LT.horasExtra FROM LineaTrabajo LT JOIN Partida P ON LT.codigoPartida = P.codigoPartida JOIN Naturaleza N ON LT.codigoNaturaleza = N.codigoNaturaleza WHERE ([codigoTrabajador] = @codigoTrabajador); ">
                <SelectParameters>
                    <asp:SessionParameter SessionField="codigoTrabajador" Name="codigoTrabajador"></asp:SessionParameter>
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:GridView ID="GridView1" class="table mt-3" runat="server" DataSourceID="SqlDataSource1" AutoGenerateColumns="False" DataKeyNames="codigoLinea" AllowPaging="True" AllowSorting="True">
                <AlternatingRowStyle BackColor="#CCCCCC" />
                <Columns>
                    <asp:BoundField DataField="codigoLinea" HeaderText="Linea" ReadOnly="True" InsertVisible="False"></asp:BoundField>
                    <asp:BoundField DataField="nombrePartida" HeaderText="Partida"></asp:BoundField>
                    <asp:BoundField DataField="nombreNaturaleza" HeaderText="Naturaleza"></asp:BoundField>
                    <asp:BoundField DataField="horasNormales" HeaderText="Horas Normales" SortExpression="horasNormales"></asp:BoundField>
                    <asp:BoundField DataField="horasExtra" HeaderText="Horas Extra" SortExpression="horasExtra"></asp:BoundField>
                    <asp:CommandField ShowSelectButton="True"></asp:CommandField>
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
    </div>
</asp:Content>

