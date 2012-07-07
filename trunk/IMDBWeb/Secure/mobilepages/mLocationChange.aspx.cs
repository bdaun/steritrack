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
                        string chkValidCntr = "SELECT ID FROM rcvDetail WHERE inboundcontainerid = @inboundcontainerid";
                        lblErrMsg.Text = "This container does not appear to have been received.  Please receive the container before attempting to change the location.";
                        SqlConnection CntrConnect = new SqlConnection();
                        CntrConnect.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
                        SqlCommand CntrCmd = new SqlCommand(chkValidCntr, CntrConnect);
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

                        string chkValidCntr = "SELECT ID FROM procdetail WHERE outboundcontainerid = @outboundcontainerid";
                        lblErrMsg.Text = "This outbound container has not been assoicated with an inbound container.  Please use the processing page to associate this container with an inbound container";
                        SqlConnection CntrConnect = new SqlConnection();
                        CntrConnect.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
                        SqlCommand CntrCmd = new SqlCommand(chkValidCntr, CntrConnect);
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
            //  NOTE:   Code for BtnSubmit_Click should be IDENTICAL to codee for txbCntrID_Textchanged.

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
                        string chkValidCntr = "SELECT ID FROM rcvDetail WHERE inboundcontainerid = @inboundcontainerid";
                        lblErrMsg.Text = "This container does not appear to have been received.  Please receive the container before attempting to change the location.";
                        SqlConnection CntrConnect = new SqlConnection();
                        CntrConnect.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
                        SqlCommand CntrCmd = new SqlCommand(chkValidCntr, CntrConnect);
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

                        string chkValidCntr = "SELECT ID FROM procdetail WHERE outboundcontainerid = @outboundcontainerid";
                        lblErrMsg.Text = "This outbound container has not been assoicated with an inbound container.  Please use the processing page to associate this container with an inbound container";
                        SqlConnection CntrConnect = new SqlConnection();
                        CntrConnect.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
                        SqlCommand CntrCmd = new SqlCommand(chkValidCntr, CntrConnect);
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
            // When user selects a new location, system does the following:
            //      1. Check if the location that was entered is a valid location
            //      2. Check if the new location is a move, a compactor process, a bailing process, or a truck out process
            //      3. For Compactor, Bailer, or Truck locations prompt for outbound container.  


            // Check to see if the New Location is a valid location

            string checklocation = "SELECT LocationName FROM Locations WHERE LocationName = @locationname";
            SqlConnection LocConnect = new SqlConnection();
            LocConnect.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
            SqlCommand LocCmd = new SqlCommand(checklocation, LocConnect);
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


            // Determine type of move.  If it is Truck or Compactor, user must supply outbound container ID.  
            // System will escape from method and prompt for container ID which user will scan in up loading to truck or compactor

            string[] args = { "COMPACTOR", "TRUCK", "BALER", "TANK 1", "TANK 2" };
            string value = txbNewLocation.Text.ToUpper();
            string found = Array.Find(args, item => item.Contains(value));
            if (!string.IsNullOrEmpty(found))
            { 
                lblOutCntr.Text = "Please scan the " + txbNewLocation.Text +" ID:";
                lblOutCntr.Visible = true;
                txbOutCntr.Visible = true;
                txbOutCntr.Focus();
                return;
            }

            // If new location is NOT compactor, baler, or Truck proceed with the update based on the type of container being moved.
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

                    string updateSql = "UPDATE rcvdetail " +
                        "SET InventoryLocation = @NewLocation " +
                        "WHERE InboundContainerID = @InboundcontainerID";
                    SqlCommand UpdateCmd = new SqlCommand(updateSql, thisConnection);

                    //  Map Parameters
                    UpdateCmd.Parameters.Add("@InboundContainerID", SqlDbType.NVarChar, 20, "InboundContainerID");
                    UpdateCmd.Parameters.Add("@NewLocation", SqlDbType.NVarChar, 50, "NewLocation");
                    UpdateCmd.Parameters["@InboundContainerID"].Value = txbCntrID.Text;
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
            else
            //  This is the case for outbound containers
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

                    string updateSql = "UPDATE ProcDetail " +
                        "SET Outboundlocation = @NewLocation " +
                        "WHERE OutboundContainerID = @outboundcontainerid";
                    SqlCommand UpdateCmd = new SqlCommand(updateSql, thisConnection);

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
        protected void txbOutCntr_TextChanged(object sender, EventArgs e)
        {
            // User arrives here only if they have selected Truck or Compactor for a location and have supplied an outbound container ID
            //  1. First check if a value has been supplied.  If not, return user to page.
            //  2. Validate outbound container does not start with "IN" or is in ship table
            //  3. If container being moved is an "IN" container, update the receive table and create prochdr and procdetail based on New Location value
            //  4. if container being moved is an "OUT" container, update the procdetail table.

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
                string inTbl = "SELECT ID FROM ShipHdr WHERE OutboundDocNo = @outbounddocno AND Completed = '0'";
                SqlCommand inTblCmd = new SqlCommand(inTbl, inTblConnect);
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
                //  This is the case for "IN" container being moved to TRUCK or COMPACTOR
                {
                    string strCntr1 = txbOutCntr.Text.ToUpper();
                    if ((
                        (strCntr1.StartsWith("ROP") && txbNewLocation.Text.ToUpper() == "BALER") || 
                        (strCntr1.StartsWith("OUT") && txbNewLocation.Text.ToUpper() == "BALER") ||
                        (strCntr1.StartsWith("OUT") && txbNewLocation.Text.ToUpper() == "TANK") ||
                        (strCntr1.StartsWith("ROP") && txbNewLocation.Text.ToUpper() == "COMPACTOR") || 
                        (strCntr1.StartsWith("OUT") && txbNewLocation.Text.ToUpper() == "COMPACTOR") || 
                        (inTblChk == true && txbNewLocation.Text.ToUpper() == "TRUCK")))
                    {
                        // Perform the location update to the RecDetails table
                        SqlConnection thisConnection = new SqlConnection();
                        thisConnection.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
                        SqlCommand nonqueryCommand = thisConnection.CreateCommand();
                        string procplan = string.Empty;
                        switch (txbNewLocation.Text.ToUpper())
                        {
                            case "COMPACTOR":
                                procplan = "Compact";
                                break;
                            case "BALER":
                                procplan = "Bale";
                                break;
                            case "TRUCK":
                                procplan = "Truck";
                                break;
                        }
                        try
                        {
                            // Open Connection
                            thisConnection.Open();

                            // Sql Update RccDetails Statement
                            string updateSql = "UPDATE rcvdetail SET InventoryLocation = @NewLocation,ProcessPlan = @processplan WHERE InboundContainerID = @InboundcontainerID";
                            SqlCommand updateCmd = new SqlCommand(updateSql, thisConnection);
                            using (updateCmd)
                            {
                                //  Map update Parameters and execute the NonQuery
                                updateCmd.Parameters.Add("@InboundContainerID", SqlDbType.NVarChar, 20, "InboundContainerID");
                                updateCmd.Parameters.Add("@NewLocation", SqlDbType.NVarChar, 50, "NewLocation");
                                updateCmd.Parameters.Add("@processplan", SqlDbType.NVarChar, 20, "ProcessPlan");
                                updateCmd.Parameters["@processplan"].Value = procplan;
                                updateCmd.Parameters["@InboundContainerID"].Value = txbCntrID.Text;
                                updateCmd.Parameters["@NewLocation"].Value = txbNewLocation.Text;

                                updateCmd.ExecuteNonQuery();
                            }

                            // Sql Insert ProcHdr Statement for new record AND get Identity using Scope_Identity
                            // Slightly different insert statement for Truck and Compactor.  Note that web login username
                            // is used for the processor value

                            string insertSQL1 = string.Empty;
                            switch (txbNewLocation.Text.ToUpper())
                            {
                                case "TRUCK":       // Truck which has 0 hrs of labor
                                    insertSQL1 = "INSERT INTO ProcHdr (InboundContainerID,ProcessorName,ProcessDate,ProcessingLaborHr) " +
                                    "VALUES (@InboundcontainerID,@User,Getdate(),'0'); Set @ProcessHeaderId = Scope_Identity()";
                                    break;
                                case "COMPACTOR":    // compactor which has 0.25 hrs of labor
                                    insertSQL1 = "INSERT INTO ProcHdr (InboundContainerID,ProcessorName,ProcessDate,ProcessingLaborHr) " +
                                    "VALUES (@InboundcontainerID,@User,Getdate(),'0.25'); Set @ProcessHeaderId = Scope_Identity()";
                                    break;
                                case "BALER":       // baler which has 0.25 hrs of labor
                                    insertSQL1 = "INSERT INTO ProcHdr (InboundContainerID,ProcessorName,ProcessDate,ProcessingLaborHr) " +
                                    "VALUES (@InboundcontainerID,@User,Getdate(),'0.25'); Set @ProcessHeaderId = Scope_Identity()";
                                    break;
                            }

                            int lastID;     // Create local variable for the identity value
                            SqlCommand insertCmd1 = new SqlCommand(insertSQL1, thisConnection);
                            using (insertCmd1)
                            {
                                // Map ProcHdr Parameters
                                SqlParameter processHeaderIdParameter = new SqlParameter("@ProcessHeaderId", SqlDbType.Int);
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

                            string selectSQL = "Select InboundPalletWeight,InboundProfileID,InboundContainerType,InboundContainerID," +
                                "InboundPalletType from RcvDetail WHERE InboundContainerID = @InboundcontainerID";
                            string InboundContainerID = String.Empty;
                            string InboundContainerType = String.Empty;
                            string InboundPalletType = String.Empty;
                            int InboundPalletWeight = 0;
                            int InboundProfileID = 0;

                            SqlCommand selectCmd = new SqlCommand(selectSQL, thisConnection);

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
                            // Sql Insert ProcDetail Statement for new record.  Single entry for Truck moves.  Two lines created for 
                            // Compactor with weights depending upon pallet type.
                            string OutboundLocation = txbNewLocation.Text.ToUpper();
                            string insertSQL2 = "";
                            int palletwt = 0;
                            int productwt = 0;
                            int palletprofile = 0;
                            switch (OutboundLocation)
                            {
                                case "TRUCK":
                                    {
                                        insertSQL2 = "INSERT INTO ProcDetail " +
                                        "(ProcHdrID,OutboundStreamType,OutboundStreamWeight,OutboundStreamProfile,OutboundContainerType," +
                                        "OutboundContainerID,OutboundPalletType,ProcessMethod,Shipped,OutboundLocation,OutboundDocNo) " +
                                        "VALUES (@lastID,'WTE',@InboundPalletWeight,@InboundProfileID,@InboundContainerType,@InboundContainerID," +
                                        "@InboundPalletType,'Ship','0','Truck',@OutboundDocNo)";
                                        break;
                                    }
                                case "COMPACTOR":
                                    {
                                        //  First determine the weights and profiles based on the type of pallet
                                        switch (InboundPalletType)
                                        {
                                            case "CHEP":
                                                palletwt = 66;
                                                palletprofile = 26;
                                                break;
                                            case "GMA":
                                                palletwt = 42;
                                                palletprofile = 27;
                                                break;
                                            default:
                                                palletwt = 0;
                                                break;
                                        }
                                        productwt = InboundPalletWeight - palletwt;

                                        // Note the insertSQL2 statement for a compactor is actually two sequential insert statements.  
                                        // One for the pallet, the other for the "product" weight
                                        insertSQL2 = "INSERT INTO ProcDetail " +
                                        "(ProcHdrID,OutboundStreamType,OutboundStreamWeight,OutboundStreamProfile,OutboundContainerType," +
                                        "OutboundContainerID,OutboundPalletType,ProcessMethod,Shipped,OutboundLocation) " +
                                        "VALUES (@lastID,'Reuse',@palletwt,@palletprofile,'None','NA'," +
                                        "'None','Compact','0','NA');INSERT INTO ProcDetail " +
                                        "(ProcHdrID,OutboundStreamType,OutboundStreamWeight,OutboundStreamProfile,OutboundContainerType," +
                                        "OutboundContainerID,OutboundPalletType,ProcessMethod,Shipped,OutboundLocation) " +
                                        "VALUES (@lastID,'WTE',@productwt,'35','Compactor',@OutboundContainerID," +
                                        "'None','Compact','0','Compactor')";
                                        break;
                                    }
                                case "BALER":
                                    {
                                        //  First determine the weights and profiles based on the type of pallet
                                        switch (InboundPalletType)
                                        {
                                            case "CHEP":
                                                palletwt = 66;
                                                palletprofile = 26;
                                                break;
                                            case "GMA":
                                                palletwt = 42;
                                                palletprofile = 27;
                                                break;
                                            default:
                                                palletwt = 0;
                                                break;
                                        }
                                        productwt = InboundPalletWeight - palletwt;

                                        // Note the insertSQL2 statement for a baler is actually two sequential insert statements.  
                                        // One for the pallet, the other for the "product" weight
                                        insertSQL2 = "INSERT INTO ProcDetail " +
                                        "(ProcHdrID,OutboundStreamType,OutboundStreamWeight,OutboundStreamProfile,OutboundContainerType," +
                                        "OutboundContainerID,OutboundPalletType,ProcessMethod,Shipped,OutboundLocation) " +
                                        "VALUES (@lastID,'Reuse',@palletwt,@palletprofile,'None','NA'," +
                                        "'None','Bale','0','NA');INSERT INTO ProcDetail " +
                                        "(ProcHdrID,OutboundStreamType,OutboundStreamWeight,OutboundStreamProfile,OutboundContainerType," +
                                        "OutboundContainerID,OutboundPalletType,ProcessMethod,Shipped,OutboundLocation) " +
                                        "VALUES (@lastID,'Reuse',@productwt,'28','Baler',@OutboundContainerID," +
                                        "'None','Bale','0','Baler')";
                                        break;
                                    }
                            }
                            SqlCommand insertCmd2 = new SqlCommand(insertSQL2, thisConnection);

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
                        if (txbNewLocation.Text.ToUpper() == "TRUCK")
                        {
                            lblErrMsg.Text = "The value you entered is not in the ShipHdr Table.  Please re-scan or contact the shipping clerk to create " +
                                "an outbound shipping record.";
                            lblOutCntr.Visible = true;
                        }
                        else
                        {
                            lblErrMsg.Text = "Please enter an OUT or ROPAK container";
                            lblOutCntr.Visible = true;
                        }
                    }
                }
                else
                //  This is the case for "OUT" containers that are being sent to a Special location
	            {
                    string strCntr1 = txbOutCntr.Text.ToUpper();
                    if ((
                        (strCntr1.StartsWith("ROP") && txbNewLocation.Text.ToUpper() == "BALER") || 
                        (strCntr1.StartsWith("OUT") && txbNewLocation.Text.ToUpper() == "BALER") ||
                        (strCntr1.StartsWith("OUT") && txbNewLocation.Text.ToUpper() == "TANK") ||
                        (strCntr1.StartsWith("ROP") && txbNewLocation.Text.ToUpper() == "COMPACTOR") || 
                        (strCntr1.StartsWith("OUT") && txbNewLocation.Text.ToUpper() == "COMPACTOR") || 
                        (inTblChk == true && txbNewLocation.Text.ToUpper() == "TRUCK")))
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
                            switch (txbNewLocation.Text.ToUpper())
                            { 
                                case "TRUCK":
                                    updateSQL = "UPDATE ProcDetail SET outboundlocation = 'Truck', ModDate = getdate(), " +
                                    "username = @username, outboundDocNo = @outbounddocno, outboundcontainerID = @outboundtruckid, " +
                                    "shipped = '0',ProcessMethod = 'Ship' WHERE outboundcontainerid = @outboundcontainerID_old";
                                    break;
                                case "COMPACTOR":
                                    updateSQL = "UPDATE ProcDetail SET outboundlocation = 'Compactor', ModDate = getdate(), " +
                                    "username = @username, outboundcontainerID = @outboundcontainerID,ProcessMethod = 'Compact' " +
                                    "WHERE outboundcontainerid = @outboundcontainerID_old";
                                    break;
                                case "BALER":
                                    updateSQL = "UPDATE ProcDetail SET outboundlocation = 'Baler', ModDate = getdate(), " +
                                    "username = @username, outboundcontainerID = @outboundcontainerID,ProcessMethod = 'Bale' " +
                                    "WHERE outboundcontainerid = @outboundcontainerID_old";
                                    break;
                                case "TANK":
                                    updateSQL = "UPDATE ProcDetail SET outboundlocation = 'Tank', ModDate = getdate(), " +
                                    "username = @username, outboundcontainerID = @outboundcontainerID,ProcessMethod = 'Decant' " +
                                    "WHERE outboundcontainerid = @outboundcontainerID_old";
                                    break;
                            }
                            SqlCommand UpdateCmd = new SqlCommand(updateSQL, thisConnection);
                                
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
                        if (txbNewLocation.Text.ToUpper() == "TRUCK")
                        {
                            lblErrMsg.Text = "The value you entered is not in the ShipHdr Table.  Please re-scan or contact the shipping clerk to create " +
                                "an outbound shipping record.";
                            lblOutCntr.Visible = true;
                        }
                        else
                        {
                            lblErrMsg.Text = "Please enter an OUT or ROPAK container";
                            lblOutCntr.Visible = true;
                        }
                    }
	            }
            }
        }
    }
}