using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;


namespace BEFOnTheWeb.Secure
{
    public partial class MeManagement : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                lblErrMsg.Visible = false;
                lblUserMsg.Visible = false;
            }

            string sp = "Me_UserInfo_Sel";
            SqlConnection sel = new SqlConnection();
            sel.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["BEF"].ConnectionString;
            SqlCommand selCmd = new SqlCommand(sp, sel);
            selCmd.CommandType = CommandType.StoredProcedure;
            sel.Open();

            using (selCmd)
            {
                try
                {
                    selCmd.Parameters.AddWithValue("@UserName", HttpContext.Current.User.Identity.Name.ToString());
                    object hasUserRecord = new object();
                    hasUserRecord = selCmd.ExecuteScalar();
                    if (hasUserRecord == null)
                    {
                        lblUserMsg.Visible = true;
                        lblUserMsg.Text = "Thank you for registering!  Please complete your registration by providing the additional contact information " +
                            "listed below. Note, this information will ONLY be used by BEF for communications associated with the Grant Application " +
                            "Process (Teachers only) and Volunteer Events that you have signed up for.";
                        fvContactInfo.ChangeMode(FormViewMode.Insert);
                    }
                }
                catch (Exception ex)
                {
                    lblErrMsg.Visible = true;
                    lblErrMsg.Text = ex.ToString();
                }
                finally
                {
                    sel.Close();
                }
            }
        }

        protected void sdsContactInfo_OnSelecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.Parameters["@UserName"].Value = HttpContext.Current.User.Identity.Name.ToString();
        }

        protected void sdsContactInfo_OnInserting(object sender, SqlDataSourceCommandEventArgs e)
        {
            e.Command.Parameters["@UserName"].Value = HttpContext.Current.User.Identity.Name.ToString();
        }

        protected void sdsContactInfo_OnUpdating(object sender, SqlDataSourceCommandEventArgs e)
        {
            e.Command.Parameters["@UserName"].Value = HttpContext.Current.User.Identity.Name.ToString();
        }

        protected void InsertCancelButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/secure/home.aspx");
        }

        protected void UpdateCancelButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/secure/MeManagement.aspx");
        }

        protected void sdsContactInfo_Inserted(object sender, SqlDataSourceStatusEventArgs e)
        {
            Response.Redirect("~/secure/MeManagement.aspx");
        }
    }
}