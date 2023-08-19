using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace tfgASPX2.Views.Super
{
    public partial class GestionarConvenios : System.Web.UI.Page
    {
        protected void Button1_Click(object sender, EventArgs e)
        {
            if (Panel1.Visible)
            {
                Panel1.Visible = false;
                Panel2.Visible = true;
                ButtonInsertar.Text = "Ocultar";
            }
            else
            {
                Panel1.Visible = true;
                Panel2.Visible = false;
                ButtonInsertar.Text = "Insertar";
            }
        }

        protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
            if (Panel2.Visible)
            {
                Panel2.Visible = false;
                Panel1.Visible = true;
                ButtonInsertar.Text = "Insertar";
            }
            else
            {
                Panel1.Visible = true;
                Panel2.Visible = false;
                ButtonInsertar.Text = "Insertar";
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
            String consultaSQL = "SELECT * FROM Convenio WHERE nombre LIKE '%" + TextBoxFiltradoConvenio.Text + "%'";

            if (fechaMinima.Value != "")
                consultaSQL += " AND fechaInicio >= '" + fechaMinima.Value + "'";

            if (fechaMaxima.Value != "")
                consultaSQL += " AND fechaFin <= '" + fechaMaxima.Value + "'";

            SqlDataSource1.SelectCommand = consultaSQL;
            SqlDataSource1.DataBind();
        }

        protected void Todos_Click(object sender, EventArgs e)
        {
            SqlDataSource1.SelectCommand = "SELECT * FROM Convenio";
            SqlDataSource1.DataBind();
            TextBoxFiltradoConvenio.Text = "";
            fechaMinima.Value = "";
            fechaMaxima.Value = "";
        }

    }
}