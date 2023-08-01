using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace tfgASPX2.Views.Super
{
    public partial class GestionarTrabajadores : System.Web.UI.Page
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
                Button1.Text = "Insertar";
            }
            else
            {
                // Si el panel no es visible, mostrarlo y cambiar el texto del botón a "Ocultar"
                Panel1.Visible = true;
                Button1.Text = "Ocultar";
            }
        }

        protected void ButtonFiltrado_Click(object sender, EventArgs e)
        {
            String consultaSQL = "SELECT *" +
                " FROM Vista_trabajador" +
                " WHERE (nombre LIKE '%"+TextBoxFiltradoTrabajador.Text.ToString()+ "%'"+
                " OR apellido LIKE '%"+TextBoxFiltradoTrabajador.Text.ToString()+"%')";

            if (TextBoxUsuario.Text != "") 
                consultaSQL+=" AND nombreUsuario LIKE '%"+TextBoxUsuario.Text.ToString()+"%'";


            if (DropDownListFiltroCategorias.SelectedValue != "")
                consultaSQL += " AND nombreCategoria = '" + DropDownListFiltroCategorias.SelectedValue + "'";


            SqlDataSource1.SelectCommand = consultaSQL;
            SqlDataSource1.DataBind();
        }

        protected void Todos_Click(object sender, EventArgs e)
        {
            SqlDataSource1.SelectCommand = "SELECT * FROM Vista_trabajador";
            
            SqlDataSource1.DataBind();
            TextBoxFiltradoTrabajador.Text = "";
            TextBoxUsuario.Text = "";
            DropDownListFiltroCategorias.SelectedIndex = 0;
        }
    }
}