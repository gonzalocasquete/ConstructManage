using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace tfgASPX2.Views.Super
{
    public partial class GestionarUsuarios : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                SqlDataSource1.SelectCommand = Session["consultaSQL"].ToString();
            }
            else
            {
                Session["consultaSQL"] = "SELECT * FROM [Usuario]";                   
            }
        }
      
        protected void Button1_Click(object sender, EventArgs e)
        {
            if (Panel1.Visible)
            {
                // Si el panel es visible, ocultarlo y cambiar el texto del botón a "Mostrar"
                Panel1.Visible = false;
                GridView1.Visible = true;
                ButtonFiltros.Visible = true;
                ButtonInsertar.Text = "Insertar Usuario";
            }
            else
            {
                // Si el panel no es visible, mostrarlo y cambiar el texto del botón a "Ocultar"
                Panel1.Visible = true;

                PanelFiltros.Visible = false;
                ButtonFiltros.Text = "Mostrar filtros";
                ButtonFiltros.Visible = false;

                GridView1.Visible=false;
                ButtonInsertar.Text = "Ocultar";
            }
        }

        protected void ButtonFiltrado_Click(object sender, EventArgs e)
        {
            string trabajador, coordinador, super, consultaSQL ;

            trabajador = CheckBoxTrabajador.Checked ? "trabajador" : null;
            coordinador = CheckBoxCoordinador.Checked ? "coordinador" : null;
            super = CheckBoxSuper.Checked ? "admin" : null;

            if (trabajador == null && coordinador == null && super == null)
            {
                consultaSQL= "SELECT * FROM Usuario WHERE (nombreUsuario LIKE '%" + TextBoxFiltradoUsuario.Text.ToString() +
                "%')";
                
            }
            else { 
           consultaSQL= "SELECT * FROM Usuario WHERE (nombreUsuario LIKE '%" + TextBoxFiltradoUsuario.Text.ToString() +
                "%' AND rol='"+trabajador+"' OR rol='"+coordinador+"' OR rol='"+super+"')";
            }

            SqlDataSource1.SelectCommand = consultaSQL;
            Session["consultaSQL"] = consultaSQL;
            SqlDataSource1.DataBind();
        }

        protected void Limpiar_Click(object sender, EventArgs e)
        {
            SqlDataSource1.SelectCommand = "SELECT * FROM Usuario ORDER BY codigoUsuario";
            Session["consultaSQL"] = "SELECT * FROM Usuario ORDER BY codigoUsuario";
            SqlDataSource1.DataBind();
            TextBoxFiltradoUsuario.Text = "";
            CheckBoxTrabajador.Checked = false;
            CheckBoxCoordinador.Checked = false;
            CheckBoxSuper.Checked = false;
        }

        protected void ButtonFiltros_Click(object sender, EventArgs e)
        {
            if (!PanelFiltros.Visible)
            {
                PanelFiltros.Visible = true;
                ButtonFiltros.Text = "Ocultar filtros";
            }
            else {

                PanelFiltros.Visible = false;
                ButtonFiltros.Text = "Mostrar filtros";
            }
        }

        //No se permite editar al usuario admin 
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            // Verifica si es una fila de datos y no es la fila de encabezado o pie de página.
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Obtiene los valores de nombreUsuario y rol de la fila actual.
                string nombreUsuario = DataBinder.Eval(e.Row.DataItem, "nombreUsuario").ToString();
                string rol = DataBinder.Eval(e.Row.DataItem, "rol").ToString();

                // Verifica si los valores de nombreUsuario y rol son "super".
                if (nombreUsuario == "admin" && rol == "admin")
                {
                    // Deshabilita la edición y eliminación de la fila.
                    e.Row.Enabled = false;
                    e.Row.Attributes["style"] = "background-color: #f2f2f2;"; // Cambia el color de fondo de la fila para indicar que está deshabilitada.

                    // Encuentra el control del botón de edición y establece el texto como una cadena vacía.
                    LinkButton editButton = e.Row.Cells[e.Row.Cells.Count - 1].Controls[0] as LinkButton; // El botón de edición es el penúltimo control en la fila.
                    if (editButton != null)
                    {
                        editButton.Text = "";
                    }

                    // Encuentra el control del botón de eliminación y establece el texto como una cadena vacía.
                    LinkButton deleteButton = e.Row.Cells[e.Row.Cells.Count-1].Controls[2] as LinkButton; // El botón de eliminación es el último control en la fila.
                    if (deleteButton != null)
                    {
                        deleteButton.Text = "";
                    }
                }
            }
        }
 
        protected void FormViewInsertarUsuario_ItemInserted(object sender, FormViewInsertedEventArgs e)
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

        protected void FormViewInsertarUsuario_ItemCommand(object sender, FormViewCommandEventArgs e)
        {
            if (e.CommandName == "Cancel")
            {
                Panel1.Visible = false;
                GridView1.Visible = true;
                ButtonFiltros.Visible = true;
                ButtonInsertar.Text = "Insertar Usuario";
            }
        }

        protected void FormViewInsertarUsuario_ItemInserting(object sender, FormViewInsertEventArgs e)
        {
            TextBox nombreUsuarioTextBox = (TextBox)FormViewInsertarUsuario.FindControl("nombreUsuarioTextBox");
            TextBox contraseñaUsuarioTextBox = (TextBox)FormViewInsertarUsuario.FindControl("contraseñaUsuarioTextBox");

            if (string.IsNullOrEmpty(nombreUsuarioTextBox.Text) || string.IsNullOrEmpty(contraseñaUsuarioTextBox.Text))
            {
                if (string.IsNullOrEmpty(nombreUsuarioTextBox.Text))
                {
                    // Cancelar la inserción
                    e.Cancel = true;
                    // Mostrar mensaje de error
                    ScriptManager.RegisterStartupScript(this, GetType(), "Error", "alert('El usuario no puede estar vacio.');", true);
                }

                if (string.IsNullOrEmpty(contraseñaUsuarioTextBox.Text))
                {
                    // Cancelar la inserción
                    e.Cancel = true;
                    // Mostrar mensaje de error
                    ScriptManager.RegisterStartupScript(this, GetType(), "Error", "alert('La contraseña no puede estar vacia');", true);
                }
            }

            string consulta = "SELECT nombreUsuario FROM Usuario WHERE nombreUsuario = @nombreUsuario";

            string connectionString = "Data Source=miservertfg.database.windows.net;Initial Catalog=mibasededatostfg;Persist Security Info=True;User ID=adminsql;Password=Josele6072";

            using (SqlConnection cnn = new SqlConnection(connectionString))
            {
                cnn.Open();
                using (SqlCommand cmd = new SqlCommand(consulta, cnn))
                {
                    cmd.Parameters.AddWithValue("@nombreUsuario", nombreUsuarioTextBox.Text.ToString());

                    using (SqlDataReader adap = cmd.ExecuteReader())
                    {
                        if (adap.Read())
                        {
                            e.Cancel = true;
                            ScriptManager.RegisterStartupScript(this, GetType(), "Error", "alert('El nombre de usuario ya se encuentra registrado');", true);
                        }
                    }
                }
            }
        }

    }
}