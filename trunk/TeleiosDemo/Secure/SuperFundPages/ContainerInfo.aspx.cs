using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Text;

namespace TeleiosDemo.Secure.SuperFundPages
{
    public partial class ContainerInfo : System.Web.UI.Page
    {
        protected void Page_Load(Object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblCntrCnt.Visible = false;
                lblCntrCntNo.Visible = false;
                gvGridLoc.EmptyDataText = "Please select a Location and/or a ContainerID";
                btnPrint.Visible = false;
                lblInstructions.Text = "* Select a location to begin";
            }
            else
            {
                gvGridLoc.EmptyDataText = "There are no Values for that Location or ContainerID";
            }


            // Define the name and type of the client scripts on the page.
            String updateLabel = "updateLabelScript";
            Type cstype = this.GetType();

            // Get a ClientScriptManager reference from the Page class.
            ClientScriptManager cs = Page.ClientScript;

            // Check to see if the startup script is already registered.
            if (!cs.IsStartupScriptRegistered(cstype, updateLabel))
            {
                StringBuilder scriptUpdateLabel = new StringBuilder();
                scriptUpdateLabel.Append("<script type='text/javascript'> function UpdateLabel() {\n ");
                scriptUpdateLabel.Append("var sn = document.getElementById('MainContent_dvContainerDetails_SampleNeeded'); \n");
                scriptUpdateLabel.Append("var sc = document.getElementById('MainContent_dvContainerDetails_SampleCompleted'); \n");
                scriptUpdateLabel.Append("if (sn.checked == true) { \n");
                scriptUpdateLabel.Append("if (sc.checked == false) { \n");
                scriptUpdateLabel.Append("document.getElementById('MainContent_fvLabel_lblSampleID').innerText = 'Sampling Needed'; } \n");
                scriptUpdateLabel.Append("else { ");
                scriptUpdateLabel.Append("document.getElementById('MainContent_fvLabel_lblSampleID').innerText = 'Sampling Completed'; } } \n");
                scriptUpdateLabel.Append("else { \n");
                scriptUpdateLabel.Append("document.getElementById('MainContent_fvLabel_lblSampleID').style.display = 'none'; }} \n");
                scriptUpdateLabel.Append("</script>");
                cs.RegisterStartupScript(cstype, updateLabel, scriptUpdateLabel.ToString());
            }
        }
        protected void gvGridLoc_RowDataBound(Object sender, GridViewRowEventArgs e)
        {
            if ((e.Row.RowState == DataControlRowState.Normal)||(e.Row.RowState==DataControlRowState.Alternate))
            {
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    e.Row.Attributes.Add("onmouseover", "this.previous_color=this.style.backgroundColor;this.style.backgroundColor='#ceedfc'");
                    e.Row.Attributes.Add("onmouseout", "this.style.backgroundColor=this.previous_color");
                    e.Row.Attributes.Add("style", "cursor:pointer;");
                    e.Row.Attributes.Add("onclick", ClientScript.GetPostBackClientHyperlink(this.gvGridLoc, "Select$" + e.Row.RowIndex));
                }
            }
        }
        protected void btnAddCntr_Click(Object sender, EventArgs e)
        {
            ddCompany.Visible = true;
            lblInstructions.Text = "* Select the owner of the Container.  If unknown, Select 'Unknown Owner' from the dropdown list";
        }
        protected void ddGridLoc_SelectedIndexChanged(Object sender, EventArgs e)
        {
            if (ddGridLoc.SelectedIndex == 0 && txbCntrID.Text== "")
            {
                lblCntrCnt.Visible = false;
                lblCntrCntNo.Visible = false;
                btnAddCntr.Visible = false;
                ddCompany.Visible = false;
                btnGo.Visible = false;
                btnPrint.Visible = false;
                lblInstructions.Text = "* Select a location to begin.  Select 'ALL' to see all containers in all locations";
            }
            else
            {
                btnAddCntr.Visible = true;
                btnAddCntr.Enabled = true;                
                ddCompany.Visible = false;
                btnGo.Visible = false;
                lblInstructions.Text = "* Enter a Container ID to find it within the current location or" + "<BR>" +
                    "* Click Add Container button to add an addional container to the current location or" + "<BR>" +
                    "* Click on any existing container row to view/edit container details or print a lable." + "<BR>" +
                    "* To edit a container record, click 'Edit'";
            }
        }
        protected void txbCntrID_TextChanged(Object sender, EventArgs e)
        {
            gvGridLoc.DataBind();
        }
        protected void ddCompany_SelectedIndexChanged(Object sender, EventArgs e)
        {
            if (ddCompany.SelectedIndex != 0)
            {
                btnGo.Visible = true;
                btnAddCntr.Enabled = false;
                lblInstructions.Text = "* Click 'GO' to create a new container for the current location and selected company";
            }
            else
            {
                btnGo.Visible = false;
                btnAddCntr.Enabled = true;
                lblInstructions.Text = "* Select the owner of the Container.  If unknown, Select 'Unknown Owner' from the dropdown list";
            }
        }
        protected void btnGo_Click(Object sender, EventArgs e)
        {
            String sp = "SFund_Container_Ins";
            SqlConnection con = new SqlConnection();
            con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
            SqlCommand spCmd = new SqlCommand(sp, con);
            spCmd.CommandType = CommandType.StoredProcedure;
            con.Open();
            using (spCmd)
            {
                try
                {
                    spCmd.Parameters.AddWithValue("@gridlocation", ddGridLoc.SelectedValue);
                    spCmd.Parameters.AddWithValue("@companyID", ddCompany.SelectedValue);
                    spCmd.Parameters.AddWithValue("@UserName", HttpContext.Current.User.Identity.Name.ToString());
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
                    gvGridLoc.DataBind();
                    ddCompany.SelectedIndex = 0;
                    btnAddCntr.Enabled = true;
                    btnGo.Visible = false;
                    lblInstructions.Text = "";
                }
            }
            gvGridLoc.SelectedIndex = 0;
            gvGridLoc_SelectedIndexChanged(null, null);
        }
        protected void btnReset_Click(Object sender, EventArgs e)
        {
            btnPrint.Visible = false;
            Response.Redirect(Request.RawUrl);
            return;
        }
        protected void gvGridLoc_SelectedIndexChanged(Object sender, EventArgs e)
        {
            GridViewRow row = gvGridLoc.SelectedRow;
            string curCntr = row.Cells[2].Text;

            String sp = "SFund_CntrDetail_Exists";
            SqlConnection con = new SqlConnection();
            con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
            SqlCommand spCmd = new SqlCommand(sp, con);
            spCmd.CommandType = CommandType.StoredProcedure;
            con.Open();
            using (spCmd)
            {
                spCmd.Parameters.AddWithValue("@ContainerID", curCntr);
                object isValid = new object();
                isValid = spCmd.ExecuteScalar();
                if (isValid == null)
                {
                    // No record exists, so insert a new blank record into the table and show 
                    // the record details in update mode.

                    String sp1 = "SFund_CntrDetail_Ins";
                    SqlCommand cmdInsert = new SqlCommand(sp1, con);
                    cmdInsert.CommandType = CommandType.StoredProcedure;
                    using (cmdInsert)
                    {

                        // define insert parameters

                        cmdInsert.Parameters.AddWithValue("@ContainerID", curCntr);
                        cmdInsert.Parameters.AddWithValue("@User", HttpContext.Current.User.Identity.Name.ToString());

                        // Execute query

                        cmdInsert.ExecuteNonQuery();
                        gvGridLoc.DataBind();
                    }
                }
            }
            con.Close();
            gvGridLoc.DataBind();
            btnPrint.Visible = true;
        }
        protected void sdsCntrDetails_Updating(Object sender, SqlDataSourceCommandEventArgs e)
        {
            e.Command.Parameters["@Modby"].Value = HttpContext.Current.User.Identity.Name.ToString();     
        }
        protected void sdsCntrDetails_Updated(Object source, SqlDataSourceStatusEventArgs e)
        {  
            gvGridLoc.DataBind();
        }
        protected void btnPrint_Click(Object sender, EventArgs e)
        {
            Session["ctrl"] = Panel1;
            ClientScript.RegisterStartupScript(this.GetType(), "onclick", "<script language=javascript>window.open('PrintLabel.aspx','PrintMe','height=300px,width=300px,scrollbars=1');</script>");
            Control ctrl = (Control)Session["ctrl"];
            PrintHelper.PrintWebControl(ctrl);         
        }
        protected void sdsGridLoc_Selected(Object sender, SqlDataSourceStatusEventArgs e)
        {
            if (ddGridLoc.SelectedIndex == 0)
            {
                lblCntrCnt.Visible = false;
                lblCntrCntNo.Visible = false;
            }
            else
            {
                lblCntrCnt.Visible = true;
                lblCntrCntNo.Visible = true;
                lblCntrCntNo.Text = e.AffectedRows.ToString();
            }
        }
        protected void sdsGridLoc_Updating(Object sender, SqlDataSourceCommandEventArgs e)
        {
            e.Command.Parameters["@Modby"].Value = HttpContext.Current.User.Identity.Name.ToString();
        }
        protected void gvGridLoc_Editing(Object sender, GridViewEditEventArgs e)
        {
            gvGridLoc.SelectedIndex = -1;
            btnPrint.Visible = false;
        }
        protected void ddProfile_SelectedIndexChanged(Object sender, EventArgs e)
        {
            DropDownList ddl1 = FindControlRecursive(dvContainerDetails, "ddProfile") as DropDownList;
            if (ddl1.SelectedIndex == 0)
            {
                CheckBox ck1 = FindControlRecursive(dvContainerDetails, "ApprovedforRemoval") as CheckBox;
                ck1.Checked = false;
            }
            else
            {
                CheckBox ck1 = FindControlRecursive(dvContainerDetails, "ApprovedforRemoval") as CheckBox;
                ck1.Checked = true;
            }
        }
        protected void fvLabel_OnDataBound(Object sender, EventArgs e)
        {
            CheckBox ck1 = FindControlRecursive(dvContainerDetails, "SampleNeeded") as CheckBox;
            CheckBox ck2 = FindControlRecursive(dvContainerDetails, "SampleCompleted") as CheckBox;
            Label lbl1 = FindControlRecursive(fvLabel, "lblSampleID") as Label;
            if (ck2 != null && ck1 != null && lbl1 != null)
            {
                if (ck2.Checked)
                {
                    lbl1.Text = "Sampling Completed";
                }
                else if (ck1.Checked)
                {
                    lbl1.Text = "Sampling Needed";
                }
                else
                {
                    lbl1.Text = "";
                }
            }
        }
        private Control FindControlRecursive(Control control, string id)
        {
            Control returnControl = control.FindControl(id);
            if (returnControl == null)
            {
                foreach (Control child in control.Controls)
                {
                    returnControl = child.FindControl(id);
                    if (returnControl != null && returnControl.ID == id) 
                    {
                        return returnControl; 
                    }
                }
            }
            return returnControl; 
        }
    }
}   