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
        protected void ButtonInsertarConvenio_Click(object sender, EventArgs e)
        {
            if (PanelInsertarConvenio.Visible)
            {
                // Si el panel es visible, ocultarlo y cambiar el texto del botón a "Mostrar"
                PanelInsertarConvenio.Visible = false;
                GridView1.Visible = true;
                ButtonFiltros.Visible = true;
                ButtonInsertarConvenio.Text = "Insertar Convenio";
                GridView1.SelectedIndex = -1;
            }
            else
            {
                // Si el panel no es visible, mostrarlo y cambiar el texto del botón a "Ocultar"
                PanelInsertarConvenio.Visible = true;

                PanelFiltros.Visible = false;
                ButtonFiltros.Text = "Mostrar filtros";
                ButtonFiltros.Visible = false;
                PanelInsertarAsociacion.Visible = false;
                GridView1.Visible = false;
                ButtonInsertarConvenio.Text = "Ocultar";
            }
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            ButtonVolver.Visible = true;

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
                SqlDataSource1.DataBind();

                SqlDataSource2.SelectCommand = "Select * FROM AsociacionCostes WHERE codigoConvenio=" + codigoConvenioInt;
                SqlDataSource2.DataBind();
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
            ButtonVolver.Visible = false;
            ButtonInsertarConvenio.Visible = true;
            ButtonInsertarAsociacion.Visible = false;
            GridView1.SelectedIndex = -1;

            ButtonInsertarConvenio.Text = "Insertar Convenio";
            SqlDataSource1.SelectCommand = "Select * FROM Convenio order by codigoConvenio DESC";
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
            //    String consultaSQL = "SELECT * FROM Convenio WHERE nombreConvenio LIKE '%" + TextBoxFiltradoConvenio.Text + "%'";

            //    if (fechaMinima.Value != "")
            //        consultaSQL += " AND fechaInicio >= '" + fechaMinima.Value + "'";

            //    if (fechaMaxima.Value != "")
            //        consultaSQL += " AND fechaFin <= '" + fechaMaxima.Value + "'";

            //    SqlDataSource1.SelectCommand = consultaSQL;
            //    SqlDataSource1.DataBind();
        }

        protected void Todos_Click(object sender, EventArgs e)
        {
            //    SqlDataSource1.SelectCommand = "SELECT * FROM Convenio";
            //    SqlDataSource1.DataBind();
            //    TextBoxFiltradoConvenio.Text = "";
            //    fechaMinima.Value = "";
            //    fechaMaxima.Value = "";
        }

}
}