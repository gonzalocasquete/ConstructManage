<%@ Page Language="C#" MasterPageFile="~/Master/Master1.Master" AutoEventWireup="true" CodeBehind="GestionarCategoriasProfesionales.aspx.cs" Inherits="tfgASPX2.Views.Super.GestionarCategoriasProfesionales" %>

<asp:Content ID="GestionarCategoriasProfesionalesHead" ContentPlaceHolderID="head" runat="server">
    <link href="../../Styles/GestionarCategoriaStyle.css" rel="stylesheet" />
    <link href="../../Styles/ComunesStyle.css" rel="stylesheet" />
    <style type="text/css">
        .auto-style5 {
            height: 728px;
        }
    </style>
</asp:Content>

<asp:Content ID="GestionarCategoriasProfesionalesNavegacion" ContentPlaceHolderID="ContentPlaceHolderNavegacion" runat="server">
    <a href="MenuSuper.aspx">Menú</a>
</asp:Content>

<asp:Content ID="GestionarCategoriasProfesionalesBody" ContentPlaceHolderID="ContentPlaceHolderContenido" runat="server">
    <div class="auto-style1">
        <h2 class="font-weight-bold">Gestión Categorias Profesionales</h2>

        <div style="width: 250px">
            <div class="row">
                <div class="col">
                    <asp:Button ID="ButtonInsertarCategoria" class="form-control btn-secondary btn-sm btn-block buttonFilter mt-1" runat="server" Text="Insertar Categoria" OnClick="ButtonInsertarCategoria_Click" />
                </div>
            </div>

            <div class="row">
                <div class="col">
                    <asp:Button ID="ButtonFiltros" class="form-control btn-secondary btn-sm btn-block buttonFilter mt-1" runat="server" Text="Filtros" OnClick="ButtonFiltros_Click" />
                </div>
            </div>

            <div class="row">
                <div class="col">
                    <asp:Button ID="ButtonInsertarAsociacion" class="form-control btn-info btn-sm btn-block mt-1" runat="server" Text="Insertar Partida" OnClick="ButtonInsertarAsociacion_Click" Visible="false" />
                </div>
            </div>

            <div class="row">
                <div class="col">
                    <asp:Button ID="ButtonVolver" class="form-control btn-warning btn-sm btn-block mt-1" runat="server" Text="Volver" OnClick="ButtonVolver_Click" Visible="false" />
                </div>
            </div>

            <asp:Panel ID="PanelFiltros" runat="server" Visible="False">
                <%--Filtros--%>
                <hr style="height: 2px; width: auto; border-width: 0; color: whitesmoke; background-color: whitesmoke">
                <div>
                    <asp:Label ID="LabelFiltroNombreCategoria" class="text-light" runat="server" Text="Nombre:"></asp:Label>
                    <asp:TextBox ID="TextBoxFiltrado" class="form-control" runat="server"></asp:TextBox>

                    <div class="text-center mt-2">
                        <asp:Button ID="ButtonFiltrado" class="form-control btn btn-primary btn-sm btn-block buttonFilter" runat="server" Text="Filtrar" OnClick="ButtonFiltrado_Click" />
                        <asp:Button runat="server" class="form-control btn-secondary btn-sm btn-block buttonFilter mt-1" Text="Limpiar" OnClick="Todos_Click"></asp:Button>
                    </div>
                </div>
            </asp:Panel>
        </div>

        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>"
            DeleteCommand="DELETE FROM [CategoriaProfesional] WHERE [codigoCategoria] = @original_codigoCategoria"
            InsertCommand="INSERT INTO [CategoriaProfesional] ([nombreCategoria]) VALUES (@nombreCategoria)" OldValuesParameterFormatString="original_{0}"
            SelectCommand="SELECT * FROM [CategoriaProfesional]"
            UpdateCommand="UPDATE [CategoriaProfesional] SET [nombreCategoria] = @nombreCategoria WHERE [codigoCategoria] = @original_codigoCategoria AND (([nombreCategoria] = @original_nombreCategoria) OR ([nombreCategoria] IS NULL AND @original_nombreCategoria IS NULL))">
            <DeleteParameters>
                <asp:Parameter Name="original_codigoCategoria" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="nombreCategoria" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="nombreCategoria" Type="String" />
                <asp:Parameter Name="original_codigoCategoria" Type="Int32" />
                <asp:Parameter Name="original_nombreCategoria" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>

        <asp:GridView ID="GridView1" class="table mt-3 tamanio-categoria" runat="server" AllowPaging="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" DataKeyNames="codigoCategoria" DataSourceID="SqlDataSource1" ForeColor="Black" GridLines="Vertical" AllowSorting="True" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
            <AlternatingRowStyle BackColor="#CCCCCC" />
            <Columns>
                <asp:BoundField DataField="codigoCategoria" HeaderText="ID" InsertVisible="False" ReadOnly="True" />
                <asp:TemplateField HeaderText="Nombre" SortExpression="nombreCategoria">
                    <ItemTemplate>
                        <%# Eval("nombreCategoria") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox Text='<%# Bind("nombreCategoria") %>' class="form-control edit-textbox" runat="server" ID="nombreCategoriaTextBox" />
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" ShowSelectButton="True" SelectText="Asociaciones"></asp:CommandField>
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

        <asp:Panel ID="PanelInsertarCategoria" class="mt-3" runat="server" Height="196px" Visible="False">
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>" DeleteCommand="DELETE FROM [CategoriaProfesional] WHERE [codigoCategoria] = @original_codigoCategoria AND (([nombreCategoria] = @original_nombreCategoria) OR ([nombreCategoria] IS NULL AND @original_nombreCategoria IS NULL))" InsertCommand="INSERT INTO [CategoriaProfesional] ([nombreCategoria]) VALUES (@nombreCategoria)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT [codigoCategoria], [nombreCategoria] FROM [CategoriaProfesional]" UpdateCommand="UPDATE [CategoriaProfesional] SET [nombreCategoria] = @nombreCategoria WHERE [codigoCategoria] = @original_codigoCategoria AND (([nombreCategoria] = @original_nombreCategoria) OR ([nombreCategoria] IS NULL AND @original_nombreCategoria IS NULL))">
                <DeleteParameters>
                    <asp:Parameter Name="original_codigoCategoria" Type="Int32" />
                    <asp:Parameter Name="original_nombreCategoria" Type="String" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="nombreCategoria" Type="String" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="nombreCategoria" Type="String" />
                    <asp:Parameter Name="original_codigoCategoria" Type="Int32" />
                    <asp:Parameter Name="original_nombreCategoria" Type="String" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:FormView ID="FormViewInsertarCategoria" class="form-control" runat="server" DataSourceID="SqlDataSource2" CellPadding="4" DataKeyNames="codigoCategoria" DefaultMode="Insert" ForeColor="#333333" OnItemInserting="FormViewInsertarCategoria_ItemInserting" OnItemInserted="FormViewInsertarCategoria_ItemInserted" OnItemCommand="FormViewInsertarCategoria_ItemCommand">
                <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <InsertItemTemplate>
                    <div class="row">
                        <div class="col">
                            Categoria:
                            <asp:TextBox ID="nombreCategoriaTextBoxInsertar" class="form-control" data-toggle="tooltip" title="Nombre de la categoria profesional" runat="server" Text='<%# Bind("nombreCategoria") %>' />
                        </div>
                    </div>

                    <div class="mt-3 text-center">
                        <asp:LinkButton ID="InsertButton" class="btn btn-success" runat="server" CausesValidation="True" CommandName="Insert" Text="Insertar" />
                        &nbsp;
                        <asp:LinkButton ID="InsertCancelButton" class="btn btn-danger" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancelar" />
                    </div>

                </InsertItemTemplate>
                <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                <RowStyle BackColor="#6c757d" ForeColor="White" />
            </asp:FormView>
        </asp:Panel>

        <asp:Panel ID="PanelMostrarAsociaciones" class="mt-3" runat="server" Visible="False">
            <asp:GridView ID="GridView2" class="table mt-3" runat="server" DataSourceID="SqlDataSource3" AutoGenerateColumns="False" DataKeyNames="codigoAsociacionCoste" AllowPaging="True" AllowSorting="True" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical">
                <AlternatingRowStyle BackColor="#CCCCCC" />
                <Columns>
                    <asp:BoundField DataField="codigoAsociacionCoste" HeaderText="ID" ReadOnly="True" InsertVisible="False" SortExpression="codigoAsociacionCoste"></asp:BoundField>
                    <asp:BoundField DataField="codigoConvenio" HeaderText="Convenio" SortExpression="codigoConvenio"></asp:BoundField>
                    <asp:BoundField DataField="codigoCategoria" HeaderText="Categoria" SortExpression="codigoCategoria"></asp:BoundField>
                    <asp:BoundField DataField="precioHora" HeaderText="PrecioHora" SortExpression="precioHora"></asp:BoundField>
                    <asp:BoundField DataField="precioHoraExtra" HeaderText="PrecioHoraExtra" SortExpression="precioHoraExtra"></asp:BoundField>
                    <asp:BoundField DataField="horasMaxDia" HeaderText="HorasMaxDia" SortExpression="horasMaxDia"></asp:BoundField>
                    <asp:CommandField ShowDeleteButton="True" ShowEditButton="True"></asp:CommandField>
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

            <asp:SqlDataSource runat="server" ID="SqlDataSource3" ConnectionString='<%$ ConnectionStrings:mibasededatostfgConnectionString %>'
                DeleteCommand="DELETE FROM [AsociacionCostes] WHERE [codigoAsociacionCoste] = @codigoAsociacionCoste"
                InsertCommand="INSERT INTO [AsociacionCostes] ([codigoConvenio], [codigoCategoria], [precioHora], [precioHoraExtra], [horasMaxDia]) VALUES (@codigoConvenio, @codigoCategoria, @precioHora, @precioHoraExtra, @horasMaxDia)"
                SelectCommand="SELECT * FROM [AsociacionCostes] WHERE ([codigoCategoria] = @codigoCategoria)"
                UpdateCommand="UPDATE [AsociacionCostes] SET [codigoConvenio] = @codigoConvenio, [codigoCategoria] = @codigoCategoria, [precioHora] = @precioHora, [precioHoraExtra] = @precioHoraExtra, [horasMaxDia] = @horasMaxDia WHERE [codigoAsociacionCoste] = @codigoAsociacionCoste">
                <DeleteParameters>
                    <asp:Parameter Name="codigoAsociacionCoste" Type="Int32"></asp:Parameter>
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="codigoConvenio" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="codigoCategoria" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="precioHora" Type="Decimal"></asp:Parameter>
                    <asp:Parameter Name="precioHoraExtra" Type="Decimal"></asp:Parameter>
                    <asp:Parameter Name="horasMaxDia" Type="Int32"></asp:Parameter>
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="GridView1" PropertyName="SelectedValue" Name="codigoCategoria" Type="Int32"></asp:ControlParameter>
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="codigoConvenio" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="codigoCategoria" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="precioHora" Type="Decimal"></asp:Parameter>
                    <asp:Parameter Name="precioHoraExtra" Type="Decimal"></asp:Parameter>
                    <asp:Parameter Name="horasMaxDia" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="codigoAsociacionCoste" Type="Int32"></asp:Parameter>
                </UpdateParameters>
            </asp:SqlDataSource>
        </asp:Panel>

        <asp:Panel ID="PanelInsertarAsociacion" class="mt-3" runat="server" Visible="False">

            <asp:SqlDataSource runat="server" ID="SqlDataSource4" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>" DeleteCommand="DELETE FROM [AsociacionCostes] WHERE [codigoAsociacionCoste] = @codigoAsociacionCoste" InsertCommand="INSERT INTO [AsociacionCostes] ([codigoConvenio], [codigoCategoria], [precioHora], [precioHoraExtra], [horasMaxDia]) VALUES (@codigoConvenio, @codigoCategoria, @precioHora, @precioHoraExtra, @horasMaxDia)" SelectCommand="SELECT * FROM [AsociacionCostes]" UpdateCommand="UPDATE [AsociacionCostes] SET [codigoConvenio] = @codigoConvenio, [codigoCategoria] = @codigoCategoria, [precioHora] = @precioHora, [precioHoraExtra] = @precioHoraExtra, [horasMaxDia] = @horasMaxDia WHERE [codigoAsociacionCoste] = @codigoAsociacionCoste">
                <DeleteParameters>
                    <asp:Parameter Name="codigoAsociacionCoste" Type="Int32"></asp:Parameter>
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="codigoConvenio" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="codigoCategoria" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="precioHora" Type="Decimal"></asp:Parameter>
                    <asp:Parameter Name="precioHoraExtra" Type="Decimal"></asp:Parameter>
                    <asp:Parameter Name="horasMaxDia" Type="Int32"></asp:Parameter>
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="codigoConvenio" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="codigoCategoria" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="precioHora" Type="Decimal"></asp:Parameter>
                    <asp:Parameter Name="precioHoraExtra" Type="Decimal"></asp:Parameter>
                    <asp:Parameter Name="horasMaxDia" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="codigoAsociacionCoste" Type="Int32"></asp:Parameter>
                </UpdateParameters>
            </asp:SqlDataSource>

            <asp:FormView ID="FormViewInsertarAsociacion" runat="server" DataSourceID="SqlDataSource3" DefaultMode="Insert" DataKeyNames="codigoAsociacionCoste">
                <InsertItemTemplate>
                    codigoConvenio:
                    <asp:TextBox Text='<%# Bind("codigoConvenio") %>' runat="server" ID="codigoConvenioTextBox" /><br />
                    codigoCategoria:
                    <asp:TextBox Text='<%# Bind("codigoCategoria") %>' runat="server" ID="codigoCategoriaTextBox" /><br />
                    precioHora:
                    <asp:TextBox Text='<%# Bind("precioHora") %>' runat="server" ID="precioHoraTextBox" /><br />
                    precioHoraExtra:
                    <asp:TextBox Text='<%# Bind("precioHoraExtra") %>' runat="server" ID="precioHoraExtraTextBox" /><br />
                    horasMaxDia:
                    <asp:TextBox Text='<%# Bind("horasMaxDia") %>' runat="server" ID="horasMaxDiaTextBox" /><br />
                    <asp:LinkButton runat="server" Text="Insertar" CommandName="Insert" ID="InsertButton" CausesValidation="True" />&nbsp;<asp:LinkButton runat="server" Text="Cancelar" CommandName="Cancel" ID="InsertCancelButton" CausesValidation="False" />
                </InsertItemTemplate>

            </asp:FormView>

        </asp:Panel>

    </div>
</asp:Content>
