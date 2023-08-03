using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace tfgASPX2.Views.Trabajador
{
    public partial class InicialTrabajador : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) // Verifica si es la primera carga de la página (no es un PostBack)
            {
                MostrarMensajeBienvenida();
            }     
        }

        private void MostrarMensajeBienvenida()
        {
            if (Session["nombreUsuario"] != null)
            {
                string nombreUsuario = Session["nombreUsuario"].ToString();

                // Muestra el mensaje de bienvenida en un Label o Literal en tu página.
                string mensaje = $"¡Bienvenido, {nombreUsuario}!";
                LabelMensajeBienvenida.Text = mensaje;
            }
        }

        protected void ButtonFiltrado_Click(object sender, EventArgs e)
        {
            //SqlDataSource1.SelectCommand = "SELECT * FROM CategoriaProfesional WHERE (nombreCategoria LIKE '%" + TextBoxFiltrado.Text.ToString() + "%')";
            SqlDataSource1.DataBind();
        }

        protected void Todos_Click(object sender, EventArgs e)
        {
            //SqlDataSource1.SelectCommand = "SELECT * FROM CategoriaProfesional";
            SqlDataSource1.DataBind();
        }

        protected void CheckBoxHorasNormales_CheckedChanged(object sender, EventArgs e)
        {
            CalcularHorasTotales();
        }

        protected void CheckBoxHorasExtra_CheckedChanged(object sender, EventArgs e)
        {
            CalcularHorasTotales();
        }

        private void CalcularHorasTotales()
        {
            int numeroHoras = 0;

            for (int i = 0; i < GridView1.Rows.Count; i++)
            {
                int horasNormales = int.Parse(GridView1.Rows[i].Cells[3].Text);
                int horasExtra = int.Parse(GridView1.Rows[i].Cells[4].Text);

                numeroHoras += CheckBoxHorasNormales.Checked ? horasNormales : 0;
                numeroHoras += CheckBoxHorasExtra.Checked ? horasExtra : 0;
            }

            TextBoxHorasTotales.Text = numeroHoras.ToString();
        }
    }
}