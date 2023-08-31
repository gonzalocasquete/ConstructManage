<%@ Page Language="C#" MasterPageFile="~/Master/Master1.Master" AutoEventWireup="true" CodeBehind="GestionarProyectos.aspx.cs" Inherits="tfgASPX2.Views.Super.GestionarProyectos" %>

<asp:Content ID="GestionarProyectosHead" ContentPlaceHolderID="head" runat="server">
    <link href="../../Styles/GestionarProyectoStyle.css" rel="stylesheet" />
    <link href="../../Styles/ComunesStyle.css" rel="stylesheet" />
    <script src="../../Scripts/Views/GestionarProyectoStyle.js"></script>
</asp:Content>

<asp:Content ID="GestionarProyectosNavegacion" ContentPlaceHolderID="ContentPlaceHolderNavegacion" runat="server">
    <a href="MenuSuper.aspx">Menú</a>
</asp:Content>

<asp:Content ID="GestionarProyectosBody" ContentPlaceHolderID="ContentPlaceHolderContenido" runat="server">
    <div class="auto-style1">
        <h2>Gestión de Proyectos</h2>
        <%--Filtros--%>
        <div style="width: 250px">
            <div class="row">
                <div class="col">
                    <asp:Button ID="ButtonInsertarProyecto" class="form-control btn-secondary btn-sm btn-block mt-1" runat="server" Text="Insertar Proyecto" OnClick="ButtonInsertarProyecto_Click" />
                </div>
            </div>

            <div class="row">
                <div class="col">
                    <asp:Button ID="ButtonFiltros" class="form-control btn-secondary btn-sm btn-block mt-1" runat="server" Text="Filtros" OnClick="ButtonFiltros_Click" />
                </div>
            </div>

            <div class="row">
                <div class="col">
                    <asp:Button ID="ButtonInsertarPartida" class="form-control btn-info btn-sm btn-block mt-1" runat="server" Text="Insertar Partida" OnClick="ButtonInsertarPartida_Click" Visible="false" />
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
            SelectCommand="SELECT Proyecto.*, Cliente.nombreEntidad FROM Proyecto INNER JOIN Cliente ON Proyecto.codigoCliente = Cliente.codigoCliente ORDER BY Proyecto.codigoProyecto DESC;"
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

                <asp:BoundField DataField="Presupuesto" HeaderText="Presupuesto" ReadOnly="True" InsertVisible="False" SortExpression="NombreProyecto"></asp:BoundField>
               
                <asp:TemplateField HeaderText="Comentario">
                    <ItemTemplate>
                        <%# Eval("Comentarios") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="comentariosTextBox" class="form-control edit-textbox" runat="server" Text='<%# Bind("Comentarios") %>'></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Cliente" SortExpression="nombreEntidad">
                    <ItemTemplate>
                        <%# Eval("nombreEntidad") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:DropDownList Text='<%# Bind("codigoCliente") %>' class="dropdown form-control edit-dropdown" ID="idClienteDropDownList" runat="server" DataSourceID="ClientesSqlDataSource" DataTextField="nombreEntidad" DataValueField="codigoCliente"></asp:DropDownList>
                        <asp:SqlDataSource ID="ClientesSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>" SelectCommand="SELECT codigoCliente, nombreEntidad FROM Cliente order by nombreEntidad"></asp:SqlDataSource>            
                    </EditItemTemplate>

                </asp:TemplateField>
                <asp:CommandField SelectText="Partidas" ShowDeleteButton="True" ShowEditButton="True" ShowSelectButton="True"></asp:CommandField>
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
            </asp:Panel>

            <%--Panel para la inserción de una partida al proyecto seleccionado--%>
            <div>
                <asp:Panel ID="PanelInsertarPartida" runat="server" Visible="False">
                    <asp:SqlDataSource runat="server" ID="SqlDataSource4" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>" DeleteCommand="DELETE FROM [Partida] WHERE [codigoPartida] = @codigoPartida" InsertCommand="INSERT INTO [Partida] ([nombrePartida], [FechaInicio], [FechaFin], [Presupuesto], [codigoProyecto]) VALUES (@nombrePartida, @FechaInicio, @FechaFin, @Presupuesto, @codigoProyecto)" SelectCommand="SELECT * FROM [Partida] WHERE ([codigoProyecto] = @codigoProyecto)" UpdateCommand="UPDATE [Partida] SET [nombrePartida] = @nombrePartida, [FechaInicio] = @FechaInicio, [FechaFin] = @FechaFin, [Presupuesto] = @Presupuesto, [codigoProyecto] = @codigoProyecto WHERE [codigoPartida] = @codigoPartida">
                        <DeleteParameters>
                            <asp:Parameter Name="codigoPartida" Type="Int32"></asp:Parameter>
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="nombrePartida" Type="String"></asp:Parameter>
                            <asp:Parameter DbType="Date" Name="FechaInicio"></asp:Parameter>
                            <asp:Parameter DbType="Date" Name="FechaFin"></asp:Parameter>
                            <asp:Parameter Name="Presupuesto" Type="Decimal"></asp:Parameter>
                            <asp:Parameter Name="codigoProyecto" Type="Int32"></asp:Parameter>
                        </InsertParameters>
                        <SelectParameters>
                            <asp:ControlParameter ControlID="GridView1" PropertyName="SelectedValue" Name="codigoProyecto" Type="Int32"></asp:ControlParameter>
                        </SelectParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="nombrePartida" Type="String"></asp:Parameter>
                            <asp:Parameter DbType="Date" Name="FechaInicio"></asp:Parameter>
                            <asp:Parameter DbType="Date" Name="FechaFin"></asp:Parameter>
                            <asp:Parameter Name="Presupuesto" Type="Decimal"></asp:Parameter>
                            <asp:Parameter Name="codigoProyecto" Type="Int32"></asp:Parameter>
                            <asp:Parameter Name="codigoPartida" Type="Int32"></asp:Parameter>
                        </UpdateParameters>
                    </asp:SqlDataSource>

                    <asp:FormView ID="FormViewInsertarPartida" class="form-control" runat="server" DataSourceID="SqlDataSource4" DataKeyNames="codigoPartida" DefaultMode="Insert" OnItemCommand="FormViewInsertarPartida_ItemCommand" OnItemInserting="FormViewInsertarPartida_ItemInserting">
                        <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                        <InsertItemTemplate>
                            <div class="row">
                                <div class="col text-center">
                                      <h3>Insertar Partida</h3>
                                </div>
                            </div>            
                            <asp:TextBox Text='<%# Bind("codigoProyecto") %>' class="form-control" runat="server" ID="codigoProyectoTextBox" Visible="false" /><br />
                            <div class="row">
                                <div class="col">
                                    Partida:
                                    <asp:TextBox Text='<%# Bind("nombrePartida") %>' class="form-control" runat="server" ID="nombrePartidaTextBox" /><br />
                                </div>
                                <div class="col">
                                    Presupuesto:
                                    <asp:TextBox Text='<%# Bind("Presupuesto") %>' class="form-control" runat="server" ID="PresupuestoTextBox" /><br />
                                </div>
                            </div>

                            <div class="row">
                                <div class="col">
                                    Fecha Inicio:
                         <asp:TextBox Text='<%# Bind("FechaInicio") %>' class="form-control" runat="server" ID="FechaInicioTextBox" /><br />
                                </div>
                                <div class="col">
                                    Fecha Fin:
                         <asp:TextBox Text='<%# Bind("FechaFin") %>' class="form-control" runat="server" ID="FechaFinTextBox" /><br />
                                </div>
                            </div>
            
                            <div class="mt-3 text-center">
                                <asp:LinkButton runat="server" class="btn btn-success" Text="Insertar" CommandName="Insert" ID="InsertButton" CausesValidation="True" />
                                &nbsp;
                                <asp:LinkButton runat="server" class="btn btn-danger" Text="Cancelar" CommandName="Cancel" ID="InsertCancelButton" CausesValidation="False" />
                            </div>
                        </InsertItemTemplate>

                        <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                        <RowStyle BackColor="#6c757d" ForeColor="White" />
                    </asp:FormView>
                </asp:Panel>
            </div>
            <%--Panel para la insercion de un proyecto--%>
            <div>
                <asp:Panel ID="PanelInsertarProyecto" runat="server" Height="267px" Visible="False">
                    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>"
                        DeleteCommand="DELETE FROM [Proyecto] WHERE [codigoProyecto] = @original_codigoProyecto AND [NombreProyecto] = @original_NombreProyecto AND (([Descripcion] = @original_Descripcion) OR ([Descripcion] IS NULL AND @original_Descripcion IS NULL)) AND (([FechaInicio] = @original_FechaInicio) OR ([FechaInicio] IS NULL AND @original_FechaInicio IS NULL)) AND (([FechaFin] = @original_FechaFin) OR ([FechaFin] IS NULL AND @original_FechaFin IS NULL)) AND (([Presupuesto] = @original_Presupuesto) OR ([Presupuesto] IS NULL AND @original_Presupuesto IS NULL)) AND (([Comentarios] = @original_Comentarios) OR ([Comentarios] IS NULL AND @original_Comentarios IS NULL))"
                        InsertCommand="INSERT INTO [Proyecto] ([NombreProyecto], [Descripcion], [FechaInicio], [FechaFin], [Presupuesto], [Comentarios], [codigoCliente]) VALUES (@NombreProyecto, @Descripcion, @FechaInicio, @FechaFin, @Presupuesto, @Comentarios, @codigoCliente)"
                        OldValuesParameterFormatString="original_{0}"
                        SelectCommand="SELECT * FROM [Proyecto]"
                        UpdateCommand="UPDATE [Proyecto] SET [NombreProyecto] = @NombreProyecto, [Descripcion] = @Descripcion, [FechaInicio] = @FechaInicio, [FechaFin] = @FechaFin, [Presupuesto] = @Presupuesto, [Comentarios] = @Comentarios WHERE [codigoProyecto] = @original_codigoProyecto AND [NombreProyecto] = @original_NombreProyecto AND (([Descripcion] = @original_Descripcion) OR ([Descripcion] IS NULL AND @original_Descripcion IS NULL)) AND (([FechaInicio] = @original_FechaInicio) OR ([FechaInicio] IS NULL AND @original_FechaInicio IS NULL)) AND (([FechaFin] = @original_FechaFin) OR ([FechaFin] IS NULL AND @original_FechaFin IS NULL)) AND (([Presupuesto] = @original_Presupuesto) OR ([Presupuesto] IS NULL AND @original_Presupuesto IS NULL)) AND (([Comentarios] = @original_Comentarios) OR ([Comentarios] IS NULL AND @original_Comentarios IS NULL))">
                        <InsertParameters>
                            <asp:Parameter Name="NombreProyecto" Type="String" />
                            <asp:Parameter Name="Descripcion" Type="String" />
                            <asp:Parameter DbType="Date" Name="FechaInicio" />
                            <asp:Parameter DbType="Date" Name="FechaFin" />
                            <asp:Parameter Name="Presupuesto" Type="Decimal" />
                            <asp:Parameter Name="Comentarios" Type="String" />
                            <asp:Parameter Name="codigoCliente" Type="String" />
                        </InsertParameters>
                    </asp:SqlDataSource>

                    <asp:FormView ID="FormViewInsertarProyecto" class="form-control" runat="server" DataKeyNames="codigoProyecto" DataSourceID="SqlDataSource3" DefaultMode="Insert" CellPadding="4" ForeColor="#333333" OnItemInserting="FormViewInsertarProyecto_ItemInserting">
                        <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                        <InsertItemTemplate>
                             <div class="row">
                                <div class="col text-center">
                                      <h3>Insertar Proyecto</h3>
                                </div>
                            </div>

                            <div class="row mt-3">
                                <div class="col">
                                    Nombre Proyecto:
                                    <asp:TextBox ID="NombreProyectoTextBoxInsertar" class="form-control" data-toggle="tooltip" title="Nombre del proyecto" runat="server" Text='<%# Bind("NombreProyecto") %>' />
                                </div>
                                <div class="col">
                                    Descripcion:
                                    <asp:TextBox ID="DescripcionTextBoxInsertar" class="form-control" data-toggle="tooltip" title="Descripcion del proyecto" runat="server" Text='<%# Bind("Descripcion") %>' />
                                </div>
                            </div>

                            <div class="row">
                                <div class="col">
                                    FechaInicio:
                                    <input type="date" id="FechaInicioTextBoxInsertar" class="form-control" data-toggle="tooltip" title="Fecha de alta del proyecto" runat="server" value='<%# Bind("FechaInicio", "{0:yyyy-MM-dd}") %>' />
                                </div>
                                <div class="col">
                                    FechaFin:
                                    <input type="date" id="FechaFinTextBoxInsertar" class="form-control" data-toggle="tooltip" title="Fecha de finalización del proyecto" runat="server" value='<%# Bind("FechaFin", "{0:yyyy-MM-dd}") %>' />
                                </div>
                            </div>

                            <div class="row">
                                <div class="col">
                                    Comentarios:
                                    <asp:TextBox ID="ComentariosTextBoxInsertar" class="form-control" data-toggle="tooltip" title="Comentarios del proyecto" runat="server" Text='<%# Bind("Comentarios") %>' />
                                </div>
                                <div class="col">
                                    Cliente:
                                    <asp:DropDownList Text='<%# Bind("codigoCliente") %>' class="dropdown form-control" ID="idClientesDropDownList" runat="server" DataSourceID="ClientesSqlDataSourceInsertar" DataTextField="nombreEntidad" DataValueField="codigoCliente" AppendDataBoundItems="true">
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="ClientesSqlDataSourceInsertar" runat="server" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>" SelectCommand="SELECT codigoCliente, nombreEntidad FROM Cliente order by nombreEntidad"></asp:SqlDataSource>
                                </div>
                            </div>

                            <div class="mt-3 text-center">
                                <asp:LinkButton ID="InsertButtonProyecto" class="btn btn-success" runat="server" CausesValidation="True" CommandName="Insert" Text="Insertar" OnClientClick="return validateForm();" />
                                &nbsp;
                                <asp:LinkButton ID="InsertCancelButtonProyecto" class="btn btn-danger" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancelar" />
                            </div>

                        </InsertItemTemplate>
                        <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                        <RowStyle BackColor="#6c757d" ForeColor="White" />
                    </asp:FormView>
                </asp:Panel>
            </div>
        </div>
    </div>
</asp:Content>
