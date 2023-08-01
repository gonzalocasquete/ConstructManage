using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace tfgASPX2.Views.Super
{
    public partial class GestionarUsuarios : System.Web.UI.Page
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
            string trabajador, coordinador, super;

            trabajador = CheckBoxTrabajador.Checked ? "trabajador" : null;
            coordinador = CheckBoxCoordinador.Checked ? "coordinador" : null;
            super = CheckBoxSuper.Checked ? "super" : null;

            if (trabajador == null && coordinador == null && super == null)
            {
                SqlDataSource1.SelectCommand = "SELECT * FROM Usuario WHERE (nombreUsuario LIKE '%" + TextBoxFiltradoUsuario.Text.ToString() +
                "%')";
            }
            else { 
            SqlDataSource1.SelectCommand = "SELECT * FROM Usuario WHERE (nombreUsuario LIKE '%" + TextBoxFiltradoUsuario.Text.ToString() +
                "%' AND rol='"+trabajador+"' OR rol='"+coordinador+"' OR rol='"+super+"')";
            }
 
            SqlDataSource1.DataBind();
        }

        protected void Limpiar_Click(object sender, EventArgs e)
        {
            SqlDataSource1.SelectCommand = "SELECT * FROM Usuario ORDER BY idUsuario";
            SqlDataSource1.DataBind();
            TextBoxFiltradoUsuario.Text = "";
            CheckBoxTrabajador.Checked = false;
            CheckBoxCoordinador.Checked = false;
            CheckBoxSuper.Checked = false;
        }
    }
}