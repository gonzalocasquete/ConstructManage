using System;
using System.Collections.Generic;
using System.Data.SqlClient;
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
            ButtonInsertarLinea.Visible = true;
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
                ButtonFiltros.Visible = false;
                GridView1.Visible = false;
                PanelConsultarLineasParte.Visible=false;
                PanelInsertarParte.Visible = true;
                ButtonInsertarParte.Text = "Ocultar";
            }
            else {
                ButtonFiltros.Visible = true;
                GridView1.Visible = true;
                PanelInsertarParte.Visible = false;
                ButtonInsertarParte.Text = "Insertar Parte";
            }
        }

        protected void FormViewInsertarParte_ItemInserting(object sender, FormViewInsertEventArgs e)
        {
            TextBox codigoTrabajadorTextBox = (TextBox)FormViewInsertarParte.FindControl("codigoTrabajadorTextBox");

            if (Session["codigoTrabajador"] != null)
            {
                e.Values["codigoTrabajador"] = Session["codigoTrabajador"].ToString();
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

        protected void idProyectosDropDownList_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList proyectoDropDown = (DropDownList)sender;
            DropDownList clienteDropDown = (DropDownList)FormViewInsertarParte.FindControl("idClientesDropDownList");
            DropDownList tipoDropDown = (DropDownList)FormViewInsertarParte.FindControl("tipoDropDownList");

            if (tipoDropDown.SelectedValue == "Asociado") // Si el tipo es "Asociado"
            {
                // Obtén el nombre del cliente asociado al proyecto seleccionado
                string nombreClienteAsociado = GetNombreClienteAsociado(proyectoDropDown.SelectedValue);

                // Establece el valor del DropDownList de Cliente al cliente asociado
                clienteDropDown.SelectedValue = nombreClienteAsociado;

                // Deshabilita el DropDownList de Cliente
                clienteDropDown.Enabled = false;
            }
            else
            {
                // Habilita el DropDownList de Cliente
                clienteDropDown.Enabled = true;
            }
        }

        private string GetNombreClienteAsociado(string codigoProyecto)
        {
            string consulta = "SELECT nombreEntidad AS nombreCliente FROM Proyecto INNER JOIN Cliente ON Proyecto.codigoCliente = Cliente.codigoCliente WHERE Proyecto.codigoProyecto = @codigoProyecto";

            string connectionString = "Data Source=miservertfg.database.windows.net;Initial Catalog=mibasededatostfg;Persist Security Info=True;User ID=adminsql;Password=Josele6072";

            int codigoProyectoInt = int.Parse(codigoProyecto);

            string nombreEntidad = "";

            using (SqlConnection cnn = new SqlConnection(connectionString))
            {
                cnn.Open();
                using (SqlCommand cmd = new SqlCommand(consulta, cnn))
                {
                    cmd.Parameters.AddWithValue("@codigoProyecto", codigoProyectoInt);

                    using (SqlDataReader adap = cmd.ExecuteReader())
                    {
                        if (adap.Read())
                        {
                            nombreEntidad = adap.GetString(0);
                        }
                    }
                }
            }
            return nombreEntidad;
        }



    }
}