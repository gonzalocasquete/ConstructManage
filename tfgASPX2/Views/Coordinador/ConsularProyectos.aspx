<%@ Page Language="C#" MasterPageFile="~/Master/Master1.Master" AutoEventWireup="true" CodeBehind="ConsularProyectos.aspx.cs" Inherits="tfgASPX2.Views.Coordinador.ConsultarProyectos" %>

<asp:Content ID="GestionarProyectosHead" ContentPlaceHolderID="head" runat="server">
    <link href="../../Styles/ConsultarProyectosStyle%20-%20Copia.css" rel="stylesheet" />
    <link href="../../Styles/ComunesStyle.css" rel="stylesheet" />
    <script src="../../Scripts/Views/GestionarProyectoStyle.js"></script>
</asp:Content>

<asp:Content ID="GestionarProyectosNavegacion" ContentPlaceHolderID="ContentPlaceHolderNavegacion" runat="server">
    <a href="InicialCoordinador.aspx">Inicio</a>
    <a href="ConsularProyectos.aspx">Proyectos</a>
    <a href="../Comun/Perfil.aspx">Perfil</a>
</asp:Content>

<asp:Content ID="GestionarProyectosBody" ContentPlaceHolderID="ContentPlaceHolderContenido" runat="server">
    <div class="auto-style1">
        <h2>Consultar proyectos</h2>
        <%--Filtros--%>
        <div style="width: 250px">
          
            <div class="row">
                <div class="col">
                    <asp:Button ID="ButtonFiltros" class="form-control btn-secondary btn-sm btn-block mt-1" runat="server" Text="Filtros" OnClick="ButtonFiltros_Click" />
                </div>
            </div>

            <div class="row">
                <div class="col">
                    <asp:Button ID="ButtonVolver" class="form-control btn-warning btn-sm btn-block mt-1" runat="server" Text="Volver" OnClick="ButtonVolverProyectos_Click" Visible="false" />
                </div>
            </div>

            <asp:Panel ID="PanelFiltros" runat="server" Visible="False">
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
                            <%--Presupuesto Minimo--%>
                            <asp:Label ID="LabelPresupuestoMinimo" class="text-light" for="presupuestoMinimo" runat="server" Text="Presupuesto mínimo:"></asp:Label>
                            <input id="presupuestoMinimo" class="form-control" runat="server" type="number" name="presupuestoMinimo">
                        </div>
                        <div class="col">
                            <%--Presupuesto Maximo--%>
                            <asp:Label ID="LabelPresupuestoMaximo" class="text-light" for="presupuestoMaximo" runat="server" Text="Presupuesto máximo:"></asp:Label>
                            <input id="presupuestoMaximo" class="form-control" runat="server" type="number" name="presupuestoMaximo">
                        </div>
                    </div>

                    <div class="text-center mt-2">
                        <asp:Button ID="ButtonFiltrado" class="form-control btn btn-primary btn-sm btn-block buttonFilter" runat="server" Text="Filtrar" OnClick="ButtonFiltrado_Click" />
                        <asp:Button runat="server" class="form-control btn-secondary btn-sm btn-block buttonFilter mt-1" Text="Limpiar" OnClick="Todos_Click"></asp:Button>
                    </div>
                </div>
            </asp:Panel>
        </div>

        <%--SqldDataSource para recoger todos los proyectos--%>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>"
            DeleteCommand="DELETE FROM [Proyecto] WHERE [codigoProyecto] = @codigoProyecto"
            InsertCommand="INSERT INTO [Proyecto] ([NombreProyecto], [Descripcion], [FechaInicio], [FechaFin], [Comentarios], [codigoCliente]) VALUES (@NombreProyecto, @Descripcion, @FechaInicio, @FechaFin, @Comentarios, @codigoCliente)"
            SelectCommand="SELECT Proyecto.*, Cliente.nombreEntidad FROM Proyecto INNER JOIN Cliente ON Proyecto.codigoCliente = Cliente.codigoCliente WHERE codigoCoordinador = @codigoCoordinador ORDER BY Proyecto.codigoProyecto DESC;"
            UpdateCommand="UPDATE [Proyecto] SET [NombreProyecto] = @NombreProyecto, [Descripcion] = @Descripcion, [FechaInicio] = @FechaInicio, [FechaFin] = @FechaFin, [Comentarios] = @Comentarios, [codigoCliente] = @codigoCliente WHERE [codigoProyecto] = @codigoProyecto">
            <DeleteParameters>
                <asp:Parameter Name="codigoProyecto" Type="Int32"></asp:Parameter>
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="NombreProyecto" Type="String"></asp:Parameter>
                <asp:Parameter Name="Descripcion" Type="String"></asp:Parameter>
                <asp:Parameter DbType="Date" Name="FechaInicio"></asp:Parameter>
                <asp:Parameter DbType="Date" Name="FechaFin"></asp:Parameter>
                <asp:Parameter Name="Comentarios" Type="String"></asp:Parameter>
                <asp:Parameter Name="codigoCliente" Type="Int32"></asp:Parameter>
            </InsertParameters>
              <SelectParameters>
                <asp:SessionParameter SessionField="codigoTrabajador" Name="codigoCoordinador" Type="Int32"></asp:SessionParameter>
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="NombreProyecto" Type="String"></asp:Parameter>
                <asp:Parameter Name="Descripcion" Type="String"></asp:Parameter>
                <asp:Parameter DbType="Date" Name="FechaInicio"></asp:Parameter>
                <asp:Parameter DbType="Date" Name="FechaFin"></asp:Parameter>
                <asp:Parameter Name="Comentarios" Type="String"></asp:Parameter>
                <asp:Parameter Name="codigoCliente" Type="Int32"></asp:Parameter>
                <asp:Parameter Name="codigoProyecto" Type="Int32"></asp:Parameter>
            </UpdateParameters>
        </asp:SqlDataSource>

        <%--Grid que muestra todos los proyectos--%>
        <asp:GridView ID="GridView1" class="table mt-3 tamanio-proyecto" runat="server" AllowPaging="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" DataKeyNames="codigoProyecto" DataSourceID="SqlDataSource1" ForeColor="Black" GridLines="Vertical" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" AllowSorting="True" AutoPostBack="true">
            <AlternatingRowStyle BackColor="#CCCCCC" />
            <Columns>
                <asp:BoundField DataField="codigoProyecto" HeaderText="ID" ReadOnly="True" InsertVisible="False"></asp:BoundField>
                <asp:TemplateField HeaderText="Proyecto" SortExpression="NombreProyecto">
                    <ItemTemplate>
                        <%# Eval("NombreProyecto") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="nombreProyectoTextBoxEditar" class="form-control edit-textbox" runat="server" Text='<%# Bind("NombreProyecto") %>'></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Descripcion">
                    <ItemTemplate>
                        <%# Eval("Descripcion") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="descripcionTextBox" class="form-control edit-textbox" runat="server" Text='<%# Bind("Descripcion") %>'></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Fecha Inicio" SortExpression="FechaInicio">
                    <ItemTemplate>
                        <div class="descripcion-column">
                            <%# Eval("FechaInicio", "{0:dd/MM/yy}") %>
                        </div>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <input type="date" id="dateFechaInicio" class="form-control edit-textbox" runat="server" value='<%# Bind("FechaInicio", "{0:yyyy-MM-dd}") %>' />
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Fecha Fin" SortExpression="fechaFin">
                    <ItemTemplate>
                        <%# Eval("FechaFin", "{0:dd/MM/yy}") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <input type="date" id="dateFechaFin" class="form-control edit-textbox" runat="server" value='<%# Bind("FechaFin", "{0:yyyy-MM-dd}") %>' />
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:BoundField DataField="Presupuesto" HeaderText="Presupuesto" ReadOnly="True" InsertVisible="False"></asp:BoundField>
               
                <asp:TemplateField HeaderText="Comentario">
                    <ItemTemplate>
                        <%# Eval("Comentarios") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="comentariosTextBox" class="form-control edit-textbox" runat="server" Text='<%# Bind("Comentarios") %>'></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Cliente">
                    <ItemTemplate>
                        <%# Eval("nombreEntidad") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:DropDownList Text='<%# Bind("codigoCliente") %>' class="dropdown form-control edit-dropdown" ID="idClienteDropDownList" runat="server" DataSourceID="ClientesSqlDataSource" DataTextField="nombreEntidad" DataValueField="codigoCliente"></asp:DropDownList>
                        <asp:SqlDataSource ID="ClientesSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>" SelectCommand="SELECT codigoCliente, nombreEntidad FROM Cliente order by nombreEntidad"></asp:SqlDataSource>            
                    </EditItemTemplate>

                </asp:TemplateField>
                <asp:CommandField SelectText="Partidas" ShowSelectButton="True"></asp:CommandField>
            </Columns>
            <FooterStyle BackColor="#CCCCCC" />
            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#F1F1F1" />
            <SortedAscendingHeaderStyle BackColor="Gray" />
            <SortedDescendingCellStyle BackColor="#CAC9C9" />
            <SortedDescendingHeaderStyle BackColor="#383838" />
        </asp:GridView>

        <%--Mostrado de los partes asociados al proyecto seleccionado--%>
        <div class="mt-3">
            <asp:Panel ID="PanelPartidas" runat="server" Visible="False">
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>"
                    DeleteCommand="DELETE FROM [Partida] WHERE [codigoPartida] = @codigoPartida"
                    InsertCommand="INSERT INTO [Partida] ([nombrePartida], [FechaInicio], [FechaFin], [Presupuesto], [codigoProyecto]) VALUES (@nombrePartida, @FechaInicio, @FechaFin, @Presupuesto, @codigoProyecto)"
                    SelectCommand="SELECT * FROM [Partida] WHERE ([codigoProyecto] = @codigoProyecto)"
                    UpdateCommand="UPDATE [Partida] SET [nombrePartida] = @nombrePartida, [FechaInicio] = @FechaInicio, [FechaFin] = @FechaFin, [Presupuesto] = @Presupuesto, [codigoProyecto] = @codigoProyecto WHERE [codigoPartida] = @codigoPartida">
                    <DeleteParameters>
                        <asp:Parameter Name="codigoPartida" Type="Int32" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="nombrePartida" Type="String" />
                        <asp:Parameter DbType="Date" Name="FechaInicio" />
                        <asp:Parameter DbType="Date" Name="FechaFin" />
                        <asp:Parameter Name="Presupuesto" Type="Decimal" />
                        <asp:Parameter Name="codigoProyecto" Type="Int32" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="GridView1" Name="codigoProyecto" PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="nombrePartida" Type="String" />
                        <asp:Parameter DbType="Date" Name="FechaInicio" />
                        <asp:Parameter DbType="Date" Name="FechaFin" />
                        <asp:Parameter Name="Presupuesto" Type="Decimal" />
                        <asp:Parameter Name="codigoProyecto" Type="Int32" />
                        <asp:Parameter Name="codigoPartida" Type="Int32" />
                    </UpdateParameters>
                </asp:SqlDataSource>


                <asp:GridView ID="GridView2" class="table tamanio-partida" runat="server" AllowPaging="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" DataKeyNames="codigoPartida" DataSourceID="SqlDataSource2" ForeColor="Black" GridLines="Vertical" AllowSorting="True">
                    <AlternatingRowStyle BackColor="#CCCCCC" />
                    <Columns>
                        <asp:BoundField DataField="codigoPartida" HeaderText="ID " InsertVisible="False" ReadOnly="True" />

                        <asp:TemplateField HeaderText="Nombre">
                            <ItemTemplate>
                                <asp:Label ID="LabelNombrePartida" runat="server" Text='<%# Bind("nombrePartida") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBoxNombrePartida" class="form-control edit-textbox" runat="server" Text='<%# Bind("nombrePartida") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Fecha Inicio" SortExpression="FechaInicio">
                            <ItemTemplate>
                             <%# Eval("FechaInicio", "{0:dd/MM/yy}") %>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <input type="date" class="form-control edit-textbox" id="dateFechaInicio" runat="server" value='<%# Bind("FechaInicio", "{0:yyyy-MM-dd}") %>' />
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Fecha Fin" SortExpression="FechaFin">
                            <ItemTemplate>
                                <%# Eval("FechaFin", "{0:dd/MM/yy}") %>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <input type="date" class="form-control edit-textbox" id="dateFechaFin" runat="server" value='<%# Bind("FechaFin", "{0:yyyy-MM-dd}") %>' />
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Presupuesto" SortExpression="Presupuesto">
                            <ItemTemplate>
                                <asp:Label ID="LabelPresupuesto" runat="server" Text='<%# Bind("Presupuesto") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBoxPresupuesto" class="form-control edit-textbox" runat="server" Text='<%# Bind("Presupuesto") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Proyecto">
                            <ItemTemplate>
                                <%# Eval("codigoProyecto") %>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList Text='<%# Bind("codigoProyecto") %>' class="dropdown form-control edit-dropdown" ID="idProyectoDropDownList" runat="server" DataSourceID="idProyecto2SqlDataSource" DataTextField="NombreProyecto" DataValueField="codigoProyecto"></asp:DropDownList>
                                <asp:SqlDataSource ID="idProyecto2SqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>" SelectCommand="SELECT codigoProyecto,NombreProyecto FROM Proyecto order by NombreProyecto"></asp:SqlDataSource>
                            </EditItemTemplate>
                        </asp:TemplateField>

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
            </asp:Panel>
            </div>
        </div>
</asp:Content>
