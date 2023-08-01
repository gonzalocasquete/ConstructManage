<%@ Page Language="C#" MasterPageFile="~/Master/Master1.Master" AutoEventWireup="true" CodeBehind="GestionarCategoriasProfesionales.aspx.cs" Inherits="tfgASPX2.Views.Super.GestionarCategoriasProfesionales" %>

<asp:Content ID="GestionarCategoriasProfesionalesHead" ContentPlaceHolderID="head" runat="server">
    <link href="../../Styles/GestionarCategoriaStyle.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css"
        rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x"
        crossorigin="anonymous" />
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

        <%--Filtros--%>
        <hr />
        <div>    
                <asp:Label ID="LabelFiltroNombreCategoria" runat="server" Text="Nombre:"></asp:Label>
                <asp:TextBox ID="TextBoxFiltrado" class="form-control" runat="server"></asp:TextBox>

            <div class="text-center mt-2">
                <asp:Button ID="ButtonFiltrado" class="form-control btn btn-primary btn-sm btn-block buttonFilter" runat="server" Text="Filtrar" OnClick="ButtonFiltrado_Click" />
                <asp:Button runat="server" class="form-control btn-secondary btn-sm btn-block buttonFilter mt-1" Text="Limpiar" OnClick="Todos_Click"></asp:Button>
            </div>
        </div>

        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>" DeleteCommand="DELETE FROM [CategoriaProfesional] WHERE [idCategoria] = @original_idCategoria AND (([nombreCategoria] = @original_nombreCategoria) OR ([nombreCategoria] IS NULL AND @original_nombreCategoria IS NULL))" InsertCommand="INSERT INTO [CategoriaProfesional] ([nombreCategoria]) VALUES (@nombreCategoria)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [CategoriaProfesional]" UpdateCommand="UPDATE [CategoriaProfesional] SET [nombreCategoria] = @nombreCategoria WHERE [idCategoria] = @original_idCategoria AND (([nombreCategoria] = @original_nombreCategoria) OR ([nombreCategoria] IS NULL AND @original_nombreCategoria IS NULL))">
            <DeleteParameters>
                <asp:Parameter Name="original_idCategoria" Type="Int32" />
                <asp:Parameter Name="original_nombreCategoria" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="nombreCategoria" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="nombreCategoria" Type="String" />
                <asp:Parameter Name="original_idCategoria" Type="Int32" />
                <asp:Parameter Name="original_nombreCategoria" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>

        <asp:GridView ID="GridView1" class="table mt-3" runat="server" AllowPaging="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" DataKeyNames="idCategoria" DataSourceID="SqlDataSource1" ForeColor="Black" GridLines="Vertical">
            <AlternatingRowStyle BackColor="#CCCCCC" />
            <Columns>
                <asp:BoundField DataField="idCategoria" HeaderText="ID" InsertVisible="False" ReadOnly="True" />
                <asp:BoundField DataField="nombreCategoria" HeaderText="Nombre" />
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
        <asp:Button ID="ButtonInsertar" CssClass="ButtonStyle button1 mt-3" runat="server" Text="Insertar" OnClick="Button1_Click" />

        <asp:Panel ID="Panel1" class="mt-3" runat="server" Height="196px" Visible="False">
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>" DeleteCommand="DELETE FROM [CategoriaProfesional] WHERE [idCategoria] = @original_idCategoria AND (([nombreCategoria] = @original_nombreCategoria) OR ([nombreCategoria] IS NULL AND @original_nombreCategoria IS NULL))" InsertCommand="INSERT INTO [CategoriaProfesional] ([nombreCategoria]) VALUES (@nombreCategoria)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT [idCategoria], [nombreCategoria] FROM [CategoriaProfesional]" UpdateCommand="UPDATE [CategoriaProfesional] SET [nombreCategoria] = @nombreCategoria WHERE [idCategoria] = @original_idCategoria AND (([nombreCategoria] = @original_nombreCategoria) OR ([nombreCategoria] IS NULL AND @original_nombreCategoria IS NULL))">
                <DeleteParameters>
                    <asp:Parameter Name="original_idCategoria" Type="Int32" />
                    <asp:Parameter Name="original_nombreCategoria" Type="String" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="nombreCategoria" Type="String" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="nombreCategoria" Type="String" />
                    <asp:Parameter Name="original_idCategoria" Type="Int32" />
                    <asp:Parameter Name="original_nombreCategoria" Type="String" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:FormView ID="FormView1" class="form-control" runat="server" DataSourceID="SqlDataSource2" CellPadding="4" DataKeyNames="idCategoria" DefaultMode="Insert" ForeColor="#333333">
                <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <InsertItemTemplate>
                    <div class="row">
                        <div class="col">
                            Categoria:
                            <asp:TextBox ID="nombreCategoriaTextBox" class="form-control" data-toggle="tooltip" title="Nombre de la categoria profesional" runat="server" Text='<%# Bind("nombreCategoria") %>' />
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
        </asp:Panel>
    </div>
</asp:Content>
