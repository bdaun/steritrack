using System;
using System.Web;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Web.UI;

namespace IMDBWeb.Secure.IndustrialPages
{
    public partial class TruckOut : System.Web.UI.Page
    {
        private GridViewHelper helper;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txbNewCntr.Text = string.Empty;
                Panel1.Visible = false;
                sdsOutBoundDocNo.FilterExpression = "Completed = {0}";
                trAddCntr.Visible = false;
                trErrMsg.Visible = false;
                btnExport.Visible = false;
                btnPrint.Visible = false;
                btnCompleteTruck.Visible = false;
                string strSP = "IMDB_Truckout_ActShipWt_upd";
                SqlConnection con1 = new SqlConnection();
                con1.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
                SqlCommand ActWtCmd = new SqlCommand(strSP, con1);
                ActWtCmd.CommandType = CommandType.StoredProcedure;
                con1.Open();
                using (ActWtCmd)
                {
                    try
                    {
                        ActWtCmd.ExecuteNonQuery();
                    }
                    catch (Exception x)
                    {
                        lblErrMsg.Visible = true;
                        lblErrMsg.Text = x.ToString();
                    }
                    finally
                    {
                        con1.Close();
                    }
                }
            }
            else
            {
                if (trAddCntr.Visible == true)
                {
                    txbNewCntr.Focus();
                }
                if (ddDocList.SelectedIndex == 0)
                {
                    btnPrint.Visible = false;
                    btnExport.Visible = false;
                    btnCompleteTruck.Visible = false;
                }
                else
                {
                    btnExport.Visible = true;
                    btnPrint.Visible = true;
                    btnCompleteTruck.Visible = true;
                }
            }
            helper = new GridViewHelper(gvTally);
            GridViewSummary s = helper.RegisterSummary("NumberofCntrs", SummaryOperation.Sum);
            s.Automatic = false;
            s = helper.RegisterSummary("TotalWeight", SummaryOperation.Sum);
            s.Automatic = false;
            helper.GeneralSummary += new FooterEvent(helper_ManualSummary);
        }
        private void helper_ManualSummary(GridViewRow row)
        {
            GridViewRow newRow = helper.InsertGridRow(row);
            newRow.Cells[0].HorizontalAlign = HorizontalAlign.Right;
            newRow.Cells[0].Text = String.Format("Total: {0:n0} Containers,&nbsp&nbsp&nbsp&nbsp{1:n0} lbs", helper.GeneralSummaries["NumberofCntrs"].Value, helper.GeneralSummaries["TotalWeight"].Value);
            newRow.Cells[0].ForeColor = System.Drawing.Color.Black;
            newRow.Cells[0].Font.Bold = true;
        }
        protected void rblFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            sdsOutBoundDocNo.FilterExpression = "Completed = {0}";
            ddDocList.Items.Clear();
            ddDocList.Items.Add("Select a Document");
            ddDocList.DataBind();
            btnExport.Visible = false;
            btnPrint.Visible = false;
            btnCompleteTruck.Visible = false;
            Panel1.Visible = false;
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
        protected void sdsShipHdr_OnUpdating(Object sender, SqlDataSourceCommandEventArgs e)
        {
            e.Command.Parameters["@UserName"].Value = HttpContext.Current.User.Identity.Name.ToString();
        }
        protected void ddDocList_SelectedIndexChanged(object sender, EventArgs e)
        {
            txbNewCntr.Text = string.Empty;
            lblErrMsg.Visible = false;
            lblErrMsg.Text = string.Empty;
            if (ddDocList.SelectedIndex == 0)
            {
                trAddCntr.Visible = false;
                Panel1.Visible = false;
                btnExport.Visible = false;
                btnPrint.Visible = false;
                btnCompleteTruck.Visible = false;
            }
            else
            {
                Panel1.Visible = true;
                if (rblFilter.SelectedValue == "0")
                {
                    trAddCntr.Visible = true;
                    txbNewCntr.Focus();
                    btnExport.Visible = true;
                    btnPrint.Visible = true;
                    btnCompleteTruck.Visible = true;
                }
                else
                {
                    trAddCntr.Visible = false;
                    btnExport.Visible = true;
                    btnPrint.Visible = true;
                    btnCompleteTruck.Visible = false;
                }
                trErrMsg.Visible = false;
                gvTally.DataBind();
            }
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
                this.gvContainers.Columns[editColumn].Visible = false;
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
                lblErrMsg.Visible = true;
                lblErrMsg.Text = "Please remove this container from the truck and place in the Dock area: " + Session["CurCntrID"];
            }
            else if (e.CommandName == "Update")
            {
                GridViewRow row = (GridViewRow)(((LinkButton)e.CommandSource).NamingContainer);
                string Updoutcntrid = ((Label)row.FindControl("outboundcontainerid")).Text;
                Int32 UpAggrWt = Convert.ToInt32(((TextBox)row.FindControl("ActAggrWt")).Text);
                Int32 UpAggrQty = Convert.ToInt32(((Label)row.FindControl("AggrQty")).Text);
                Session["CurCntrID"] = Updoutcntrid;
                Session["CurAggrWt"] = UpAggrWt;
                trErrMsg.Visible = true;
                lblErrMsg.Visible = true;
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
                if (DataBinder.Eval(e.Row.DataItem, "Hazardous").ToString() == "True")
                {
                    e.Row.ForeColor = System.Drawing.Color.Red;
                    e.Row.Font.Bold = true;
                }
                else if (DataBinder.Eval(e.Row.DataItem, "Name").ToString() == "Add Profile")
                {
                    e.Row.ForeColor = System.Drawing.Color.DarkOrange;
                    e.Row.Font.Bold = true;
                }
            }
        }
        protected void btnExport_Click(object sender, EventArgs e)
        {
            GridViewExportUtil.Export("TruckOutContainers.xls", gvContainers);
        }
        protected void txbNewCntr_TextChanged(object sender, EventArgs e)
        {
            //  Deterimine the outbound stream type for the selected outbounddocno
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


            // Clear any existing error messages and set default session value for pallet type
            lblErrMsg.Visible = false;
            Session["OutboundPalletType"] = string.Empty;
            if(string.IsNullOrEmpty(txbNewCntr.Text))
            {
                return;
            }

            string strSP = "IMDB_TruckOut_Stream_sel";
            SqlConnection conn = new SqlConnection();
            conn.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
            SqlCommand StreamCmd = new SqlCommand(strSP, conn);
            StreamCmd.CommandType = CommandType.StoredProcedure;
            conn.Open();
            using (StreamCmd)
            {
                try
                {
                    StreamCmd.Parameters.AddWithValue("@outbounddocno", ddDocList.SelectedItem.ToString());
                    using (SqlDataReader Reader = StreamCmd.ExecuteReader())
                    {
                        if (!Reader.HasRows)
                        {
                            trErrMsg.Visible = true;
                            lblErrMsg.Visible = true;
                            lblErrMsg.Text = "There is no Stream defined for this Vendor.  Please contact the database administrator to update the record.";
                            Session["OutStream"] = "NotDefined";
                            return;
                        }
                        else  // ShipHeader with defined outbound stream exists.  Collect the current information
                        {
                            using (Reader)
                            {
                                try
                                {
                                    while (Reader.Read())
                                    {
                                        Session["OutStream"] = Reader["StreamType"].ToString();
                                    }
                                }
                                catch (Exception ex)
                                {
                                    trErrMsg.Visible = true;
                                    lblErrMsg.Visible = true;
                                    lblErrMsg.Text = ex.ToString();
                                }
                                Reader.Close();
                            }
                        }
                    }
                }
                catch (Exception x)
                {
                    trErrMsg.Visible = true;
                    lblErrMsg.Visible = true;
                    lblErrMsg.Text = x.ToString();
                }
                finally
                {
                    conn.Close();
                }
            }
            #region OUT Container
            if (txbNewCntr.Text.StartsWith("O"))   //  Case for OUT containers
            {
                String sp = "IMDB_TruckOut_ChkCmplt";
                String Curoutbounddocno = String.Empty;
                String completed = String.Empty;
                String curPalletType = String.Empty;

                SqlConnection CntrConnect = new SqlConnection();
                CntrConnect.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
                SqlCommand CntrCmd = new SqlCommand(sp, CntrConnect);
                CntrCmd.CommandType = CommandType.StoredProcedure;
                CntrConnect.Open();

                using (CntrCmd)  //  Determine if there is an outbound container in the system with the scanned OUT ID
                {
                    CntrCmd.Parameters.AddWithValue("@outboundcontainerID", txbNewCntr.Text);
                    using (SqlDataReader Reader = CntrCmd.ExecuteReader())
                    {
                        if (!Reader.HasRows)
                        {
                            trErrMsg.Visible = true;
                            lblErrMsg.Visible = true;
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
                                        Curoutbounddocno = Reader["Outbounddocno"].ToString();
                                        curPalletType = Reader["OutboundPalletType"].ToString();
                                    }
                                }
                                catch (Exception ex)
                                {
                                    trErrMsg.Visible = true;
                                    lblErrMsg.Visible = true;
                                    lblErrMsg.Text = ex.ToString();
                                }
                                Reader.Close();
                            }
                        }
                    }
                }
                CntrConnect.Close();
                if (completed.ToString() == "True") // You cannot update an container that has already shipped.
                {
                    trErrMsg.Visible = true;
                    lblErrMsg.Visible = true;
                    lblErrMsg.Text = "This container is associated with an OutboundDoc (" + Curoutbounddocno + ") that has already Shipped.  Please contact Supervision Immediately!";
                    txbNewCntr.Text = "";
                    txbNewCntr.Focus();
                }
                else  // ProcDetail record for container can be udpated
                {
                    // Check to see if the pallet type is set to CHEP, If yes, prompt User to acknowlege the pallet and proceed w/ Supervisor approval
                    if (curPalletType.ToString().ToUpper() == "CHEP")
                    {
                        this.mpeOUTCHEP.Show();
                        return;
                    }
                    else
                    {
                        SqlConnection con = new SqlConnection();
                        con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
                        String spUpdate = "IMDB_TruckOut_UpdOutboundDocNo";
                        SqlCommand cmd = new SqlCommand(spUpdate, con);
                        using (cmd)
                        {
                            try
                            {
                                cmd.CommandType = CommandType.StoredProcedure;
                                con.Open();
                                cmd.Parameters.AddWithValue("@outboundcontainerID", txbNewCntr.Text);
                                cmd.Parameters.AddWithValue("@outbounddocno", ddDocList.SelectedItem.ToString());
                                cmd.Parameters.AddWithValue("@OutStream", Session["OutStream"]);
                                cmd.Parameters.AddWithValue("@UserName", HttpContext.Current.User.Identity.Name.ToString());
                                cmd.ExecuteNonQuery();
                            }
                            catch (Exception ex)
                            {
                                trErrMsg.Visible = true;
                                lblErrMsg.Visible = true;
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
            }
            #endregion
            #region IN Container
            else   //  this is the IN Cntr Case
            {
                String spRcvDetail = "IMDB_Processing_RcvDetail_Sel";
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
                        using (SqlDataReader Reader = rcvCmd.ExecuteReader())
                        {
                            if (!Reader.HasRows)
                            {
                                trErrMsg.Visible = true;
                                lblErrMsg.Visible = true;
                                lblErrMsg.Text = "This container has not been received in the system. " + "<br/>" +
                                    "Please receive the container BEFORE putting on the Truck. " + "<br/>" +
                                    "This container has NOT been added to the outbound document!";
                                return;
                            }
                            else
                            {
                                while (Reader.Read())
                                {
                                    Session["RcvID"] = (int)Reader["RcvID"];
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
                }
                catch (Exception ex)
                {
                    // Display error
                    trErrMsg.Visible = true;
                    lblErrMsg.Visible = true;
                    lblErrMsg.Text = ex.ToString();
                }

                try  // Determine if a procDetail record exists for this IN Cntr
                {
                    string spProcDetailExists = "IMDB_TruckOut_pdExist";
                    SqlCommand pdChk = new SqlCommand(spProcDetailExists, con);
                    pdChk.CommandType = CommandType.StoredProcedure;
                    using (pdChk)
                    {
                        String ProcHdrID = string.Empty;
                        String ProcDetailID = string.Empty;
                        String OutboundContainerID = string.Empty;
                        String xOutboundContainerID = string.Empty;
                        String OutboundPalletType = string.Empty;
                        pdChk.Parameters.AddWithValue("@CntrID", txbNewCntr.Text);
                        using (SqlDataReader Reader = pdChk.ExecuteReader())
                        {
                            if (Reader.HasRows) // Meaning there is a prochdr and possibly a proc detail
                            {
                                while (Reader.Read())
                                {
                                    ProcHdrID = Reader["prochdrID"].ToString();
                                    ProcDetailID = Reader["procdetailID"].ToString();
                                    OutboundContainerID = Reader["OutboundContainerID"].ToString();
                                    OutboundPalletType = Reader["OutboundPalletType"].ToString();
                                    if (OutboundContainerID == txbNewCntr.Text)
                                    {
                                        xOutboundContainerID = OutboundContainerID;  // This is the case where an OUT containerID begins w/ IN
                                        Session["OutboundPalletType"] = OutboundPalletType;
                                        if (OutboundPalletType.ToString().ToUpper() == "CHEP")
                                        {
                                            con.Close();
                                            this.mpeINCHEP.Show();
                                            return;
                                        }
                                    }
                                }
                                Reader.Close();
                                if (ProcDetailID == "")  // Need to add record to exising ProcHdr
                                {
                                    //  Check to see if the inboundPalletType is CHEP- if so, exit routine and prompt user
                                    if (Session["InboundPalletType"].ToString().ToUpper() == "CHEP")
                                    {
                                        con.Close();
                                        this.mpeINCHEP.Show();
                                        return;
                                    }

                                    string spInsProcDetail = "IMDB_TruckOut_ProcDetail_Ins";
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
                                        insProcDetail.Parameters.AddWithValue("@OutStream", Session["OutStream"]);

                                        insProcDetail.ExecuteNonQuery();
                                    }
                                }
                                else  //  A ProcDetail record exists. 
                                //  NOTE:  No need to check for CHEP here since was already done when check was done to determine if procDetail record exists
                                //  If the scanned container is in procdetail table, update the procdetail line for truck out.  
                                //  If not, prompt user to scan the OUT cntr ID from the process detail record
                                {

                                    //  First, test to see if the txbNewCntr value exists in the ProcDetail table.  If yes, update record.
                                    if (xOutboundContainerID == txbNewCntr.Text)
                                    {
                                        String spUpdate = "IMDB_TruckOut_UpdOutboundDocNo";
                                        SqlCommand cmd = new SqlCommand(spUpdate, con);
                                        using (cmd)
                                        {
                                            try
                                            {
                                                cmd.CommandType = CommandType.StoredProcedure;
                                                cmd.Parameters.AddWithValue("@outboundcontainerID", txbNewCntr.Text);
                                                cmd.Parameters.AddWithValue("@outbounddocno", ddDocList.SelectedItem.ToString());
                                                cmd.Parameters.AddWithValue("@OutStream", Session["OutStream"]);
                                                cmd.Parameters.AddWithValue("@UserName", HttpContext.Current.User.Identity.Name.ToString());
                                                cmd.ExecuteNonQuery();
                                            }
                                            catch (Exception ex)
                                            {
                                                trErrMsg.Visible = true;
                                                lblErrMsg.Visible = true;
                                                lblErrMsg.Text = ex.ToString();
                                            }
                                            finally
                                            {
                                                con.Close();
                                                gvContainers.DataBind();
                                                gvTally.DataBind();
                                                txbNewCntr.Focus();
                                                Session.Abandon();
                                                txbNewCntr.Text = string.Empty;
                                            }
                                        }
                                    }
                                    else
                                    {
                                        trErrMsg.Visible = true;
                                        lblErrMsg.Visible = true;
                                        lblErrMsg.Text = "There is an exising proc detail record for this container.  Please scan the OutboundContainerID.";
                                    }
                                }
                            }
                            else  // There is no ProcHdr.  Must create ProcHdr and ProcDetail record
                            {
                                Reader.Close();  //  Close the open reader from the initial check for procHdr

                                //  Determine if the inbound pallet is a CHEP
                                if (Session["InboundPalletType"].ToString().ToUpper() == "CHEP")
                                {
                                    con.Close();
                                    this.mpeINCHEP.Show();
                                    return;
                                }
                                else
                                {
                                    string spInsProcHdr = "IMDB_TruckOUT_ProcHdr_Ins";
                                    string spInsProcDetail = "IMDB_TruckOut_ProcDetail_Ins";
                                    SqlCommand insProcHdr = new SqlCommand(spInsProcHdr, con);
                                    SqlCommand insProcDetail = new SqlCommand(spInsProcDetail, con);
                                    insProcHdr.CommandType = CommandType.StoredProcedure;
                                    insProcDetail.CommandType = CommandType.StoredProcedure;
                                    int lastID;  //  will be used to capture newly created prochdr for inserts into procdetail table

                                    try
                                    {
                                        using (insProcHdr)
                                        {
                                            SqlParameter processHeaderIdParameter = new SqlParameter("@ProcHdrID", SqlDbType.Int);
                                            processHeaderIdParameter.Direction = ParameterDirection.Output;
                                            insProcHdr.Parameters.Add(processHeaderIdParameter);
                                            insProcHdr.Parameters.AddWithValue("@CntrID", txbNewCntr.Text);
                                            insProcHdr.Parameters.AddWithValue("@ProcessorName", HttpContext.Current.User.Identity.Name.ToString());   // made change here

                                            insProcHdr.ExecuteNonQuery();
                                            lastID = (int)processHeaderIdParameter.Value;
                                            Session["ProcHdrID"] = lastID;   // will use this value if new process detail record is added
                                        }
                                        using (insProcDetail)
                                        {
                                            insProcDetail.Parameters.AddWithValue("@OutboundcontainerID", txbNewCntr.Text);
                                            insProcDetail.Parameters.AddWithValue("@UserName", HttpContext.Current.User.Identity.Name.ToString());
                                            insProcDetail.Parameters.AddWithValue("@ProchdrID", lastID);
                                            insProcDetail.Parameters.AddWithValue("@OutboundStreamProfile", Session["inboundprofileid"]);
                                            insProcDetail.Parameters.AddWithValue("@OutboundContainerType", Session["inboundcontainertype"]);
                                            insProcDetail.Parameters.AddWithValue("@OutboundPalletType", Session["inboundpallettype"]);
                                            insProcDetail.Parameters.AddWithValue("@Outboundstreamweight", Session["inboundpalletweight"]);
                                            insProcDetail.Parameters.AddWithValue("@OutboundCntrQty", Session["inboundcontainerqty"]);
                                            insProcDetail.Parameters.AddWithValue("@OutboundDocNo", ddDocList.SelectedItem.ToString());
                                            insProcDetail.Parameters.AddWithValue("@OutStream", Session["OutStream"]);

                                            insProcDetail.ExecuteNonQuery();
                                        }
                                    }
                                    catch (Exception ex)
                                    {
                                        trErrMsg.Visible = true;
                                        lblErrMsg.Visible = true;
                                        lblErrMsg.Text = ex.ToString();
                                    }
                                } 
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    trErrMsg.Visible = true;
                    lblErrMsg.Visible = true;
                    lblErrMsg.Text = ex.ToString();
                }
                finally
                {
                    //close up connection
                    con.Close();
                    if ((Session["InboundPalletType"].ToString().ToUpper() != "CHEP") || (Session["OutboundPalletType"].ToString().ToUpper() == "CHEP"))
                    {
                        gvContainers.DataBind();
                        gvTally.DataBind();
                        txbNewCntr.Text = "";
                        txbNewCntr.Focus();
                        Session.Abandon();
                    }
                }
            }
            #endregion
        }
        protected void btnCompleteTruck_Click(object sender, EventArgs e)
        {
            string strSP = "IMDB_Truckout_CloseOutTruck_upd";
            SqlConnection con = new SqlConnection();
            con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
            SqlCommand CloseOut = new SqlCommand(strSP, con);
            CloseOut.CommandType = CommandType.StoredProcedure;
            using (con)
            {
                con.Open();
                try
                {
                    CloseOut.Parameters.AddWithValue("@OutboundDocNo", ddDocList.SelectedValue.ToString());
                    CloseOut.Parameters.AddWithValue("@UserName", HttpContext.Current.User.Identity.Name.ToString());
                    CloseOut.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    lblErrMsg.Visible = true;
                    lblErrMsg.Text = ex.Message;
                }
                finally
                {
                    con.Close();
                    Response.Redirect("TruckOut.aspx");
                }
            }
        }
        protected void OUTwApproval(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection();
            con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
            String spUpdate = "IMDB_TruckOut_UpdOutboundDocNo";
            SqlCommand cmd = new SqlCommand(spUpdate, con);
            using (cmd)
            {
                try
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    con.Open();
                    cmd.Parameters.AddWithValue("@outboundcontainerID", txbNewCntr.Text);
                    cmd.Parameters.AddWithValue("@outbounddocno", ddDocList.SelectedItem.ToString());
                    cmd.Parameters.AddWithValue("@OutStream", Session["OutStream"]);
                    cmd.Parameters.AddWithValue("@UserName", HttpContext.Current.User.Identity.Name.ToString());
                    cmd.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    trErrMsg.Visible = true;
                    lblErrMsg.Visible = true;
                    lblErrMsg.Text = ex.ToString();
                }

                con.Close();
            }
            gvContainers.DataBind();
            trErrMsg.Visible = false;
            txbNewCntr.Text = "";
            txbNewCntr.Focus();
        }
        protected void OUTCancel(object sender, EventArgs e)
        {
            txbNewCntr.Text = string.Empty;
            txbNewCntr.Focus();
            trErrMsg.Visible = true;
            lblErrMsg.Visible = true;
            lblErrMsg.Text = "Container was NOT added to the truckout manifest.  Do NOT place container on the truck.";
        }
        protected void INYesChanged(object sender, EventArgs e)  // This is case where IN was scanned and OUT will be created with 2 process lines
        {

            SqlConnection con = new SqlConnection();
            con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
            con.Open();

            try  // Determine if a procDetail record exists for this IN Cntr
            {
                string spProcDetailExists = "IMDB_TruckOut_pdExist";
                SqlCommand pdChk = new SqlCommand(spProcDetailExists, con);
                pdChk.CommandType = CommandType.StoredProcedure;
                using (pdChk)
                {
                    String ProcHdrID = string.Empty;
                    Decimal ProcLaborHr = 0.000M;
                    String ProcDetailID = string.Empty;
                    String OutboundContainerID = string.Empty;
                    String xOutboundContainerID = string.Empty;
                    pdChk.Parameters.AddWithValue("@CntrID", txbNewCntr.Text);
                    using (SqlDataReader Reader = pdChk.ExecuteReader())
                    {
                        if (Reader.HasRows) // Meaning there is a prochdr and possibly a proc detail
                        {
                            while (Reader.Read())
                            {
                                ProcHdrID = Reader["prochdrID"].ToString();
                                ProcDetailID = Reader["procdetailID"].ToString();
                                ProcLaborHr = Convert.ToDecimal(Reader["ProcessingLaborHr"].ToString());
                                OutboundContainerID = Reader["OutboundContainerID"].ToString();
                                if (OutboundContainerID == txbNewCntr.Text)
                                {
                                    xOutboundContainerID = OutboundContainerID;  // This is the case where an OUT containerID begins w/ IN
                                }
                            }
                            Reader.Close();
                            if (ProcDetailID == "")  // Need to add record to exising ProcHdr and add 0.25 labor hours to the current labor hrs
                            {
                                ProcLaborHr = ProcLaborHr + 0.2500M;
                                string spInsProcDetail = "IMDB_TruckOut_ProcDetailCHEP_Ins";
                                SqlCommand insProcDetail = new SqlCommand(spInsProcDetail, con);
                                insProcDetail.CommandType = CommandType.StoredProcedure;
                                using (insProcDetail)
                                {
                                    insProcDetail.Parameters.AddWithValue("@ProcessingLaborHr", ProcLaborHr);
                                    insProcDetail.Parameters.AddWithValue("@OutboundcontainerID", txbNewCntr.Text);
                                    insProcDetail.Parameters.AddWithValue("@UserName", HttpContext.Current.User.Identity.Name.ToString());
                                    insProcDetail.Parameters.AddWithValue("@ProchdrID", ProcHdrID);
                                    insProcDetail.Parameters.AddWithValue("@OutboundStreamProfile", Session["Inboundprofileid"]);
                                    insProcDetail.Parameters.AddWithValue("@OutboundContainerType", Session["Inboundcontainertype"]);
                                    insProcDetail.Parameters.AddWithValue("@Outboundstreamweight", Session["Inboundpalletweight"]);
                                    insProcDetail.Parameters.AddWithValue("@OutboundCntrQty", Session["Inboundcontainerqty"]);
                                    insProcDetail.Parameters.AddWithValue("@OutboundDocNo", ddDocList.SelectedItem.ToString());
                                    insProcDetail.Parameters.AddWithValue("@OutStream", Session["OutStream"]);

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
                                    String spUpdate = "IMDB_TruckOut_UpdOutboundDocNo";
                                    SqlCommand cmd = new SqlCommand(spUpdate, con);
                                    using (cmd)
                                    {
                                        try
                                        {
                                            cmd.CommandType = CommandType.StoredProcedure;
                                            cmd.Parameters.AddWithValue("@outboundcontainerID", txbNewCntr.Text);
                                            cmd.Parameters.AddWithValue("@outbounddocno", ddDocList.SelectedItem.ToString());
                                            cmd.Parameters.AddWithValue("@OutStream", Session["OutStream"]);
                                            cmd.Parameters.AddWithValue("@UserName", HttpContext.Current.User.Identity.Name.ToString());
                                            cmd.ExecuteNonQuery();
                                        }
                                        catch (Exception ex)
                                        {
                                            trErrMsg.Visible = true;
                                            lblErrMsg.Visible = true;
                                            lblErrMsg.Text = ex.ToString();
                                        }

                                        con.Close();
                                    }
                                }
                                else
                                {
                                    trErrMsg.Visible = true;
                                    lblErrMsg.Visible = true;
                                    lblErrMsg.Text = "There is an exising proc detail record for this container.  Please scan the OutboundContainerID.";
                                }
                            }
                        }
                        else  // There is no ProcHdr.  Must create ProcHdr and ProcDetail record
                        {
                            Reader.Close();
                            string spInsProcHdr = "IMDB_TruckOUT_ProcHdr_Ins";
                            string spInsProcDetail = "IMDB_TruckOut_ProcDetailCHEP_Ins";
                            SqlCommand insProcHdr = new SqlCommand(spInsProcHdr, con);
                            SqlCommand insProcDetail = new SqlCommand(spInsProcDetail, con);
                            insProcHdr.CommandType = CommandType.StoredProcedure;
                            insProcDetail.CommandType = CommandType.StoredProcedure;
                            int lastID;  //  will be used to capture newly created prochdr for inserts into procdetail table

                            try
                            {
                                using (insProcHdr)
                                {
                                    SqlParameter processHeaderIdParameter = new SqlParameter("@ProcHdrID", SqlDbType.Int);
                                    processHeaderIdParameter.Direction = ParameterDirection.Output;
                                    insProcHdr.Parameters.Add(processHeaderIdParameter);
                                    insProcHdr.Parameters.AddWithValue("@CntrID", txbNewCntr.Text);
                                    insProcHdr.Parameters.AddWithValue("@ProcessorName", HttpContext.Current.User.Identity.Name.ToString());

                                    insProcHdr.ExecuteNonQuery();
                                    lastID = (int)processHeaderIdParameter.Value;
                                    Session["ProcHdrID"] = lastID;   // will use this value if new process detail record is added
                                }
                                using (insProcDetail)
                                {
                                    insProcDetail.Parameters.AddWithValue("@ProcessingLaborHr", 0.250);
                                    insProcDetail.Parameters.AddWithValue("@OutboundcontainerID", txbNewCntr.Text);
                                    insProcDetail.Parameters.AddWithValue("@UserName", HttpContext.Current.User.Identity.Name.ToString());
                                    insProcDetail.Parameters.AddWithValue("@ProchdrID", lastID);
                                    insProcDetail.Parameters.AddWithValue("@OutboundStreamProfile", Session["Inboundprofileid"]);
                                    insProcDetail.Parameters.AddWithValue("@OutboundContainerType", Session["Inboundcontainertype"]);
                                    insProcDetail.Parameters.AddWithValue("@Outboundstreamweight", Session["Inboundpalletweight"]);
                                    insProcDetail.Parameters.AddWithValue("@OutboundCntrQty", Session["Inboundcontainerqty"]);
                                    insProcDetail.Parameters.AddWithValue("@OutboundDocNo", ddDocList.SelectedItem.ToString());
                                    insProcDetail.Parameters.AddWithValue("@OutStream", Session["OutStream"]);

                                    insProcDetail.ExecuteNonQuery();
                                }
                            }
                            catch (Exception ex)
                            {
                                trErrMsg.Visible = true;
                                lblErrMsg.Visible = true;
                                lblErrMsg.Text = ex.ToString();
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                trErrMsg.Visible = true;
                lblErrMsg.Visible = true;
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
        protected void INNotChanged(object sender, EventArgs e)
        {
            this.mpeINChange.Show();
        }
        protected void INwApproval(object sender, EventArgs e)  // Inbound container not moved from CHEP with Supervisor Approval
        {
            SqlConnection con = new SqlConnection();
            con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
            con.Open();

            try  // Determine if a procDetail record exists for this IN Cntr
            {
                string spProcDetailExists = "IMDB_TruckOut_pdExist";
                SqlCommand pdChk = new SqlCommand(spProcDetailExists, con);
                pdChk.CommandType = CommandType.StoredProcedure;
                using (pdChk)
                {
                    String ProcHdrID = string.Empty;
                    String ProcDetailID = string.Empty;
                    String OutboundContainerID = string.Empty;
                    String xOutboundContainerID = string.Empty;
                    pdChk.Parameters.AddWithValue("@CntrID", txbNewCntr.Text);
                    using (SqlDataReader Reader = pdChk.ExecuteReader())
                    {
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
                                string spInsProcDetail = "IMDB_TruckOut_ProcDetail_Ins";
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
                                    insProcDetail.Parameters.AddWithValue("@OutStream", Session["OutStream"]);

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
                                    String spUpdate = "IMDB_TruckOut_UpdOutboundDocNo";
                                    SqlCommand cmd = new SqlCommand(spUpdate, con);
                                    using (cmd)
                                    {
                                        try
                                        {
                                            cmd.CommandType = CommandType.StoredProcedure;
                                            cmd.Parameters.AddWithValue("@outboundcontainerID", txbNewCntr.Text);
                                            cmd.Parameters.AddWithValue("@outbounddocno", ddDocList.SelectedItem.ToString());
                                            cmd.Parameters.AddWithValue("@OutStream", Session["OutStream"]);
                                            cmd.Parameters.AddWithValue("@UserName", HttpContext.Current.User.Identity.Name.ToString());
                                            cmd.ExecuteNonQuery();
                                        }
                                        catch (Exception ex)
                                        {
                                            trErrMsg.Visible = true;
                                            lblErrMsg.Visible = true;
                                            lblErrMsg.Text = ex.ToString();
                                        }

                                        con.Close();
                                    }
                                }
                                else
                                {
                                    trErrMsg.Visible = true;
                                    lblErrMsg.Visible = true;
                                    lblErrMsg.Text = "There is an exising proc detail record for this container.  Please scan the OutboundContainerID.";
                                }
                            }
                        }
                        else  // There is no ProcHdr.  Must create ProcHdr and ProcDetail record
                        {
                            Reader.Close();
                            string spInsProcHdr = "IMDB_TruckOUT_ProcHdr_Ins";
                            string spInsProcDetail = "IMDB_TruckOut_ProcDetail_Ins";
                            SqlCommand insProcHdr = new SqlCommand(spInsProcHdr, con);
                            SqlCommand insProcDetail = new SqlCommand(spInsProcDetail, con);
                            insProcHdr.CommandType = CommandType.StoredProcedure;
                            insProcDetail.CommandType = CommandType.StoredProcedure;
                            int lastID;  //  will be used to capture newly created prochdr for inserts into procdetail table

                            try
                            {
                                using (insProcHdr)
                                {
                                    SqlParameter processHeaderIdParameter = new SqlParameter("@ProcHdrID", SqlDbType.Int);
                                    processHeaderIdParameter.Direction = ParameterDirection.Output;
                                    insProcHdr.Parameters.Add(processHeaderIdParameter);
                                    insProcHdr.Parameters.AddWithValue("@CntrID", txbNewCntr.Text);
                                    insProcHdr.Parameters.AddWithValue("@ProcessorName", HttpContext.Current.User.Identity.Name.ToString());   // made change here

                                    insProcHdr.ExecuteNonQuery();
                                    lastID = (int)processHeaderIdParameter.Value;
                                    Session["ProcHdrID"] = lastID;   // will use this value if new process detail record is added
                                }
                                using (insProcDetail)
                                {
                                    insProcDetail.Parameters.AddWithValue("@OutboundcontainerID", txbNewCntr.Text);
                                    insProcDetail.Parameters.AddWithValue("@UserName", HttpContext.Current.User.Identity.Name.ToString());
                                    insProcDetail.Parameters.AddWithValue("@ProchdrID", lastID);
                                    insProcDetail.Parameters.AddWithValue("@OutboundStreamProfile", Session["inboundprofileid"]);
                                    insProcDetail.Parameters.AddWithValue("@OutboundContainerType", Session["inboundcontainertype"]);
                                    insProcDetail.Parameters.AddWithValue("@OutboundPalletType", Session["inboundpallettype"]);
                                    insProcDetail.Parameters.AddWithValue("@Outboundstreamweight", Session["inboundpalletweight"]);
                                    insProcDetail.Parameters.AddWithValue("@OutboundCntrQty", Session["inboundcontainerqty"]);
                                    insProcDetail.Parameters.AddWithValue("@OutboundDocNo", ddDocList.SelectedItem.ToString());
                                    insProcDetail.Parameters.AddWithValue("@OutStream", Session["OutStream"]);

                                    insProcDetail.ExecuteNonQuery();
                                }
                            }
                            catch (Exception ex)
                            {
                                trErrMsg.Visible = true;
                                lblErrMsg.Visible = true;
                                lblErrMsg.Text = ex.ToString();
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                trErrMsg.Visible = true;
                lblErrMsg.Visible = true;
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
        protected void INCancel(object sender, EventArgs e)
        {
            txbNewCntr.Text = string.Empty;
            txbNewCntr.Focus();
            trErrMsg.Visible = true;
            lblErrMsg.Visible = true;
            lblErrMsg.Text = "Container was NOT added to the truckout manifest.  Do NOT place container on the truck.";        
        }
    }
}
