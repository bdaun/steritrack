using System;
using System.Web;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

namespace IMDBWeb.Secure.deskTopPages
{
    public partial class ManifestMailing : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblSelParam.Visible = false;
                txbSelParam.Visible = false;
                gvManifestStatus.EmptyDataText = "";
                gvManifestStatus.DataSourceID = "";
                trUpdateAll.Visible = false;
            }
        }
        protected void rbList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            switch (rbList1.SelectedIndex)
            {
                case 0:
                    gvManifestStatus.DataSourceID = "sdsmanifestMail_Date";
                    gvManifestStatus.EmptyDataText = "There are no overdue manifests";
                    lblSelParam.Visible = false;
                    txbSelParam.Visible = false;
                    trUpdateAll.Visible = false;
                    break;
                case 1:
                    gvManifestStatus.DataSourceID = "";
                    gvManifestStatus.EmptyDataText = "";
                    lblSelParam.Text = "Enter the TruckID in format @@-mm/dd/yy-###";
                    lblSelParam.Visible = true;
                    txbSelParam.Visible = true;
                    txbSelParam.Text = "";
                    revSelParam.ValidationExpression = "^([0-9][0-9])-(0[1-9]|1[012])[/](0[1-9]|[12][0-9]|3[01])[/][0-9][0-9][-][0-9][0-9][0-9]$";
                    revSelParam.ErrorMessage = "Please use a format of @@-mm/dd/yy-###";
                    break;
                case 2:
                    gvManifestStatus.DataSourceID = "";
                    gvManifestStatus.EmptyDataText = "";
                    lblSelParam.Text = "Enter a manifest";
                    lblSelParam.Visible = true;
                    txbSelParam.Visible = true;
                    txbSelParam.Text = "";
                    revSelParam.ValidationExpression = "";
                    revSelParam.ErrorMessage = "";
                    trUpdateAll.Visible = false;
                    break;
                default:
                    gvManifestStatus.DataSourceID = "";
                    gvManifestStatus.EmptyDataText = "";
                    lblSelParam.Visible = false;
                    txbSelParam.Visible = false;
                    trUpdateAll.Visible = false;
                    break;
            }
        }
        protected void txbSelParam_TextChanged(object sender, EventArgs e)
        {
            switch (rbList1.SelectedIndex)
            {
                case 0:
                    gvManifestStatus.DataSourceID = "sdsmanifestMail_Date";
                    gvManifestStatus.EmptyDataText = "There are no overdue manifests";
                    gvManifestStatus.DataBind();
                    break;
                case 1:
                    gvManifestStatus.DataSourceID = "sdsManifestMail_TruckID";
                    gvManifestStatus.EmptyDataText = "No results available for this TruckID";
                    trUpdateAll.Visible = true;
                    txbMailDate.Text = null;
                    gvManifestStatus.DataBind();
                    break;
                case 2:
                    gvManifestStatus.DataSourceID = "sdsManifestMail_Manifest";
                    gvManifestStatus.EmptyDataText = "No results available for this Manifest";
                    gvManifestStatus.DataBind();
                    break;
            }
        }
        protected void btnGo_Click(object sender, EventArgs e)
        {
            if (txbMailDate.Text == string.Empty)
            {
                lblDateErr.Visible = true;
            }
            else
            {
                lblDateErr.Visible = false;
                String sp = "SPAK_ManifestMail_TruckID_Upd";
                SqlConnection con = new SqlConnection();
                con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
                SqlCommand spCmd = new SqlCommand(sp, con);
                spCmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                using (spCmd)
                {
                    try
                    {
                        spCmd.Parameters.AddWithValue("@User", HttpContext.Current.User.Identity.Name.ToString());
                        spCmd.Parameters.AddWithValue("@TruckID", txbSelParam.Text);
                        spCmd.Parameters.AddWithValue("@MailDate", txbMailDate.Text);
                        spCmd.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        lblErrMsg.Visible = true;
                        lblErrMsg.Text = ex.ToString();
                    }
                    finally
                    {
                        con.Close();
                        gvManifestStatus.DataBind();
                    }
                }
            }
        }
        protected void sdsManifestMail_Date_Updating(Object sender, SqlDataSourceCommandEventArgs e)
        {
            e.Command.Parameters["@User"].Value = HttpContext.Current.User.Identity.Name.ToString();
        }
        protected void gvManifestMail_Update_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                lblErrMsg.Visible = true;
                lblErrMsg.Text = e.ToString();
            }
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/secure/DesktopPages/ManifestMailing.aspx");
        }
    }
}