using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace tfgASPX2.Views.Super
{
    public partial class GestionarPartidas : System.Web.UI.Page
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
            String consultaSQL = "SELECT * FROM Partida WHERE nombrePartida LIKE '%" + TextBoxFiltradoPartida.Text.ToString() + "%'";

            if (DropDownListProyectos.SelectedValue != "")
                consultaSQL += " AND codigoProyecto=" + DropDownListProyectos.SelectedValue +"";

            if (fechaInicio.Value != "")
                consultaSQL += " AND fechaInicio >= '" + fechaInicio.Value + "'";

            if (fechaFin.Value != "")
                consultaSQL += " AND FechaFin <= '" + fechaFin.Value + "'";

            if (costeMinimo.Value.Length != 0)
                consultaSQL+=" AND Costo>"+costeMinimo.Value+"";

            if (costeMaximo.Value.Length != 0)
                consultaSQL += " AND Costo<" + costeMaximo.Value + "";


            Response.Write(consultaSQL);
            SqlDataSource1.SelectCommand = consultaSQL;
            SqlDataSource1.DataBind();
        }

        protected void Todos_Click(object sender, EventArgs e)
        {
            SqlDataSource1.SelectCommand = "SELECT * FROM Partida";
            SqlDataSource1.DataBind();
            TextBoxFiltradoPartida.Text = "";
            DropDownListProyectos.SelectedIndex = 0;
            fechaInicio.Value = "";
            fechaFin.Value = "";
            costeMinimo.Value = null;
            costeMaximo.Value = null;
         
        }
    }
}