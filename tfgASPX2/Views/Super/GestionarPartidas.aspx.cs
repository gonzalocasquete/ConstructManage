using Org.BouncyCastle.Asn1.X509;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace tfgASPX2.Views.Super
{
    public partial class GestionarPartidas : System.Web.UI.Page
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

                Session["consultaSQL"] = "SELECT P.*, Pr.nombreProyecto FROM Partida P INNER JOIN Proyecto Pr ON P.codigoProyecto = Pr.codigoProyecto order by P.codigoPartida DESC;";
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (Panel1.Visible)
            {
                // Si el panel es visible, ocultarlo y cambiar el texto del botón a "Mostrar"
                ButtonFiltros.Visible = true;
                Panel1.Visible = false;
                GridView1.Visible = true;
                ButtonInsertar.Text = "Insertar";
            }
            else
            {
                // Si el panel no es visible, mostrarlo y cambiar el texto del botón a "Ocultar"
                ButtonFiltros.Visible = false;
                PanelFiltros.Visible = false;
                Panel1.Visible = true;
                GridView1.Visible = false;
                ButtonInsertar.Text = "Ocultar";
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
            String consultaSQL = "SELECT P.*, Pr.nombreProyecto FROM Partida P INNER JOIN Proyecto Pr ON P.codigoProyecto = Pr.codigoProyecto WHERE nombrePartida LIKE '%" + TextBoxFiltradoPartida.Text.ToString() + "%'";

            if (DropDownListProyectos.SelectedValue != "")
                consultaSQL += " AND P.codigoProyecto=" + DropDownListProyectos.SelectedValue +"";

            if (fechaInicio.Value != "")
                consultaSQL += " AND P.fechaInicio >= '" + fechaInicio.Value + "'";

            if (fechaFin.Value != "")
                consultaSQL += " AND P.FechaFin <= '" + fechaFin.Value + "'";

            if (presupuestoMinimo.Value.Length != 0)
                consultaSQL+=" AND P.Presupuesto>"+presupuestoMinimo.Value+"";

            if (presupuestoMaximo.Value.Length != 0)
                consultaSQL += " AND P.Presupuesto<" + presupuestoMaximo.Value + "";

            SqlDataSource1.SelectCommand = consultaSQL;
            Session["consultaSQL"] = consultaSQL;
            SqlDataSource1.DataBind();
        }

        protected void Todos_Click(object sender, EventArgs e)
        {
            SqlDataSource1.SelectCommand = "SELECT P.*, Pr.nombreProyecto FROM Partida P INNER JOIN Proyecto Pr ON P.codigoProyecto = Pr.codigoProyecto order by codigoPartida DESC;";
            Session["consultaSQL"]= "SELECT P.*, Pr.nombreProyecto FROM Partida P INNER JOIN Proyecto Pr ON P.codigoProyecto = Pr.codigoProyecto order by codigoPartida DESC;";
            SqlDataSource1.DataBind();
            TextBoxFiltradoPartida.Text = "";
            DropDownListProyectos.SelectedIndex = 0;
            fechaInicio.Value = "";
            fechaFin.Value = "";
            presupuestoMinimo.Value = null;
            presupuestoMaximo.Value = null;
         
        }

        protected void FormViewInsertarUsuario_ItemCommand(object sender, FormViewCommandEventArgs e)
        {
            if (e.CommandName == "Cancel")
            {
                Panel1.Visible = false;
                GridView1.Visible = true;
                ButtonFiltros.Visible = true;
                ButtonInsertar.Text = "Insertar";
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
                ShowErrorMessage("Todos los campos son obligatorios."+nombrePartida+" "+fechaInicio+" "+fechaFin+" "+presupuesto);
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
            ScriptManager.RegisterStartupScript(this, GetType(), "Error", "alert('"+message+"');", true);
        }

    }
}