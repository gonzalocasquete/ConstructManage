using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace tfgASPX2.Views.Super
{
    public partial class GestionarCategoriasProfesionales : System.Web.UI.Page
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
                Session["consultaSQL"] = "SELECT * FROM [CategoriaProfesional] order by codigoCategoria DESC";
            }
        }

        protected void ButtonInsertarCategoria_Click(object sender, EventArgs e)
        {
            PanelInsertarAsociacion.Visible = false;
            if (PanelInsertarCategoria.Visible)
            {
                // Si el panel es visible, ocultarlo y cambiar el texto del botón a "Mostrar"
                
                PanelInsertarCategoria.Visible = false;
                GridView1.Visible = true;
                ButtonFiltros.Visible = true;
                ButtonInsertarCategoria.Text = "Insertar Categoria";
                Session["consultaSQL"] = "SELECT * FROM CategoriaProfesional order by codigoCategoria DESC";
                PanelInsertarCategoria.Visible = false;
                PanelMostrarAsociaciones.Visible = false;
                ButtonInsertarAsociacion.Visible = false;
                ButtonVolver.Visible = false;
            }
            else
            {
                // Si el panel no es visible, mostrarlo y cambiar el texto del botón a "Ocultar"
                PanelInsertarCategoria.Visible = true;
                PanelMostrarAsociaciones.Visible=false;
                ButtonInsertarAsociacion.Visible = false;
                ButtonVolver.Visible = false;

                PanelFiltros.Visible = false;
                ButtonFiltros.Text = "Mostrar filtros";
                ButtonFiltros.Visible = false;

                GridView1.Visible = false;
                ButtonInsertarCategoria.Text = "Ocultar";
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
            string consultaSQL= "SELECT * FROM CategoriaProfesional WHERE (nombreCategoria LIKE '%" + TextBoxFiltrocategoria.Text.ToString() + "%')";
            SqlDataSource1.SelectCommand = consultaSQL;
            Session["consultaSQL"] = consultaSQL;
            SqlDataSource1.DataBind();
        }

        protected void Todos_Click(object sender, EventArgs e)
        {
            SqlDataSource1.SelectCommand = "SELECT * FROM CategoriaProfesional order by codigoCategoria DESC";
            Session["consultaSQL"] = "SELECT * FROM CategoriaProfesional order by codigoCategoria DESC";
            TextBoxFiltrocategoria.Text = "";
            SqlDataSource1.DataBind();
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            TextBox codigoCategoria = (TextBox)this.FormViewInsertarAsociacion.FindControl("codigoCategoriaTextBoxInsertarAsociacion");
            int codigo = Convert.ToInt32(this.GridView1.SelectedDataKey["codigoCategoria"]);
            codigoCategoria.Text = codigo.ToString();

            ButtonVolver.Visible = true;

            PanelMostrarAsociaciones.Visible = true;
            PanelInsertarCategoria.Visible = false;
            PanelInsertarAsociacion.Visible = false;
            ButtonInsertarAsociacion.Visible = true;
            ButtonInsertarCategoria.Text = "Insertar Categoria";
            ButtonInsertarAsociacion.Text = "Insertar Asociacion";

            if (GridView1.SelectedIndex >= 0)
            {
                int rowIndex = GridView1.SelectedIndex;
                string codigoCategoriaStr = GridView1.DataKeys[rowIndex]["codigoCategoria"].ToString();
                int.TryParse(codigoCategoriaStr, out int codigoCategoriaInt);
                SqlDataSource1.SelectCommand = "Select * FROM CategoriaProfesional WHERE codigoCategoria=" + codigoCategoriaInt;
                Session["consultaSQL"]= "Select * FROM CategoriaProfesional WHERE codigoCategoria=" + codigoCategoriaInt;
                SqlDataSource1.DataBind();

                SqlDataSource2.SelectCommand = "Select * FROM AsociacionCostes WHERE codigoCategoria=" + codigoCategoriaInt;
                SqlDataSource2.DataBind();
            }
        }

        protected void ButtonInsertarAsociacion_Click(object sender, EventArgs e)
        {
            if (PanelInsertarAsociacion.Visible)
            {
                PanelMostrarAsociaciones.Visible = true;
                PanelInsertarAsociacion.Visible = false;
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
                    string codigoProyectoStr = GridView1.DataKeys[rowIndex]["codigoCategoria"].ToString();
                    int.TryParse(codigoProyectoStr, out int codigoProyecto);
                }
            }
        }

        protected void ButtonVolver_Click(object sender, EventArgs e)
        {
            ButtonVolver.Visible = false;
            ButtonInsertarAsociacion.Visible = false;
            GridView1.SelectedIndex = -1;
            PanelInsertarAsociacion.Visible = false;

            ButtonInsertarCategoria.Text = "Insertar Asociacion";
            SqlDataSource1.SelectCommand = "Select * FROM CategoriaProfesional order by codigoCategoria DESC";
            Session["consultaSQL"]= "Select * FROM CategoriaProfesional order by codigoCategoria DESC";
            SqlDataSource1.DataBind();
        }
        protected void FormViewInsertarCategoria_ItemInserted(object sender, FormViewInsertedEventArgs e)
        {
            if (e.Exception == null)
            {
                // Mostrar mensaje de éxito
                ScriptManager.RegisterStartupScript(this, GetType(), "Success", "alert('Usuario insertado exitosamente.');", true);
            }
            else
            {
                // Mostrar mensaje de error en caso de excepción
                ScriptManager.RegisterStartupScript(this, GetType(), "Error", "alert('Error al insertar usuario.');", true);
                e.ExceptionHandled = true;
            }
        }

        protected void FormViewInsertarCategoria_ItemCommand(object sender, FormViewCommandEventArgs e)
        {
            if (e.CommandName == "Cancel")
            {
                PanelInsertarCategoria.Visible = false;
                GridView1.Visible = true;
                ButtonFiltros.Visible = true;
                ButtonInsertarCategoria.Text = "Insertar Categoria";
            }
        }
 
        protected void FormViewInsertarAsociacion_ItemCommand(object sender, FormViewCommandEventArgs e)
        {
            if (e.CommandName == "Cancel")
            {
                PanelMostrarAsociaciones.Visible = true;
                PanelInsertarAsociacion.Visible = false;
                ButtonInsertarAsociacion.Text = "Insertar Asociacion";

                PanelInsertarCategoria.Visible = false;

                GridView1.Visible = true;
                ButtonInsertarAsociacion.Visible = true;
                ButtonFiltros.Visible = false;
                ButtonInsertarCategoria.Text = "Insertar Categoria";
            }
        }

        protected void FormViewInsertarCategoria_ItemInserting(object sender, FormViewInsertEventArgs e)
        {
            TextBox nombreCategoriaTextBox = (TextBox)FormViewInsertarCategoria.FindControl("nombreCategoriaTextBoxInsertar");

            if (string.IsNullOrEmpty(nombreCategoriaTextBox.Text))
            {
                // Cancelar la inserción
                e.Cancel = true;
                // Mostrar mensaje de error
                ScriptManager.RegisterStartupScript(this, GetType(), "Error", "alert('El nombre de la categoria no puede estar vacia.');", true);
            }
            string consulta = "SELECT nombreCategoria FROM CategoriaProfesional WHERE nombreCategoria = @nombreCategoria";

            string connectionString = "Data Source=miservertfg.database.windows.net;Initial Catalog=mibasededatostfg;Persist Security Info=True;User ID=adminsql;Password=Josele6072";

            using (SqlConnection cnn = new SqlConnection(connectionString))
            {
                cnn.Open();
                using (SqlCommand cmd = new SqlCommand(consulta, cnn))
                {
                    cmd.Parameters.AddWithValue("@nombreCategoria", nombreCategoriaTextBox.Text.ToString());

                    using (SqlDataReader adap = cmd.ExecuteReader())
                    {
                        if (adap.Read())
                        {
                            e.Cancel = true;
                            ScriptManager.RegisterStartupScript(this, GetType(), "Error", "alert('La categoria profesional ya existe en la base de datos');", true);
                        }
                    }
                }
            }
        }

        protected void FormViewInsertarAsociacion_ItemInserting(object sender, FormViewInsertEventArgs e)
        {
            HtmlInputGenericControl horasMaximasInp = (HtmlInputGenericControl)FormViewInsertarAsociacion.FindControl("HorasMaxDiaInput");
            HtmlInputGenericControl precioHoraInp = (HtmlInputGenericControl)FormViewInsertarAsociacion.FindControl("PrecioHoraInput");
            HtmlInputGenericControl precioHoraExtraInp = (HtmlInputGenericControl)FormViewInsertarAsociacion.FindControl("PrecioHoraExtraInput");

            string horasMaximas = horasMaximasInp.Value.Trim();
            string precioHora = precioHoraInp.Value.Trim();
            string precioHoraExtra = precioHoraExtraInp.Value.Trim();

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

            if (horasMaximaFloat > 12.0f) // Verifica si las horas máximas superan 12 horas
            {
                ShowErrorMessage("Las horas máximas no pueden ser mayores a 12 horas.");
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