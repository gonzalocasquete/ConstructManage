﻿<%@ Page Language="C#" MasterPageFile="~/Master/Master1.Master" AutoEventWireup="true" CodeBehind="GestionarProyectos.aspx.cs" Inherits="tfgASPX2.Views.Super.GestionarProyectos" %>

<asp:Content ID="GestionarProyectosHead" ContentPlaceHolderID="head" runat="server">
    <link href="../../Styles/GestionarProyectoStyle.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css"
        rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x"
        crossorigin="anonymous" />
    <style type="text/css">
        .auto-style5 {
            height: 822px;
        }

        .auto-style6 {
            height: 348px;
        }
    </style>
    <script src="../../Scripts/Views/GestionarProyectoStyle.js"></script>
</asp:Content>

<asp:Content ID="GestionarProyectosNavegacion" ContentPlaceHolderID="ContentPlaceHolderNavegacion" runat="server">
    <a href="MenuSuper.aspx">Menú</a>
</asp:Content>

<asp:Content ID="GestionarProyectosBody" ContentPlaceHolderID="ContentPlaceHolderContenido" runat="server">
    <div class="auto-style1">
        <h2 class="font-weight-bold">Gestión de Proyectos</h2>

        <%--Filtros--%>
        <hr />
        <div>

            <div class="row">
                <div class="col">
                    <%--Nombre Proyecto--%>
                    <asp:Label ID="LabelFiltroProyecto" runat="server" Text="Proyecto:"></asp:Label>
                    <asp:TextBox ID="TextBoxFiltradoProyecto" class="form-control" runat="server"></asp:TextBox>
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
                    <input id="fechaMaxima" class="form-control" runat="server" type="date" name="fechaMaxima" onclick="showDatePicker()">
                </div>
            </div>

            <div class="row">
                <div class="col">
                    <%--Presupuesto Minimo--%>
                    <asp:Label ID="LabelPresupuestoMinimo" for="presupuestoMinimo" runat="server" Text="Presupuesto mínimo:"></asp:Label>
                    <input id="presupuestoMinimo" class="form-control" runat="server" type="number" name="presupuestoMinimo">
                </div>
                <div class="col">
                    <%--Presupuesto Maximo--%>
                    <asp:Label ID="LabelPresupuestoMaximo" for="presupuestoMaximo" runat="server" Text="Presupuesto máximo:"></asp:Label>
                    <input id="presupuestoMaximo" class="form-control" runat="server" type="number" name="presupuestoMaximo">
                </div>
            </div>

            <div class="text-center mt-2">
                <asp:Button ID="ButtonFiltrado" class="form-control btn btn-primary btn-sm btn-block buttonFilter" runat="server" Text="Filtrar" OnClick="ButtonFiltrado_Click" />
                <asp:Button runat="server" class="form-control btn-secondary btn-sm btn-block buttonFilter mt-1" Text="Limpiar" OnClick="Todos_Click"></asp:Button>
            </div>
        </div>

        <%--SqldDataSource para recoger todos los proyectos--%>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>"
            DeleteCommand="DELETE FROM [Proyecto] WHERE [CodigoProyecto] = @original_CodigoProyecto AND [NombreProyecto] = @original_NombreProyecto AND (([Descripcion] = @original_Descripcion) OR ([Descripcion] IS NULL AND @original_Descripcion IS NULL)) AND (([FechaInicio] = @original_FechaInicio) OR ([FechaInicio] IS NULL AND @original_FechaInicio IS NULL)) AND (([FechaFin] = @original_FechaFin) OR ([FechaFin] IS NULL AND @original_FechaFin IS NULL)) AND (([Presupuesto] = @original_Presupuesto) OR ([Presupuesto] IS NULL AND @original_Presupuesto IS NULL)) AND (([Comentarios] = @original_Comentarios) OR ([Comentarios] IS NULL AND @original_Comentarios IS NULL))"
            InsertCommand="INSERT INTO [Proyecto] ([NombreProyecto], [Descripcion], [FechaInicio], [FechaFin], [Presupuesto], [Comentarios]) VALUES (@NombreProyecto, @Descripcion, @FechaInicio, @FechaFin, @Presupuesto, @Comentarios)"
            SelectCommand="SELECT * FROM [Proyecto]"
            UpdateCommand="UPDATE [Proyecto] SET [NombreProyecto] = @NombreProyecto, [Descripcion] = @Descripcion, [FechaInicio] = @FechaInicio, [FechaFin] = @FechaFin, [Presupuesto] = @Presupuesto, [Comentarios] = @Comentarios WHERE [CodigoProyecto] = @original_CodigoProyecto AND [NombreProyecto] = @original_NombreProyecto AND (([Descripcion] = @original_Descripcion) OR ([Descripcion] IS NULL AND @original_Descripcion IS NULL)) AND (([FechaInicio] = @original_FechaInicio) OR ([FechaInicio] IS NULL AND @original_FechaInicio IS NULL)) AND (([FechaFin] = @original_FechaFin) OR ([FechaFin] IS NULL AND @original_FechaFin IS NULL)) AND (([Presupuesto] = @original_Presupuesto) OR ([Presupuesto] IS NULL AND @original_Presupuesto IS NULL)) AND (([Comentarios] = @original_Comentarios) OR ([Comentarios] IS NULL AND @original_Comentarios IS NULL))"
            ConflictDetection="CompareAllValues"
            OldValuesParameterFormatString="original_{0}">
            <DeleteParameters>
                <asp:Parameter Name="original_CodigoProyecto" Type="Int32" />
                <asp:Parameter Name="original_NombreProyecto" Type="String" />
                <asp:Parameter Name="original_Descripcion" Type="String" />
                <asp:Parameter DbType="Date" Name="original_FechaInicio" />
                <asp:Parameter DbType="Date" Name="original_FechaFin" />
                <asp:Parameter Name="original_Presupuesto" Type="Decimal" />
                <asp:Parameter Name="original_Comentarios" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="NombreProyecto" Type="String" />
                <asp:Parameter Name="Descripcion" Type="String" />
                <asp:Parameter DbType="Date" Name="FechaInicio" />
                <asp:Parameter DbType="Date" Name="FechaFin" />
                <asp:Parameter Name="Presupuesto" Type="Decimal" />
                <asp:Parameter Name="Comentarios" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="NombreProyecto" Type="String" />
                <asp:Parameter Name="Descripcion" Type="String" />
                <asp:Parameter DbType="Date" Name="FechaInicio" />
                <asp:Parameter DbType="Date" Name="FechaFin" />
                <asp:Parameter Name="Presupuesto" Type="Decimal" />
                <asp:Parameter Name="Comentarios" Type="String" />
                <asp:Parameter Name="original_CodigoProyecto" Type="Int32" />
                <asp:Parameter Name="original_NombreProyecto" Type="String" />
                <asp:Parameter Name="original_Descripcion" Type="String" />
                <asp:Parameter DbType="Date" Name="original_FechaInicio" />
                <asp:Parameter DbType="Date" Name="original_FechaFin" />
                <asp:Parameter Name="original_Presupuesto" Type="Decimal" />
                <asp:Parameter Name="original_Comentarios" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <%--Grid que muestra todos los proyectos--%>
        <asp:GridView ID="GridView1" class="mt-3 table" runat="server" AllowPaging="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" DataKeyNames="CodigoProyecto" DataSourceID="SqlDataSource1" ForeColor="Black" GridLines="Vertical" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" AllowSorting="True">
            <AlternatingRowStyle BackColor="#CCCCCC" />
            <Columns>
                <asp:BoundField DataField="CodigoProyecto" HeaderText="CodigoProyecto" ReadOnly="True" InsertVisible="False"></asp:BoundField>
                <asp:BoundField DataField="NombreProyecto" HeaderText="NombreProyecto"></asp:BoundField>
                <asp:BoundField DataField="Descripcion" HeaderText="Descripcion" />

                <asp:TemplateField HeaderText="Fecha Inicio" SortExpression="FechaInicio">
                    <ItemTemplate>
                        <%# Eval("FechaInicio", "{0:dd/MM/yy}") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <input type="date" id="dateFechaInicio" runat="server" value='<%# Bind("FechaInicio", "{0:yyyy-MM-dd}") %>' />
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Fecha Inicio" SortExpression="fechaInicio">
                    <ItemTemplate>
                        <%# Eval("FechaFin", "{0:dd/MM/yy}") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <input type="date" id="dateFechaFin" runat="server" value='<%# Bind("FechaFin", "{0:yyyy-MM-dd}") %>' />
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:BoundField DataField="Presupuesto" HeaderText="Presupuesto" SortExpression="Presupuesto" />
                <asp:BoundField DataField="Comentarios" HeaderText="Comentario" />
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
        <asp:Button ID="ButtonInsertarProyecto" CssClass="ButtonStyle button1 mt-3" runat="server" Text="Insertar" OnClick="ButtonInsertarProyecto_Click" />

        <%--Mostrado de los partes asociados al proyecto seleccionado--%>
        <div class="auto-style5 mt-3">
            <asp:Panel ID="PanelPartidas" runat="server" Height="347px" Visible="False">
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>"
                    DeleteCommand="DELETE FROM [Partida] WHERE [CodigoPartida] = @CodigoPartida"
                    InsertCommand="INSERT INTO [Partida] ([nombrePartida], [FechaInicio], [FechaFin], [Costo], [CodigoProyecto]) VALUES (@nombrePartida, @FechaInicio, @FechaFin, @Costo, @CodigoProyecto)"
                    SelectCommand="SELECT * FROM [Partida] WHERE ([CodigoProyecto] = @CodigoProyecto)"
                    UpdateCommand="UPDATE [Partida] SET [nombrePartida] = @nombrePartida, [FechaInicio] = @FechaInicio, [FechaFin] = @FechaFin, [Costo] = @Costo, [CodigoProyecto] = @CodigoProyecto WHERE [CodigoPartida] = @CodigoPartida">
                    <DeleteParameters>
                        <asp:Parameter Name="CodigoPartida" Type="Int32" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="nombrePartida" Type="String" />
                        <asp:Parameter DbType="Date" Name="FechaInicio" />
                        <asp:Parameter DbType="Date" Name="FechaFin" />
                        <asp:Parameter Name="Costo" Type="Decimal" />
                        <asp:Parameter Name="CodigoProyecto" Type="Int32" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="GridView1" Name="CodigoProyecto" PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="nombrePartida" Type="String" />
                        <asp:Parameter DbType="Date" Name="FechaInicio" />
                        <asp:Parameter DbType="Date" Name="FechaFin" />
                        <asp:Parameter Name="Costo" Type="Decimal" />
                        <asp:Parameter Name="CodigoProyecto" Type="Int32" />
                        <asp:Parameter Name="CodigoPartida" Type="Int32" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                <asp:GridView ID="GridView2" class="table" runat="server" AllowPaging="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" DataKeyNames="CodigoPartida" DataSourceID="SqlDataSource2" ForeColor="Black" GridLines="Vertical">
                    <AlternatingRowStyle BackColor="#CCCCCC" />
                    <Columns>
                        <asp:BoundField DataField="nombrePartida" HeaderText="Nombre" SortExpression="nombrePartida" />
                        <asp:BoundField DataField="FechaInicio" DataFormatString="{0:dd/MM/yy}" HeaderText="Fecha Inicio" SortExpression="FechaInicio" />
                        <asp:BoundField DataField="FechaFin" DataFormatString="{0:dd/MM/yy}" HeaderText="Fecha Fin" SortExpression="FechaFin" />
                        <asp:BoundField DataField="Costo" HeaderText="Costo" SortExpression="Costo" />
                        <asp:BoundField DataField="CodigoProyecto" HeaderText="ID Proyecto" SortExpression="CodigoProyecto" />
                        <asp:BoundField DataField="CodigoPartida" HeaderText="ID Partida" InsertVisible="False" ReadOnly="True" SortExpression="CodigoPartida" />
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

                <%--Panel para la inserción de una partida al proyecto seleccionado--%>
                <asp:Button ID="ButtonInsertarPartida" CssClass="ButtonStyle button1" runat="server" Text="Insertar Partida" OnClick="ButtonInsertarPartida_Click" />

                <div>
                    <asp:Panel ID="PanelInsertarPartida" runat="server" Visible="False" HorizontalAlign="Center">
                        <asp:SqlDataSource runat="server" ID="SqlDataSource4" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>" DeleteCommand="DELETE FROM [Partida] WHERE [CodigoPartida] = @CodigoPartida" InsertCommand="INSERT INTO [Partida] ([nombrePartida], [FechaInicio], [FechaFin], [Costo], [CodigoProyecto]) VALUES (@nombrePartida, @FechaInicio, @FechaFin, @Costo, @CodigoProyecto)" SelectCommand="SELECT * FROM [Partida] WHERE ([CodigoProyecto] = @CodigoProyecto)" UpdateCommand="UPDATE [Partida] SET [nombrePartida] = @nombrePartida, [FechaInicio] = @FechaInicio, [FechaFin] = @FechaFin, [Costo] = @Costo, [CodigoProyecto] = @CodigoProyecto WHERE [CodigoPartida] = @CodigoPartida">
                            <DeleteParameters>
                                <asp:Parameter Name="CodigoPartida" Type="Int32"></asp:Parameter>
                            </DeleteParameters>
                            <InsertParameters>
                                <asp:Parameter Name="nombrePartida" Type="String"></asp:Parameter>
                                <asp:Parameter DbType="Date" Name="FechaInicio"></asp:Parameter>
                                <asp:Parameter DbType="Date" Name="FechaFin"></asp:Parameter>
                                <asp:Parameter Name="Costo" Type="Decimal"></asp:Parameter>
                                <asp:Parameter Name="CodigoProyecto" Type="Int32"></asp:Parameter>
                            </InsertParameters>
                            <SelectParameters>
                                <asp:ControlParameter ControlID="GridView1" PropertyName="SelectedValue" Name="CodigoProyecto" Type="Int32"></asp:ControlParameter>
                            </SelectParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="nombrePartida" Type="String"></asp:Parameter>
                                <asp:Parameter DbType="Date" Name="FechaInicio"></asp:Parameter>
                                <asp:Parameter DbType="Date" Name="FechaFin"></asp:Parameter>
                                <asp:Parameter Name="Costo" Type="Decimal"></asp:Parameter>
                                <asp:Parameter Name="CodigoProyecto" Type="Int32"></asp:Parameter>
                                <asp:Parameter Name="CodigoPartida" Type="Int32"></asp:Parameter>
                            </UpdateParameters>
                        </asp:SqlDataSource>

                        <asp:FormView ID="FormView2" runat="server" DataSourceID="SqlDataSource4" DataKeyNames="CodigoPartida" DefaultMode="Insert">
                            <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                            <InsertItemTemplate>
                                <div class="row">
                                    <div class="col">
                                        Partida:
                                        <asp:TextBox Text='<%# Bind("nombrePartida") %>' class="form-control" runat="server" ID="nombrePartidaTextBox" /><br />
                                    </div>
                                    <div class="col">
                                        Costo:
                                        <asp:TextBox Text='<%# Bind("Costo") %>' class="form-control" runat="server" ID="CostoTextBox" /><br />
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

                                <div class="row">
                                    <div class="col">
                                        CodigoProyecto:
                                        <asp:TextBox Text='<%# Bind("CodigoProyecto") %>' class="form-control" runat="server" ID="CodigoProyectoTextBox" /><br />
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
            </asp:Panel>

            <%--Panel para la insercion de un proyecto--%>
            <div class="auto-style6">
                <asp:Panel ID="PanelInsertarProyecto" runat="server" Height="267px" Visible="False">
                    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:mibasededatostfgConnectionString %>"
                        DeleteCommand="DELETE FROM [Proyecto] WHERE [CodigoProyecto] = @original_CodigoProyecto AND [NombreProyecto] = @original_NombreProyecto AND (([Descripcion] = @original_Descripcion) OR ([Descripcion] IS NULL AND @original_Descripcion IS NULL)) AND (([FechaInicio] = @original_FechaInicio) OR ([FechaInicio] IS NULL AND @original_FechaInicio IS NULL)) AND (([FechaFin] = @original_FechaFin) OR ([FechaFin] IS NULL AND @original_FechaFin IS NULL)) AND (([Presupuesto] = @original_Presupuesto) OR ([Presupuesto] IS NULL AND @original_Presupuesto IS NULL)) AND (([Comentarios] = @original_Comentarios) OR ([Comentarios] IS NULL AND @original_Comentarios IS NULL))"
                        InsertCommand="INSERT INTO [Proyecto] ([NombreProyecto], [Descripcion], [FechaInicio], [FechaFin], [Presupuesto], [Comentarios]) VALUES (@NombreProyecto, @Descripcion, @FechaInicio, @FechaFin, @Presupuesto, @Comentarios)"
                        OldValuesParameterFormatString="original_{0}"
                        SelectCommand="SELECT * FROM [Proyecto]"
                        UpdateCommand="UPDATE [Proyecto] SET [NombreProyecto] = @NombreProyecto, [Descripcion] = @Descripcion, [FechaInicio] = @FechaInicio, [FechaFin] = @FechaFin, [Presupuesto] = @Presupuesto, [Comentarios] = @Comentarios WHERE [CodigoProyecto] = @original_CodigoProyecto AND [NombreProyecto] = @original_NombreProyecto AND (([Descripcion] = @original_Descripcion) OR ([Descripcion] IS NULL AND @original_Descripcion IS NULL)) AND (([FechaInicio] = @original_FechaInicio) OR ([FechaInicio] IS NULL AND @original_FechaInicio IS NULL)) AND (([FechaFin] = @original_FechaFin) OR ([FechaFin] IS NULL AND @original_FechaFin IS NULL)) AND (([Presupuesto] = @original_Presupuesto) OR ([Presupuesto] IS NULL AND @original_Presupuesto IS NULL)) AND (([Comentarios] = @original_Comentarios) OR ([Comentarios] IS NULL AND @original_Comentarios IS NULL))">
                        <InsertParameters>
                            <asp:Parameter Name="NombreProyecto" Type="String" />
                            <asp:Parameter Name="Descripcion" Type="String" />
                            <asp:Parameter DbType="Date" Name="FechaInicio" />
                            <asp:Parameter DbType="Date" Name="FechaFin" />
                            <asp:Parameter Name="Presupuesto" Type="Decimal" />
                            <asp:Parameter Name="Comentarios" Type="String" />
                        </InsertParameters>
                    </asp:SqlDataSource>
                    <asp:FormView ID="FormView1" class="form-control" runat="server" DataKeyNames="CodigoProyecto" DataSourceID="SqlDataSource3" DefaultMode="Insert" CellPadding="4" ForeColor="#333333">
                        <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                        <InsertItemTemplate>

                            <div class="row">
                                <div class="col">
                                    NombreProyecto:
                                    <asp:TextBox ID="NombreProyectoTextBox" class="form-control" data-toggle="tooltip" title="Nombre del proyecto" runat="server" Text='<%# Bind("NombreProyecto") %>' />
                                </div>
                                <div class="col">
                                    Descripcion:
                                    <asp:TextBox ID="DescripcionTextBox" class="form-control" data-toggle="tooltip" title="Descripcion del proyecto" runat="server" Text='<%# Bind("Descripcion") %>' />
                                </div>
                            </div>

                            <div class="row">
                                <div class="col">
                                    FechaInicio:
                                    <input type="date" id="FechaInicioTextBox" class="form-control" data-toggle="tooltip" title="Fecha de alta del proyecto" runat="server" value='<%# Bind("FechaInicio", "{0:yyyy-MM-dd}") %>' />
                                </div>
                                <div class="col">
                                    FechaFin:
                                    <input type="date" id="FechaFinTextBox" class="form-control" data-toggle="tooltip" title="Fecha de finalización del proyecto" runat="server" value='<%# Bind("FechaFin", "{0:yyyy-MM-dd}") %>' />
                                </div>
                            </div>

                            <div class="row">
                                <div class="col">
                                    Presupuesto:
                                    <asp:TextBox ID="PresupuestoTextBox" class="form-control" data-toggle="tooltip" title="Presupuesto estimado del proyecto" runat="server" Text='<%# Bind("Presupuesto") %>' />
                                </div>
                                <div class="col">
                                    Comentarios:
                                    <asp:TextBox ID="ComentariosTextBox" class="form-control" data-toggle="tooltip" title="Comentarios del proyecto" runat="server" Text='<%# Bind("Comentarios") %>' />
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
        </div>
    </div>
</asp:Content>
