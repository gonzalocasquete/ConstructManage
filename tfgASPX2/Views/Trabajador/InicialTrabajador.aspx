<%@ Page Language="C#" MasterPageFile="~/Master/Master1.Master" AutoEventWireup="true" CodeBehind="InicialTrabajador.aspx.cs" Inherits="tfgASPX2.Views.Trabajador.InicialTrabajador" %>

<asp:Content ID="TrabajadorHead" ContentPlaceHolderID="head" runat="server">
    <link href="../../Styles/InicialTrabajadorStyle.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css"
        rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x"
        crossorigin="anonymous" />
</asp:Content>

<asp:Content ID="TrabajadorNavegacion" ContentPlaceHolderID="ContentPlaceHolderNavegacion" runat="server">
    <a href="InicialTrabajador.aspx">Inicio</a>
    <a href="../Comun/Perfil.aspx">Perfil</a>
</asp:Content>

<asp:Content ID="TrabajadorBody" ContentPlaceHolderID="ContentPlaceHolderContenido" runat="server">
    <div class="auto-style1">
                    <div class="row">
                <div class="col">
                    <asp:Label ID="LabelMensajeBienvenida" class="alert alert-info" runat="server" Text=""></asp:Label>
                </div>
            </div>

        <%--Bloque div para los filtros--%>  
        <div>
             <hr />
            <div class="row">
                <div class="col">
                    <asp:Label ID="LabelFiltroHorasMinimas" runat="server" Text="Horas Minimas:"></asp:Label>
                    <input id="horasMinimas" class="form-control" runat="server" type="number" name="horasMinimas">
                </div>
                <div class="col">
                    <asp:Label ID="LabelHorasMaximas" runat="server" Text="Horas Maximas:"></asp:Label>
                    <input id="horasMaximas" class="form-control" runat="server" type="number" name="horasMaximas">
                </div>
            </div>

            <div class="row">
                <div class="col">
                    <asp:Label ID="LabelFiltroHorasExtraMinimas" runat="server" Text="Horas Extra Minimas:"></asp:Label>
                    <input id="horasExtraMinimas" class="form-control" runat="server" type="number" name="horasExtraMinimas">
                </div>
                <div class="col">
                    <asp:Label ID="LabelFiltroHorasExtraMaximas" runat="server" Text="Horas Extra Maximas:"></asp:Label>
                    <input id="horasExtraMaximas" class="form-control" runat="server" type="number" name="horasExtraMaximas">
                </div>
            </div>

            <div class="text-center mt-2">
                <asp:Button ID="ButtonFiltrado" class="form-control btn btn-primary btn-sm btn-block buttonFilter" runat="server" Text="Filtrar" OnClick="ButtonFiltrado_Click" />
                <asp:Button runat="server" class="form-control btn-secondary btn-sm btn-block buttonFilter mt-1" Text="Limpiar" OnClick="Todos_Click"></asp:Button>
            </div>


            <%--Bloque div para el numero de horas totales del trabajador--%>
            <div class="mt-2">
                <div class="row">
                    <div class="col">
                        <asp:Label ID="LabelCalculoHoras" runat="server" Text="Horas totales:"></asp:Label>
                        <asp:TextBox ID="TextBoxHorasTotales" class="form-control" runat="server" ReadOnly="true"></asp:TextBox>
                    </div>
                    <div class="col">codigoNaturaleza
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
                </div>
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
                    <asp:BoundField DataField="codigoLinea" HeaderText="Linea" ReadOnly="True" InsertVisible="False" SortExpression="codigoLinea"></asp:BoundField>
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

