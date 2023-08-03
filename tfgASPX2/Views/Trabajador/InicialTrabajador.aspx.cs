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
            string consultaSQL = "SELECT LT.codigoLinea,P.nombrePartida AS nombrePartida,N.nombre AS nombreNaturaleza,LT.horasNormales,LT.horasExtra FROM LineaTrabajo LT JOIN Partida P ON LT.codigoPartida = P.codigoPartida JOIN Naturaleza N ON LT.codigoNaturaleza = N.codigoNaturaleza WHERE [codigoTrabajador] = " + Session["codigoTrabajador"] +"";
            
            if (horasMinimas.Value.Length !=0)
                consultaSQL += " AND horasNormales>=" + horasMinimas.Value + "";

            if (horasMaximas.Value.Length != 0)
                consultaSQL += " AND horasNormales<=" + horasMaximas.Value + "";

            SqlDataSource1.SelectCommand = consultaSQL;
            SqlDataSource1.DataBind();
        }

        protected void Todos_Click(object sender, EventArgs e)
        {
            SqlDataSource1.SelectCommand = "SELECT LT.codigoLinea,P.nombrePartida AS nombrePartida,N.nombre AS nombreNaturaleza,LT.horasNormales,LT.horasExtra FROM LineaTrabajo LT JOIN Partida P ON LT.codigoPartida = P.codigoPartida JOIN Naturaleza N ON LT.codigoNaturaleza = N.codigoNaturaleza WHERE ([codigoTrabajador] = " +Session["codigoTrabajador"]+")";
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