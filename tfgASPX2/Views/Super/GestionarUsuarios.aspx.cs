using System;
using System.Collections.Generic;
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

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (Panel1.Visible)
            {
                // Si el panel es visible, ocultarlo y cambiar el texto del botón a "Mostrar"
                Panel1.Visible = false;
                ButtonInsertar.Text = "Insertar";
            }
            else
            {
                // Si el panel no es visible, mostrarlo y cambiar el texto del botón a "Ocultar"
                Panel1.Visible = true;
                ButtonInsertar.Text = "Ocultar";
            }
        }

        protected void ButtonFiltrado_Click(object sender, EventArgs e)
        {
            string trabajador, coordinador, super;

            trabajador = CheckBoxTrabajador.Checked ? "trabajador" : null;
            coordinador = CheckBoxCoordinador.Checked ? "coordinador" : null;
            super = CheckBoxSuper.Checked ? "super" : null;

            if (trabajador == null && coordinador == null && super == null)
            {
                SqlDataSource1.SelectCommand = "SELECT * FROM Usuario WHERE (nombreUsuario LIKE '%" + TextBoxFiltradoUsuario.Text.ToString() +
                "%')";
            }
            else { 
            SqlDataSource1.SelectCommand = "SELECT * FROM Usuario WHERE (nombreUsuario LIKE '%" + TextBoxFiltradoUsuario.Text.ToString() +
                "%' AND rol='"+trabajador+"' OR rol='"+coordinador+"' OR rol='"+super+"')";
            }
 
            SqlDataSource1.DataBind();
        }

        protected void Limpiar_Click(object sender, EventArgs e)
        {
            SqlDataSource1.SelectCommand = "SELECT * FROM Usuario ORDER BY codigoUsuario";
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

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            // Verifica si es una fila de datos y no es la fila de encabezado o pie de página.
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Obtiene los valores de nombreUsuario y rol de la fila actual.
                string nombreUsuario = DataBinder.Eval(e.Row.DataItem, "nombreUsuario").ToString();
                string rol = DataBinder.Eval(e.Row.DataItem, "rol").ToString();

                // Verifica si los valores de nombreUsuario y rol son "super".
                if (nombreUsuario == "super" && rol == "super")
                {
                    // Deshabilita la edición de la fila.
                    e.Row.Enabled = false;
                    e.Row.Attributes["style"] = "background-color: #f2f2f2;"; // Cambia el color de fondo de la fila para indicar que está deshabilitada.

                    // Encuentra el control del botón de edición y establece el texto como una cadena vacía.
                    LinkButton editButton = e.Row.Cells[e.Row.Cells.Count - 2].Controls[0] as LinkButton; // El botón de edición es el penúltimo control en la fila.
                    if (editButton != null)
                    {
                        editButton.Text = "";
                    }

                    // Encuentra el control del botón de eliminación y establece el texto como una cadena vacía.
                    LinkButton deleteButton = e.Row.Cells[e.Row.Cells.Count - 1].Controls[0] as LinkButton; // El botón de eliminación es el último control en la fila.
                    if (deleteButton != null)
                    {
                        deleteButton.Text = "";
                    }
                }
            }
        }
    }
}