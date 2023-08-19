using System;
using System.Collections.Generic;
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
    }
}