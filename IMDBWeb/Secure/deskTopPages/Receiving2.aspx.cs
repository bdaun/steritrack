    using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

namespace IMDBWeb.Secure.deskTopPages
{
    public partial class Receiving2 : System.Web.UI.Page
    {
        private GridViewHelper helper;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblErrMsg.Visible = false;
                lblTruckMsg.Visible = false;
                tblSearch.Visible = false;
                tblNewTruck.Visible = false;
                tblBegin.Visible = true;
                trContainerDetails.Visible = false;
            }
            helper = new GridViewHelper(gvSummary);
            GridViewSummary s = helper.RegisterSummary("NumberContainers", SummaryOperation.Sum);
            s.Automatic = false;
            s = helper.RegisterSummary("TotalWeight", SummaryOperation.Sum);
            s.Automatic = false;
            helper.GeneralSummary += new FooterEvent(helper_ManualSummary);
        }

        private void helper_ManualSummary(GridViewRow row)
        {
            GridViewRow newRow = helper.InsertGridRow(row);
            newRow.Cells[0].HorizontalAlign = HorizontalAlign.Right;
            newRow.Cells[0].Text = String.Format("Total: {0:n0} Containers,&nbsp&nbsp&nbsp&nbsp{1:n0} lbs", helper.GeneralSummaries["NumberContainers"].Value, helper.GeneralSummaries["TotalWeight"].Value);
            newRow.Cells[0].ForeColor = System.Drawing.Color.Black;
            newRow.Cells[0].Font.Bold = true;
        }

        protected void btnSearchTruck_Click(object sender, EventArgs e)
        {
            tblSearch.Visible = true;
            tblNewTruck.Visible = false;
            tblBegin.Visible = false;
            Session.Abandon();
            fvNewTruck.ChangeMode(FormViewMode.ReadOnly);
        }

        protected void btnCancelSearch_Click(object sender, EventArgs e)
        {
            tblBegin.Visible = true;
            tblSearch.Visible = false;
            tblNewTruck.Visible = false;
            ddClient.SelectedIndex = 0;
            txbOrderNumber.Text = string.Empty;
            txbBegDate.Text = string.Empty;
            txbEndDate.Text = string.Empty;
            sdsRcvHdr.SelectParameters["OrderNumber"].DefaultValue = null;
        }

        protected void ddClient_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txbOrderNumber.Text) || string.IsNullOrWhiteSpace(txbOrderNumber.Text))
            {
                sdsRcvHdr.SelectParameters["OrderNumber"].DefaultValue = "All";
            }
            else
            {
                sdsRcvHdr.SelectParameters["OrderNumber"].DefaultValue = null;
            }
            gvRcvHdr.DataBind();
            gvRcvHdr.SelectedIndex = -1;
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txbOrderNumber.Text) || string.IsNullOrWhiteSpace(txbOrderNumber.Text))
            {
                sdsRcvHdr.SelectParameters["OrderNumber"].DefaultValue = "All";
            }
            else
            {
                sdsRcvHdr.SelectParameters["OrderNumber"].DefaultValue = null;
            }
            gvRcvHdr.DataBind();
            if (gvRcvHdr.Rows.Count > 0)
            {
                lblTruckMsg.Visible = true;
            }
            else
            {
                lblTruckMsg.Visible = false;
            }
        }

        protected void gvRcvHdr_DataBound(object sender, EventArgs e)
        {
            if (gvRcvHdr.Rows.Count > 0)
            {
                lblTruckMsg.Visible = true;
                if (gvRcvHdr.SelectedIndex == -1)
                {
                    lblTruckMsg.Text = "Click on a row from the available trucks to manage containers";
                }  
                else if(gvRcvHdr.SelectedIndex > 0)
                {
                    lblTruckMsg.Text = "Showing Containers for this truck ";
                }
            }
            else
            {
                lblTruckMsg.Visible = false;
            }
        }

        protected void gvRcvHdr_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes.Add("onmouseover", "this.previous_color=this.style.backgroundColor;this.style.backgroundColor='#ceedfc'");
                e.Row.Attributes.Add("onmouseout", "this.style.backgroundColor=this.previous_color");
                e.Row.Attributes.Add("style", "cursor:pointer;");
                e.Row.Attributes.Add("onclick", ClientScript.GetPostBackClientHyperlink(this.gvRcvHdr, "Select$" + e.Row.RowIndex));
            }
        }
        protected void gvRcvHdr_SelectedIndexChanged(object sender, EventArgs e)
        {
            trAddContainers.Visible = true;
            trContainerDetails.Visible = true;
            tblSearch.Visible = false;
            tblNewTruck.Visible = false;
            Session["CurRcvHdrID"] = gvRcvHdr.SelectedDataKey.Value.ToString();
            sdsRcvHdr.SelectParameters["OrderNumber"].DefaultValue = "All";
            ddClient.SelectedIndex = 0;
            gvRcvHdr.DataBind();
            gvContainers.DataBind();
        }
        protected void btnDone_Click(object sender, EventArgs e)
        {
            lblErrMsg.Text = string.Empty;
            lblErrMsg.Visible = false;
            trAddContainers.Visible = false;
            tdContainerEdit.Visible = false;
            tblSearch.Visible = false;
            tblNewTruck.Visible = false;
            tblBegin.Visible = true;
            ddClient.SelectedIndex = 0;
            txbOrderNumber.Text = string.Empty;
            trSummary.Visible = false;
            btnSummary.Text = "Show Summary";
            Session["CurRcvHdrID"] = 0;
            sdsRcvHdr.SelectParameters["OrderNumber"].DefaultValue = null;
            gvRcvHdr.DataBind();
            Session.Abandon();
        }

        protected void btnAddContainer_Click(object sender, EventArgs e)
        {
            trContainerDetails.Visible = true;
            tdContainerEdit.Visible = true;
            fvContainerDetail.ChangeMode(FormViewMode.Insert);
        }
        protected void InsCancel_Click(object sender, EventArgs e)
        {
            tdContainerEdit.Visible = false;
        }

        protected void UpdCancel_Click(object sender, EventArgs e)
        {
            tdContainerEdit.Visible = false;
        }

        protected void fvNewTruck_Command(object sender, FormViewCommandEventArgs e)
        {
            if(e.CommandName=="Cancel")
            {
            tblNewTruck.Visible = false;
            tblSearch.Visible = false;
            tblBegin.Visible = true;
            }
        }
        protected void fvContainerDetailsUpd_Click(object sender, EventArgs e)
        {
            String spUpd = "IMDB_Receive_Container_Upd";
            SqlConnection con = new SqlConnection();
            con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
            SqlCommand UpdCmd = new SqlCommand(spUpd, con);
            UpdCmd.CommandType = CommandType.StoredProcedure;
            con.Open();
            using (UpdCmd)
            {
                try
                {
                    UpdCmd.Parameters.AddWithValue("RcvDetailID", Session["CurDetailID"].ToString());
                    UpdCmd.Parameters.AddWithValue("@UserName", HttpContext.Current.User.Identity.Name.ToString());
                    UpdCmd.Parameters.AddWithValue("@InboundDocNo", ((TextBox)fvContainerDetail.FindControl("InboundDocNoTextBox")).Text);
                    UpdCmd.Parameters.AddWithValue("@ManifestLineNumber", Convert.ToInt32(((TextBox)fvContainerDetail.FindControl("ManLineTextBox")).Text));
                    UpdCmd.Parameters.AddWithValue("@RcvHdrID", Session["CurRcvHdrID"].ToString());
                    UpdCmd.Parameters.AddWithValue("@InboundProfileID", Convert.ToInt32(((DropDownList)fvContainerDetail.FindControl("ddProfile")).Text));
                    UpdCmd.Parameters.AddWithValue("@InboundContainerType", ((DropDownList)fvContainerDetail.FindControl("ddContainerType")).Text);
                    UpdCmd.Parameters.AddWithValue("@InboundPalletType", ((DropDownList)fvContainerDetail.FindControl("ddPalletType")).Text);
                    UpdCmd.Parameters.AddWithValue("@InboundPalletWeight", Convert.ToInt32(((TextBox)fvContainerDetail.FindControl("InboundPalletWeightTextBox")).Text));
                    UpdCmd.Parameters.AddWithValue("@InboundContainerQty", Convert.ToInt32(((TextBox)fvContainerDetail.FindControl("InboundContainerQtyTextBox")).Text));
                    UpdCmd.Parameters.AddWithValue("@InboundContainerID", ((TextBox)fvContainerDetail.FindControl("InboundContainerIDTextBox")).Text);
                    UpdCmd.Parameters.AddWithValue("@InventoryLocation", ((DropDownList)fvContainerDetail.FindControl("ddLocation")).Text);
                    UpdCmd.Parameters.AddWithValue("@BrandCode", ((Label)fvContainerDetail.FindControl("lblBrandCodeID")).Text);
                    UpdCmd.Parameters.AddWithValue("@ProcessPlan", ((DropDownList)fvContainerDetail.FindControl("ddProcessPlan")).Text);
                    UpdCmd.Parameters.AddWithValue("@RcvdAs", ((DropDownList)fvContainerDetail.FindControl("ddRcvdAs")).Text);

                    UpdCmd.ExecuteNonQuery();
                }
                catch (SqlException ex)
                {
                    if (ex.ErrorCode == -2146232060)
                    {
                        // there is already a record with this container ID
                        lblErrMsg.Text = "There is already a record with this container ID.  Please scan/enter a new containerID or contact your supervisor";
                        lblErrMsg.Visible = true;
                    }
                    else
                    {
                        lblErrMsg.Text = ex.ToString();
                        lblErrMsg.Visible = true;
                    }
                }
                finally
                {
                    con.Close();
                    gvContainers.DataBind();
                    fvContainerDetail.DataBind();
                    gvSummary.DataBind();
                    tdContainerEdit.Visible = false;
                }
            }
        
        }
        protected void fvContainerDetailsIns_Click(object sender, EventArgs e)
        {
            lblErrMsg.Visible = false;
            lblErrMsg.Text = string.Empty;
            String spIns = "IMDB_Receive_Container_Ins";
            SqlConnection con = new SqlConnection();
            con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
            SqlCommand InsCmd = new SqlCommand(spIns, con);
            InsCmd.CommandType = CommandType.StoredProcedure;
            con.Open();
            using (InsCmd)
            {
                try
                {
                    InsCmd.Parameters.AddWithValue("@UserName", HttpContext.Current.User.Identity.Name.ToString());
                    InsCmd.Parameters.AddWithValue("@InboundDocNo", ((TextBox)fvContainerDetail.FindControl("InboundDocNoTextBox")).Text);
                    InsCmd.Parameters.AddWithValue("@ManifestLineNumber", Convert.ToInt32(((TextBox)fvContainerDetail.FindControl("ManLineTextBox")).Text));
                    InsCmd.Parameters.AddWithValue("@RcvHdrID", Session["CurRcvHdrID"].ToString());
                    InsCmd.Parameters.AddWithValue("@InboundProfileID", Convert.ToInt32(((DropDownList)fvContainerDetail.FindControl("ddProfile")).Text));
                    InsCmd.Parameters.AddWithValue("@InboundContainerType", ((DropDownList)fvContainerDetail.FindControl("ddContainerType")).Text);
                    InsCmd.Parameters.AddWithValue("@InboundPalletType", ((DropDownList)fvContainerDetail.FindControl("ddPalletType")).Text);
                    InsCmd.Parameters.AddWithValue("@InboundPalletWeight", Convert.ToInt32(((TextBox)fvContainerDetail.FindControl("InboundPalletWeightTextBox")).Text));
                    InsCmd.Parameters.AddWithValue("@InboundContainerQty", Convert.ToInt32(((TextBox)fvContainerDetail.FindControl("InboundContainerQtyTextBox")).Text));
                    InsCmd.Parameters.AddWithValue("@InboundContainerID",  ((TextBox)fvContainerDetail.FindControl("InboundContainerIDTextBox")).Text);
                    InsCmd.Parameters.AddWithValue("@InventoryLocation", ((DropDownList)fvContainerDetail.FindControl("ddLocation")).Text);
                    InsCmd.Parameters.AddWithValue("@BrandCode", ((Label)fvContainerDetail.FindControl("lblBrandCodeID")).Text);
                    InsCmd.Parameters.AddWithValue("@ProcessPlan", ((DropDownList)fvContainerDetail.FindControl("ddProcessPlan")).Text);
                    InsCmd.Parameters.AddWithValue("@RcvdAs", ((DropDownList)fvContainerDetail.FindControl("ddRcvdAs")).Text);

                    InsCmd.ExecuteNonQuery();
                }
                catch (SqlException ex)
                {
                    if (ex.ErrorCode == -2146232060)
                    {
                        // there is already a record with this container ID
                        lblErrMsg.Text = "There is already a record with this container ID.  Please scan/enter a new containerID or contact your supervisor";
                        lblErrMsg.Visible = true;
                    }
                    else
                    {
                        lblErrMsg.Text = ex.ToString();
                        lblErrMsg.Visible = true;
                    }
                }
                finally
                {
                    con.Close();
                    gvContainers.DataBind();
                    fvContainerDetail.DataBind();
                    gvSummary.DataBind();
                }
            }
        }

        protected void fvContainerDetail_DataBound(object sender, EventArgs e)
        { 
            Control ctrl = fvContainerDetail.FindControl("InboundDocNoTextBox"); 
            if (ctrl != null) 
            { 
                ctrl.Focus(); 
            } 
        }
        protected void txbBrandCodes_SelectedIndexChanged(object sender, EventArgs e)
        {
            string SelBCName = ((TextBox)fvContainerDetail.FindControl("txbBrandCodes")).Text;
            string SelBCID = string.Empty;

            String spBCID = "IMDB_Receive_GetBrandCodeIDs_Sel";
            SqlConnection con = new SqlConnection();
            con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
            SqlCommand spCmd = new SqlCommand(spBCID, con);
            spCmd.CommandType = CommandType.StoredProcedure;
            con.Open();
            spCmd.Parameters.AddWithValue("@Product", SelBCName);
            SqlDataReader rdr = spCmd.ExecuteReader();
            while (rdr.Read())
            {
                ((Label)fvContainerDetail.FindControl("lblBrandCodeID")).Text = rdr["BCID"].ToString();
                SelBCID = rdr["BCID"].ToString();
                ((DropDownList)fvContainerDetail.FindControl("ddProfile")).SelectedValue = rdr["Profileid"].ToString();
            }
            rdr.Close();

            string SelProcPlan = string.Empty;
            String spProcPlan = "IMDB_Receive_GetProcessPlan_Sel";
            SqlCommand spCmd1 = new SqlCommand(spProcPlan, con);
            spCmd1.CommandType = CommandType.StoredProcedure;
            spCmd1.Parameters.AddWithValue("@BCID", SelBCID);
            SqlDataReader rdr1 = spCmd1.ExecuteReader();
            while (rdr1.Read())
            {
                SelProcPlan = rdr1["ProcessPlan"].ToString();

                if (string.IsNullOrEmpty(SelProcPlan) == true || SelProcPlan.ToString()== "")
                {
                    SelProcPlan = "Select...";
                }
                ((DropDownList)fvContainerDetail.FindControl("ddProcessPlan")).SelectedValue = SelProcPlan;
            }
            rdr1.Close();
            ((TextBox)fvContainerDetail.FindControl("ManLineTextBox")).Focus();
        }
        protected void gvContainers_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case "EditDetail":
                    int index = Int32.Parse(e.CommandArgument.ToString());
                    Session["CurDetailID"] = index;
                    trContainerDetails.Visible = true;
                    tdContainerEdit.Visible = true;
                    tdContainerDuplicate.Visible = false;
                    fvContainerDetail.ChangeMode(FormViewMode.Edit);
                    fvContainerDetail.DataSourceID = "sdsContainer_Edit";
                    break;
                case "DupeDetail":
                    Session["CurDetailID"] = Int32.Parse(e.CommandArgument.ToString());
                    trContainerDetails.Visible = true;
                    tdContainerDuplicate.Visible = true;
                    tdContainerEdit.Visible = false;
                    lblCntrID_Dup.Text = "Please enter a new Container ID to duplicate values in RcvDetailID '" + Session["CurDetailID"] + "'";
                    txbNewCntrID.Focus();
                    break;
            }
        }

        protected void btnCreateDup_Click(object sender, EventArgs e)
        {
            String spDup = "IMDB_Receive_Container_Dup";
            SqlConnection con = new SqlConnection();
            con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
            SqlCommand DupCmd = new SqlCommand(spDup, con);
            DupCmd.CommandType = CommandType.StoredProcedure;
            con.Open();
            using (DupCmd)
            {
                try
                {
                    DupCmd.Parameters.AddWithValue("@UserName", HttpContext.Current.User.Identity.Name.ToString());
                    DupCmd.Parameters.AddWithValue("@InboundContainerID", txbNewCntrID.Text);
                    DupCmd.Parameters.AddWithValue("RcvDetailID", Session["CurDetailID"].ToString());

                    DupCmd.ExecuteNonQuery();
                }
                catch (SqlException ex)
                {
                    if (ex.ErrorCode == -2146232060)
                    {
                        // there is already a record with this container ID
                        lblErrMsg.Text = "There is already a record with this container ID.  Please scan/enter a new containerID or contact your supervisor";
                        lblErrMsg.Visible = true;
                    }
                    else
                    {
                        lblErrMsg.Text = ex.ToString();
                        lblErrMsg.Visible = true;
                    }
                }
                finally
                {
                    con.Close();
                    gvContainers.DataBind();
                    fvContainerDetail.DataBind();
                    gvSummary.DataBind();
                    txbNewCntrID.Text = "";
                    tdContainerDuplicate.Visible = false;
                    trContainerDetails.Visible = false;
                }
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            lblErrMsg.Text = string.Empty;
            lblErrMsg.Visible = false;
            txbNewCntrID.Text = "";
            tdContainerDuplicate.Visible = false;
            trContainerDetails.Visible = false;
        }

        protected void btnNewTruck_Click(object sender, EventArgs e)
        {
            tblBegin.Visible = false;
            tblNewTruck.Visible = true;
            fvNewTruck.ChangeMode(FormViewMode.Insert); 
        }

        protected void sdsNewTruck_Inserting(Object sender, SqlDataSourceCommandEventArgs e)
        {
            e.Command.Parameters["@UserName"].Value = HttpContext.Current.User.Identity.Name.ToString();
        }

        protected void sdsNewTruck_Inserted(object sender, SqlDataSourceStatusEventArgs e)
        {
            tblNewTruck.Visible = false;
            tblSearch.Visible = false;
            tblBegin.Visible = false;
            Session["CurRcvHdrID"] = Convert.ToInt32(e.Command.Parameters["@ID"].Value);
            sdsRcvHdr.SelectParameters["OrderNumber"].DefaultValue = "All";
            gvRcvHdr.DataBind();
            gvRcvHdr.SelectedIndex = 0;
            fvContainerDetail.DataBind();
            trContainerDetails.Visible = true;
            tdContainerEdit.Visible = true;
            trAddContainers.Visible = true;
            fvContainerDetail.ChangeMode(FormViewMode.Insert);
        }

        protected void txbNewOrderNumber_Validate(object source, ServerValidateEventArgs args)
        {
            string spExist = "IMDB_Receive_OrderNumbers_Exist";
            SqlConnection con = new SqlConnection();
            con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
            SqlCommand spCmdExist = new SqlCommand(spExist, con);
            spCmdExist.CommandType = CommandType.StoredProcedure;
            con.Open();
            using (spCmdExist)
            {
                spCmdExist.Parameters.AddWithValue("@OrderNumber", ((TextBox)fvNewTruck.FindControl("txbNewOrderNumber")).Text);
                object OrderExist = new object();
                OrderExist = spCmdExist.ExecuteScalar();
                if(OrderExist == null)
                {
                    args.IsValid = false;
                }
                else
	            {
                    args.IsValid = true;
	            }  
            }
        }

        protected void btnSummary_Click(object sender, EventArgs e)
        {
            if(btnSummary.Text=="Show Summary")
            {
                btnSummary.Text = "Hide Summary";
                trSummary.Visible = true;
                gvSummary.DataBind();
            }
            else
            {
                btnSummary.Text = "Show Summary";
                trSummary.Visible = false;
            }
        } 
    }
}