using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace tfgASPX2.Views.Super
{
    public partial class GestionarProyectos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void ButtonInsertarProyecto_Click(object sender, EventArgs e)
        {
            if (PanelInsertarProyecto.Visible)
            {
                GridView1.SelectedIndex = -1;
                PanelInsertarProyecto.Visible = false;

                PanelPartidas.Visible = false;

                GridView1.Visible = true;
                ButtonInsertarPartida.Visible = false;
                ButtonFiltros.Visible= true;
                ButtonInsertarProyecto.Text = "Insertar Proyecto";
                SqlDataSource1.SelectCommand = "Select * FROM Proyecto order by codigoProyecto DESC";
                SqlDataSource1.DataBind();
            }
            else
            {
                PanelInsertarProyecto.Visible = true;

                ButtonVolver.Visible = false;
                PanelFiltros.Visible = false;
                ButtonFiltros.Text = "Mostrar filtros";
                ButtonFiltros.Visible = false;
                ButtonInsertarPartida.Visible = false;
                GridView1.Visible = false;
                PanelPartidas.Visible = false;
                ButtonInsertarProyecto.Text = "Volver";      
            }
        }

        protected void ButtonInsertarPartida_Click(object sender, EventArgs e)
        {
            if (PanelInsertarPartida.Visible)
            {
                PanelPartidas.Visible = true;
                PanelInsertarPartida.Visible = false;
                ButtonInsertarPartida.Text = "Insertar Partida";
            }
            else
            {
                PanelInsertarPartida.Visible = true;
                PanelPartidas.Visible = false;
                ButtonInsertarPartida.Text = "Ocultar";
                if (GridView1.SelectedIndex >= 0)
                {
                    int rowIndex = GridView1.SelectedIndex;
                    string codigoProyectoStr = GridView1.DataKeys[rowIndex]["codigoProyecto"].ToString();
                    int.TryParse(codigoProyectoStr, out int codigoProyecto);      
                }           
            }
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            TextBox codigoProyecto = (TextBox)this.FormViewInsertarPartida.FindControl("codigoProyectoTextBox");
            int codigo = Convert.ToInt32(this.GridView1.SelectedDataKey["codigoProyecto"]);
            codigoProyecto.Text = codigo.ToString();

            ButtonVolver.Visible = true;

            PanelPartidas.Visible = true;
            PanelInsertarProyecto.Visible = false;
            PanelInsertarPartida.Visible = false;
            ButtonInsertarPartida.Visible = true;
            ButtonInsertarProyecto.Text = "Insertar Proyecto";
            ButtonInsertarPartida.Text = "Insertar Partida";

            if (GridView1.SelectedIndex >= 0)
            {
                int rowIndex = GridView1.SelectedIndex;
                string codigoProyectoStr = GridView1.DataKeys[rowIndex]["codigoProyecto"].ToString();
                int.TryParse(codigoProyectoStr, out int codigoProyectoInt);
                SqlDataSource1.SelectCommand = "Select * FROM Proyecto WHERE codigoProyecto=" + codigoProyectoInt;
                SqlDataSource1.DataBind();

                SqlDataSource2.SelectCommand = "Select * FROM Partida WHERE codigoProyecto="+codigoProyectoInt;
                SqlDataSource2.DataBind();
            }       
        }

        protected void ButtonVolverProyectos_Click(object sender, EventArgs e)
        {
            ButtonVolver.Visible = false;
            ButtonInsertarPartida.Visible= false;
            GridView1.SelectedIndex = -1;
            
            ButtonInsertarPartida.Text = "Insertar Partida";
            SqlDataSource1.SelectCommand = "Select * FROM Proyecto order by codigoProyecto DESC";
            SqlDataSource1.DataBind();
        }

        //Filtros
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
            String consultaSQL = "SELECT * FROM Proyecto WHERE nombreProyecto LIKE '%" + TextBoxFiltradoProyecto.Text + "%'";

            if (fechaMinima.Value != "")
                consultaSQL += " AND FechaInicio >= '" + fechaMinima.Value + "'";

            if (fechaMaxima.Value != "")
                consultaSQL += " AND FechaFin <= '" + fechaMaxima.Value + "'";

            if (presupuestoMinimo.Value.Length != 0)
                consultaSQL += " AND Presupuesto>=" + presupuestoMinimo.Value + "";

            if (presupuestoMaximo.Value.Length != 0)
                consultaSQL += " AND Presupuesto<=" + presupuestoMaximo.Value + "";

            SqlDataSource1.SelectCommand = consultaSQL;
            SqlDataSource1.DataBind();
        }

        protected void Todos_Click(object sender, EventArgs e)
        {
            SqlDataSource1.SelectCommand = "SELECT * FROM Proyecto order by codigoProyecto DESC";
            SqlDataSource1.DataBind();
            TextBoxFiltradoProyecto.Text = "";
            fechaMinima.Value = "";
            fechaMaxima.Value = "";
            presupuestoMinimo.Value = null;
            presupuestoMaximo.Value = null;
        }

        protected void FormViewInsertarProyecto_ItemCommand(object sender, FormViewCommandEventArgs e)
        {
            if (e.CommandName == "Cancel")
            {
                PanelPartidas.Visible = true;
                PanelInsertarPartida.Visible = false;
                ButtonInsertarPartida.Text = "Insertar Partida";

                PanelInsertarProyecto.Visible = false;

                GridView1.Visible = true;
                ButtonInsertarPartida.Visible = true;
                ButtonFiltros.Visible = false;
                ButtonInsertarProyecto.Text = "Insertar Proyecto";
            }
        }

        protected void FormViewInsertarPartida_ItemCommand(object sender, FormViewCommandEventArgs e)
        {
            if (e.CommandName == "Cancel")
            {
                PanelInsertarPartida.Visible = false;
                ButtonInsertarPartida.Text = "Insertar Partida";
                SqlDataSource1.SelectCommand = "Select * FROM Proyecto order by codigoProyecto DESC";
                SqlDataSource1.DataBind();
            }
        }

        protected void FormViewInsertarProyecto_ItemInserting(object sender, FormViewInsertEventArgs e)
        {
            TextBox NombreProyectoTextBox = (TextBox)FormViewInsertarProyecto.FindControl("NombreProyectoTextBoxInsertar");
            DropDownList idClientesDropDownList = FormViewInsertarProyecto.FindControl("idClientesDropDownList") as DropDownList;

            string nombreProyecto = NombreProyectoTextBox.Text.Trim().ToString();
            string selectedClienteValue = idClientesDropDownList.SelectedValue;

            string fechaInicio = Request.Form["FechaInicioTextBox"]; // Acceder al valor del input type="date"
            if (string.IsNullOrEmpty(nombreProyecto) || string.IsNullOrEmpty(fechaInicio) || string.IsNullOrEmpty(selectedClienteValue))
            {
                // Cancelar la inserción
                e.Cancel = true;
                // Mostrar mensaje de error o realizar acciones adicionales
                Page.ClientScript.RegisterStartupScript(this.GetType(), "ValidationScript", "alert('Por favor, completa todos los campos obligatorios.');", true);
            }

            string consulta = "SELECT NombreProyecto FROM Proyecto WHERE NombreProyecto = @nombreProyecto";

            string connectionString = "Data Source=miservertfg.database.windows.net;Initial Catalog=mibasededatostfg;Persist Security Info=True;User ID=adminsql;Password=Josele6072";

            using (SqlConnection cnn = new SqlConnection(connectionString))
            {
                cnn.Open();
                using (SqlCommand cmd = new SqlCommand(consulta, cnn))
                {
                    cmd.Parameters.AddWithValue("@nombreProyecto", NombreProyectoTextBox.Text.ToString());

                    using (SqlDataReader adap = cmd.ExecuteReader())
                    {
                        if (adap.Read())
                        {
                            e.Cancel = true;
                            ScriptManager.RegisterStartupScript(this, GetType(), "Error", "alert('El nombre del proyecto ya existe en la base de datos');", true);
                        }
                    }
                }
            }
        }

        protected void FormViewInsertarPartida_ItemInserting(object sender, FormViewInsertEventArgs e)
        {
            TextBox nombrePartidaTextBox = (TextBox)FormViewInsertarPartida.FindControl("nombrePartidaTextBox");
            HtmlInputGenericControl presupuestoInput = (HtmlInputGenericControl)FormViewInsertarPartida.FindControl("PresupuestoInputNumber");
            HtmlInputGenericControl fechaInicioInput = (HtmlInputGenericControl)FormViewInsertarPartida.FindControl("FechaInicioTextBox");
            HtmlInputGenericControl fechaFinInput = (HtmlInputGenericControl)FormViewInsertarPartida.FindControl("FechaFinTextBox");

            string fechaFin = fechaFinInput.Value.ToString(); ;
            string fechaInicio = fechaInicioInput.Value.ToString();
            string nombrePartida = nombrePartidaTextBox.Text;
            string presupuesto = presupuestoInput.Value;

            if (string.IsNullOrEmpty(nombrePartida) || string.IsNullOrEmpty(presupuesto) || string.IsNullOrEmpty(fechaInicio) || string.IsNullOrEmpty(fechaFin))
            {
                ShowErrorMessage("Todos los campos son obligatorios." + nombrePartida + " " + fechaInicio + " " + fechaFin + " " + presupuesto);
                e.Cancel = true;
                return;
            }

            if (!decimal.TryParse(presupuesto, out decimal presupuestoValue))
            {
                ShowErrorMessage("El Presupuesto debe ser un número válido.");
                e.Cancel = true;
                return;
            }

            if (!DateTime.TryParse(fechaInicio, out DateTime fechaInicioValue) || !DateTime.TryParse(fechaFin, out DateTime fechaFinValue))
            {
                ShowErrorMessage("Las fechas no son válidas.");
                e.Cancel = true;
                return;
            }

            DateTime fechaActual = DateTime.Now.Date;

            if (fechaInicioValue > fechaActual)
            {
                ShowErrorMessage("La Fecha de Inicio no puede ser posterior a la fecha actual.");
                e.Cancel = true;
                return;
            }

            if (fechaFinValue <= fechaInicioValue)
            {
                ShowErrorMessage("La Fecha Fin debe ser posterior a la Fecha de Inicio.");
                e.Cancel = true;
                return;
            }

            string consulta = "SELECT nombrePaetida FROM Partida WHERE nombrePartida = @nombrePartida";

            string connectionString = "Data Source=miservertfg.database.windows.net;Initial Catalog=mibasededatostfg;Persist Security Info=True;User ID=adminsql;Password=Josele6072";

            using (SqlConnection cnn = new SqlConnection(connectionString))
            {
                cnn.Open();
                using (SqlCommand cmd = new SqlCommand(consulta, cnn))
                {
                    cmd.Parameters.AddWithValue("@nombrePartida", nombrePartidaTextBox.Text.ToString());

                    using (SqlDataReader adap = cmd.ExecuteReader())
                    {
                        if (adap.Read())
                        {
                            ShowErrorMessage("El nombre de la partida ya se encuentra registrado");
                            e.Cancel = true;
                            return;
                        }
                    }
                }
            }
        }

        private void ShowErrorMessage(string message)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "Error", "alert('" + message + "');", true);
        }



    }
}