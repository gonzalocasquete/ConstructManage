using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace tfgASPX
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session.RemoveAll();
                Session.Abandon();
            }
        }

        protected void Entrar_Click(object sender, EventArgs e)
        {
            // Clear existing session data
            Session.Clear();

            string usuario, contraseña;
            usuario = InputUsuario.Value.ToString();
            contraseña = InputPassword.Value.ToString();

            string consulta = "SELECT codigoUsuario, nombreUsuario, contraseñaUsuario, rol FROM USUARIO WHERE " +
                              "nombreUsuario=@usuario AND contraseñaUsuario=@contraseña";

            string connectionString = "Data Source=miservertfg.database.windows.net;Initial Catalog=mibasededatostfg;Persist Security Info=True;User ID=adminsql;Password=Josele6072";

            using (SqlConnection cnn = new SqlConnection(connectionString))
            {
                cnn.Open();
                using (SqlCommand cmd = new SqlCommand(consulta, cnn))
                {
                    cmd.Parameters.AddWithValue("@usuario", usuario);
                    cmd.Parameters.AddWithValue("@contraseña", contraseña);

                    using (SqlDataReader adap = cmd.ExecuteReader())
                    {
                        if (adap.Read())
                        {
                            try
                            {
                                string rol = adap.GetString(3);
                                Session["codigoUsuario"] = adap.GetInt32(0);
                                Session["nombreUsuario"] = adap.GetString(1);
                                Session["rol"] = rol;

                                // Redirect based on role
                                if (rol == "admin")
                                {
                                    Response.Redirect("Super/MenuSuper.aspx");
                                }
                                else if (rol == "trabajador")
                                {
                                    Response.Redirect("Trabajador/InicialTrabajador.aspx");
                                }
                                else if (rol == "coordinador")
                                {
                                    Response.Redirect("Coordinador/InicialCoordinador.aspx");
                                }
                            }
                            catch (Exception ex)
                            {
                                Response.Write(ex.Message.ToString());
                            }
                        }
                        else
                        {
                            // User does not exist, display an error message
                            ErrorMessageLabel.Visible = true;
                            ErrorMessageLabel.Text = "Usuario y/o contraseña incorrectos.";
                        }
                    }
                }
            }
        }

    }
}