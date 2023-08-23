using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace tfgASPX2.Views.Coordinador
{
    public partial class InicialCoordinador : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
          
        }


        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            PanelConsultarLineasParte.Visible = true;
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
            }
        }


        protected void ButtonInsertarParte_Click(object sender, EventArgs e)
        {
            if (!PanelInsertarParte.Visible)
            {
                PanelConsultarLineasParte.Visible=false;
                PanelInsertarParte.Visible = true;
                ButtonInsertarParte.Text = "Ocultar";
            }
            else {
                if(GridView2.Rows.Count !=0) /*Solo se mostrara si hay valores que mostrar*/
                    PanelConsultarLineasParte.Visible = true;

                PanelInsertarParte.Visible = false;
                ButtonInsertarParte.Text = "Insertar Parte";
            }
        }

        protected void FormViewInsertarParte_DataBound(object sender, EventArgs e)
        {
            if (FormViewInsertarParte.CurrentMode == FormViewMode.Insert)
            {
                TextBox codigoTrabajadorTextBox = (TextBox)FormViewInsertarParte.FindControl("codigoTrabajadorTextBox");

                if (codigoTrabajadorTextBox != null && Session["codigoTrabajador"] != null)
                {
                    codigoTrabajadorTextBox.Text = Session["codigoTrabajador"].ToString();
                }
            }
        }

        protected void ButtonInsertarLinea_Click(object sender, EventArgs e)
        {
            if (!PanelInsertarLinea.Visible)
            {
               PanelInsertarLinea.Visible = true;
                ButtonInsertarLinea.Text = "Ocultar";
            }
            else {
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
            String consultaSQL = "SELECT Parte.codigoParte, Parte.fecha, Parte.tipo, Parte.codigoTrabajador, Proyecto.NombreProyecto, Cliente.nombreEntidad" +
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
            SqlDataSource1.DataBind();
        }


        protected void Limpiar_Click(object sender, EventArgs e)
        {
            SqlDataSource1.SelectCommand = "SELECT Parte.codigoParte, Parte.fecha, Parte.tipo, Parte.codigoTrabajador, Proyecto.NombreProyecto, Cliente.nombreEntidad FROM Parte LEFT JOIN Proyecto ON Parte.codigoProyecto = Proyecto.codigoProyecto LEFT JOIN Cliente ON Parte.codigoCliente = Cliente.codigoCliente WHERE Parte.codigoTrabajador = " + Session["codigoTrabajador"] +"";
            SqlDataSource1.DataBind();
            TextBoxFiltradoProyecto.Text = "";
            TextBoxFiltradoCliente.Text = "";
            fechaMinima.Value = null;
            fechaMaxima.Value = null;
            DropDownListTipo.SelectedIndex = 0;
        }

    }
}