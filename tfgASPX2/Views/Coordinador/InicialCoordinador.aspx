<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Master1.Master" AutoEventWireup="true" CodeBehind="InicialCoordinador.aspx.cs" Inherits="tfgASPX2.Views.Coordinador.InicialCoordinador" %>

<asp:Content ID="InicialCoordinadorHead" ContentPlaceHolderID="head" runat="server">
    <link href="../../Styles/InicialCoordinadorStyle.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css"
        rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x"
        crossorigin="anonymous" />
</asp:Content>

<asp:Content ID="InicialCoordinadorNavegacion" ContentPlaceHolderID="ContentPlaceHolderNavegacion" runat="server">
    <a href="InicialCoordinador.aspx">Menu</a>
    <%--<a href="InsertarParte.aspx">Parte</a>--%>
    <%--<a href="PerfilCoordinador.aspx">Perfil</a>--%>
</asp:Content>

<asp:Content ID="InicialCoordinadorBody" ContentPlaceHolderID="ContentPlaceHolderContenido" runat="server">
    <div class="auto-style1">
        <div>
            <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>"
                SelectCommand="SELECT Parte.codigoParte, Parte.fecha, Parte.tipo, Parte.codigoTrabajador, Proyecto.NombreProyecto, Cliente.NombreEntidad FROM Parte LEFT JOIN Proyecto ON Parte.codigoProyecto = Proyecto.codigoProyecto LEFT JOIN Cliente ON Parte.codigoCliente = Cliente.codigoCliente WHERE ([codigoTrabajador] = @codigoTrabajador)">
                <SelectParameters>
                    <asp:SessionParameter SessionField="codigoTrabajador" Name="codigoTrabajador" Type="Int32"></asp:SessionParameter>
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:GridView ID="GridView1" class="table" runat="server" DataSourceID="SqlDataSource1" AutoGenerateColumns="False" DataKeyNames="codigoParte" AllowPaging="True">
                <AlternatingRowStyle BackColor="#CCCCCC" />
                <Columns>
                    <asp:BoundField DataField="codigoParte" HeaderText="Parte" ReadOnly="True" InsertVisible="False" SortExpression="codigoParte"></asp:BoundField>
                   
                    <asp:TemplateField HeaderText="Tipo" SortExpression="tipo">
                        <ItemTemplate>
                            <asp:Label ID="lblTipo" runat="server" Text='<%# Eval("tipo").ToString() == "1" ? "Asociado" : "No asociado" %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="NombreProyecto" HeaderText="Proyecto" SortExpression="NombreProyecto"></asp:BoundField>
                    <asp:BoundField DataField="NombreEntidad" HeaderText="Cliente" SortExpression="NombreEntidad"></asp:BoundField>
                    <asp:BoundField DataField="fecha" HeaderText="Fecha" SortExpression="fecha"></asp:BoundField>
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
    </div>
</asp:Content>
