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
            Session["rol"] = "";
            Session["codigoUsuario"] = "";
            Session["nombreUsuario"] = "";
            Session["codigoTrabajador"] = "";

            String usuario, contraseña;
            usuario = TextBoxUsuario.Text.ToString();
            contraseña = TextBoxContraseña.Text.ToString();
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
                            }
                            catch (Exception ex)
                            {
                                Response.Write(ex.Message.ToString());
                            }
                        }
                    }
                }

                // Evitar reutilizar el mismo objeto SqlCommand y SqlDataReader, mejor usar nuevos objetos
                string consultaTrabajador = "SELECT codigoTrabajador FROM Trabajador WHERE codigoUsuario = @codigoUsuario";
                using (SqlCommand cmdTrabajador = new SqlCommand(consultaTrabajador, cnn))
                {
                    cmdTrabajador.Parameters.AddWithValue("@codigoUsuario", Session["codigoUsuario"]);

                    using (SqlDataReader adapTrabajador = cmdTrabajador.ExecuteReader())
                    {
                        if (adapTrabajador.Read())
                        {
                            try
                            {
                                Session["codigoTrabajador"] = adapTrabajador.GetInt32(0);
                            }
                            catch (Exception ex)
                            {
                                Response.Write(ex.Message.ToString());
                            }
                        }
                    }
                }
            }

            if (Session["rol"].ToString() == "super")
            {
                Response.Redirect("Super/MenuSuper.aspx");
            }
            else if (Session["rol"].ToString()=="trabajador")
            {
                Response.Redirect("Trabajador/InicialTrabajador.aspx");
            }
            else {
                Response.Redirect("Login.aspx");
            }
        }
    }
}