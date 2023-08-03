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
        <%--Bloque de sqldatasource y tabla para listado--%>
        <div>  
            <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>"
                SelectCommand="SELECT LT.codigoLinea,P.nombrePartida AS nombrePartida,N.nombre AS nombreNaturaleza,LT.horasNormales,LT.horasExtra FROM LineaTrabajo LT JOIN Partida P ON LT.codigoPartida = P.codigoPartida JOIN Naturaleza N ON LT.codigoNaturaleza = N.codigoNaturaleza WHERE ([codigoTrabajador] = @codigoTrabajador); ">
                <SelectParameters>
                    <asp:SessionParameter SessionField="codigoTrabajador" Name="codigoTrabajador"></asp:SessionParameter>
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource1" AutoGenerateColumns="False" DataKeyNames="codigoLinea" AllowPaging="True" AllowSorting="True">
                <AlternatingRowStyle BackColor="#CCCCCC" />
                <Columns>
                    <asp:BoundField DataField="codigoLinea" HeaderText="codigoLinea" ReadOnly="True" InsertVisible="False"></asp:BoundField>
                    <asp:BoundField DataField="nombrePartida" HeaderText="nombrePartida"></asp:BoundField>
                    <asp:BoundField DataField="nombreNaturaleza" HeaderText="nombreNaturaleza"></asp:BoundField>
                    <asp:BoundField DataField="horasNormales" HeaderText="horasNormales" SortExpression="horasNormales"></asp:BoundField>
                    <asp:BoundField DataField="horasExtra" HeaderText="horasExtra" SortExpression="horasExtra"></asp:BoundField>
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

