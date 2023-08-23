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

                PanelPartidas.Visible = false;

                GridView1.Visible = true;
                ButtonInsertarPartida.Visible = false;
                ButtonFiltros.Visible= true;
                ButtonInsertarProyecto.Text = "Insertar Proyecto";
                SqlDataSource1.SelectCommand = "Select * FROM Proyecto";
                SqlDataSource1.DataBind();
            }
            else
            {
                PanelInsertarProyecto.Visible = true;

                PanelFiltros.Visible = false;
                ButtonFiltros.Text = "Mostrar filtros";
                ButtonFiltros.Visible = false;
                ButtonInsertarPartida.Visible = false;
                GridView1.Visible = false;
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
                SqlDataSource1.SelectCommand = "Select * FROM Proyecto";
                SqlDataSource1.DataBind();
            }
            else
            {
                PanelInsertarPartida.Visible = true;
                ButtonInsertarPartida.Text = "Ocultar";
                if (GridView1.SelectedIndex >= 0)
                {
                    int rowIndex = GridView1.SelectedIndex;
                    string codigoProyectoStr = GridView1.DataKeys[rowIndex]["codigoProyecto"].ToString();
                    int.TryParse(codigoProyectoStr, out int codigoProyecto);
                    SqlDataSource1.SelectCommand = "Select * FROM Proyecto WHERE codigoProyecto=" + codigoProyecto;
                    SqlDataSource1.DataBind();
                }           
            }
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            TextBox codigoProyecto = (TextBox)this.FormViewInsertarPartida.FindControl("codigoProyectoTextBox");
            int codigo = Convert.ToInt32(this.GridView1.SelectedDataKey["codigoProyecto"]);
            codigoProyecto.Text = codigo.ToString();

            PanelPartidas.Visible = true;
            PanelInsertarProyecto.Visible = false;
            PanelInsertarPartida.Visible = false;
            ButtonInsertarPartida.Visible = true;
            ButtonInsertarProyecto.Text = "Insertar Proyecto";
            ButtonInsertarPartida.Text = "Insertar Partida";
        }

        //Filtros
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
            String consultaSQL = "SELECT * FROM Proyecto WHERE nombreProyecto LIKE '%" + TextBoxFiltradoProyecto.Text + "%'";

            if (fechaMinima.Value != "")
                consultaSQL += " AND FechaInicio >= '" + fechaMinima.Value + "'";

            if (fechaMaxima.Value != "")
                consultaSQL += " AND FechaFin <= '" + fechaMaxima.Value + "'";

            if (presupuestoMinimo.Value.Length != 0)
                consultaSQL += " AND Presupuesto>=" + presupuestoMinimo.Value + "";

            if (presupuestoMaximo.Value.Length != 0)
                consultaSQL += " AND Presupuesto<=" + presupuestoMaximo.Value + "";

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

        protected void FormViewInsertarProyecto_ItemCommand(object sender, FormViewCommandEventArgs e)
        {
            if (e.CommandName == "Cancel")
            {
                PanelInsertarProyecto.Visible = false;

                PanelPartidas.Visible = false;

                GridView1.Visible = true;
                ButtonInsertarPartida.Visible = false;
                ButtonFiltros.Visible = true;
                ButtonInsertarProyecto.Text = "Insertar Proyecto";
                SqlDataSource1.SelectCommand = "Select * FROM Proyecto";
                SqlDataSource1.DataBind();
            }
        }

        protected void FormViewInsertarPartida_ItemCommand(object sender, FormViewCommandEventArgs e)
        {
            if (e.CommandName == "Cancel")
            {
                PanelInsertarPartida.Visible = false;
                ButtonInsertarPartida.Text = "Insertar Partida";
                SqlDataSource1.SelectCommand = "Select * FROM Proyecto";
                SqlDataSource1.DataBind();
            }
        }
    }
}