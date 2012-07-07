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
    public partial class TruckOut : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                sdsOutBoundDocNo.FilterExpression = "Completed = {0}";
                trAddCntr.Visible = false;
                trErrMsg.Visible = false;
            }
            else
            {
                if(trAddCntr.Visible==true)
                {
                    txbNewCntr.Focus();
                }
                GridViewHelper helper = new GridViewHelper(gvTally);
                helper.RegisterSummary("NumberofCntrs", SummaryOperation.Sum);
                helper.RegisterSummary("TotalWeight", SummaryOperation.Sum);
            }
        }
        private void helper_GroupHeader(string groupName, object[] values, GridViewRow row)
        {
                row.BackColor = System.Drawing.Color.FromArgb(236, 236, 236);
                row.Cells[0].Text = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + row.Cells[0].Text;
        }
        protected void rblFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            sdsOutBoundDocNo.FilterExpression = "Completed = {0}";
            ddDocList.Items.Clear();
            ddDocList.Items.Add("Select a Document");
            ddDocList.DataBind();
            trAddCntr.Visible = false;
            trErrMsg.Visible = false;
        }
        protected void sdsTruckOut_OnDataBinding(object sender, EventArgs e)
        {
            sdsTruckOut.FilterExpression = "Completed = {0}";
        }
        protected void sdsTruckOut_Updating(Object sender, SqlDataSourceCommandEventArgs e)
        {
            e.Command.Parameters["@User"].Value = HttpContext.Current.User.Identity.Name.ToString();
            e.Command.Parameters["@outboundcontainerid"].Value = Session["CurCntrID"];
            e.Command.Parameters["@ActAggrWt"].Value = Session["CurAggrWt"];  
        }
        protected void sdsTruckOut_Updated(object sender, EventArgs e)
        {
            gvContainers.DataBind();
            gvTally.DataBind();
        }
        protected void sdsTruckOut_Deleting(Object sender, SqlDataSourceCommandEventArgs e)
        {
            e.Command.Parameters["@outboundcontainerID"].Value = Session["CurCntrID"];
            e.Command.Parameters["@User"].Value = HttpContext.Current.User.Identity.Name.ToString();
        }
        protected void ddDocList_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (rblFilter.SelectedValue == "0")
            {
                trAddCntr.Visible = true;
                txbNewCntr.Focus();
            }
            else
            {
                trAddCntr.Visible = false;
            }
            gvTally.DataBind();
        }
        protected void gvContainers_onDataBound(object sender, EventArgs e)
        {
            const int editColumn = 0;
            const int removeColumn = 10;
            if (rblFilter.SelectedIndex == 0)
            {
                this.gvContainers.Columns[editColumn].Visible = true;
                this.gvContainers.Columns[removeColumn].Visible = true;
            }
            else
            {
                this.gvContainers.Columns[editColumn].Visible=false;
                this.gvContainers.Columns[removeColumn].Visible = false;
            }
            gvTally.DataBind();
        }
        protected void gvContainers_onRowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Delete")
            {
                int rindex = Convert.ToInt32(e.CommandArgument);
                GridViewRow selectedRow = gvContainers.Rows[rindex];
                string Rmvoutcntrid = ((Label)selectedRow.FindControl("outboundcontainerid")).Text;
                Session["CurCntrID"] = Rmvoutcntrid;
                trErrMsg.Visible = true;
                lblErrMsg.Text = "Please remove this container from the truck and place in the Dock area: " + Session["CurCntrID"];
            }
            else if(e.CommandName=="Update")
            {
                GridViewRow row = (GridViewRow)(((LinkButton)e.CommandSource).NamingContainer);
                string Updoutcntrid = ((Label)row.FindControl("outboundcontainerid")).Text;
                Int32 UpAggrWt = Convert.ToInt32(((TextBox)row.FindControl("ActAggrWt")).Text);
                Int32 UpAggrQty = Convert.ToInt32(((Label)row.FindControl("AggrQty")).Text);
                Session["CurCntrID"] = Updoutcntrid;
                Session["CurAggrWt"] = UpAggrWt/UpAggrQty;
                trErrMsg.Visible = true;
                lblErrMsg.Text = "The actual ship weight has been updated for container: " + Session["CurCntrID"];

            }
        }
        protected void gvContainers_RowDatabound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes.Add("onmouseover", "this.previous_color=this.style.backgroundColor;this.style.backgroundColor='#ceedfc'");
                e.Row.Attributes.Add("onmouseout", "this.style.backgroundColor=this.previous_color");
                e.Row.Attributes.Add("style", "cursor:pointer;");
                if (e.Row.Cells[11].Text == "True")
                {
                    e.Row.ForeColor = System.Drawing.Color.Red;
                    e.Row.Font.Bold = true;
                }
            }
        }
        protected void txbNewCntr_TextChanged(object sender, EventArgs e)
        {
        //  Determine if scanned cntr is IN or OUT 
            //  if OUT:
                //  Confirm that the cntrID exists in procdetails table.  If not prompt user to contact supervision.
                //  Check to see if that outbound document has ShipHdr.Complete = 1
                    //  If yes, then alert user that there is significant error with this container and to contact supervision
                //  update current procdetail record with new outboundcntrID and shipped='1' for all procDetails with that OUT cntr
            //  if IN:
                //  Confirm that the CntrID exists in the rcvDetails table.  If not prompt user to receive the container before proceeding.
                //  Determine if a ProcDetail record exists.  
                    //  if yes, prompt user to contact Supervision
                    //  if no, determine if ProcHdr exists (rare case of ProcHdr w no ProcDetails)
                        //  if yes, create ProcDetail line
                        //  if no, create procHdr, ProcDetail

            if (txbNewCntr.Text.StartsWith("O"))   //  Case for OUT containers
            {
                String sp = "SP_IMDB_TruckOut_Upd";
                String Curoutbounddocno = String.Empty;
                String completed = String.Empty;

                SqlConnection CntrConnect = new SqlConnection();
                CntrConnect.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
                SqlCommand CntrCmd = new SqlCommand(sp, CntrConnect);
                CntrCmd.CommandType = CommandType.StoredProcedure;
                CntrConnect.Open();

                using (CntrCmd)  //  Determine if there is an outbound container in the system with the scanned OUT ID
                {
                    CntrCmd.Parameters.AddWithValue("@outboundcontainerID", txbNewCntr.Text);
                    SqlDataReader Reader = CntrCmd.ExecuteReader();
                    if (!Reader.HasRows)
                    {
                        trErrMsg.Visible = true;
                        lblErrMsg.Text = "This container does not exist in the Process Detail table.  Please contact your supervisor.";
                        return;
                    }
                    else  // ProcDetail record exists.  Collect the current information
                    {
                        using (Reader)
                        {
                            try
                            {
                                while (Reader.Read())
                                {
                                    completed = Reader["completed"].ToString();
                                }
                            }
                            catch (Exception ex)
                            {
                                trErrMsg.Visible = true;
                                lblErrMsg.Text = ex.ToString();
                            }
                            Reader.Close();
                        }
                    }
                }
                CntrConnect.Close();
                if (completed.ToString() == "True") // You cannot update an container that has already shipped.
                {
                    trErrMsg.Visible = true;
                    lblErrMsg.Text = "This container is associated with an OutboundDoc (" + Curoutbounddocno + ") that has already Shipped.  Please contact Supervision Immediately!";
                    txbNewCntr.Text = "";
                    txbNewCntr.Focus();
                }
                else  // ProcDetail record for container can be udpated
                {
                    SqlConnection con = new SqlConnection();
                    con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
                    String spUpdate = "SP_TruckOut_UpdOutboundDocNo";
                    SqlCommand cmd = new SqlCommand(spUpdate, con);
                    using (cmd)
                    {
                        try
                        {
                            cmd.CommandType = CommandType.StoredProcedure;
                            con.Open();
                            cmd.Parameters.AddWithValue("@outboundcontainerID", txbNewCntr.Text);
                            cmd.Parameters.AddWithValue("@outbounddocno", ddDocList.SelectedItem.ToString());
                            cmd.ExecuteNonQuery();
                        }
                        catch (Exception ex)
                        {
                            trErrMsg.Visible = true;
                            lblErrMsg.Text = ex.ToString();
                        }

                        con.Close();
                    }
                    gvContainers.DataBind();
                    trErrMsg.Visible = false;
                    txbNewCntr.Text = "";
                    txbNewCntr.Focus();
                }
            }
            else   //  this is the IN Cntr Case
            {
                String spRcvDetail = "SP_IMDB_RcvDetail_Sel";
                SqlConnection con = new SqlConnection();
                con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
                SqlCommand rcvCmd = new SqlCommand(spRcvDetail, con);
                rcvCmd.CommandType = CommandType.StoredProcedure;
                con.Open();

                try    //  Determine if the entered value exists in the rcvdetail table.  If existing, get current values.
                {
                    using (rcvCmd)
                    {
                        rcvCmd.Parameters.AddWithValue("@inboundcontainerid", txbNewCntr.Text);
                        SqlDataReader Reader = rcvCmd.ExecuteReader();
                        if (!Reader.HasRows)
                        {
                            trErrMsg.Visible = true;
                            lblErrMsg.Text = "This container has not been received in the system. " + "<br/>" +
                                "Please receive the container BEFORE putting on the Truck. " + "<br/>" +
                                "This container has NOT been added to the outbound document!";
                            return; 
                        }
                        else
                        {
                            while(Reader.Read())
                            {
                                Session["RcvID"] =(int)Reader["RcvID"];
                                Session["RcvHdrID"] = (int)Reader["RcvHdrID"];
                                Session["InboundProfileID"] = (int)Reader["inboundprofileid"];
                                Session["InboundContainerType"] = Reader["InboundContainertype"];
                                Session["InboundPalletType"] = Reader["InboundPalletType"].ToString();
                                Session["InboundPalletweight"] = (int)Reader["InboundPalletWeight"];
                                Session["Inboundcontainerqty"] = (int)Reader["InboundContainerQty"];
                                Session["Inboundcontainerid"] = Reader["InboundContainerID"].ToString();
                            }
                            Reader.Close();
                        }
                    }
                }
                catch (Exception ex)
                {
                    // Display error
                    trErrMsg.Visible = true;
                    lblErrMsg.Text = ex.ToString();
                }

                try  // Determine if a procDetail record exists for this IN Cntr
                {
                    string spProcDetailExists = "SP_IMDB_TruckOUT_pdExist";
                    SqlCommand pdChk = new SqlCommand(spProcDetailExists,con);
                    pdChk.CommandType = CommandType.StoredProcedure;
                    using (pdChk)
                    {
                        String ProcHdrID = string.Empty;
                        String ProcDetailID = string.Empty;
                        String OutboundContainerID = string.Empty;
                        String xOutboundContainerID = string.Empty;
                        pdChk.Parameters.AddWithValue("@CntrID", txbNewCntr.Text);
                        SqlDataReader Reader = pdChk.ExecuteReader();
                        if (Reader.HasRows) // Meaning there is a prochdr and possibly a proc detail
                        {
                            while (Reader.Read())
                            {
                                ProcHdrID = Reader["prochdrID"].ToString();
                                ProcDetailID = Reader["procdetailID"].ToString();
                                OutboundContainerID = Reader["OutboundContainerID"].ToString();
                                if (OutboundContainerID == txbNewCntr.Text)
                                {
                                    xOutboundContainerID = OutboundContainerID;  // This is the case where an OUT containerID begins w/ IN
                                }
                            }
                            Reader.Close();
                            if (ProcDetailID == "")  // Need to add record to exising ProcHdr
                            {
                                string spInsProcDetail = "SP_IMDB_ProcDetail_Ins";
                                SqlCommand insProcDetail = new SqlCommand(spInsProcDetail, con);
                                insProcDetail.CommandType = CommandType.StoredProcedure;
                                using (insProcDetail)
                                {
                                    insProcDetail.Parameters.AddWithValue("@OutboundcontainerID", txbNewCntr.Text);
                                    insProcDetail.Parameters.AddWithValue("@UserName", HttpContext.Current.User.Identity.Name.ToString());
                                    insProcDetail.Parameters.AddWithValue("@ProchdrID", ProcHdrID);
                                    insProcDetail.Parameters.AddWithValue("@OutboundStreamProfile", Session["inboundprofileid"]);
                                    insProcDetail.Parameters.AddWithValue("@OutboundContainerType", Session["inboundcontainertype"]);
                                    insProcDetail.Parameters.AddWithValue("@OutboundPalletType", Session["inboundpallettype"]);
                                    insProcDetail.Parameters.AddWithValue("@Outboundstreamweight", Session["inboundpalletweight"]);
                                    insProcDetail.Parameters.AddWithValue("@OutboundCntrQty", Session["inboundcontainerqty"]);
                                    insProcDetail.Parameters.AddWithValue("@OutboundDocNo", ddDocList.SelectedItem.ToString());

                                    insProcDetail.ExecuteNonQuery();
                                }
                            }
                            else  //  A ProcDetail record exists.  
                                  //  If the scanned container is in procdetail table, update the procdetail line for truck out.  
                                  //  If not, prompt user to scan the OUT cntr ID from the process detail record
                            {

                                //  First, test to see if the txbNewCntr value exists in the ProcDetail table.  If yes, update record.
                                if (xOutboundContainerID == txbNewCntr.Text)
                                {
                                    String spUpdate = "SP_TruckOut_UpdOutboundDocNo";
                                    SqlCommand cmd = new SqlCommand(spUpdate, con);
                                    using (cmd)
                                    {
                                        try
                                        {
                                            cmd.CommandType = CommandType.StoredProcedure;
                                            cmd.Parameters.AddWithValue("@outboundcontainerID", txbNewCntr.Text);
                                            cmd.Parameters.AddWithValue("@outbounddocno", ddDocList.SelectedItem.ToString());
                                            cmd.ExecuteNonQuery();
                                        }
                                        catch (Exception ex)
                                        {
                                            trErrMsg.Visible = true;
                                            lblErrMsg.Text = ex.ToString();
                                        }

                                        con.Close();
                                    }
                                }
                                else
	                            {
                                    trErrMsg.Visible = true;
                                    lblErrMsg.Text = "There is an exising proc detail record for this container.  Please scan the OutboundContainerID.";
	                            }
                            }
                        }
                        else  // There is no ProcHdr.  Must create ProcHdr and ProcDetail record
                        {
                        Reader.Close();
                        string spInsProcHdr = "SP_IMDB_ProcHdr_Ins";
                        string spInsProcDetail = "SP_IMDB_ProcDetail_Ins";
                        SqlCommand insProcHdr = new SqlCommand(spInsProcHdr, con);
                        SqlCommand insProcDetail = new SqlCommand(spInsProcDetail,con);
                        insProcHdr.CommandType = CommandType.StoredProcedure;
                        insProcDetail.CommandType = CommandType.StoredProcedure;
                        int lastID;  //  will be used to capture newly created prochdr for inserts into procdetail table

                            try
                            {   
                                using (insProcHdr)
                                {
                                    SqlParameter processHeaderIdParameter = new SqlParameter("@ProcessHdrId", SqlDbType.Int);
                                    processHeaderIdParameter.Direction = ParameterDirection.Output;
                                    insProcHdr.Parameters.Add(processHeaderIdParameter);
                                    insProcHdr.Parameters.AddWithValue("@CntrID", txbNewCntr.Text);
                                    insProcHdr.Parameters.AddWithValue("@ProcessorName", HttpContext.Current.User.Identity.Name.ToString());   // made change here

                                    insProcHdr.ExecuteNonQuery();
                                    lastID = (int)processHeaderIdParameter.Value;
                                    Session["ProcHdrID"] = lastID;   // will use this value if new process detail record is added
                                }
                                using(insProcDetail)
                                {
                                    insProcDetail.Parameters.AddWithValue("@OutboundcontainerID",txbNewCntr.Text);
                                    insProcDetail.Parameters.AddWithValue("@UserName", HttpContext.Current.User.Identity.Name.ToString());
                                    insProcDetail.Parameters.AddWithValue("@ProchdrID", lastID);
                                    insProcDetail.Parameters.AddWithValue("@OutboundStreamProfile",Session["inboundprofileid"]);
                                    insProcDetail.Parameters.AddWithValue("@OutboundContainerType",Session["inboundcontainertype"]);
                                    insProcDetail.Parameters.AddWithValue("@OutboundPalletType",Session["inboundpallettype"]);
                                    insProcDetail.Parameters.AddWithValue("@Outboundstreamweight",Session["inboundpalletweight"]);
                                    insProcDetail.Parameters.AddWithValue("@OutboundCntrQty",Session["inboundcontainerqty"]);
                                    insProcDetail.Parameters.AddWithValue("@OutboundDocNo",ddDocList.SelectedItem.ToString());

                                    insProcDetail.ExecuteNonQuery();
                                }
                            }
                            catch (Exception ex)
                            {
                                trErrMsg.Visible = true;
                                lblErrMsg.Text = ex.ToString();
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    trErrMsg.Visible = true;
                    lblErrMsg.Text = ex.ToString();
                }
                finally
                {
                    //close up connection
                    con.Close();
                    gvContainers.DataBind();
                    gvTally.DataBind();
                    txbNewCntr.Text = "";
                    txbNewCntr.Focus();
                    Session.Abandon();
                }
            }
        }
    }
}
 