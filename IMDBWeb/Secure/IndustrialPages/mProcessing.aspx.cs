using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Collections;
using System.Text.RegularExpressions;

namespace IMDBWeb.Secure
{
    public partial class Processing : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblHeader.Visible = false;
                lblProcDetails.Visible = false;
                lblOutCntr.Visible = false;
                txbOutCntr.Visible = false;
                lblDots.Visible = false;
                btnInsCntr.Visible = false;
                btnInsBale.Visible = false;
                btnInsPallet.Visible = false;
                btnInsCompact.Visible = false;
                btnDone.Visible = false;
                lblErrMsg.Visible = false;
                txbCntrID.Focus();
            }
        }
        protected void txbCntrID_TextChanged(object sender, EventArgs e)
        {
            // When there is a change in containerID system will:
            //  1. Check if the value is valid.
            //  2. Check if the value exists in the rcvdetail table.  If not send error msg
            //  3. Determine if a process record already exists.  If yes, present current info.  If no, create a prochdr and make "Add Detail" button visible.


            //  1. Check if value exists
            txbCntrID.Text = txbCntrID.Text.ToUpper();
            if (txbCntrID.Text == string.Empty)
            {
                Response.Redirect(Request.RawUrl);
                return;
            }
            else
            {
                if (!txbCntrID.Text.StartsWith("IN"))
                {
                    lblErrMsg.Visible = true;
                    lblErrMsg.Text = "You must enter a valid 'IN' container ID";
                    return;
                }
            }

            //  2.  Determine if the entered value exists in the rcvdetail table

            string checkRcvDetail = "IMDB_LocChange_InboundContainer_Exist";
            SqlConnection rcvConnect = new SqlConnection();
            rcvConnect.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
            SqlCommand rcvCmd = new SqlCommand(checkRcvDetail, rcvConnect);
            rcvCmd.CommandType = CommandType.StoredProcedure;
            rcvConnect.Open();

            try
            {
                using (rcvCmd)
                {
                    rcvCmd.Parameters.AddWithValue("@inboundcontainerid", txbCntrID.Text);
                    object hasRcvID = new object();
                    hasRcvID = rcvCmd.ExecuteScalar();
                    if (hasRcvID == null)
                    {
                        lblErrMsg.Visible = true;
                        lblErrMsg.Text = "This container is not in the system.  Please re-scan or contact your supervisor";
                        return;
                    }
                    else
                    {
                        lblErrMsg.Visible = false;
                    }
                }
            }
            catch (Exception ex)
            {
                // Display error
                lblErrMsg.Text = ex.ToString();
                lblErrMsg.Visible = true;
            }
            finally
            {
                rcvConnect.Close();
            }

            //  The inbound container location will be set to 'Processing'

            string setlocation = "IMDB_Processing_Location_Upd";
            SqlConnection rcvConnect1 = new SqlConnection();
            rcvConnect1.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
            SqlCommand rcvCmd1 = new SqlCommand(setlocation, rcvConnect1);
            rcvCmd1.CommandType = CommandType.StoredProcedure;
            rcvConnect1.Open();
            try
            {
                using (rcvCmd1)
                {
                    rcvCmd1.Parameters.AddWithValue("@inboundContainerID", txbCntrID.Text);
                    rcvCmd1.Parameters.AddWithValue("@UserName", HttpContext.Current.User.Identity.Name.ToString());
                    rcvCmd1.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                // Display error
                lblErrMsg.Text = ex.ToString();
                lblErrMsg.Visible = true;
            }
            finally
            {
                rcvConnect1.Close();
            }

            // 3. Determine if a process record exists.  If it does, bring back results. If it doesn't, create new process header.

            string checkSql = "IMDB_Processing_ProcHdr_Exist";
            SqlConnection Connect = new SqlConnection();
            Connect.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
            SqlCommand checkCmd = new SqlCommand(checkSql, Connect);
            checkCmd.CommandType = CommandType.StoredProcedure;

            try
            {
                Connect.Open();
                using (checkCmd)
                {
                    checkCmd.Parameters.Add("@InboundContainerID", SqlDbType.NVarChar, 20, "InboundContainerID");
                    checkCmd.Parameters["@InboundContainerID"].Value = txbCntrID.Text;
                    object hasID = new object();
                    hasID = checkCmd.ExecuteScalar();
                    if (hasID != null)  //  this is the case where there is an existing ProcessHdr
                    {
                        Session["ProcHdrID"] = hasID;  // will use this value if new process detail record is added
                        lblHeader.Visible = true;
                        lblProcDetails.Visible = true;
                        btnInsCntr.Visible = true;
                        btnInsCompact.Visible = true;
                        btnInsBale.Visible = true;
                        btnInsPallet.Visible = true;
                        btnDone.Visible = true;
                        btnInsCntr.Focus();
                    }
                    else  // this is the case where new prochdr must be created.
                    {
                        string spInsProcHdr = "IMDB_Processing_ProcHdr_Ins";
                        SqlConnection insConnect = new SqlConnection();
                        insConnect.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
                        SqlCommand insCmd = new SqlCommand(spInsProcHdr, insConnect);
                        insCmd.CommandType = CommandType.StoredProcedure;
                        int lastID;  //  will be used to capture newly created prochdr for inserts into procdetail table

                        try
                        {
                            insConnect.Open();
                            using (insCmd)
                            {
                                SqlParameter processHeaderIdParameter = new SqlParameter("@ProcHdrID", SqlDbType.Int);
                                processHeaderIdParameter.Direction = ParameterDirection.Output;
                                insCmd.Parameters.Add(processHeaderIdParameter);
                                insCmd.Parameters.AddWithValue("@CntrID", txbCntrID.Text);
                                insCmd.Parameters.AddWithValue("@ProcessorName", HttpContext.Current.User.Identity.Name.ToString());   // made change here

                                insCmd.ExecuteNonQuery();
                                lastID = (int)processHeaderIdParameter.Value;
                                Session["ProcHdrID"] = lastID;   // will use this value if new process detail record is added
                            }
                        }
                        catch (Exception ex)
                        {
                            lblErrMsg.Visible = true;
                            lblErrMsg.Text = ex.ToString();
                        }
                        finally
                        {
                            insConnect.Close();
                            lblHeader.Visible = true;
                            lblProcDetails.Visible = true;
                            btnInsCntr.Visible = true;
                            btnInsCompact.Visible = true;
                            btnInsBale.Visible = true;
                            btnInsPallet.Visible = true;
                            btnDone.Visible = true;
                            btnInsCntr.Focus();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblErrMsg.Visible = true;
                lblErrMsg.Text = ex.ToString();
            }
            finally
            {
                //close up connection
                Connect.Close();
            }
        }
        protected void btnClear_Click(object sender, EventArgs e)
        {
            // Reset page
            txbCntrID.Text = string.Empty;
            Response.Redirect(Request.RawUrl);
        }
        protected void btnInsCntr_Click(object sender, EventArgs e)
        {
            // This button is only visible when a process header already exists
            // When user clicks "Add Record" button, system will prompt user for outbound container

            lblOutCntr.Visible = true;
            lblOutCntr.Text = "Please scan an OUT or ROPAK container";
            txbOutCntr.Visible = true;
            txbOutCntr.Focus();
        }
        protected void txbOutCntr_TextChanged(object sender, EventArgs e)
        {

            /* ******************************** Algorithm *********************************************
             *  
             *  The txbOutCntr entry is only visible after the user has clicked on the "Add Record" button.  
             *  This button is only visible when a process record exists.  The ProcHdrID associated with 
             *  the txbCntrID (the "IN" container) is stored as a session variable.
             *  This header ID is used when new OUT containers are added as ProcDetail records.
             *  The steps are as follows:
             *      1. Validate the txbOutCntr valcompaue to exist and begin with "OUT"
             *      2. Confirm that the OUT container has not been shipped
             *      3. Create a process detail record with the outbound cntr and the session variable prochdrid.
             *          Return the user to the current record allowing additional process detail records to be added.
             *      
                **************************************************************************************** */



            //  1.  Validate entry
            #region Entry Validation

            if (txbOutCntr.Text == string.Empty)
            {
                txbOutCntr.Focus();
                return;
            }
            else
            {
                txbOutCntr.Text = txbOutCntr.Text.ToUpper();
                if (!Regex.IsMatch(txbOutCntr.Text, @"^[O][U][T]?[-](\d{6})*$"))
                {
                    lblErrMsg.Text = "You must use an OUT container in the format of OUT-######";
                    lblErrMsg.Visible = true;
                    lblOutCntr.Visible = true;
                    txbOutCntr.Visible = true;
                    txbOutCntr.Text = string.Empty;
                    txbOutCntr.Focus();
                    return;
                }                
            } 
            #endregion

            //  2. Confirm that the OUT container has not been shipped

            #region Check container status

            string sqlCntrCheck = "IMDB_Processing_CntrCheck";
            SqlConnection con = new SqlConnection();
            con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
            SqlCommand cmdCntrCheck = new SqlCommand(sqlCntrCheck, con);
            cmdCntrCheck.CommandType = CommandType.StoredProcedure;
            Boolean CntrCheck = false;
            try
            {
                con.Open();
                using (cmdCntrCheck)
                {
                    cmdCntrCheck.Parameters.AddWithValue("@OutboundcontainerID", txbOutCntr.Text);
                    object CntrShipped = new object();
                    CntrShipped = cmdCntrCheck.ExecuteScalar();
                    if (CntrShipped != null)
                    {
                        CntrCheck = true;
                        lblErrMsg.Visible = true;
                        lblErrMsg.Text = "This container (" + txbOutCntr.Text +") has already shipped out.  You cannot add additional material.  Please notify your supervisor of this error.";
                        txbOutCntr.Text = string.Empty;
                        txbOutCntr.Focus();
                        return;
                    }
                    else
                    {
                        CntrCheck = false;
                    }
                }
            }
            catch (Exception em)
            {
                lblErrMsg.Visible = true;
                lblErrMsg.Text = em.ToString();
            }
            finally
            {
                con.Close();
            }
            #endregion

            //  3. Create ProcDetail record

            #region Create ProcDetail
            if (!CntrCheck)
            {
                string sqlProcDetailIns = "IMDB_Processing_InsCntr";
                SqlConnection insConnect1 = new SqlConnection();
                insConnect1.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
                SqlCommand insCmd1 = new SqlCommand(sqlProcDetailIns, insConnect1);
                insCmd1.CommandType = CommandType.StoredProcedure;

                try
                {
                    insConnect1.Open();
                    using (insCmd1)
                    {
                        insCmd1.Parameters.AddWithValue("@prochdrid", Session["ProcHdrID"]);
                        insCmd1.Parameters.AddWithValue("@outboundcontainerid", txbOutCntr.Text);
                        insCmd1.Parameters.AddWithValue("@User", HttpContext.Current.User.Identity.Name.ToString());
                        insCmd1.ExecuteNonQuery();
                        gvProcDetails.Sort("ID", SortDirection.Ascending);
                        txbOutCntr.Text = string.Empty;
                        btnInsCntr.Visible = true;
                        btnInsCompact.Visible = true;
                        btnInsBale.Visible = true;
                        btnInsPallet.Visible = true;
                        btnDone.Visible = true;
                        btnInsCntr.Focus();
                    }
                }
                catch (Exception ex)
                {
                    lblErrMsg.Visible = true;
                    lblErrMsg.Text = ex.ToString();
                }
                finally
                {
                    insConnect1.Close();
                    txbOutCntr.Visible = true;
                    txbOutCntr.Focus();
                    lblErrMsg.Visible = false;
                    lblErrMsg.Text = string.Empty;
                }
            }
            #endregion
        }
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            txbCntrID.Text = txbCntrID.Text.ToUpper();
            if ((txbCntrID.Text == null) || (!txbCntrID.Text.StartsWith("IN")))
            {
                lblErrMsg.Visible = true;
                lblErrMsg.Text = "You must enter a valid 'IN' container";
                return;
            }
            else
            {
                txbCntrID_TextChanged(null, null);
            }
        }
        protected void btnDone_Click(object sender, EventArgs e)
        {
            Response.Redirect(Request.RawUrl);
        }
        protected void btnIns_Compact_Click(object sender, EventArgs e)
        {
            /* ******************************** Algorithm *********************************************
             *  Note: This button only visible when process record exist
             *  1. Confirm that compact record doesn't already exist
             *  2. Get the current Aggregate Cntr ID for compactor
             *  3. Get RcvDetail values
             *  4. Insert new compact record
                **************************************************************************************** */


            String spAggrCntr = "IMDB_AggCntr_Select";
            String spChk = "IMDB_Processing_insCompact_Exist";
            String sp = "IMDB_Processing_InsCompact";
            Boolean ChkResult = false;
            SqlConnection con = new SqlConnection();
            con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
            SqlCommand spCmd = new SqlCommand(sp, con);
            SqlCommand spChkCmd = new SqlCommand(spChk, con);
            SqlCommand spAggrCmd = new SqlCommand(spAggrCntr, con);
            spAggrCmd.CommandType = CommandType.StoredProcedure;
            spCmd.CommandType = CommandType.StoredProcedure;
            spChkCmd.CommandType = CommandType.StoredProcedure;
            con.Open();

            //check for existing Compact record for this prochdrid
            #region Check for Existing Compact Record
            using (spChkCmd)  
            {
                try
                {
                    spChkCmd.Parameters.AddWithValue("@ProcHdrID", Session["ProcHdrID"]);
                    object hasCmptRecord = new object();
                    hasCmptRecord = spChkCmd.ExecuteScalar();
                    if (hasCmptRecord != null)
                    {
                        ChkResult = true;
                        lblErrMsg.Visible = true;
                        lblErrMsg.Text = "There is already a Compactor Record. Click 'Submit' to re-enter the record.";
                        lblProcDetails.Visible = true;
                        lblHeader.Visible = true;
                    }
                }
                catch (Exception ex)
                {
                    lblErrMsg.Visible = true;
                    lblErrMsg.Text = ex.ToString();
                }
            }
            #endregion

            if (ChkResult == false)
            {
                //  Get current compactor cntrID
                #region Cur Compactor CntrID
                using (spAggrCmd)
                {
                    try
                    {
                        String cntrname = "Compactor";
                        Session["curCntr"] = "";
                        spAggrCmd.Parameters.AddWithValue("@cntrname", cntrname);
                        object objCntr = new object();
                        objCntr = spAggrCmd.ExecuteScalar();
                        if (objCntr != null)
                        {
                            Session["curCntr"] = objCntr.ToString();
                        }

                    }
                    catch (Exception ex)
                    {
                        lblErrMsg.Visible = true;
                        lblErrMsg.Text = ex.ToString();
                    }
                }
                #endregion
                
                //  Get RcvDetal Values to populate ProcDetail record
                #region RcvDetail Values
                String spRcvDetail = "IMDB_Processing_RcvDetail_Sel";
                SqlCommand rcvCmd = new SqlCommand(spRcvDetail, con);
                rcvCmd.CommandType = CommandType.StoredProcedure;

                try    //  Determine if the entered value exists in the rcvdetail table.  If existing, get current values.
                {
                    using (rcvCmd)
                    {
                        rcvCmd.Parameters.AddWithValue("@inboundcontainerid", txbCntrID.Text);
                        using (SqlDataReader Reader = rcvCmd.ExecuteReader())
                        {
                            if (!Reader.HasRows)
                            {
                                lblErrMsg.Visible = true;
                                lblErrMsg.Text = "This container has not been received in the system. " + "<br/>" +
                                    "Please receive the container BEFORE attempting to process.";
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
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    // Display error
                    lblErrMsg.Visible = true;
                    lblErrMsg.Text = ex.ToString();
                }
                #endregion

                #region Insert ProcDetail Record
                // Insert the new procdetail record
                using (spCmd)
                {
                    try
                    {
                        spCmd.Parameters.AddWithValue("@User", HttpContext.Current.User.Identity.Name.ToString());
                        spCmd.Parameters.AddWithValue("@ProchdrID", Session["ProcHdrID"]);
                        spCmd.Parameters.AddWithValue("@AggCntr", Session["curCntr"]);
                        spCmd.Parameters.AddWithValue("@OutboundStreamProfile", "35");
                        spCmd.Parameters.AddWithValue("@OutboundContainerType", Session["InboundContainerType"]);
                        spCmd.Parameters.AddWithValue("@OutboundStreamWeight", Session["InboundPalletweight"]);
                        spCmd.Parameters.AddWithValue("@OutboundCntrQty", Session["Inboundcontainerqty"]);
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
                    }
                }
                #endregion
                gvProcDetails.DataBind();
                lblProcDetails.Visible = true;
                lblHeader.Visible = true;
            }
            else
            {
                con.Close();
            }
        }
        protected void btnIns_Bale_Click(object sender, EventArgs e)
        {
            // This button only visible when process record exists
            // Confirm that bale record doesn't already exist
            // Insert new bale record

            String spAggrCntr = "IMDB_AggCntr_Select";
            String spChk = "IMDB_Processing_insBale_Exist";
            String sp = "IMDB_Processing_InsBale";
            Boolean ChkResult = false;
            SqlConnection con = new SqlConnection();
            con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
            SqlCommand spCmd = new SqlCommand(sp, con);
            SqlCommand spChkCmd = new SqlCommand(spChk, con);
            SqlCommand spAggrCmd = new SqlCommand(spAggrCntr, con);
            spAggrCmd.CommandType = CommandType.StoredProcedure;
            spCmd.CommandType = CommandType.StoredProcedure;
            spChkCmd.CommandType = CommandType.StoredProcedure;
            con.Open();

            //check for existing Bale record for this prochdrid
            #region Check Bale Exist
            using (spChkCmd)  
            {
                try
                {
                    spChkCmd.Parameters.AddWithValue("@ProcHdrID", Session["ProcHdrID"]);
                    object hasCmptRecord = new object();
                    hasCmptRecord = spChkCmd.ExecuteScalar();
                    if (hasCmptRecord != null)
                    {
                        ChkResult = true;
                        lblErrMsg.Visible = true;
                        lblErrMsg.Text = "There is already a Bale Record. Click 'Submit' to re-enter the record.";
                        lblProcDetails.Visible = true;
                        lblHeader.Visible = true;
                    }
                }
                catch (Exception ex)
                {
                    lblErrMsg.Visible = true;
                    lblErrMsg.Text = ex.ToString();
                }
            } 
            #endregion

            if (ChkResult == false)
            {
                #region Obtain AggrCntrID
                using (spAggrCmd)
                {
                    try
                    {
                        String cntrname = "Baler";
                        Session["curCntr"] = "";
                        spAggrCmd.Parameters.AddWithValue("@cntrname", cntrname);
                        object objCntr = new object();
                        objCntr = spAggrCmd.ExecuteScalar();
                        if (objCntr != null)
                        {
                            Session["curCntr"] = objCntr.ToString();
                        }

                    }
                    catch (Exception ex)
                    {
                        lblErrMsg.Visible = true;
                        lblErrMsg.Text = ex.ToString();
                    }
                }
                
                #endregion

                //  Get RcvDetal Values to populate ProcDetail record
                #region RcvDetail Values
                String spRcvDetail = "IMDB_Processing_RcvDetail_Sel";
                SqlCommand rcvCmd = new SqlCommand(spRcvDetail, con);
                rcvCmd.CommandType = CommandType.StoredProcedure;

                try    //  Determine if the entered value exists in the rcvdetail table.  If existing, get current values.
                {
                    using (rcvCmd)
                    {
                        rcvCmd.Parameters.AddWithValue("@inboundcontainerid", txbCntrID.Text);
                        using (SqlDataReader Reader = rcvCmd.ExecuteReader())
                        {
                            if (!Reader.HasRows)
                            {
                                lblErrMsg.Visible = true;
                                lblErrMsg.Text = "This container has not been received in the system. " + "<br/>" +
                                    "Please receive the container BEFORE attempting to process.";
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
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    // Display error
                    lblErrMsg.Visible = true;
                    lblErrMsg.Text = ex.ToString();
                }
                #endregion

                //  Using AggrCntrID and RcvDetails, insert new ProcDetail
                #region Insert ProcDetail Record

                using (spCmd)
                {
                    try
                    {
                        spCmd.Parameters.AddWithValue("@User", HttpContext.Current.User.Identity.Name.ToString());
                        spCmd.Parameters.AddWithValue("@ProchdrID", Session["ProcHdrID"]);
                        spCmd.Parameters.AddWithValue("@AggCntr", Session["curCntr"]);
                        spCmd.Parameters.AddWithValue("@OutboundStreamProfile", "28");
                        spCmd.Parameters.AddWithValue("@OutboundContainerType", Session["InboundContainerType"]);
                        spCmd.Parameters.AddWithValue("@OutboundStreamWeight", Session["InboundPalletweight"]);
                        spCmd.Parameters.AddWithValue("@OutboundCntrQty", Session["Inboundcontainerqty"]);
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
                    }
                } 
                #endregion
                gvProcDetails.DataBind();
                lblProcDetails.Visible = true;
                lblHeader.Visible = true;
            }
            else
            {
                con.Close();
            }

        }
        protected void btnIns_Pallet_Click(object sender, EventArgs e)
        {
            // This button only visible when process record exists
            // Confirm that a pallet record doesn't already exist
            // Insert new pallet record

            ddPalletAction.Visible = true;
        }

        protected void ddPalletAction_SelectedIndexChanged(object sender, EventArgs e)
        {
            if(ddPalletAction.SelectedIndex != 0)
            {
                btnInsPallet.Visible = false;

                string processmethod = "";
                string palletweight = "";
                string palletprofile = "";

                
                switch (ddPalletAction.SelectedIndex)
                { 
                    case 1:
                        palletprofile = "27";
                        palletweight = "42";
                        processmethod = "PalletRemoved";
                        break;
                    case 2:
                        palletprofile = "26";
                        palletweight = "66";
                        processmethod = "PalletRemoved";
                        break;
                    case 3:
                        palletprofile = "25";
                        palletweight = "24";
                        processmethod = "CHEP2GMA";
                        break;
                }

                String sp = "IMDB_Processing_InsPallet";
                String spChk = "IMDB_Processing_insPallet_Exist";
                Boolean ChkResult = false;
                SqlConnection con = new SqlConnection();
                con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
                SqlCommand spCmd = new SqlCommand(sp, con);
                SqlCommand spChkCmd = new SqlCommand(spChk, con);
                spCmd.CommandType = CommandType.StoredProcedure;
                spChkCmd.CommandType = CommandType.StoredProcedure;
                using (con)
                {
                    try
                    {
                        con.Open();
                        #region Check Pallet Exist
                        using (spChkCmd)
                        {
                            try
                            {
                                spChkCmd.Parameters.AddWithValue("@ProcHdrID", Session["ProcHdrID"]);
                                object hasCmptRecord = new object();
                                hasCmptRecord = spChkCmd.ExecuteScalar();
                                if (hasCmptRecord != null)
                                {
                                    ChkResult = true;
                                    lblErrMsg.Visible = true;
                                    lblErrMsg.Text = "There is already a Pallet Record. Click 'Submit' to re-enter the record.";
                                    lblProcDetails.Visible = true;
                                    lblHeader.Visible = true;
                                }
                            }
                            catch (Exception ex)
                            {
                                lblErrMsg.Visible = true;
                                lblErrMsg.Text = ex.ToString();
                            }
                        }
                        #endregion

                        if (ChkResult == false)
                        {
                            //  Insert new ProcDetail
                            #region Insert ProcDetail Record

                            using (spCmd)
                            {
                                try
                                {
                                    spCmd.Parameters.AddWithValue("@User", HttpContext.Current.User.Identity.Name.ToString());
                                    spCmd.Parameters.AddWithValue("@ProchdrID", Session["ProcHdrID"]);
                                    spCmd.Parameters.AddWithValue("@OutboundStreamProfile", palletprofile);
                                    spCmd.Parameters.AddWithValue("@ProcessMethod", processmethod);
                                    spCmd.Parameters.AddWithValue("@OutboundStreamWeight", palletweight);
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
                                }
                            }
                            #endregion                    
                        }
                        else
                        {
                            con.Close();
                        }
                    }
                    catch (Exception ex)
                    {
                        // Display error
                        lblErrMsg.Text = ex.ToString();
                        lblErrMsg.Visible = true;
                    }
                    finally
                    {
                        con.Close();
                        ddPalletAction.Visible = false;
                        btnInsPallet.Visible = true;
                        gvProcDetails.DataBind();
                        lblProcDetails.Visible = true;
                        lblHeader.Visible = true;
                    }
                }
            }
            else
            {
                ddPalletAction.Visible = false;
                btnInsPallet.Visible = true;
            }
        }
    }
}