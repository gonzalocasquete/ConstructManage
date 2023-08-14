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

    }
}