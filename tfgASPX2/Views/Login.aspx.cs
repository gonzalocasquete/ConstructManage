using Microsoft.Ajax.Utilities;
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

            string usuario, contraseña, consultaSQL;
            usuario = InputUsuario.Value.ToString();
            contraseña = InputPassword.Value.ToString();
            Session["consultaSQL"] = "";

            if (usuario == "admin" && contraseña == "admin") { 
                consultaSQL= "SELECT U.codigoUsuario, U.nombreUsuario, U.contraseñaUsuario, U.rol FROM Usuario U";
            }
            else
            {
                consultaSQL = "SELECT U.codigoUsuario, U.nombreUsuario, U.contraseñaUsuario, U.rol, T.codigoTrabajador FROM Usuario U INNER JOIN Trabajador T ON U.codigoUsuario = T.codigoUsuario WHERE U.nombreUsuario = @usuario AND U.contraseñaUsuario = @contraseña";
            }

            string connectionString = "Data Source=miservertfg.database.windows.net;Initial Catalog=mibasededatostfg;Persist Security Info=True;User ID=adminsql;Password=Josele6072";

            using (SqlConnection cnn = new SqlConnection(connectionString))
            {
                cnn.Open();
                using (SqlCommand cmd = new SqlCommand(consultaSQL, cnn))
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

                                if (usuario == "admin" && contraseña == "admin") { } else { Session["codigoTrabajador"] = adap.GetInt32(4);}
                                         
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