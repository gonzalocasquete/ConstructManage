<%@ Page Language="C#" MasterPageFile="~/Master/Master1.Master" AutoEventWireup="true" CodeBehind="GestionarClientes.aspx.cs" Inherits="tfgASPX2.Views.Super.GestionarClientes" %>

<asp:Content ID="GestionarClientesHead" ContentPlaceHolderID="head" runat="server">
    <link href="../../Styles/GestionarClientesStyle.css" rel="stylesheet" />
    <style type="text/css">
        .auto-style5 {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            margin-top: 40px;
            height: 818px;
        }

        .auto-style6 {
            height: 404px;
        }

        .auto-style7 {
            display: block;
            width: 100%;
            font-size: 1rem;
            font-weight: 400;
            line-height: 1.5;
            color: #212529;
            background-clip: padding-box;
            -webkit-appearance: none;
            -moz-appearance: none;
            appearance: none;
            border-radius: .25rem;
            transition: none;
            height: 310px;
            border: 1px solid #ced4da;
            background-color: #fff;
        }
    </style>
</asp:Content>

<asp:Content ID="GestionarClientesNavegacion" ContentPlaceHolderID="ContentPlaceHolderNavegacion" runat="server">
    <a href="MenuSuper.aspx">Menú</a>
</asp:Content>

<asp:Content ID="GestionarClientesBody" ContentPlaceHolderID="ContentPlaceHolderContenido" runat="server">
    <div class="auto-style1">
        <h2 class="font-weight-bold">Gestión Clientes</h2>

         <div style="width:200px">
     <div class="row">
         <div class="col">
             <asp:Button ID="ButtonFiltros" class="form-control btn-secondary btn-sm btn-block buttonFilter mt-1" runat="server" Text="Filtros" OnClick="ButtonFiltros_Click" />
         </div>
     </div>

     <asp:Panel ID="PanelFiltros" runat="server" Visible="False">   

        <%--Filtros--%>
        <hr />
        <div>
            <%--Entidad--%>
            <asp:Label ID="LabelFiltroEntidad" runat="server" Text="Entidad:"></asp:Label>
            <asp:TextBox ID="TextBoxFiltradoEntidad" class="form-control" runat="server"></asp:TextBox>
  
            <div class="text-center mt-2">
                <asp:Button ID="ButtonFiltrado" class="form-control btn btn-primary btn-sm btn-block buttonFilter" runat="server" Text="Filtrar" OnClick="ButtonFiltrado_Click" />
                <asp:Button runat="server" class="form-control btn-secondary btn-sm btn-block buttonFilter mt-1" Text="Limpiar" OnClick="Todos_Click"></asp:Button>
            </div>
        </div>
             </asp:Panel>
</div>

        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>" DeleteCommand="DELETE FROM [Cliente] WHERE [codigoCliente] = @codigoCliente" InsertCommand="INSERT INTO [Cliente] ([NombreEntidad], [DireccionDF], [CodigoPostalDF], [UbicacionDF], [BancoDF], [DireccionDE], [CodigoPostalDE], [UbicacionDE]) VALUES (@NombreEntidad, @DireccionDF, @CodigoPostalDF, @UbicacionDF, @BancoDF, @DireccionDE, @CodigoPostalDE, @UbicacionDE)" SelectCommand="SELECT * FROM [Cliente]" UpdateCommand="UPDATE [Cliente] SET [NombreEntidad] = @NombreEntidad, [DireccionDF] = @DireccionDF, [CodigoPostalDF] = @CodigoPostalDF, [UbicacionDF] = @UbicacionDF, [BancoDF] = @BancoDF, [DireccionDE] = @DireccionDE, [CodigoPostalDE] = @CodigoPostalDE, [UbicacionDE] = @UbicacionDE WHERE [codigoCliente] = @codigoCliente">
            <DeleteParameters>
                <asp:Parameter Name="codigoCliente" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="NombreEntidad" Type="String" />
                <asp:Parameter Name="DireccionDF" Type="String" />
                <asp:Parameter Name="CodigoPostalDF" Type="String" />
                <asp:Parameter Name="UbicacionDF" Type="String" />
                <asp:Parameter Name="BancoDF" Type="String" />
                <asp:Parameter Name="DireccionDE" Type="String" />
                <asp:Parameter Name="CodigoPostalDE" Type="String" />
                <asp:Parameter Name="UbicacionDE" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="NombreEntidad" Type="String" />
                <asp:Parameter Name="DireccionDF" Type="String" />
                <asp:Parameter Name="CodigoPostalDF" Type="String" />
                <asp:Parameter Name="UbicacionDF" Type="String" />
                <asp:Parameter Name="BancoDF" Type="String" />
                <asp:Parameter Name="DireccionDE" Type="String" />
                <asp:Parameter Name="CodigoPostalDE" Type="String" />
                <asp:Parameter Name="UbicacionDE" Type="String" />
                <asp:Parameter Name="codigoCliente" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:GridView ID="GridView1" class="mt-3 table mi-gridview" runat="server" AllowPaging="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" DataKeyNames="codigoCliente" DataSourceID="SqlDataSource1" ForeColor="Black" GridLines="Vertical">
            <AlternatingRowStyle BackColor="#CCCCCC" />
            <Columns>
                <asp:BoundField DataField="codigoCliente" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="codigoCliente" />
                <asp:BoundField DataField="NombreEntidad" HeaderText="Entidad" SortExpression="NombreEntidad" />
                <asp:BoundField DataField="DireccionDF" HeaderText="Domicilio Fiscal" SortExpression="DireccionDF" />
                <asp:BoundField DataField="CodigoPostalDF" HeaderText="Codigo Postal D.F" SortExpression="CodigoPostalDF" />
                <asp:BoundField DataField="UbicacionDF" HeaderText="Ubicacion D.F" SortExpression="UbicacionDF" />
                <asp:BoundField DataField="BancoDF" HeaderText="Banco D.F" SortExpression="BancoDF" />
                <asp:BoundField DataField="DireccionDE" HeaderText="Direccion D.E" SortExpression="DireccionDE" />
                <asp:BoundField DataField="CodigoPostalDE" HeaderText="CodigoPostal D.E" SortExpression="CodigoPostalDE" />
                <asp:BoundField DataField="UbicacionDE" HeaderText="Ubicacion D.E" SortExpression="UbicacionDE" />
                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
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
        <asp:Button ID="ButtonInsertar" CssClass="ButtonStyle button1 mt-3" runat="server" Text="Insertar" OnClick="Button1_Click" />
        <div class="auto-style6 mt-3">
            <asp:Panel ID="PanelInsertar" runat="server" Height="348px" Visible="False">
                <div class="auto-style7">
                    <asp:FormView ID="FormView1" runat="server" DataSourceID="SqlDataSource1" DataKeyNames="codigoCliente" DefaultMode="Insert" CellPadding="4" ForeColor="#333333">
                        <FooterStyle BackColor="#990000" ForeColor="White" Font-Bold="True" />
                        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                        <InsertItemTemplate>

                            <div class="row">
                                <div class="col">
                                    NombreEntidad:
                                    <asp:TextBox ID="NombreEntidadTextBox" class="form-control" data-toggle="tooltip" title="Nombre de la entidad" runat="server" Text='<%# Bind("NombreEntidad") %>' />
                                </div>
                                <div class="col">
                                    DireccionDF:
                                    <asp:TextBox ID="DireccionDFTextBox" class="form-control" data-toggle="tooltip" title="Dirección del domicilio fiscal" runat="server" Text='<%# Bind("DireccionDF") %>' />
                                </div>
                            </div>

                            <div class="row">
                                <div class="col">
                                    CodigoPostalDF:
                                    <asp:TextBox ID="CodigoPostalDFTextBox" class="form-control" data-toggle="tooltip" title="Codigo postal del domicilio fiscal" runat="server" Text='<%# Bind("CodigoPostalDF") %>' />
                                </div>
                                <div class="col">
                                    UbicacionDF:
                                    <asp:TextBox ID="UbicacionDFTextBox" class="form-control" data-toggle="tooltip" title="Ubicacion del domicilio fiscal" runat="server" Text='<%# Bind("UbicacionDF") %>' />
                                </div>
                            </div>

                            <div class="row">
                                <div class="col">
                                    BancoDF:
                                    <asp:TextBox ID="BancoDFTextBox" class="form-control" data-toggle="tooltip" title="Banco asignado al domicilio fiscal" runat="server" Text='<%# Bind("BancoDF") %>' />
                                </div>
                                <div class="col">
                                    DireccionDE:
                                    <asp:TextBox ID="DireccionDETextBox" class="form-control" data-toggle="tooltip" title="Direccion del domicilio empresarial" runat="server" Text='<%# Bind("DireccionDE") %>' />
                                </div>
                            </div>

                            <div class="row">
                                <div class="col">
                                    CodigoPostalDE:
                                    <asp:TextBox ID="CodigoPostalDETextBox" class="form-control" data-toggle="tooltip" title="Codigo postal del domicilio empresarial" runat="server" Text='<%# Bind("CodigoPostalDE") %>' />
                                </div>
                                <div class="col">
                                    UbicacionDE:
                                    <asp:TextBox ID="UbicacionDETextBox" class="form-control" data-toggle="tooltip" title="Ubicacion del domicilio empresarial" runat="server" Text='<%# Bind("UbicacionDE") %>' />
                                </div>
                            </div>

                            <div class="mt-3 text-center">
                                <asp:LinkButton ID="InsertButton" class="btn btn-success" runat="server" CausesValidation="True" CommandName="Insert" Text="Insertar" />
                                &nbsp;
                                <asp:LinkButton ID="InsertCancelButton" class="btn btn-danger" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancelar" />
                            </div>
                        </InsertItemTemplate>
                        <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                        <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
                    </asp:FormView>
                </div>
            </asp:Panel>
        </div>
    </div>
</asp:Content>

