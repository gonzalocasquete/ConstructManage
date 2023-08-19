using System;
using System.Collections.Generic;
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

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (PanelInsertar.Visible)
            {
                // Si el panel es visible, ocultarlo y cambiar el texto del botón a "Mostrar"
                PanelInsertar.Visible = false;
                ButtonInsertar.Text = "Insertar";
            }
            else
            {
                // Si el panel no es visible, mostrarlo y cambiar el texto del botón a "Ocultar"
                PanelInsertar.Visible = true;
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
    }
}