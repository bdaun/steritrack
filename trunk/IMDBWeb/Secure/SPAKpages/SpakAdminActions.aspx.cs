using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace IMDBWeb.Secure.SPAKpages
{
    public partial class SpakAdminActions : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblErrMsg.Visible = false;
                lblResult.Visible = false;
            }
        }

        protected void lnkUpdateBoxes_Click(object sender, EventArgs e)
        {
            lblErrMsg.Visible = false;
            lblResult.Visible = false;
            lblResult.Text = string.Empty;
            String spUpdateBox = "SPAK_Admin_IMDBBarcode_upd";
            SqlConnection con = new SqlConnection();
            con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
            SqlCommand cmdUpdateBox = new SqlCommand(spUpdateBox, con);
            cmdUpdateBox.CommandType = CommandType.StoredProcedure;
            con.Open();
            using (cmdUpdateBox)
            {
                try
                {
                    cmdUpdateBox.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    lblErrMsg.Visible = true;
                    lblErrMsg.Text = ex.Message;
                }
                finally
                {
                    con.Close();
                    lblResult.Visible = true;
                    lblResult.Text = "Boxes in IMDB have been updated with SPAK values";
                }
            }
        }
        protected void lnkUpdateManifests_Click(object sender, EventArgs e)
        {
            lblErrMsg.Visible = false;
            lblResult.Visible = false;
            lblResult.Text = string.Empty;
            String spUpdateManifest = "SPAK_Admin_IMDBManifest_upd";
            SqlConnection con = new SqlConnection();
            con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
            SqlCommand cmdUpdateManifest = new SqlCommand(spUpdateManifest, con);
            cmdUpdateManifest.CommandType = CommandType.StoredProcedure;
            con.Open();
            using (cmdUpdateManifest)
            {
                try
                {
                    cmdUpdateManifest.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    lblErrMsg.Visible = true;
                    lblErrMsg.Text = ex.Message;
                }
                finally
                {
                    con.Close();
                    lblResult.Visible = true;
                    lblResult.Text = "Manifests in IMDB have been updated with SPAK values";
                }
            }
        }
        protected void lnkUpdateUnknowns_Click(object sender, EventArgs e)
        {
            lblErrMsg.Visible = false;
            lblResult.Visible = false;
            lblResult.Text = string.Empty;
            String spUpdateUnknowns = "SPAK_Admin_SPAKBoxRcvd_FacilityProfile_upd";
            SqlConnection con = new SqlConnection();
            con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
            SqlCommand cmdUpdateUnknowns = new SqlCommand(spUpdateUnknowns, con);
            cmdUpdateUnknowns.CommandType = CommandType.StoredProcedure;
            con.Open();
            using (cmdUpdateUnknowns)
            {
                try
                {
                    cmdUpdateUnknowns.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    lblErrMsg.Visible = true;
                    lblErrMsg.Text = ex.Message;
                }
                finally
                {
                    con.Close();
                    lblResult.Visible = true;
                    lblResult.Text = "UNKNOWNS in IMDB have been updated with SPAK values";
                }
            }
        }
    }
}