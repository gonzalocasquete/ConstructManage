<%@ Page Language="C#" MasterPageFile="~/Master/Master1.Master" AutoEventWireup="true" CodeBehind="Presupuestos.aspx.cs" Inherits="tfgASPX2.Views.Coordinador.Presupuesto" %>

<asp:Content ID="GestionarProyectosHead" ContentPlaceHolderID="head" runat="server">
    <link href="../../Styles/PresupuestosStyle.css" rel="stylesheet" />
    <link href="../../Styles/ComunesStyle.css" rel="stylesheet" />
    <link href="../../Styles/ComunCoordinadorStyle.css" rel="stylesheet" />
    <script src="../../Scripts/Views/GestionarProyectoStyle.js"></script>
</asp:Content>

<asp:Content ID="GestionarProyectosNavegacion" ContentPlaceHolderID="ContentPlaceHolderNavegacion" runat="server">
    <a href="InicialCoordinador.aspx">Inicio</a>
    <a href="ConsularProyectos.aspx">Proyectos</a>
    <a href="Presupuestos.aspx">Balance</a>
    <a href="Informacion.aspx.cs">Estudio</a>
    <a href="../Comun/Perfil.aspx">Perfil</a>
</asp:Content>

<asp:Content ID="GestionarProyectosBody" ContentPlaceHolderID="ContentPlaceHolderContenido" runat="server">
    <div class="auto-style1">
        <h2>Presupuesto</h2>
        <%--Filtros--%>
        <div style="width: 250px">

            <div class="row">
                <div class="col">
                    <asp:Button ID="ButtonFiltros" class="form-control btn-secondary btn-sm btn-block mt-1" runat="server" Text="Filtros" />
                </div>
            </div>

            <div class="row">
                <div class="col">
                    <asp:Button ID="ButtonVolver" class="form-control btn-warning btn-sm btn-block mt-1" runat="server" Text="Volver" Visible="false" />
                </div>
            </div>

            <asp:Panel ID="PanelFiltros" runat="server" Visible="true">
                <%--Filtros--%>
                <hr style="height: 2px; width: auto; border-width: 0; color: whitesmoke; background-color: whitesmoke">
                <div>
                    <div class="row">
                        <div class="col">
                            <%--Nombre Proyecto--%>
                            <asp:Label ID="LabelFiltroProyecto" class="text-light" runat="server" Text="Proyecto:"></asp:Label>
                            <asp:TextBox ID="TextBoxFiltradoProyecto" class="form-control" runat="server"></asp:TextBox>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col">
                            <%--Presupuesto Minimo--%>
                            <asp:Label ID="LabelPresupuestoMinimo" class="text-light" for="presupuestoMinimo" runat="server" Text="Horas normales mínimas:"></asp:Label>
                            <input id="presupuestoMinimo" class="form-control" runat="server" type="number" name="presupuestoMinimo">
                        </div>
                        <div class="col">
                            <%--Presupuesto Maximo--%>
                            <asp:Label ID="LabelPresupuestoMaximo" class="text-light" for="presupuestoMaximo" runat="server" Text="Horas extras mínimas:"></asp:Label>
                            <input id="presupuestoMaximo" class="form-control" runat="server" type="number" name="presupuestoMaximo">
                        </div>
                    </div>

                    <div class="row">
                        <div class="col">
                            <%--Presupuesto Minimo--%>
                            <asp:Label ID="Label1" class="text-light" for="presupuestoMinimo" runat="server" Text="Importe Horas Normales:"></asp:Label>
                            <input id="Number1" class="form-control" runat="server" type="number" name="presupuestoMinimo">
                        </div>
                        <div class="col">
                            <%--Presupuesto Maximo--%>
                            <asp:Label ID="Label2" class="text-light" for="presupuestoMaximo" runat="server" Text="Importe Horas Extras:"></asp:Label>
                            <input id="Number2" class="form-control" runat="server" type="number" name="presupuestoMaximo">
                        </div>
                    </div>

                    <div class="row">



                        <div class="col">
                            <%--Presupuesto Maximo--%>
                            <asp:Label ID="Label3" class="text-light" for="presupuestoMaximo" runat="server" Text="Presupuesto:"></asp:Label>
                            <input id="Number3" class="form-control" runat="server" type="number" name="presupuestoMaximo">
                        </div>

                        <div class="col">
                            <%--Presupuesto Maximo--%>
                            <asp:Label ID="Label4" class="text-light" for="presupuestoMaximo" runat="server" Text="Total:"></asp:Label>
                            <input id="Number4" class="form-control" runat="server" type="number" name="presupuestoMaximo">
                        </div>
                    </div>
                    <div class="text-center mt-2">
                        <asp:Button ID="ButtonFiltrado" class="form-control btn btn-primary btn-sm btn-block buttonFilter" runat="server" Text="Filtrar" />
                        <asp:Button runat="server" class="form-control btn-secondary btn-sm btn-block buttonFilter mt-1" Text="Limpiar" />
                    </div>
                </div>
            </asp:Panel>
        </div>

        <%--SqldDataSource para recoger todos los proyectos--%>
        <asp:SqlDataSource runat="server" ID="SqlDataSourcePresupuestos" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>"
            SelectCommand="SELECT *, (Presupuesto - ImporteHN - ImporteHe) AS Total FROM [AnalisisProyecto]"></asp:SqlDataSource>

        <asp:GridView ID="GridView1" class="table mt-3 tamanio-presupuesto" runat="server" DataSourceID="SqlDataSourcePresupuestos" AutoGenerateColumns="False" DataKeyNames="codigoProyecto" AllowPaging="True" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical" AllowSorting="True" OnRowDataBound="GridView1_RowDataBound">
            <AlternatingRowStyle BackColor="#CCCCCC" />
            <Columns>
                <asp:BoundField DataField="NombreProyecto" HeaderText="Proyecto" SortExpression="NombreProyecto"></asp:BoundField>
                <asp:BoundField DataField="Hn" HeaderText="Horas Normales" SortExpression="Hn"></asp:BoundField>
                <asp:BoundField DataField="He" HeaderText="Horas Extra" SortExpression="He"></asp:BoundField>
                <asp:BoundField DataField="Presupuesto" HeaderText="Presupuesto" SortExpression="Presupuesto"></asp:BoundField>
                <asp:BoundField DataField="ImporteHN" HeaderText="Importe HN" SortExpression="ImporteHN"></asp:BoundField>
                <asp:BoundField DataField="ImporteHe" HeaderText="Importe He" SortExpression="ImporteHe"></asp:BoundField>
                <asp:BoundField DataField="Total" HeaderText="Total" SortExpression="Total"></asp:BoundField>

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
