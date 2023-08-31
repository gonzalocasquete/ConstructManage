using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace tfgASPX2.Views.Coordinador
{
    public partial class InicialCoordinador : System.Web.UI.Page
    {
       
            protected void Page_Load(object sender, EventArgs e)
            {
                if (IsPostBack)
                {
                    SqlDataSource1.SelectCommand = Session["consultaSQL"].ToString();
                }
                else
                {
                if (Session["rol"] == null || Session["rol"].ToString() != "coordinador")
                    Response.Redirect("../Login.aspx");

                Session["consultaSQL"] = "SELECT Parte.*, COALESCE(Proyecto.NombreProyecto, 'Sin proyecto') AS NombreProyecto, Cliente.nombreEntidad FROM Parte LEFT JOIN Proyecto ON Parte.codigoProyecto = Proyecto.codigoProyecto INNER JOIN Cliente ON Parte.codigoCliente = Cliente.codigoCliente WHERE Parte.codigoTrabajador = " + Session["codigoTrabajador"];
                MostrarTitulo();
                }
            }

        private void MostrarTitulo()
        {
            if (Session["nombreUsuario"] != null)
            {
                string nombreUsuario = Session["nombreUsuario"].ToString();
                // Muestra el mensaje de bienvenida en un Label o Literal en tu página.
                string mensaje = $"Partes de {nombreUsuario}";
                LabelMensajeBienvenida.Text = mensaje;
            }
        }


        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            ButtonVolver.Visible = true;
            PanelConsultarLineasParte.Visible = true;
            ButtonInsertarLinea.Visible = true;
            ButtonFiltros.Visible = false;
            GridView2.Visible = true;
            PanelInsertarLinea.Visible = false;

            if (GridView1.SelectedIndex >= 0)
            {
                // Obtén el valor de codigoParte de la fila seleccionada
                string codigoParteSeleccionado = GridView1.SelectedDataKey["codigoParte"].ToString();

                // Establece el valor en el campo codigoParte del FormView
                TextBox codigoParteTextBox = FormViewInsertarLinea.FindControl("TextBoxCodigoParteLinea") as TextBox; // Corrección aquí
                if (codigoParteTextBox != null)
                {
                    codigoParteTextBox.Text = codigoParteSeleccionado;
                }

                if (GridView1.SelectedIndex >= 0)
                {
                    int rowIndex = GridView1.SelectedIndex;
                    string codigoParteStr = GridView1.DataKeys[rowIndex]["codigoParte"].ToString();
                    int.TryParse(codigoParteStr, out int codigoParteInt);
                    SqlDataSource1.SelectCommand = "SELECT Parte.*, COALESCE(Proyecto.NombreProyecto, 'Sin proyecto') AS NombreProyecto, Cliente.nombreEntidad FROM Parte INNER JOIN Proyecto ON Parte.codigoProyecto = Proyecto.codigoProyecto INNER JOIN Cliente ON Parte.codigoCliente = Cliente.codigoCliente WHERE [codigoTrabajador] = "+Session["codigoTrabajador"] +" AND codigoParte=" + codigoParteInt;
                    Session["consultaSQL"]= "SELECT Parte.*, COALESCE(Proyecto.NombreProyecto, 'Sin proyecto') AS NombreProyecto, Cliente.nombreEntidad FROM Parte LEFT JOIN Proyecto ON Parte.codigoProyecto = Proyecto.codigoProyecto INNER JOIN Cliente ON Parte.codigoCliente = Cliente.codigoCliente WHERE [codigoTrabajador] = "+Session["codigoTrabajador"]+" AND codigoParte=" + codigoParteInt;
                    SqlDataSource1.DataBind();              
                }
            }
        }

        protected void ButtonVolver_Click(object sender, EventArgs e)
        {
            ButtonVolver.Visible = false;
            ButtonInsertarLinea.Visible = false;
            GridView1.SelectedIndex = -1;
            PanelInsertarLinea.Visible = false;
            ButtonFiltros.Visible = true;

            ButtonInsertarLinea.Text = "Insertar Linea";
            SqlDataSource1.SelectCommand = "SELECT Parte.*, Proyecto.NombreProyecto, Cliente.nombreEntidad FROM Parte INNER JOIN Proyecto ON Parte.codigoProyecto = Proyecto.codigoProyecto INNER JOIN Cliente ON Parte.codigoCliente = Cliente.codigoCliente WHERE [codigoTrabajador] = " + Session["codigoTrabajador"];
            Session["consultaSQL"] = "SELECT Parte.*, COALESCE(Proyecto.NombreProyecto, 'Sin proyecto') AS NombreProyecto, Cliente.nombreEntidad FROM Parte LEFT JOIN Proyecto ON Parte.codigoProyecto = Proyecto.codigoProyecto INNER JOIN Cliente ON Parte.codigoCliente = Cliente.codigoCliente WHERE Parte.codigoTrabajador = " + Session["codigoTrabajador"];
            SqlDataSource1.DataBind();
        }


        protected void ButtonInsertarParte_Click(object sender, EventArgs e)
        {
            if (!PanelInsertarParte.Visible)
            {
                ButtonInsertarLinea.Visible = false;
                ButtonFiltros.Visible = false;
                GridView1.Visible = false;
                PanelConsultarLineasParte.Visible=false;
                PanelInsertarParte.Visible = true;
                ButtonInsertarParte.Text = "Ocultar";
            }
            else {
                ButtonVolver.Visible = false;
                ButtonFiltros.Visible = true;
                GridView1.Visible = true;
                PanelInsertarParte.Visible = false;
                ButtonInsertarParte.Text = "Insertar Parte";
                GridView1.SelectedIndex = -1;

                SqlDataSource1.SelectCommand = "SELECT Parte.*, Proyecto.NombreProyecto, Cliente.nombreEntidad FROM Parte INNER JOIN Proyecto ON Parte.codigoProyecto = Proyecto.codigoProyecto INNER JOIN Cliente ON Parte.codigoCliente = Cliente.codigoCliente WHERE [codigoTrabajador] = " + Session["codigoTrabajador"];
                Session["consultaSQL"] = "SELECT Parte.*, COALESCE(Proyecto.NombreProyecto, 'Sin proyecto') AS NombreProyecto, Cliente.nombreEntidad FROM Parte LEFT JOIN Proyecto ON Parte.codigoProyecto = Proyecto.codigoProyecto INNER JOIN Cliente ON Parte.codigoCliente = Cliente.codigoCliente WHERE Parte.codigoTrabajador = " + Session["codigoTrabajador"];
                SqlDataSource1.DataBind();
            }
        }

        protected void FormViewInsertarParte_ItemInserting(object sender, FormViewInsertEventArgs e)
        {
            TextBox codigoTrabajadorTextBox = (TextBox)FormViewInsertarParte.FindControl("codigoTrabajadorTextBox");
            HtmlInputControl fechaInput = (HtmlInputControl)FormViewInsertarParte.FindControl("fechaTextBox");  // Cambiamos el tipo a HtmlInputControl
      
            if (Session["codigoTrabajador"] != null)
            {
                e.Values["codigoTrabajador"] = Session["codigoTrabajador"].ToString();
            }

            // Establecemos la fecha del día de hoy
            DateTime fechaHoy = DateTime.Now;
            fechaInput.Value = fechaHoy.ToString("yyyy-MM-dd");
        }

        protected void ButtonInsertarLinea_Click(object sender, EventArgs e)
        {
            if (!PanelInsertarLinea.Visible)
            {
                GridView2.Visible = false;
                PanelInsertarLinea.Visible = true;
                ButtonInsertarLinea.Text = "Ocultar";
            }
            else {
                GridView2.Visible = true;
                PanelInsertarLinea.Visible = false;
                ButtonInsertarLinea.Text = "Insertar Linea";
            }
        }

        protected void ButtonFiltros_Click(object sender, EventArgs e)
        {
            if (!PanelFiltros.Visible)
            {
                PanelFiltros.Visible = true;
                ButtonFiltros.Text = "Ocultar filtros";
            }
            else
            {

                PanelFiltros.Visible = false;
                ButtonFiltros.Text = "Mostrar filtros";
            }
        }

        protected void ButtonFiltrado_Click(object sender, EventArgs e)
        {
            String consultaSQL = "SELECT Parte.*, COALESCE(Proyecto.NombreProyecto, 'Sin proyecto') AS NombreProyecto, Cliente.nombreEntidad" +
                " FROM Parte LEFT JOIN Proyecto ON Parte.codigoProyecto = Proyecto.codigoProyecto LEFT JOIN Cliente ON Parte.codigoCliente = Cliente.codigoCliente";

            bool whereAdded = false; // Bandera para controlar la adición del primer "WHERE"

            if (!string.IsNullOrEmpty(TextBoxFiltradoProyecto.Text))
            {
                consultaSQL += " WHERE NombreProyecto LIKE '%" + TextBoxFiltradoProyecto.Text + "%'";
                whereAdded = true;
            }

            if (!string.IsNullOrEmpty(TextBoxFiltradoCliente.Text))
            {
                consultaSQL += (whereAdded ? " AND" : " WHERE") + " nombreEntidad LIKE '%" + TextBoxFiltradoCliente.Text + "%'";
                whereAdded = true;
            }

            if (DropDownListTipo.SelectedIndex != 0)
            {
                consultaSQL += (whereAdded ? " AND" : " WHERE") + " Tipo = " + DropDownListTipo.SelectedValue;
                whereAdded = true;
            }

            if (!string.IsNullOrEmpty(fechaMinima.Value))
            {
                consultaSQL += (whereAdded ? " AND" : " WHERE") + " fecha >= '" + fechaMinima.Value + "'";
                whereAdded = true;
            }

            if (!string.IsNullOrEmpty(fechaMaxima.Value))
            {
                consultaSQL += (whereAdded ? " AND" : " WHERE") + " fecha <= '" + fechaMaxima.Value + "'";
            }

            SqlDataSource1.SelectCommand = consultaSQL;
            Session["consultaSQL"]= consultaSQL;
            SqlDataSource1.DataBind();
        }


        protected void Limpiar_Click(object sender, EventArgs e)
        {
            Session["consultaSQL"] = "SELECT Parte.*, COALESCE(Proyecto.NombreProyecto, 'Sin proyecto') AS NombreProyecto, Cliente.nombreEntidad FROM Parte LEFT JOIN Proyecto ON Parte.codigoProyecto = Proyecto.codigoProyecto INNER JOIN Cliente ON Parte.codigoCliente = Cliente.codigoCliente WHERE Parte.codigoTrabajador = " + Session["codigoTrabajador"];
            SqlDataSource1.SelectCommand = Session["consultaSQL"].ToString();
            SqlDataSource1.DataBind();
            TextBoxFiltradoProyecto.Text = "";
            TextBoxFiltradoCliente.Text = "";
            fechaMinima.Value = null;
            fechaMaxima.Value = null;
            DropDownListTipo.SelectedIndex = 0;
        }

        protected string GetTipoText(object tipoValue)
        {
            if (tipoValue != null)
            {
                int tipo = Convert.ToInt32(tipoValue);
                if (tipo == 1)
                {
                    return "Asociado";
                }
                else if (tipo == 2)
                {
                    return "No Asociado";
                }
            }
            return string.Empty; // Default value if tipoValue is null or not 1 or 2
        }
    }
}