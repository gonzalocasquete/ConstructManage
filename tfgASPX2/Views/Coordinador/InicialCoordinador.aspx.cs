using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace tfgASPX2.Views.Coordinador
{
    public partial class InicialCoordinador : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
          
        }


        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            PanelConsultarLineasParte.Visible = true;
            if (GridView1.SelectedIndex >= 0)
            {
                // Obtén el valor de codigoParte de la fila seleccionada
                string codigoParteSeleccionado = GridView1.SelectedDataKey["codigoParte"].ToString();

                // Establece el valor en el campo codigoParte del FormView
                TextBox codigoParteTextBox = FormViewInsertarLinea.FindControl("codigoParteTextBox") as TextBox;
                if (codigoParteTextBox != null)
                {
                    codigoParteTextBox.Text = codigoParteSeleccionado;
                }
            }
        }

        protected void ButtonInsertarParte_Click(object sender, EventArgs e)
        {
            if (!PanelInsertarParte.Visible)
            {
                PanelConsultarLineasParte.Visible=false;
                PanelInsertarParte.Visible = true;
                ButtonInsertarParte.Text = "Ocultar";
            }
            else {
                if(GridView2.Rows.Count !=0) /*Solo se mostrara si hay valores que mostrar*/
                    PanelConsultarLineasParte.Visible = true;

                PanelInsertarParte.Visible = false;
                ButtonInsertarParte.Text = "Insertar Parte";
            }
        }

        protected void FormViewInsertarParte_DataBound(object sender, EventArgs e)
        {
            if (FormViewInsertarParte.CurrentMode == FormViewMode.Insert)
            {
                TextBox codigoTrabajadorTextBox = (TextBox)FormViewInsertarParte.FindControl("codigoTrabajadorTextBox");

                if (codigoTrabajadorTextBox != null && Session["codigoTrabajador"] != null)
                {
                    codigoTrabajadorTextBox.Text = Session["codigoTrabajador"].ToString();
                }
            }
        }

        protected void ButtonInsertarLinea_Click(object sender, EventArgs e)
        {
            if (!PanelInsertarLinea.Visible)
            {
               PanelInsertarLinea.Visible = true;
                ButtonInsertarLinea.Text = "Ocultar";
            }
            else {
                PanelInsertarLinea.Visible = false;
                ButtonInsertarLinea.Text = "Insertar Linea";
            }
        }

    }
}