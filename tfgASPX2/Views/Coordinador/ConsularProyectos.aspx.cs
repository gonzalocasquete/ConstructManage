using Org.BouncyCastle.Asn1.X509;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace tfgASPX2.Views.Coordinador
{
    public partial class ConsultarProyectos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                SqlDataSource1.SelectCommand = Session["consultaSQL"].ToString();
            }
            else {
                if (Session["rol"] == null || Session["rol"].ToString() != "coordinador")
                    Response.Redirect("../Login.aspx");
            }
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            int codigo = Convert.ToInt32(this.GridView1.SelectedDataKey["codigoProyecto"]);
         
            ButtonVolver.Visible = true;
            PanelPartidas.Visible = true;
        
            if (GridView1.SelectedIndex >= 0)
            {
                int rowIndex = GridView1.SelectedIndex;
                string codigoProyectoStr = GridView1.DataKeys[rowIndex]["codigoProyecto"].ToString();
                int.TryParse(codigoProyectoStr, out int codigoProyectoInt);
                SqlDataSource1.SelectCommand = "SELECT Proyecto.*, Cliente.nombreEntidad FROM Proyecto INNER JOIN Cliente ON Proyecto.codigoCliente = Cliente.codigoCliente WHERE codigoProyecto = "+codigoProyectoInt+" ORDER BY Proyecto.codigoProyecto DESC";
                SqlDataSource1.DataBind();

                SqlDataSource2.SelectCommand = "Select * FROM Partida WHERE codigoProyecto="+codigoProyectoInt;
                SqlDataSource2.DataBind();
            }       
        }

        protected void ButtonVolverProyectos_Click(object sender, EventArgs e)
        {
            ButtonVolver.Visible = false;
         
            GridView1.SelectedIndex = -1;
            
            SqlDataSource1.SelectCommand = "SELECT Proyecto.*, Cliente.nombreEntidad FROM Proyecto INNER JOIN Cliente ON Proyecto.codigoCliente = Cliente.codigoCliente WHERE codigoCoordinador = "+Session["codigoTrabajador"]+" ORDER BY Proyecto.codigoProyecto DESC;";

            SqlDataSource1.DataBind();
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
             
            String consultaSQL = "SELECT Proyecto.*, Cliente.nombreEntidad FROM Proyecto INNER JOIN Cliente ON Proyecto.codigoCliente = Cliente.codigoCliente WHERE nombreProyecto LIKE '%" + TextBoxFiltradoProyecto.Text + "%'";

            if (fechaMinima.Value != "")
                consultaSQL += " AND FechaInicio >= '" + fechaMinima.Value + "'";

            if (fechaMaxima.Value != "")
                consultaSQL += " AND FechaFin <= '" + fechaMaxima.Value + "'";

            if (presupuestoMinimo.Value.Length != 0)
                consultaSQL += " AND Presupuesto>=" + presupuestoMinimo.Value + "";

            if (presupuestoMaximo.Value.Length != 0)
                consultaSQL += " AND Presupuesto<=" + presupuestoMaximo.Value + "";

            consultaSQL += "AND codigoCoordinador = "+Session["codigoTrabajador"]+" ORDER BY Proyecto.codigoProyecto DESC;";
            SqlDataSource1.SelectCommand = consultaSQL;
            Session["consultaSQL"] = consultaSQL;
            SqlDataSource1.DataBind();
        }

        protected void Todos_Click(object sender, EventArgs e)
        {
            SqlDataSource1.SelectCommand = "SELECT * FROM Proyecto WHERE codigoCoordinador = "+Session["codigoTrabajador"]+" order by codigoProyecto DESC";
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
                PanelPartidas.Visible = true;
             
                GridView1.Visible = true;
            
                ButtonFiltros.Visible = false;
            }
        }

        protected void FormViewInsertarPartida_ItemCommand(object sender, FormViewCommandEventArgs e)
        {
            if (e.CommandName == "Cancel")
            {
                SqlDataSource1.SelectCommand = "Select * FROM Proyecto WHERE codigoCoordinador = "+Session["codigoTrabajador"]+ "order by codigoProyecto DESC";
                SqlDataSource1.DataBind();
            }
        }

    }
}