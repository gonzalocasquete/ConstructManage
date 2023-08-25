using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace tfgASPX2.Views.Super
{
    public partial class GestionarCategoriasProfesionales : System.Web.UI.Page
    {
       
        protected void Page_Load(object sender, EventArgs e)
        {
         
        }

        protected void ButtonInsertarCategoria_Click(object sender, EventArgs e)
        {
            if (PanelInsertarCategoria.Visible)
            {
                // Si el panel es visible, ocultarlo y cambiar el texto del botón a "Mostrar"
                PanelInsertarCategoria.Visible = false;
                GridView1.Visible = true;
                ButtonFiltros.Visible = true;
                ButtonInsertarCategoria.Text = "Insertar Categoria";

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
            SqlDataSource1.SelectCommand = "SELECT * FROM CategoriaProfesional WHERE (nombreCategoria LIKE '%" + TextBoxFiltrado.Text.ToString() + "%')";
            SqlDataSource1.DataBind();
        }

        protected void Todos_Click(object sender, EventArgs e)
        {
            SqlDataSource1.SelectCommand = "SELECT * FROM CategoriaProfesional";
            SqlDataSource1.DataBind();
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            TextBox codigoProyecto = (TextBox)this.FormViewInsertarAsociacion.FindControl("codigoCategoriaTextBox");
            int codigo = Convert.ToInt32(this.GridView1.SelectedDataKey["codigoCategoria"]);
            codigoProyecto.Text = codigo.ToString();

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
                SqlDataSource1.DataBind();

                SqlDataSource2.SelectCommand = "Select * FROM AsociacionCostes WHERE codigoCategoria=" + codigoCategoriaInt;
                SqlDataSource2.DataBind();
            }
        }

        protected void FormViewInsertarCategoria_ItemInserting(object sender, FormViewInsertEventArgs e)
        {
            TextBox nombreCategoriaTextBox = (TextBox)FormViewInsertarCategoria.FindControl("nombreCategoriaTextBoxInsertar");

            if (string.IsNullOrEmpty(nombreCategoriaTextBox.Text) )
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

            ButtonInsertarCategoria.Text = "Insertar Asociacion";
            SqlDataSource1.SelectCommand = "Select * FROM CategoriaProfesional order by codigoCategoria DESC";
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
    }
}