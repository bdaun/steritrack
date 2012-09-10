using System;
using System.Data;
using System.Data.SqlClient;
using System.Web;

namespace IMDBWeb.Secure
{
    public partial class LocationChange : System.Web.UI.Page
    {
        string CntrType = string.Empty;     // initialize local var CntrType used to differentiate Inbound and Outbound Cntr ID's 
        string strCntr = string.Empty;      // initialize local var for the Container ID


        protected void Page_Load(object sender, EventArgs e)
        {
            txbNewLocation.Visible = false;
            lblNewLocation.Visible = false;
            lblOutCntr.Visible = false;
            txbOutCntr.Visible = false;
            lblCntrErr.Visible = false;
            lblErrMsg.Visible = false;
            txbCntrID.Focus();
        }
        protected void txbCntrID_TextChanged(object sender, EventArgs e)
        {

            /* ******************************** Algorithm *********************************************
             * 
             * NOTE:   Code for BtnSubmit_Click should be IDENTICAL to code for txbCntrID_Textchanged.
             * 
                **************************************************************************************** */

            // Based on strCntr value, set control visibility  strCntr = txbCntrID.Text;                       
            if (txbCntrID.Text == "")
            {
                txbNewLocation.Visible = false;
                lblNewLocation.Visible = false;
                FormView1.Visible = true;
                lblCntrErr.Visible = false;
            }
            else
            {
                string strCntr = txbCntrID.Text.ToUpper();
                if (strCntr.StartsWith("IN") || strCntr.StartsWith("OUT") || strCntr.StartsWith("ROP"))
                {
                    if (strCntr.StartsWith("IN"))
                    {
                        string chkValidCntr = "IMDB_LocChange_InboundContainer_Exist";
                        lblErrMsg.Text = "This container does not appear to have been received.  Please receive the container before attempting to change the location.";
                        SqlConnection CntrConnect = new SqlConnection();
                        CntrConnect.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
                        SqlCommand CntrCmd = new SqlCommand(chkValidCntr, CntrConnect);
                        CntrCmd.CommandType = CommandType.StoredProcedure;
                        CntrConnect.Open();
                        using (CntrCmd)
                        {
                            CntrCmd.Parameters.AddWithValue("@inboundcontainerid", txbCntrID.Text);
                            object isValid = new object();
                            isValid = CntrCmd.ExecuteScalar();
                            if (isValid == null)
                            {
                                lblErrMsg.Visible = true;
                                txbNewLocation.Visible = false;
                                return;
                            }
                            else
                            {
                                txbNewLocation.Visible = true;
                                lblNewLocation.Visible = true;
                                txbNewLocation.Text = string.Empty;
                                txbNewLocation.Focus();
                            }
                        }
                        CntrConnect.Close();
                    }
                    else  // OUT or ROPAK container is being moved
                    {

                        //  Confirm that the container id that was scanned is associated with an inbound container

                        string chkValidCntr = "IMDB_LocChange_OutboundContainer_Exist";
                        lblErrMsg.Text = "This outbound container has not been associated with an inbound container.  Please use the processing page to associate this container with an inbound container";
                        SqlConnection CntrConnect = new SqlConnection();
                        CntrConnect.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
                        SqlCommand CntrCmd = new SqlCommand(chkValidCntr, CntrConnect);
                        CntrCmd.CommandType = CommandType.StoredProcedure;
                        CntrConnect.Open();
                        using (CntrCmd)
                        {
                            CntrCmd.Parameters.AddWithValue("@outboundcontainerid", txbCntrID.Text);
                            object isValid = new object();
                            isValid = CntrCmd.ExecuteScalar();
                            if (isValid == null)
                            {
                                //  this is the case where the inbound container did not have a related inbound record
                                lblErrMsg.Visible = true;
                                txbNewLocation.Visible = false;
                                return;
                            }
                            else
                            {
                                //  inbound record has been found.  Therefore, present the user with new location options
                                txbNewLocation.Visible = true;
                                lblNewLocation.Visible = true;
                                txbNewLocation.Text = string.Empty;
                                txbNewLocation.Focus();
                            }
                        }
                        CntrConnect.Close();
                    }
                }
                else  // this is the catch-all for scanned containers that do not meet the std convention for container naming
                {
                    txbNewLocation.Visible = false;
                    lblNewLocation.Visible = false;
                    txbCntrID.Text = "";
                    txbCntrID.Focus();
                    lblCntrErr.Visible = true;
                    lblCntrErr.Text = "You must scan a container barcode which begins with 'IN', 'OUT' or 'ROPAK'.";
                }
            }
        }
        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
            /* ******************************** Algorithm *********************************************
             * 
             * NOTE:   Code for BtnSubmit_Click should be IDENTICAL to code for txbCntrID_Textchanged.
             * 
                **************************************************************************************** */

            // Based on strCntr value, set control visibility  strCntr = txbCntrID.Text;    
                   
            if (txbCntrID.Text == "")
            {
                txbNewLocation.Visible = false;
                lblNewLocation.Visible = false;
                FormView1.Visible = true;
                lblCntrErr.Visible = false;
            }
            else
            {
                string strCntr = txbCntrID.Text.ToUpper();
                if (strCntr.StartsWith("IN") || strCntr.StartsWith("OUT") || strCntr.StartsWith("ROP"))
                {
                    if (strCntr.StartsWith("IN"))
                    {
                        string chkValidCntr = "IMDB_LocChange_InboundContainer_Exist";
                        lblErrMsg.Text = "This container does not appear to have been received.  Please receive the container before attempting to change the location.";
                        SqlConnection CntrConnect = new SqlConnection();
                        CntrConnect.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
                        SqlCommand CntrCmd = new SqlCommand(chkValidCntr, CntrConnect);
                        CntrCmd.CommandType = CommandType.StoredProcedure;
                        CntrConnect.Open();
                        using (CntrCmd)
                        {
                            CntrCmd.Parameters.AddWithValue("@inboundcontainerid", txbCntrID.Text);
                            object isValid = new object();
                            isValid = CntrCmd.ExecuteScalar();
                            if (isValid == null)
                            {
                                lblErrMsg.Visible = true;
                                txbNewLocation.Visible = false;
                                return;
                            }
                            else
                            {
                                txbNewLocation.Visible = true;
                                lblNewLocation.Visible = true;
                                txbNewLocation.Text = string.Empty;
                                txbNewLocation.Focus();
                            }
                        }
                        CntrConnect.Close();
                    }
                    else  // OUT or ROPAK container is being moved
                    {

                        //  Confirm that the container id that was scanned is associated with an inbound container

                        string chkValidCntr = "IMDB_LocChange_OutboundContainer_Exist";
                        lblErrMsg.Text = "This outbound container has not been assoicated with an inbound container.  Please use the processing page to associate this container with an inbound container";
                        SqlConnection CntrConnect = new SqlConnection();
                        CntrConnect.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
                        SqlCommand CntrCmd = new SqlCommand(chkValidCntr, CntrConnect);
                        CntrCmd.CommandType = CommandType.StoredProcedure;
                        CntrConnect.Open();
                        using (CntrCmd)
                        {
                            CntrCmd.Parameters.AddWithValue("@outboundcontainerid", txbCntrID.Text);
                            object isValid = new object();
                            isValid = CntrCmd.ExecuteScalar();
                            if (isValid == null)
                            {
                                //  this is the case where the inbound container did not have a related inbound record
                                lblErrMsg.Visible = true;
                                txbNewLocation.Visible = false;
                                return;
                            }
                            else
                            {
                                //  inbound record has been found.  Therefore, present the user with new location options
                                txbNewLocation.Visible = true;
                                lblNewLocation.Visible = true;
                                txbNewLocation.Text = string.Empty;
                                txbNewLocation.Focus();
                            }
                        }
                        CntrConnect.Close();
                    }
                }
                else  // this is the catch-all for scanned containers that do not meet the std convention for container naming
                {
                    txbNewLocation.Visible = false;
                    lblNewLocation.Visible = false;
                    txbCntrID.Text = "";
                    txbCntrID.Focus();
                    lblCntrErr.Visible = true;
                    lblCntrErr.Text = "You must scan a container barcode which begins with 'IN', 'OUT' or 'ROPAK'.";
                }
            }
        }
        protected void btnClear_Click(object sender, EventArgs e)
        {
            // Reset page
            txbCntrID.Text = "";
            Response.Redirect(Request.RawUrl);
        }
        protected void txbNewLocation_TextChanged(object sender, EventArgs e)
        {
            /*  ********************************** Algorithm ************************************************
                When user selects a new location, system does the following:
                1. Check if the location that was entered is a valid location
                2. Check if the new location is a loc2loc move, an aggrcntr process, or a truck out process
                3. If new location isL
                    a. Truck:  prompt for TruckID,
                    b. AggrCntr:  create and/or update the process record with the aggrcntr value and name
                    c. Loc2Loc:  Update the location

                ********************************************************************************************** */

            // Check to see if the New Location is a valid location
            #region CheckLocation valid

            string checklocation = "IMDB_LocChange_Location_Sel";
            SqlConnection LocConnect = new SqlConnection();
            LocConnect.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
            SqlCommand LocCmd = new SqlCommand(checklocation, LocConnect);
            LocCmd.CommandType = CommandType.StoredProcedure;
            LocConnect.Open();

            using (LocCmd)
            {
                LocCmd.Parameters.AddWithValue("@locationname", txbNewLocation.Text);
                object hasLoc = new object();
                hasLoc = LocCmd.ExecuteScalar();
                if (hasLoc == null)
                {
                    lblErrMsg.Visible = true;
                    lblErrMsg.Text = "This is not a valid Location.";
                    txbNewLocation.Visible = true;
                    txbNewLocation.Text = string.Empty;
                    txbNewLocation.Focus();
                    return;
                }
            }
            LocConnect.Close();

            #endregion

            // Determine type of move.  If it is Truck user must supply the shipping information.
            #region Type of Move and Location Updates

            string[] args = { "COMPACTOR", "TRUCK", "BALER", "TANK 1", "TANK 2" };
            string value = txbNewLocation.Text.ToUpper();
            string found = Array.Find(args, item => item.Contains(value));
            if (!string.IsNullOrEmpty(found))  //new location is Aggregate Container or Truck
            {
                if (value == "TRUCK")
                {
                    // new Location is a Truck.  Exit and prompt user for TruckID
                    #region TruckID Prompt
                    lblOutCntr.Text = "Please scan the Truck ID:";
                    lblOutCntr.Visible = true;
                    txbOutCntr.Visible = true;
                    txbOutCntr.Focus();
                    return;
                    #endregion
                }
                else
                {
                // Use AggrCntr current value to auto-process the move and post message back to user.
                #region AggrCntr AutoProcess

                    /* *************************** Algorithm ***********************************

                    User arrives here only if they have selected an AggrCntr location (Compactor, Baler, or Tank)
                    1.. Determine if the cntrid exists in the procdetail table
                        a. If yes, determine if an aggrcntr line already exists
                            i. If yes, error msg & exit
                            ii. If no, update location/cntrid to aggrcntrname and aggrcntrid
                        b. If no, determine if the cntr exists in rcvdetail
                            i. If yes, copy rcv info to prochdr/proc detail line w/ aggrcntrname and aggrcntrid
                            ii. If no, error msg & exit

                     ***************************************************************************** */



                    // Determine if the cntrID exists in prochdr.  Return ProcHdrID as Session
                    #region CntrID in ProcDetail

                    SqlConnection Connect = new SqlConnection();
                    Connect.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
                    string spProcExist = "IMDB_Processing_ProcHdr_Exist";
                    string cntrID = txbCntrID.Text.ToUpper();
                    SqlCommand CmdProcExist= new SqlCommand(spProcExist, Connect);
                    CmdProcExist.CommandType = CommandType.StoredProcedure;

                    try
                    {
                        Connect.Open();
                        using (CmdProcExist)
                        {
                            CmdProcExist.Parameters.AddWithValue("@InboundContainerID", cntrID);
                            object hasID = new object();
                            hasID = CmdProcExist.ExecuteScalar();
                            if (hasID != null)  //  this is the case where there is an existing ProcessHdr
                            {
                                Session["ProcHdrID"] = hasID;  // will use this value for new process detail record
                            }
                            else  // this is the case where new prochdr must be created.
                            {
                                string spInsProcHdr = "IMDB_LocChange_ProcHdr_InsAggrCntr";
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
                                        insCmd.Parameters.AddWithValue("@InboundcontainerID", txbCntrID.Text);
                                        insCmd.Parameters.AddWithValue("@User", HttpContext.Current.User.Identity.Name.ToString()); 

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

                    #endregion

                    // Create/update procdetail record
                    #region Add/Update ProcDetail Record
                    /* ******************************** Algorithm *********************************************
                     *  1. Confirm that an AggrCntr record doesn't already exist
                     *  2. Get the current Aggregate Cntr ID for compactor
                     * 
	                   **************************************************************************************** */

                    String spChk = string.Empty;
                    String spIns = string.Empty;
                    String spPallet = string.Empty;
                    //  Use switch to set storedprocedure values depending on new location
                    switch (txbNewLocation.Text.ToUpper())
                    {
                        case "COMPACTOR":
                            spChk = "IMDB_Processing_InsCompact_Exist";
                            spIns = "IMDB_Processing_InsCompact";
                            spPallet = "IMDB_Processing_Pallet_Ins";
                            break;
                        case "BALER":
                            spChk = "IMDB_Processing_InsBale_Exist";
                            spIns = "IMDB_processing_InsBale";
                            spPallet = "IMDB_Processing_Pallet_Ins";
                            break;
                        default:  // Captures both Tank1 and Tank2 Case
                            spChk = "IMDB_Processing_insTank_Exist";
                            spIns = "IMDB_Processing_InsTank";
                            spPallet = "IMDB_Processing_Pallet_Ins";
                            break;
                    }
                    String spAggrCntr = "IMDB_AggCntr_Select";
                    Boolean ChkResult = false;  // Default setting assumes new AggrCntr record can be created
                    SqlConnection con = new SqlConnection();
                    con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
                    SqlCommand spCmd = new SqlCommand(spIns, con);
                    SqlCommand spChkCmd = new SqlCommand(spChk, con);
                    SqlCommand spAggrCmd = new SqlCommand(spAggrCntr, con);
                    SqlCommand spPalletCmd = new SqlCommand(spPallet, con);

                    spAggrCmd.CommandType = CommandType.StoredProcedure;
                    spCmd.CommandType = CommandType.StoredProcedure;
                    spChkCmd.CommandType = CommandType.StoredProcedure;
                    spPalletCmd.CommandType = CommandType.StoredProcedure;
                    con.Open();
                    
                    //check for existing AggrCntr record for this prochdrid
                    using (spChkCmd)  
                    {
                        try
                        {
                            spChkCmd.Parameters.AddWithValue("@ProcHdrID", Session["ProcHdrID"]);
                            object hasRecord = new object();
                            hasRecord = spChkCmd.ExecuteScalar();
                            if (hasRecord != null)
                            {
                                ChkResult = true;
                                lblErrMsg.Visible = true;
                                lblErrMsg.Text = "There is already a " + txbNewLocation.Text + " Record. Please contact your supervisor";
                            }
                        }
                        catch (Exception ex)
                        {
                            lblErrMsg.Visible = true;
                            lblErrMsg.Text = ex.ToString();
                        }
                    }

                    // if ChkResult is false, obtain the aggrCntrID and rcvdetail values for procdetail record to be created/updated
                    if (ChkResult == false)
                    {
                        using (spAggrCmd)
                        {
                            try
                            {
                                String cntrname = txbNewLocation.Text;
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

                        //  Obtain the RcvDetail Information for the container
                        #region RcvDetail Values
                        String spRcvDetail = "IMDB_Processing_RcvDetail_Sel";
                        SqlCommand rcvCmd = new SqlCommand(spRcvDetail, con);
                        rcvCmd.CommandType = CommandType.StoredProcedure;

                        try    //  Determine if the entered value exists in the rcvdetail table.  If existing, get current values.
                        {
                            using (rcvCmd)
                            {
                                rcvCmd.Parameters.AddWithValue("@inboundcontainerid", cntrID);
                                SqlDataReader Reader = rcvCmd.ExecuteReader();
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
                                    Reader.Close();
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

                        //  Create Process Detail Record
                        #region Process Detail Insert
                        using (spCmd)
                        {
                            try
                            {
                            //  Set the default value for the the new record Weight.
                            //  For compactor and baler, this value will be changed to separate out the pallet
                            
                                int productWt = (int)Session["InboundPalletWeight"];
                                int palletwt = 0;

                                switch (Session["InboundPalletType"].ToString())
                                {
                                    case "CHEP":
                                        palletwt = 66;
                                        break;
                                    case "GMA":
                                        palletwt = 42;
                                        break;
                                    default:
                                        palletwt = 0;
                                        break;
                                }
                                productWt = productWt - palletwt;
                                spCmd.Parameters.AddWithValue("@OutboundStreamWeight", productWt );
                                spCmd.Parameters.AddWithValue("@User", HttpContext.Current.User.Identity.Name.ToString());
                                spCmd.Parameters.AddWithValue("@ProchdrID", Session["ProcHdrID"]);
                                spCmd.Parameters.AddWithValue("@AggCntr", Session["curCntr"]);
                                spCmd.Parameters.AddWithValue("@OutboundStreamProfile", Session["InboundProfileID"]);
                                spCmd.Parameters.AddWithValue("@OutboundContainerType", Session["InboundContainerType"]);
                                spCmd.Parameters.AddWithValue("@OutboundCntrQty", Session["Inboundcontainerqty"]);
                                spCmd.ExecuteNonQuery();
                            }
                            catch (Exception ex)
                            {
                                lblErrMsg.Visible = true;
                                lblErrMsg.Text = ex.ToString();
                            }
                        }
                        using (spPalletCmd)
                        {
                            try
                            {
                                int palletWt = 0;
                                int palletprofile = 0;
                                switch (Session["InboundPalletType"].ToString())
                                {
                                    case "CHEP":
                                        palletWt = 66;
                                        palletprofile = 26;
                                        break;
                                    case "GMA":
                                        palletWt = 42;
                                        palletprofile = 27;
                                        break;
                                    default:
                                        palletWt = 0;
                                        break;
                                }
                                spPalletCmd.Parameters.AddWithValue("@ProcHdrID", Session["ProcHdrID"]);
                                spPalletCmd.Parameters.AddWithValue("@palletwt", palletWt );
                                spPalletCmd.Parameters.AddWithValue("@palletprofile", palletprofile);
                                spPalletCmd.Parameters.AddWithValue("@PalletType", Session["InboundPalletType"]);
                                spPalletCmd.Parameters.AddWithValue("@User", HttpContext.Current.User.Identity.Name.ToString());
                                spPalletCmd.ExecuteNonQuery();
                            }
                            catch (Exception ex)
                            {
                                lblErrMsg.Visible = true;
                                lblErrMsg.Text = ex.ToString();
                            }
                        }
                        txbCntrID.Text = string.Empty;
                        txbCntrID.Focus();
                        FormView1.DataBind();
                        con.Close();
                        #endregion
                    }
                    else
                    {
                        con.Close();
                    }
                    #endregion
                }
                #endregion
            }
            else
            {
            // If new location is not an AggrCntr or Truck proceed with the update based on the type of container being moved.
            #region Location2Location Move

                string strCntr = txbCntrID.Text.ToUpper();
                if (strCntr.StartsWith("IN"))
                //  This is the case for Inbound containers that are being moved to storage areas within the building
                {
                    //Create Command object
                    SqlConnection thisConnection = new SqlConnection();
                    thisConnection.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
                    SqlCommand nonqueryCommand = thisConnection.CreateCommand();
                    try
                    {
                        // Open Connection
                        thisConnection.Open();

                        // Sql Update Statement

                        string updateSql = "IMDB_LocChange_Upd";
                        SqlCommand UpdateCmd = new SqlCommand(updateSql, thisConnection);
                        UpdateCmd.CommandType = CommandType.StoredProcedure;

                        //  Map Parameters
                        UpdateCmd.Parameters.Add("@InboundContainerID", SqlDbType.NVarChar, 20, "InboundContainerID");
                        UpdateCmd.Parameters.Add("@NewLocation", SqlDbType.NVarChar, 50, "NewLocation");
                        UpdateCmd.Parameters["@InboundContainerID"].Value = txbCntrID.Text;
                        UpdateCmd.Parameters["@NewLocation"].Value = txbNewLocation.Text;
                        UpdateCmd.Parameters.AddWithValue("@UserName", HttpContext.Current.User.Identity.Name.ToString());

                        UpdateCmd.ExecuteNonQuery();
                    }

                    catch (SqlException ex)
                    {
                        // Display error
                        lblErrMsg.Text = ex.ToString();
                        lblErrMsg.Visible = true;
                    }

                    finally
                    {
                        // Close Connection
                        thisConnection.Close();
                        txbCntrID.Text = string.Empty;
                        txbOutCntr.Text = string.Empty;
                        txbCntrID.Focus();
                    }
                }
                else  //  This is the case for outbound containers
                {
                    //Create Command object
                    SqlConnection thisConnection = new SqlConnection();
                    thisConnection.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
                    SqlCommand nonqueryCommand = thisConnection.CreateCommand();
                    try
                    {
                        // Open Connection
                        thisConnection.Open();

                        // Sql Update Statement

                        string updateSql = "IMDB_LocChange_ProcDetail_Upd";
                        SqlCommand UpdateCmd = new SqlCommand(updateSql, thisConnection);
                        UpdateCmd.CommandType = CommandType.StoredProcedure;

                        //  Map Parameters
                        UpdateCmd.Parameters.Add("@outboundcontainerid", SqlDbType.NVarChar, 20, "OutboundContainerID");
                        UpdateCmd.Parameters.Add("@NewLocation", SqlDbType.NVarChar, 50, "NewLocation");
                        UpdateCmd.Parameters["@outboundcontainerid"].Value = txbCntrID.Text;
                        UpdateCmd.Parameters["@NewLocation"].Value = txbNewLocation.Text;

                        UpdateCmd.ExecuteNonQuery();
                    }

                    catch (SqlException ex)
                    {
                        // Display error
                        lblErrMsg.Text = ex.ToString();
                        lblErrMsg.Visible = true;
                    }

                    finally
                    {
                        // Close Connection
                        thisConnection.Close();
                        txbCntrID.Text = string.Empty;
                        txbOutCntr.Text = string.Empty;
                        txbCntrID.Focus();
                    }
                }
            }
                #endregion
            #endregion
        }
        protected void txbOutCntr_TextChanged(object sender, EventArgs e)
        {
            // User arrives here only if they have selected Truck
            //  1. First check if a value has been supplied.  If not, return user to page.
            //  2. If container being moved is an "IN" container, update the receive table and create prochdr and procdetail based on New Location value
            //  3. if container being moved is an "OUT" container, update the procdetail table.

            if (txbOutCntr.Text == "")
            {
                Response.Redirect(Request.RawUrl);
            }
            else
            {

                //  Set the value of the local variable inTblChk based on a check of txbOutCntr presences in ship table.  
                //  Note, this variable is only used if the new location is TRUCK.   

                Boolean inTblChk = false;
                object inTable = new object();
                SqlConnection inTblConnect = new SqlConnection();
                inTblConnect.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
                string inTbl = "IMDB_LocChange_OutboundDoc_Exist";
                SqlCommand inTblCmd = new SqlCommand(inTbl, inTblConnect);
                inTblCmd.CommandType = CommandType.StoredProcedure;
                inTblConnect.Open();

                using (inTblCmd)
                {
                    inTblCmd.Parameters.AddWithValue("@outbounddocno", txbOutCntr.Text);
                    inTable = inTblCmd.ExecuteScalar();
                    if (inTable != null)
                    {
                        inTblChk = true;
                    }
                    else
                    {
                        inTblChk = false;
                    }
                }
                inTblConnect.Close();

                //  Determine if this is an "IN" container move or "OUT" move and perform updates accordingly
                string strCntr = txbCntrID.Text.ToUpper();
                if (strCntr.StartsWith("IN"))
                //  This is the case for "IN" container being moved to TRUCK
                {
                    string strCntr1 = txbOutCntr.Text.ToUpper();
                    if (inTblChk == true && txbNewLocation.Text.ToUpper() == "TRUCK")
                    {
                        // Perform the location update to the RecDetails table
                        SqlConnection thisConnection = new SqlConnection();
                        thisConnection.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
                        SqlCommand nonqueryCommand = thisConnection.CreateCommand();

                        try
                        {
                            // Open Connection
                            thisConnection.Open();

                            // Sql Update RcvDetails Statement
                            string updateSql = "IMDB_LocChange_RcvDetail_Upd";
                            SqlCommand updateCmd = new SqlCommand(updateSql, thisConnection);
                            updateCmd.CommandType = CommandType.StoredProcedure;
                            using (updateCmd)
                            {
                                //  Map update Parameters and execute the NonQuery
                                updateCmd.Parameters.Add("@InboundContainerID", SqlDbType.NVarChar, 20, "InboundContainerID");
                                updateCmd.Parameters.Add("@NewLocation", SqlDbType.NVarChar, 50, "NewLocation");
                                updateCmd.Parameters.Add("@processplan", SqlDbType.NVarChar, 20, "ProcessPlan");
                                updateCmd.Parameters["@processplan"].Value = "Truck";
                                updateCmd.Parameters["@InboundContainerID"].Value = txbCntrID.Text;
                                updateCmd.Parameters["@NewLocation"].Value = txbNewLocation.Text;

                                updateCmd.ExecuteNonQuery();
                            }
                            string insertSQL1 = "IMDB_LocChange_ProcHdr_Ins";
                            int lastID;     // Create local variable for the identity value
                            SqlCommand insertCmd1 = new SqlCommand(insertSQL1, thisConnection);
                            insertCmd1.CommandType = CommandType.StoredProcedure;
                            using (insertCmd1)
                            {
                                // Map ProcHdr Parameters
                                SqlParameter processHeaderIdParameter = new SqlParameter("@ProcHdrID", SqlDbType.Int);
                                processHeaderIdParameter.Direction = ParameterDirection.Output;
                                insertCmd1.Parameters.Add(processHeaderIdParameter);
                                insertCmd1.Parameters.Add("@InboundContainerID", SqlDbType.NVarChar, 20, "InboundContainerID");
                                insertCmd1.Parameters["@InboundContainerID"].Value = txbCntrID.Text;
                                insertCmd1.Parameters.Add("@User", SqlDbType.NVarChar, 20, "ProcessorName");
                                insertCmd1.Parameters["@User"].Value = HttpContext.Current.User.Identity.Name.ToString();

                                // Execute the insert and get the identity
                                insertCmd1.ExecuteNonQuery();
                                lastID = (int)processHeaderIdParameter.Value;
                            }

                            // Create sql select from rcvdetail to obtain values from the current record
                            // which can be used to create procdetail values

                            string selectSQL = "IMDB_LocChange_RcvDetail_Sel";
                            string InboundContainerID = String.Empty;
                            string InboundContainerType = String.Empty;
                            string InboundPalletType = String.Empty;
                            int InboundPalletWeight = 0;
                            int InboundProfileID = 0;

                            SqlCommand selectCmd = new SqlCommand(selectSQL, thisConnection);
                            selectCmd.CommandType = CommandType.StoredProcedure;

                            using (selectCmd)
                            {
                                // Map Select Parmeters
                                selectCmd.Parameters.Add("@InboundContainerID", SqlDbType.NVarChar, 20, "InboundContainerID");
                                selectCmd.Parameters["@InboundContainerID"].Value = txbCntrID.Text;
                                selectCmd.Parameters.Add("@InboundContainerType", SqlDbType.NVarChar, 20, "InboundContainerType");
                                selectCmd.Parameters["@InboundContainerType"].Direction = ParameterDirection.Output;
                                selectCmd.Parameters.Add("@InboundPalletType", SqlDbType.NVarChar, 20, "InboundPalletType");
                                selectCmd.Parameters["@InboundPalletType"].Direction = ParameterDirection.Output;
                                selectCmd.Parameters.Add("@InboundPalletWeight", SqlDbType.Int, 20, "InboundPalletWeight");
                                selectCmd.Parameters["@InboundPalletWeight"].Direction = ParameterDirection.Output;
                                selectCmd.Parameters.Add("@InboundProfileID", SqlDbType.Int, 20, "InboundProfileID");
                                selectCmd.Parameters["@InboundProfileID"].Direction = ParameterDirection.Output;

                                SqlDataReader Reader = selectCmd.ExecuteReader();

                                using (Reader)
                                {
                                    while (Reader.Read())
                                    {
                                        InboundContainerID = Reader["InboundContainerID"].ToString();
                                        InboundContainerType = Reader["InboundContainerType"].ToString();
                                        InboundPalletType = Reader["InboundPalletType"].ToString();
                                        InboundPalletWeight = (int)Reader["InboundPalletWeight"];
                                        InboundProfileID = (int)Reader["InboundProfileID"];
                                    }
                                }
                            }
                            // Sql Insert ProcDetail Statement for new record.
                            string OutboundLocation = txbNewLocation.Text.ToUpper();
                            string insertSQL2 = "";
                            int palletwt = 0;
                            int productwt = 0;
                            int palletprofile = 0;
                            insertSQL2 = "IMDB_LocChange_ProcDetail_Ins";

                            SqlCommand insertCmd2 = new SqlCommand(insertSQL2, thisConnection);
                            insertCmd2.CommandType = CommandType.StoredProcedure;

                            using (insertCmd2)
                            {
                                insertCmd2.Parameters.AddWithValue("@lastID", lastID);
                                insertCmd2.Parameters.AddWithValue("@InboundPalletWeight", InboundPalletWeight);
                                insertCmd2.Parameters.AddWithValue("@InboundProfileID", InboundProfileID);
                                insertCmd2.Parameters.AddWithValue("@InboundContainerType", InboundContainerType);
                                insertCmd2.Parameters.AddWithValue("@OutboundContainerID", txbOutCntr.Text);
                                insertCmd2.Parameters.AddWithValue("@InboundPalletType", InboundPalletType);
                                insertCmd2.Parameters.AddWithValue("@Palletwt", palletwt);
                                insertCmd2.Parameters.AddWithValue("@palletprofile", palletprofile);
                                insertCmd2.Parameters.AddWithValue("@Productwt", productwt);
                                insertCmd2.Parameters.AddWithValue("@OutboundDocNo", txbOutCntr.Text);
                                insertCmd2.Parameters.AddWithValue("@InboundContainerID", InboundContainerID);

                                insertCmd2.ExecuteNonQuery();
                            }

                            txbNewLocation.Text = string.Empty;
                        }
                        catch (SqlException ex)
                        {
                            if (ex.ErrorCode == -2146232060)
                            {
                                // there is already a process header for this record
                                lblErrMsg.Text = "There is already a Process Header for this record.  Please scan the outboundID or contact your supervisor";
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
                            // Close Connection and clean up
                            thisConnection.Close();
                            txbCntrID.Text = string.Empty;
                            txbOutCntr.Text = string.Empty;
                            txbCntrID.Focus();
                        }
                    }
                    else    // this is the case if the entered value does not begin with "OUT" or is not in ShipHdr
                    {
                        txbOutCntr.Visible = true;
                        txbOutCntr.Text = string.Empty;
                        txbOutCntr.Focus();
                        lblErrMsg.Visible = true;
                        lblErrMsg.Text = "The value you entered is not in the ShipHdr Table or is marked as already shipped.  Please re-scan or contact the shipping clerk to create " +
                            "an outbound shipping record.";
                        lblOutCntr.Visible = true;
                    }
                }
                else
                //  This is the case for "OUT" containers that are being loaded on a Truck
	            {
                    string strCntr1 = txbOutCntr.Text.ToUpper();
                    if (inTblChk == true && txbNewLocation.Text.ToUpper() == "TRUCK")
                    {
                        // Perform the location update to the ProcDetails table
                        SqlConnection thisConnection = new SqlConnection();
                        thisConnection.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
                        SqlCommand nonqueryCommand = thisConnection.CreateCommand();
                        
                        try
                        {
                            // Open Connection
                            thisConnection.Open();

                            string updateSQL = string.Empty;
                            updateSQL = "IMDB_LocChange_ProcDetailTruck_Ins";

                            SqlCommand UpdateCmd = new SqlCommand(updateSQL, thisConnection);
                            UpdateCmd.CommandType = CommandType.StoredProcedure;
                                
                            //  Map Parameters
                            UpdateCmd.Parameters.AddWithValue("@outbounddocno", txbOutCntr.Text);
                            UpdateCmd.Parameters.AddWithValue("@username", HttpContext.Current.User.Identity.Name.ToString());
                            UpdateCmd.Parameters.AddWithValue("@outboundcontainerid_old",txbCntrID.Text);
                            UpdateCmd.Parameters.AddWithValue("@outboundcontainerid", txbOutCntr.Text);
                            UpdateCmd.Parameters.AddWithValue("@outboundTruckid", txbCntrID.Text);

                            UpdateCmd.ExecuteNonQuery();           
                            
                            txbNewLocation.Text = string.Empty;
                        }
                        catch (SqlException ex)
                        {
                            // Display error
                            lblErrMsg.Text = ex.ToString();
                            lblErrMsg.Visible = true;
                        }
                        finally
                        {
                            // Close Connection and clean up
                            thisConnection.Close();
                            txbCntrID.Text = string.Empty;
                            txbOutCntr.Text = string.Empty;
                            txbCntrID.Focus();
                        }
                    }
                    else    // this is the case if the entered value does not begin with "OUT" or is not in ShipHdr
                    {
                        txbOutCntr.Visible = true;
                        txbOutCntr.Text = string.Empty;
                        txbOutCntr.Focus();
                        lblErrMsg.Visible = true;
                        lblErrMsg.Text = "The value you entered is not in the ShipHdr Table or has already shipped. " +
                            "Please re-scan or contact the shipping clerk to create " +
                            "an outbound shipping record.";
                        lblOutCntr.Visible = true;
                    }
	            }
            }
        }
    }
}
