using System;
using System.Collections.Generic;
using System.Data.SqlClient;
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
                // Definir la lista de provincias de España
                List<string> provincias = new List<string>
                {
                    "","Álava", "Albacete", "Alicante", "Almería", "Asturias", "Ávila", "Badajoz", "Barcelona", "Burgos",
                    "Cáceres", "Cádiz", "Cantabria", "Castellón", "Ciudad Real", "Córdoba", "Cuenca", "Gerona", "Granada",
                    "Guadalajara", "Guipúzcoa", "Huelva", "Huesca", "Islas Baleares", "Jaén", "La Coruña", "La Rioja",
                    "Las Palmas", "León", "Lérida", "Lugo", "Madrid", "Málaga", "Murcia", "Navarra", "Orense", "Palencia",
                    "Pontevedra", "Salamanca", "Santa Cruz de Tenerife", "Segovia", "Sevilla", "Soria", "Tarragona",
                    "Teruel", "Toledo", "Valencia", "Valladolid", "Vizcaya", "Zamora", "Zaragoza"
                };

                // Asignar la lista de provincias al DropDownList
                DropDownListUbicacionDE.DataSource = provincias;
                DropDownListUbicacionDE.DataBind();

                DropDownListUbicacionDF.DataSource = provincias;
                DropDownListUbicacionDF.DataBind();
            }else
            {
                SqlDataSource1.SelectCommand = Session["consultaSQL"].ToString();
            }
        }

        protected void ButtonInsertarCliente_Click(object sender, EventArgs e)
        {
            if (PanelInsertar.Visible)
            {
                // Si el panel es visible, ocultarlo y cambiar el texto del botón a "Mostrar"
                PanelInsertar.Visible = false;
                GridView1.Visible = true;
                ButtonFiltros.Visible = true;
                ButtonInsertarCliente.Text = "Insertar Cliente";
            }
            else
            {
                // Si el panel no es visible, mostrarlo y cambiar el texto del botón a "Ocultar"
                PanelInsertar.Visible = true;

                PanelFiltros.Visible = false;
                ButtonFiltros.Text = "Mostrar filtros";
                ButtonFiltros.Visible = false;

                GridView1.Visible = false;
                ButtonInsertarCliente.Text = "Ocultar";
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
            String consultaSQL = "SELECT * FROM Cliente WHERE nombreEntidad LIKE '%" + TextBoxFiltradoEntidad.Text.ToString() + "%'";

            if (DropDownListUbicacionDF.SelectedItem.Text.ToString() != "") {
                consultaSQL += " AND UbicacionDF ='"+DropDownListUbicacionDF.SelectedItem.Text.ToString()+"'";
            }

            if (DropDownListUbicacionDE.SelectedItem.Text.ToString() != "")
            {
                consultaSQL += " AND UbicacionDE ='" + DropDownListUbicacionDE.SelectedItem.Text.ToString() + "'";
            }

            SqlDataSource1.SelectCommand = consultaSQL;
            Session["consultaSQL"] = consultaSQL;
            SqlDataSource1.DataBind();
        }

        protected void Limpiar_Click(object sender, EventArgs e)
        {
            SqlDataSource1.SelectCommand = "SELECT * FROM Cliente order by codigoCliente DESC";
            SqlDataSource1.DataBind();
            TextBoxFiltradoEntidad.Text = "";
            DropDownListUbicacionDF.SelectedIndex = 0;
            DropDownListUbicacionDE.SelectedIndex = 0;
        }

    
        protected void FormViewInsertarCliente_ItemCommand(object sender, FormViewCommandEventArgs e)
        {
            if (e.CommandName == "Cancel")
            {
                PanelInsertar.Visible = false;
                GridView1.Visible = true;
                ButtonFiltros.Visible = true;
                ButtonInsertarCliente.Text = "Insertar";
            }
        }

        protected void FormViewInsertarCliente_ItemInserting(object sender, FormViewInsertEventArgs e)
        {
            TextBox nombreEntidadTextBox = (TextBox)FormViewInsertarCliente.FindControl("nombreEntidadTextBox");
            TextBox ubicacionDFTextBox = (TextBox)FormViewInsertarCliente.FindControl("UbicacionDFTextBox");
            TextBox ubicacionDETextBox = (TextBox)FormViewInsertarCliente.FindControl("UbicacionDETextBox");

            if (string.IsNullOrEmpty(nombreEntidadTextBox.Text))
            {
                e.Cancel = true;
                ScriptManager.RegisterStartupScript(this, GetType(), "Error", "alert('El nombre de la entidad no puede estar vacía.');", true);
            }

            if (string.IsNullOrEmpty(ubicacionDFTextBox.Text))
            {
                e.Cancel = true;
                ScriptManager.RegisterStartupScript(this, GetType(), "Error", "alert('La ubicación del domicilio fiscal no puede estar vacía.');", true);

            }

            if (string.IsNullOrEmpty(ubicacionDETextBox.Text))
            {
                e.Cancel = true;
                ScriptManager.RegisterStartupScript(this, GetType(), "Error", "alert('La ubicación del domicilio empresarial no puede estar vacía.');", true);

            }

            string consulta = "SELECT nombreEntidad FROM Cliente WHERE nombreEntidad = @nombreEntidad";

            string connectionString = "Data Source=miservertfg.database.windows.net;Initial Catalog=mibasededatostfg;Persist Security Info=True;User ID=adminsql;Password=Josele6072";

            using (SqlConnection cnn = new SqlConnection(connectionString))
            {
                cnn.Open();
                using (SqlCommand cmd = new SqlCommand(consulta, cnn))
                {
                    cmd.Parameters.AddWithValue("@nombreEntidad", nombreEntidadTextBox.Text.ToString());

                    using (SqlDataReader adap = cmd.ExecuteReader())
                    {
                        if (adap.Read())
                        {
                            e.Cancel = true;
                            ScriptManager.RegisterStartupScript(this, GetType(), "Error", "alert('El nombre de la entidad ya se encuentra registrado');", true);
                        }
                    }
                }
            }
        }
    } 
}