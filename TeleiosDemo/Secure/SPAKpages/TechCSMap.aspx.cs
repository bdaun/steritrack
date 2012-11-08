using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace TeleiosDemo.Secure.SPAKpages
{
    public partial class TechCSMap : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!Page.User.IsInRole("Admin"))
            {
                btnAddCM.Visible = false;
                btnAddTech.Visible = false;
                btnSubmitCM.Visible = false;
                btnSubmitTech.Visible = false;
                lblCMName.Visible = false;
                lblCMNameID.Visible = false;
                lblMsg.Visible = false;
                lblTechName.Visible = false;
                lblTechNameID.Visible = false;
                lblTechPhone.Visible = false;
                txbTechPhone.Visible = false;
                txbCMName.Visible = false;
                txbCMNameID.Visible = false;
                txbTEchName.Visible = false;
                txbTechNameID.Visible = false;
            }
            else
            {
                btnAddCM.Visible = false;  //  Note this is here until I figure out how to add a CM w/o a tech
                btnSubmitCM.Visible = false;
                btnSubmitTech.Visible = false;
                lblCMName.Visible = false;
                lblCMNameID.Visible = false;
                lblMsg.Visible = false;
                lblTechName.Visible = false;
                lblTechNameID.Visible = false;
                lblTechPhone.Visible = false;
                txbTechPhone.Visible = false;
                txbCMName.Visible = false;
                txbCMNameID.Visible = false;
                txbTEchName.Visible = false;
                txbTechNameID.Visible = false;
            }
        }

        protected void btnAddTech_Click(object sender, EventArgs e)
        {
            btnSubmitCM.Visible = false;
            btnSubmitTech.Visible = true;
            lblCMName.Visible = false;
            lblCMNameID.Visible = false;
            lblMsg.Visible = false;
            lblTechName.Visible = true;
            lblTechNameID.Visible = true;
            lblTechPhone.Visible = true;
            txbTechPhone.Visible = true;
            txbCMName.Visible = false;
            txbCMNameID.Visible = false;
            txbTEchName.Visible = true;
            txbTechNameID.Visible = true;
        }

        protected void btnSubmitTech_Click(object sender, EventArgs e)
        {
            if (txbTechNameID.Text == "")
            {
                lblMsg.Visible = true;
                lblMsg.Text = "You must enter a NameID.  It should match the NameID in 4D";
                return;
            }
            else if (txbTEchName.Text == "")
            {
                lblMsg.Visible = true;
                lblMsg.Text = "You must enter a Name for the user.";
                return;
            }
            else
            {
                lblMsg.Visible = false;
                lblMsg.Text = "";
                String sp = "SPAK_TechCSMap_Ins";
                SqlConnection con = new SqlConnection();
                con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
                SqlCommand spCmd = new SqlCommand(sp, con);
                spCmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                using (spCmd)
                {
                    spCmd.Parameters.AddWithValue("@TechNameID", txbTechNameID.Text );
                    spCmd.Parameters.AddWithValue("@TechName", txbTEchName.Text);
                    spCmd.Parameters.AddWithValue("@TechPhone", txbTechPhone.Text);

                    spCmd.ExecuteNonQuery();
                }
                con.Close();
            }
        }
    }
}