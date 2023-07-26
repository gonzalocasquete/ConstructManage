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
            String connectionString, consulta, rol = null;
            SqlConnection cnn;
            SqlCommand cmd;
            SqlDataReader adap;
            Session["rol"] = "";
            Session["idUsuario"] = "";
            Session["nombreUsuario"] = "";

            String usuario, contraseña;
            usuario = TextBoxUsuario.Text.ToString();
            contraseña = TextBoxContraseña.Text.ToString();

            consulta = "SELECT idUsuario,nombreUsuario, contraseñaUsuario, rol FROM USUARIO WHERE " +
                "nombreUsuario='" + usuario + "' AND" +
                " contraseñaUsuario ='" + contraseña + "'";

            connectionString = "Data Source=miservertfg.database.windows.net;Initial Catalog=mibasededatostfg;Persist Security Info=True;User ID=adminsql;Password=Josele6072";
            Session["cadenaConexion"] = connectionString;

            cnn = new SqlConnection(Session["cadenaConexion"].ToString());
            cnn.Open();
            cmd = new SqlCommand(consulta, cnn);
            adap = cmd.ExecuteReader();

            if (adap.Read())
            {
                try
                {
                    rol = adap.GetString(3);
                    Session["idUsuario"] = adap.GetInt32(0);
                    Session["nombreUsuario"] = adap.GetString(1);
                    Session["rol"] = rol;
                }
                catch (Exception ex)
                {
                    Response.Write(ex.Message.ToString());
                }
                adap.Close();
            }

            cnn.Close();
            adap.Close();

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