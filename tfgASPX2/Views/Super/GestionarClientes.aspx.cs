using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace tfgASPX2.Views.Super
{
    public partial class GestionarClientes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Configurar el estado inicial del panel y el botón
                PanelInsertar.Visible = false;
                //Comprobacion de que el rol es 'super'
                //if (Session["rol"].ToString() != "super") {
                //    Response.Redirect("Login.aspx");
                //}
            }
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
            String consultaSQL = "SELECT * FROM Cliente WHERE NombreEntidad LIKE '%" + TextBoxFiltradoEntidad.Text.ToString() + "%'";

            Response.Write(consultaSQL);
            SqlDataSource1.SelectCommand = consultaSQL;
            SqlDataSource1.DataBind();
        }

        protected void Todos_Click(object sender, EventArgs e)
        {
            SqlDataSource1.SelectCommand = "SELECT * FROM Cliente";
            SqlDataSource1.DataBind();
            TextBoxFiltradoEntidad.Text = "";      
        }
    }
}