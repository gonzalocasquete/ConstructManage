using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace tfgASPX2.Views.Super
{
    public partial class GestionarProyectos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack) {
                PanelPartidas.Visible = false;
                ButtonInsertarPartida.Visible = false;
                PanelPartidas.Visible= false;
                PanelInsertarPartida.Visible = false;    
            }  
        }

        protected void ButtonInsertarProyecto_Click(object sender, EventArgs e)
        {
            if (PanelInsertarProyecto.Visible)
            {
                PanelInsertarProyecto.Visible = false;
                PanelPartidas.Visible = true;
                ButtonInsertarPartida.Visible = true;
                ButtonInsertarProyecto.Text = "Insertar Proyecto";
            }
            else
            {
                PanelInsertarProyecto.Visible = true;
                PanelPartidas.Visible = false;
                ButtonInsertarProyecto.Text = "Ocultar";
            }
        }

        protected void ButtonInsertarPartida_Click(object sender, EventArgs e)
        {
            if (PanelInsertarPartida.Visible)
            {
                PanelInsertarPartida.Visible = false;
                ButtonInsertarPartida.Text = "Insertar Partida";
            }
            else
            {
                PanelInsertarPartida.Visible = true;
                ButtonInsertarPartida.Text = "Ocultar";
            }
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (!PanelPartidas.Visible)
            {
                PanelInsertarProyecto.Visible = false;
                PanelInsertarPartida.Visible = false;
                ButtonInsertarPartida.Visible = true;
                PanelPartidas.Visible = true;

            }
            else if (PanelInsertarProyecto.Visible)
            {
                PanelPartidas.Visible = false;
                PanelInsertarProyecto.Visible = false;
                PanelInsertarPartida.Visible = false;
                ButtonInsertarPartida.Visible = false;
                ButtonInsertarProyecto.Text = "Insertar Proyecto";
            }
        }

        //Filtros
        protected void ButtonFiltrado_Click(object sender, EventArgs e)
        {
            String consultaSQL = "SELECT * FROM Proyecto WHERE nombreProyecto LIKE '%" + TextBoxFiltradoProyecto.Text + "%'";

            if (fechaMinima.Value != "")
                consultaSQL += " AND FechaInicio >= '" + fechaMinima.Value + "'";

            if (fechaMaxima.Value != "")
                consultaSQL += " AND FechaFin <= '" + fechaMaxima.Value + "'";

            if (presupuestoMinimo.Value.Length != 0)
                consultaSQL += " AND Presupuesto>" + presupuestoMinimo.Value + "";

            if (presupuestoMaximo.Value.Length != 0)
                consultaSQL += " AND Presupuesto<" + presupuestoMaximo.Value + "";

            SqlDataSource1.SelectCommand = consultaSQL;
            SqlDataSource1.DataBind();
        }

        protected void Todos_Click(object sender, EventArgs e)
        {
            SqlDataSource1.SelectCommand = "SELECT * FROM Proyecto";
            SqlDataSource1.DataBind();
            TextBoxFiltradoProyecto.Text = "";
            fechaMinima.Value = "";
            fechaMaxima.Value = "";
            presupuestoMinimo.Value = null;
            presupuestoMaximo.Value = null;
        }
    }
}