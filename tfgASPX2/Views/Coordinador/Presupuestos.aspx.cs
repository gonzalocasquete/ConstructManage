using Org.BouncyCastle.Asn1.X509;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace tfgASPX2.Views.Coordinador
{
    public partial class Presupuesto : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
                if (Session["rol"] == null || Session["rol"].ToString() != "coordinador")
                    Response.Redirect("../Login.aspx");
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DataRowView rowView = e.Row.DataItem as DataRowView;
                if (rowView != null)
                {
                    decimal totalValue = Convert.ToDecimal(rowView["Total"]);

                    if (totalValue < 0)
                    {
                        System.Drawing.Color lessIntenseRed = System.Drawing.Color.FromArgb(200, 50, 50);

                        e.Row.BackColor = lessIntenseRed;
                        e.Row.ForeColor = System.Drawing.Color.White;
                    }
                }
            }
        }



    }
}