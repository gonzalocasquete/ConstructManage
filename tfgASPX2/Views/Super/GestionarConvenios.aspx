<%@ Page Language="C#" MasterPageFile="~/Master/Master1.Master" AutoEventWireup="true" CodeBehind="GestionarConvenios.aspx.cs" Inherits="tfgASPX2.Views.Super.GestionarConvenios" %>

<asp:Content ID="GestionarConveniosHead" ContentPlaceHolderID="head" runat="server">
    <link href="../../Styles/GestionarConveniosStyles.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css"
        rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x"
        crossorigin="anonymous" />
</asp:Content>

<asp:Content ID="GestionarConveniosNavegacion" ContentPlaceHolderID="ContentPlaceHolderNavegacion" runat="server">
    <a href="MenuSuper.aspx">Menú</a>
</asp:Content>

<asp:Content ID="GestionarConveniosBody" ContentPlaceHolderID="ContentPlaceHolderContenido" runat="server">
    <div class="auto-style1">

        <h2 class="font-weight-bold">Gestión de Convenios</h2>

        <%--Filtros--%>
        <hr />
        <div>
            <div class="row">
                <div class="col">
                    <%--Nombre Proyecto--%>
                    <asp:Label ID="LabelFiltroConvenio" runat="server" Text="Convenio:"></asp:Label>
                    <asp:TextBox ID="TextBoxFiltradoConvenio" class="form-control" runat="server"></asp:TextBox>
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
                    <input id="fechaMaxima" class="form-control" runat="server" type="date" name="fechaMaxima">
                </div>
            </div>

            <div class="text-center mt-2">
                <asp:Button ID="ButtonFiltrado" class="form-control btn btn-primary btn-sm btn-block buttonFilter" runat="server" Text="Filtrar" OnClick="ButtonFiltrado_Click" />
                <asp:Button runat="server" class="form-control btn-secondary btn-sm btn-block buttonFilter mt-1" Text="Limpiar" OnClick="Todos_Click"></asp:Button>
            </div>
        </div>

        <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>" DeleteCommand="DELETE FROM [Convenio] WHERE [codigoConvenio] = @codigoConvenio" InsertCommand="INSERT INTO [Convenio] ([fechaInicio], [fechaFin], [nombre]) VALUES (@fechaInicio, @fechaFin, @nombre)" SelectCommand="SELECT * FROM [Convenio]" UpdateCommand="UPDATE [Convenio] SET [fechaInicio] = @fechaInicio, [fechaFin] = @fechaFin, [nombre] = @nombre WHERE [codigoConvenio] = @codigoConvenio">
            <DeleteParameters>
                <asp:Parameter Name="codigoConvenio" Type="Int32"></asp:Parameter>
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter DbType="Date" Name="fechaInicio"></asp:Parameter>
                <asp:Parameter DbType="Date" Name="fechaFin"></asp:Parameter>
                <asp:Parameter Name="nombre" Type="String"></asp:Parameter>
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter DbType="Date" Name="fechaInicio"></asp:Parameter>
                <asp:Parameter DbType="Date" Name="fechaFin"></asp:Parameter>
                <asp:Parameter Name="nombre" Type="String"></asp:Parameter>
                <asp:Parameter Name="codigoConvenio" Type="Int32"></asp:Parameter>
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:GridView ID="GridView1" class="table mt-3" runat="server" AllowPaging="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" DataKeyNames="codigoConvenio" DataSourceID="SqlDataSource1" ForeColor="Black" GridLines="Vertical" AllowSorting="True">
            <AlternatingRowStyle BackColor="#CCCCCC" />
            <Columns>
                <asp:BoundField DataField="nombre" HeaderText="Nombre"></asp:BoundField>
                <asp:BoundField DataField="codigoConvenio" HeaderText="ID" ReadOnly="True" InsertVisible="False"></asp:BoundField>

                <asp:TemplateField HeaderText="Fecha Inicio" SortExpression="fechaInicio" >
                    <ItemTemplate>
                        <%# Eval("fechaInicio", "{0:dd/MM/yy}") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <input type="date" id="dateFechaInicio" runat="server" value='<%# Bind("fechaInicio", "{0:yyyy-MM-dd}") %>' />
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Fecha Fin" SortExpression="fechaFin">
                    <ItemTemplate>
                        <%# Eval("fechaFin", "{0:dd/MM/yy}") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <input type="date" id="dateFechFin" runat="server" value='<%# Bind("fechaFin", "{0:yyyy-MM-dd}") %>' />
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:CommandField SelectText="DetallesxCategoria" ShowDeleteButton="True" ShowEditButton="True" ShowSelectButton="True"></asp:CommandField>
            </Columns>
            <FooterStyle BackColor="#CCCCCC" />
            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
        </asp:GridView>

        <asp:Button ID="ButtonInsertar" CssClass="ButtonStyle button1 mt-3" runat="server" Text="Insertar" OnClick="Button1_Click" />


        <asp:Panel ID="Panel1" runat="server">
            <asp:SqlDataSource runat="server" ID="SqlDataSource2" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>" SelectCommand="SELECT AsociacionCostes.*, AsociacionCostes.codigoAsociacionCoste AS Expr1, AsociacionCostes.codigoConvenio AS Expr2, AsociacionCostes.codigoCategoria AS Expr3, AsociacionCostes.precioHora AS Expr4, AsociacionCostes.precioHoraExtra AS Expr5, AsociacionCostes.horasMaxDia AS Expr6, CategoriaProfesional.nombreCategoria, Convenio.nombre FROM AsociacionCostes INNER JOIN CategoriaProfesional ON AsociacionCostes.codigoCategoria = CategoriaProfesional.codigoCategoria INNER JOIN Convenio ON AsociacionCostes.codigoConvenio = Convenio.codigoConvenio WHERE (AsociacionCostes.codigoConvenio = @codigoConvenio)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="GridView1" PropertyName="SelectedValue" Name="codigoConvenio" Type="Int32"></asp:ControlParameter>
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:GridView ID="GridView2" class="table mt-3" runat="server" AllowPaging="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" DataKeyNames="codigoAsociacionCoste,Expr1" DataSourceID="SqlDataSource2" ForeColor="Black" GridLines="Vertical">
                <AlternatingRowStyle BackColor="#CCCCCC" />
                <Columns>
                    <asp:BoundField DataField="codigoAsociacionCoste" HeaderText="ID " ReadOnly="True" InsertVisible="False" SortExpression="codigoAsociacionCoste"></asp:BoundField>
                    <asp:BoundField DataField="nombreCategoria" HeaderText="Categoria" SortExpression="nombreCategoria"></asp:BoundField>
                    <asp:BoundField DataField="nombre" HeaderText="Convenio" SortExpression="nombre"></asp:BoundField>
                    <asp:BoundField DataField="precioHora" HeaderText="Precio Hora" SortExpression="precioHora"></asp:BoundField>
                    <asp:BoundField DataField="precioHoraExtra" HeaderText="Precio HHEE" SortExpression="precioHoraExtra"></asp:BoundField>
                    <asp:BoundField DataField="horasMaxDia" HeaderText="Max Horas " SortExpression="horasMaxDia"></asp:BoundField>
                </Columns>
                <FooterStyle BackColor="#CCCCCC" />
                <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
            </asp:GridView>
        </asp:Panel>

        <asp:Panel ID="Panel2" runat="server" Visible="False">
            <asp:FormView ID="FormView1" class="form-control" runat="server" DataKeyNames="codigoConvenio" DataSourceID="SqlDataSource1" DefaultMode="Insert">
                <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <InsertItemTemplate>
                    <div class="row">
                        <div class="col">
                            Nombre:
                            <asp:TextBox Text='<%# Bind("nombre") %>' class="form-control" data-toggle="tooltip" title="Nombre del convenio" runat="server" ID="nombreTextBox" />
                        </div>

                    </div>

                    <div class="row">
                        <div class="col">
                            Fecha de Inicio:
                            <input type="date" id="fechaInicio" class="form-control" data-toggle="tooltip" title="Fecha de alta del proyecto" runat="server" value='<%# Bind("fechaInicio", "{0:yyyy-MM-dd}") %>' />
                        </div>
                        <div class="col">
                            Fecha Fin:
                            <input type="date" id="fechaFin" class="form-control" data-toggle="tooltip" title="Fecha de fin del proyecto" runat="server" value='<%# Bind("fechaInicio", "{0:yyyy-MM-dd}") %>' />
                        </div>
                    </div>

                    <div class="mt-3 text-center">
                        <asp:LinkButton runat="server" class="btn btn-success" Text="Insertar" CommandName="Insert" ID="InsertButton" CausesValidation="True" />
                        &nbsp;
                    <asp:LinkButton runat="server" class="btn btn-danger" Text="Cancelar" CommandName="Cancel" ID="InsertCancelButton" CausesValidation="False" />
                    </div>
                </InsertItemTemplate>
                <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
            </asp:FormView>
        </asp:Panel>
    </div>
</asp:Content>
