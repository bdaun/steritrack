using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SiteBuilder
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                resetpage();
            }
            else
            {
                gvCommunities.DataBind();
            }
        }

        protected void resetpage()
        {
            tblStart.Visible = true;
            tblSearch.Visible = false;
            tblNewSite.Visible = false;
        }

        protected void btnNewSite_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txbNewSite.Text)) 
            {
                WebMsgBox.Show("You must enter a site name! ");
            }
            else if (string.IsNullOrWhiteSpace(ddNewCountry.SelectedValue) ||(ddNewCountry.SelectedIndex==0))
            {
                WebMsgBox.Show("You must select a Country!");
            }
            string strSP = "Community_NewSite_Ins";
            SqlConnection con = new SqlConnection();
            con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["SiteBuilderCon"].ConnectionString;
            SqlCommand newSite = new SqlCommand(strSP, con);
            newSite.CommandType = System.Data.CommandType.StoredProcedure;
            con.Open();
            using (newSite)
            {
                try
                {
                    newSite.Parameters.AddWithValue("@SiteName", txbNewSite.Text);
                    newSite.Parameters.AddWithValue("@Comments", txbComments.Text);
                    newSite.Parameters.AddWithValue("@CountryID", ddNewCountry.SelectedValue);
                    newSite.Parameters.AddWithValue("@UserName", HttpContext.Current.User.Identity.Name.ToString());
                    newSite.ExecuteNonQuery();
                }
                catch (Exception x)
                {
                    lblErrMsg.Visible = true;
                    lblErrMsg.Text = x.ToString();
                }
                finally
                {
                    con.Close();
                    txbNewSite.Text = string.Empty;
                    txbComments.Text = string.Empty;
                    ddNewCountry.SelectedIndex = 0;
                    WebMsgBox.Show("New Community Created!");
                    resetpage();
                }
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            tblStart.Visible = false;
            tblSearch.Visible = true;
            tblNewSite.Visible = false;
        }

        protected void btnlookupCancel_Click(object sender, EventArgs e)
        {
            txbName.Text = string.Empty;
            ddCountry.SelectedIndex = 0;
            gvCommunities.DataBind();
            resetpage();
        }

        protected void btnNewCommunity_Click(object sender, EventArgs e)
        {
            tblStart.Visible = false;
            tblSearch.Visible = false;
            tblNewSite.Visible = true;
        }

        protected void btnNewSiteCancel_Click(object sender, EventArgs e)
        {
            resetpage();
        }

        protected void btnlookup_Click(object sender, EventArgs e)
        {
            gvCommunities.DataBind();
        }

        protected void sdsCommunityInfo_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            sdsCommunityInfo.SelectParameters["UserName"].DefaultValue = HttpContext.Current.User.Identity.Name.ToString();
            if (chkMe.Checked)
            {
                sdsCommunityInfo.SelectParameters["OnlyMe"].DefaultValue = "0";
            }
            else
            {
                sdsCommunityInfo.SelectParameters["OnlyMe"].DefaultValue = "1";
            }
                
        }
    }
}