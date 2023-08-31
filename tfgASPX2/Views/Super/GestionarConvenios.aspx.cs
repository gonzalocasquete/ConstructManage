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
    public partial class GestionarConvenios : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                SqlDataSource1.SelectCommand = Session["consultaSQL"].ToString();
            }
            else
            {
                if (Session["rol"] == null || Session["rol"].ToString() != "admin")
                    Response.Redirect("../Login.aspx");

                Session["consultaSQL"] = "Select * FROM Convenio order by codigoConvenio DESC";
            }
        }
        protected void ButtonInsertarConvenio_Click(object sender, EventArgs e)
        {  
            if (PanelInsertarConvenio.Visible)
            {
                // Si el panel es visible, ocultarlo y cambiar el texto del botón a "Mostrar"
                PanelInsertarConvenio.Visible = false;
                PanelInsertarAsociacion.Visible = false;
                GridView2.Visible = false;
                GridView1.Visible = true;
                ButtonFiltros.Visible = true;
                ButtonInsertarConvenio.Text = "Insertar Convenio";
                GridView1.SelectedIndex = -1;
                SqlDataSource1.SelectCommand = "Select * FROM Convenio order by codigoConvenio DESC";
                Session["consultaSQL"] = "Select * FROM Convenio order by codigoConvenio DESC";
                SqlDataSource1.DataBind();
            }
            else
            {
                // Si el panel no es visible, mostrarlo y cambiar el texto del botón a "Ocultar"
                PanelInsertarConvenio.Visible = true;
                GridView1.Visible = false;
                GridView2.Visible = false;
                PanelFiltros.Visible = false;
                ButtonFiltros.Text = "Mostrar filtros";
                ButtonFiltros.Visible = false;
                PanelInsertarAsociacion.Visible = false;
                ButtonInsertarAsociacion.Visible = false;
                ButtonVolver.Visible = false;
                ButtonInsertarConvenio.Text = "Ocultar";
            }
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {

            TextBox codigoConvenio = (TextBox)this.FormViewInsertarAsociacion.FindControl("codigoConvenioTextBoxInsertarAsociacion");
            int codigo = Convert.ToInt32(this.GridView1.SelectedDataKey["codigoConvenio"]);
            codigoConvenio.Text = codigo.ToString();

            ButtonVolver.Visible = true;
            ButtonFiltros.Visible = false;
            PanelMostrarAsociaciones.Visible = true;
            PanelInsertarConvenio.Visible = false;
            PanelInsertarAsociacion.Visible = false;
            ButtonInsertarAsociacion.Visible = true;
            ButtonInsertarConvenio.Text = "Insertar Convenio";
            ButtonInsertarAsociacion.Text = "Insertar Asociacion";

            if (GridView1.SelectedIndex >= 0)
            {
                int rowIndex = GridView1.SelectedIndex;
                string codigoConvenioStr = GridView1.DataKeys[rowIndex]["codigoConvenio"].ToString();
                int.TryParse(codigoConvenioStr, out int codigoConvenioInt);
                SqlDataSource1.SelectCommand = "Select * FROM Convenio WHERE codigoConvenio=" + codigoConvenioInt;
                Session["consultaSQL"] = "Select * FROM Convenio WHERE codigoConvenio=" + codigoConvenioInt;
                SqlDataSource1.DataBind();
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

        protected void ButtonVolver_Click(object sender, EventArgs e)
        {
            PanelInsertarAsociacion.Visible = false;
            ButtonVolver.Visible = false;
            ButtonInsertarConvenio.Visible = true;
            ButtonInsertarAsociacion.Visible = false;
            GridView1.SelectedIndex = -1;
            ButtonFiltros.Visible = true;

            ButtonInsertarConvenio.Text = "Insertar Convenio";
            SqlDataSource1.SelectCommand = "Select * FROM Convenio order by codigoConvenio DESC";
            Session["consultaSQL"]= "Select * FROM Convenio order by codigoConvenio DESC";
            SqlDataSource1.DataBind();
        }

        protected void ButtonInsertarAsociacion_Click(object sender, EventArgs e)
        {
            if (PanelInsertarAsociacion.Visible)
            {
                PanelMostrarAsociaciones.Visible = true;
                PanelInsertarConvenio.Visible = false;
                ButtonInsertarAsociacion.Text = "Insertar Asociacion";
            }
            else
            {
                PanelInsertarAsociacion.Visible = true;
                PanelMostrarAsociaciones.Visible = false;
                ButtonInsertarAsociacion.Text = "Ocultar";
                if (GridView1.SelectedIndex >= 0)
                {
                    int rowIndex = GridView1.SelectedIndex;
                    string codigoConvenioStr = GridView1.DataKeys[rowIndex]["codigoConvenio"].ToString();
                    int.TryParse(codigoConvenioStr, out int codigoConvenio);
                }
            }
        }

        protected void ButtonFiltrado_Click(object sender, EventArgs e)
        {
            String consultaSQL = "SELECT * FROM Convenio WHERE nombreConvenio LIKE '%" + TextBoxFiltradoConvenio.Text + "%'";

            if (fechaMinima.Value != "")
                consultaSQL += " AND fechaInicio >= '" + fechaMinima.Value + "'";

            if (fechaMaxima.Value != "")
                consultaSQL += " AND fechaFin <= '" + fechaMaxima.Value + "'";

            SqlDataSource1.SelectCommand = consultaSQL;
            Session["consultaSQL"] = consultaSQL;
            SqlDataSource1.DataBind();
        }

        protected void Todos_Click(object sender, EventArgs e)
        {
            SqlDataSource1.SelectCommand = "SELECT * FROM Convenio order by codigoConvenio DESC";
            Session["consultaSQL"] = "SELECT * FROM Convenio order by codigoConvenio DESC";
            SqlDataSource1.DataBind();
            TextBoxFiltradoConvenio.Text = "";
            fechaMinima.Value = "";
            fechaMaxima.Value = "";
        }

       

        protected void FormViewInsertarAsociacion_ItemCommand(object sender, FormViewCommandEventArgs e)
        {
            if (e.CommandName == "Cancel")
            {
                PanelMostrarAsociaciones.Visible = true;
                PanelInsertarAsociacion.Visible = false;
                ButtonInsertarAsociacion.Text = "Insertar Asociacion";

                PanelInsertarConvenio.Visible = false;

                GridView1.Visible = true;
                ButtonInsertarAsociacion.Visible = true;
                ButtonFiltros.Visible = false;
                ButtonInsertarConvenio.Text = "Insertar Convenio";
            }
        }

        protected void FormViewInsertarConvenio_ItemCommand(object sender, FormViewCommandEventArgs e)
        {
            if (e.CommandName == "Cancel")
            {
                PanelInsertarConvenio.Visible = false;
                PanelInsertarAsociacion.Visible = false;
                GridView2.Visible = false;
                GridView1.Visible = true;
                ButtonFiltros.Visible = true;
                ButtonInsertarConvenio.Text = "Insertar Convenio";
                GridView1.SelectedIndex = -1;
                SqlDataSource1.SelectCommand = "Select * FROM Convenio order by codigoConvenio DESC";
                Session["consultaSQL"]= "Select * FROM Convenio order by codigoConvenio DESC";
                SqlDataSource1.DataBind();
            }
        }

        protected void FormViewInsertarConvenio_ItemInserting(object sender, FormViewInsertEventArgs e)
        {
            TextBox nombreConvenioTextBox = (TextBox)FormViewInsertarConvenio.FindControl("nombreConvenioTextBoxInsertarConvenio");
            HtmlInputGenericControl fechaInicioInput = (HtmlInputGenericControl)FormViewInsertarConvenio.FindControl("fechaInicioTextBoxInsertarConvenio");
            HtmlInputGenericControl fechaFinInput = (HtmlInputGenericControl)FormViewInsertarConvenio.FindControl("fechaFinTextBoxInsertarConvenio");

            string fechaFin = fechaFinInput.Value.ToString(); ;
            string fechaInicio = fechaInicioInput.Value.ToString();
            string nombreConvenio = nombreConvenioTextBox.Text;

            if (string.IsNullOrEmpty(nombreConvenio) || string.IsNullOrEmpty(fechaInicio) || string.IsNullOrEmpty(fechaFin))
            {
                ShowErrorMessage("Todos los campos son obligatorios.");
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

        }

        protected void FormViewInsertarAsociacion_ItemInserting(object sender, FormViewInsertEventArgs e)
        {
            HtmlInputGenericControl horasMaximasInp = (HtmlInputGenericControl)FormViewInsertarAsociacion.FindControl("HorasMaxDiaInput");
            HtmlInputGenericControl precioHoraInp = (HtmlInputGenericControl)FormViewInsertarAsociacion.FindControl("PrecioHoraInput");
            HtmlInputGenericControl precioHoraExtraInp = (HtmlInputGenericControl)FormViewInsertarAsociacion.FindControl("PrecioHoraExtraInput");

            string horasMaximas = horasMaximasInp.Value.ToString();
            string precioHora = precioHoraInp.Value.ToString();
            string precioHoraExtra = precioHoraExtraInp.Value.ToString();

            if (string.IsNullOrEmpty(horasMaximas) || string.IsNullOrEmpty(precioHora) || string.IsNullOrEmpty(precioHoraExtra))
            {
                ShowErrorMessage("Todos los campos son obligatorios.");
                e.Cancel = true;
                return;
            }

            if (!float.TryParse(horasMaximas, out float horasMaximaFloat))
            {
                ShowErrorMessage("Las horas máximas deben ser un número válido.");
                e.Cancel = true;
                return;
            }

            if (!float.TryParse(precioHora, out float precioHoraFloat))
            {
                ShowErrorMessage("El precio hora debe ser un número válido.");
                e.Cancel = true;
                return;
            }

            if (!float.TryParse(precioHoraExtra, out float precioHoraExtraFloat))
            {
                ShowErrorMessage("El precio hora extra debe ser un número válido.");
                e.Cancel = true;
                return;
            }
        }

        private void ShowErrorMessage(string message)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "Error", "alert('" + message + "');", true);
        }

    }
}