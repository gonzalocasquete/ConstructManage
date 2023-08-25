using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace tfgASPX2.Views.Super
{
    public partial class GestionarTrabajadores : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ButtonInsertarTrabajador_Click(object sender, EventArgs e)
        {
            if (PanelInsertar.Visible)
            {
                // Si el panel es visible, ocultarlo y cambiar el texto del botón a "Mostrar"
                PanelInsertar.Visible = false;
                GridView1.Visible = true;
                ButtonFiltros.Visible = true;
                ButtonInsertarUsuario.Visible = false;
                PanelInsertarUsuario.Visible = false;
                ButtonInsertarTrabajador.Text = "Insertar";
            }
            else
            {
                // Si el panel no es visible, mostrarlo y cambiar el texto del botón a "Ocultar"
                PanelInsertar.Visible = true;
                ButtonInsertarUsuario.Visible = true;
                PanelFiltros.Visible = false;
                ButtonFiltros.Text = "Mostrar filtros";
                ButtonFiltros.Visible = false;

                GridView1.Visible = false;
                ButtonInsertarTrabajador.Text = "Volver";
            }
        }

        protected void ButtonInsertarUsuario_Click(object sender, EventArgs e)
        {
            if (PanelInsertarUsuario.Visible)
            {
                PanelInsertarUsuario.Visible = false;
                ButtonInsertarUsuario.Text = "Insertar Usuario";
            }
            else
            {
                PanelInsertarUsuario.Visible = true;
                ButtonInsertarUsuario.Text = "Ocultar Usuario";
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
            string trabajador = CheckBoxTrabajador.Checked ? "trabajador" : null;
            string coordinador = CheckBoxCoordinador.Checked ? "coordinador" : null;
            string super = CheckBoxSuper.Checked ? "super" : null;

            String consultaSQL = "SELECT Trabajador.codigoTrabajador, Trabajador.nombre, Trabajador.apellido, Trabajador.codigoUsuario, Trabajador.codigoCategoria, Usuario.nombreUsuario, CategoriaProfesional.nombreCategoria, Usuario.rol " +
                "FROM Trabajador INNER JOIN Usuario ON Trabajador.codigoUsuario = Usuario.codigoUsuario INNER JOIN CategoriaProfesional ON Trabajador.codigoCategoria = CategoriaProfesional.codigoCategoria " +
                "WHERE Trabajador.nombre LIKE '%" + TextBoxFiltradoNombre.Text + "%' OR Trabajador.apellido LIKE '%" + TextBoxFiltradoApellido.Text + "%' AND (Usuario.rol='" + trabajador + "' OR Usuario.rol='" + coordinador + "' OR Usuario.rol='" + super + "')";

            if (DropDownListCategorias.SelectedValue != "")
                consultaSQL += " AND Trabajador.codigoCategoria = " + DropDownListCategorias.SelectedValue + "";

            SqlDataSource1.SelectCommand = consultaSQL;
            SqlDataSource1.DataBind();
        }



        protected void Limpiar_Click(object sender, EventArgs e)
        {
            SqlDataSource1.SelectCommand = "SELECT Trabajador.codigoTrabajador, Trabajador.nombre, Trabajador.apellido, Trabajador.codigoUsuario, Trabajador.codigoCategoria, Usuario.nombreUsuario, CategoriaProfesional.nombreCategoria, Usuario.rol FROM Trabajador INNER JOIN Usuario ON Trabajador.codigoUsuario = Usuario.codigoUsuario INNER JOIN CategoriaProfesional ON Trabajador.codigoCategoria = CategoriaProfesional.codigoCategoria";
            SqlDataSource1.DataBind();

            TextBoxFiltradoNombre.Text = "";
            TextBoxFiltradoApellido.Text = "";
            DropDownListCategorias.SelectedIndex = 0;
            CheckBoxTrabajador.Checked = false;
            CheckBoxCoordinador.Checked = false;
            CheckBoxSuper.Checked = false;
        }


        protected void FormViewInsertarTrabajador_ItemCommand(object sender, FormViewCommandEventArgs e)
        {
            if (e.CommandName == "Cancel")
            {
                PanelInsertarUsuario.Visible = false;
                ButtonInsertarUsuario.Visible = false;
                ButtonInsertarUsuario.Text = "Insertar Usuario";
                PanelInsertar.Visible = false;
                GridView1.Visible = true;
                ButtonFiltros.Visible = true;
                ButtonInsertarTrabajador.Text = "Insertar Trabajador";
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

        protected void FormViewInsertarTrabajador_ItemInserting(object sender, FormViewInsertEventArgs e)
        {
            // Validar que los campos necesarios no estén vacíos o con valor inválido
            TextBox nombreTextBox = (TextBox)FormViewInsertarTrabajador.FindControl("nombreTextBox");
            TextBox apellidoTextBox = (TextBox)FormViewInsertarTrabajador.FindControl("apellidoTextBox");
            DropDownList idUsuariosDropDownList = (DropDownList)FormViewInsertarTrabajador.FindControl("idUsuariosDropDownList");
            DropDownList idCategoriasDropDownList = (DropDownList)FormViewInsertarTrabajador.FindControl("idCategoriasDropDownList");

            if (string.IsNullOrEmpty(nombreTextBox.Text) || string.IsNullOrEmpty(apellidoTextBox.Text) ||
                idUsuariosDropDownList.SelectedIndex == 0 || idCategoriasDropDownList.SelectedIndex == 0)
            {
                e.Cancel = true; // Cancelar la inserción
                                 // Mostrar mensaje de error
                ScriptManager.RegisterStartupScript(this, GetType(), "Error", "alert('Todos los campos deben ser completados.');", true);
            }
        }

        protected void FormViewInsertarTrabajador_ItemInserted(object sender, FormViewInsertedEventArgs e)
        {
            if (e.Exception == null)
            {
                // Mostrar mensaje de éxito
                ScriptManager.RegisterStartupScript(this, GetType(), "Success", "alert('Trabajador insertado exitosamente.');", true);
            }
            else
            {
                // Mostrar mensaje de error en caso de excepción
                ScriptManager.RegisterStartupScript(this, GetType(), "Error", "alert('Error al insertar trabajador.');", true);
                e.ExceptionHandled = true;
            }
        }

        protected void FormViewInsertarUsuario_ItemCommand(object sender, FormViewCommandEventArgs e)
        {
            if (e.CommandName == "Cancel")
            {
                PanelInsertarUsuario.Visible = false;
                ButtonInsertarUsuario.Text = "Insertar Usuario";
            }
        }
    }
}