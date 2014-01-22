using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;

namespace IMDBWeb.Secure.SPAKpages
{
    public partial class BoxRcvd : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["CurTruckCntrID"] = string.Empty;
                tblBoxNotFound.Visible = false;
                txbTruckCntrID.Focus();
            }
        }

        protected void btnClose_Click(object sender, EventArgs e)
        {
            txbTruckCntrID.Text = string.Empty;
            txbBoxCntrID.Text = string.Empty;
            txbPalletCntrID.Text = string.Empty;
            Session.Clear();
            Response.Redirect("~/secure/SPAKPages/SPAKPages.aspx");
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            txbTruckCntrID.Text = string.Empty;
            txbBoxCntrID.Text = string.Empty;
            txbPalletCntrID.Text = string.Empty;
            Session.Clear();
            lblFacilityName.Text = string.Empty;
            lblProfileName.Text = string.Empty;
            lblTruckCntrID.ForeColor = System.Drawing.ColorTranslator.FromHtml("#696969");
            lblBoxCntrID.ForeColor = System.Drawing.ColorTranslator.FromHtml("#696969");
            lblPalletCntrID.ForeColor = System.Drawing.ColorTranslator.FromHtml("#696969");
            chkCntrl.Checked = false;
            ddProfile.SelectedIndex = 0;
            ddStore.SelectedIndex = 0;
            txbManifest.Text = string.Empty;
            trBoxNotFound.BgColor = "White";
            tblBoxNotFound.Visible = false;
            gvBoxData.DataBind();
            txbTruckCntrID.Focus();
        }

        protected void txbTruckCntrID_TextChanged(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(txbTruckCntrID.Text) && !string.IsNullOrWhiteSpace(txbTruckCntrID.Text))
            {
                //  Determine if the sitecode portion of the TruckCntrID is a valid SiteCode
                Boolean foundit = false;
                String spSite = "SPAK_BoxRcvd_SiteCheck_Sel";
                SqlConnection con = new SqlConnection();
                con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
                SqlCommand spCmdSite = new SqlCommand(spSite, con);
                con.Open();
                using (spCmdSite)
                {
                    try
                    {
                        using (SqlDataReader rdrSite = spCmdSite.ExecuteReader())
                        {
                            if (rdrSite.HasRows)
                            {
                                while (rdrSite.Read())
                                {
                                    if (!String.IsNullOrEmpty(txbTruckCntrID.Text) && txbTruckCntrID.Text.Substring(0, 2).ToString() == rdrSite["SiteCode"].ToString())
                                    {
                                        foundit = true;
                                    }
                                }
                                if (!foundit)
                                {
                                    WebMsgBox.Show("You have not entered a valid Site Code.  Please check your TruckCntrID.");
                                    txbTruckCntrID.Focus();
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
                        con.Close();
                    }
                }
                if (foundit)
                {
                    txbBoxCntrID.Focus();
                    lblTruckCntrID.ForeColor = System.Drawing.Color.Green;
                    Session["CurTruckCntrID"] = txbTruckCntrID.Text;
                }
                else
                {
                    txbTruckCntrID.Focus();
                    lblTruckCntrID.ForeColor = System.Drawing.Color.Red;
                }

                if (!Regex.IsMatch(txbTruckCntrID.Text, @"^\d\d[-](0[1-9]|1[012])[/](0[1-9]|[12][0-9]|3[01])[/][01]\d[-]\d\d\d-[1-9]\d?$"))
                {
                    WebMsgBox.Show("Please use the format of XX-mm/dd/yy-###-@@ where XX is a valid SiteCode, ### is the truck sequence number, and @@ is the TruckTag pallet ID");
                    txbTruckCntrID.Focus();
                    lblTruckCntrID.ForeColor = System.Drawing.Color.Red;
                }
            }
            else
            {
                lblTruckCntrID.ForeColor = System.Drawing.ColorTranslator.FromHtml("#696969");
            }
        }

        protected void txbBoxCntrID_TextChanged(object sender, EventArgs e)
        {
            if(!string.IsNullOrEmpty(txbBoxCntrID.Text) && !string.IsNullOrWhiteSpace(txbBoxCntrID.Text) &&
                !string.IsNullOrEmpty(txbTruckCntrID.Text) && !string.IsNullOrWhiteSpace(txbTruckCntrID.Text))
            {
                // Determine if the box is an alert item
                String spAlert = "SPAK_BoxRcvd_Alert_Sel";

                SqlConnection con = new SqlConnection();
                con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
                SqlCommand spCmdAlert = new SqlCommand(spAlert, con);
                spCmdAlert.CommandType = CommandType.StoredProcedure;

                con.Open();
                using (spCmdAlert)
                {
                    try
                    {
                        spCmdAlert.Parameters.AddWithValue("@BoxCntrID", txbBoxCntrID.Text);
                        using (SqlDataReader rdrAlert = spCmdAlert.ExecuteReader())
                        {
                            if (rdrAlert.HasRows)
                            {
                                while (rdrAlert.Read())
                                {
                                    String AlertComment = rdrAlert["Comment"].ToString();
                                    WebMsgBox.Show("This Box has an alert associated with it.  The alert message is '" + AlertComment + "'");
                                    lblBoxCntrID.ForeColor = System.Drawing.Color.Goldenrod;
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
                        con.Close();
                    }
                }

                /* ******************************** Algorithm *********************************************
                 * In the first section, inspect the entered BoxCntrID.  If it is not of a 'typical' format
                 * warn the user to check what they have entered and show the Label in 'Goldenrod' color. 
                 * If format is typical, show label in 'Green'.  In either of these cases, the user can 
                 * proceed to attempt to add the container.
                 * 
                 * In the second section, the BoxCntrID is checked to see if it is an aggregate container.  
                 * If it is, the user is warned, the label is shown in Red and no Facility or Profile are
                 * found.  A record cannot be added with an aggregate container.
                 * 
                 * If the container is not an aggregate container the BoxCntrID is matched to a Barcode value
                 * in SteriWise.  From this, the corresponding manifest, Facility, Profile, and other product 
                 * characteristics are obtained.  If it is not found, value will be added (if it doesn't 
                 * already exist) as an UNKNOWN facility and Profile. 
	            **************************************************************************************** */
                
                //************ Format Warning section
                // Check the BoxCntrID length is 12.  If not, send warning
                if (txbBoxCntrID.Text.Length != 12)  
                {
                    WebMsgBox.Show("The value you entered is not formatted like most barcodes.  " +
                        "It does not contain 12 characters.  Please check that you have entered the correct value.");
                    txbPalletCntrID.Focus();
                    lblBoxCntrID.ForeColor = System.Drawing.Color.Goldenrod;
                }

                // Check that the BoxCntrID contains only numbers.  If not, send warning
                else  
                {
                    Boolean foundChar = false;
                    for (int i = 0; i < txbBoxCntrID.Text.Length; i++)
                    {
                        if (!char.IsNumber(txbBoxCntrID.Text.Trim()[i]))
                        {
                            foundChar = true;
                        }
                    }
                    if (foundChar)
                    {
                        WebMsgBox.Show("The value you entered is not formatted like most barcodes.  " +
                        "It contains non-integer characters.  Please check that you have entered the correct value.");
                        lblBoxCntrID.ForeColor = System.Drawing.Color.Goldenrod;
                    }
                    else
                    {
                        txbPalletCntrID.Focus();
                        lblBoxCntrID.ForeColor = System.Drawing.Color.Green;
                    }
                }

                // *************** Obtain Product Characteristics Section

                Boolean BoxInSPAK = false;
                Boolean ManifestInSPAK = false;
                Boolean ManifestinIMDB = false;
                Boolean SameManifestSite = false;
                Boolean SameTruckID = false;
                Boolean BoxInIMDB = false;
                Boolean SameBoxInIMDB = false;
                Boolean Is10day = false;
                Boolean MngAs10day = true;

                // Check if the BoxCntrID is a consolidation container
                if (txbBoxCntrID.Text.Substring(0, 3) == "999")
                {
                    WebMsgBox.Show("You have scanned in a consolidated container barcode, please utilize attached scan sheet to receive in child barcodes for " +
                        "this container. If no scan sheet is present, do not receive the container until you have contacted your supervisor for further assistance.");
                    txbBoxCntrID.Focus();
                    lblBoxCntrID.ForeColor = System.Drawing.Color.Red;
                }
                else
                {
                    // Determine if the box is found in SterWise

                    #region Box in Steriwise

                    Session["CurManifest"] = string.Empty;
                    Session["CurProfileName"] = string.Empty;
                    Session["CurTSDFCompany"] = string.Empty;
                    Session["CurPharmControl"] = string.Empty;
                    Session["CurHazCode"] = string.Empty;
                    Session["CurStoreState"] = string.Empty;
                    Session["CurStoreNumber"] = string.Empty;
                    Session["CurStoreName"] = string.Empty;
                    Session["CurCustomerNumber"] = string.Empty;

                    String spBoxInfo = "SPAK_BoxRcvd_ManifestInfo_Sel";
                    SqlCommand spCmdBoxInfo = new SqlCommand(spBoxInfo, con);
                    spCmdBoxInfo.CommandType = CommandType.StoredProcedure;

                    con.Open();
                    using (spCmdBoxInfo)
                    {
                        try
                        {
                            spCmdBoxInfo.Parameters.AddWithValue("@BoxCntrID", txbBoxCntrID.Text);
                            using(SqlDataReader rdrBoxInfo = spCmdBoxInfo.ExecuteReader())
                            {
                                if (rdrBoxInfo.HasRows)
                                {
                                    while (rdrBoxInfo.Read())
                                    {
                                        Session["CurManifest"] = rdrBoxInfo["TrackingNumber"].ToString();
                                        Session["CurProfileName"] = rdrBoxInfo["ProfileName"].ToString(); 
                                        Session["CurTSDFCompany"] = rdrBoxInfo["TSDFCompany"].ToString();
                                        Session["CurPharmControl"] = rdrBoxInfo["PharmControl"].ToString();
                                        Session["CurHazCode"] = rdrBoxInfo["HazCode"].ToString();
                                        Session["CurStoreState"] = rdrBoxInfo["StoreState"].ToString();
                                        Session["CurStoreNumber"] = rdrBoxInfo["StoreNumber"].ToString();
                                        Session["CurStoreName"] = rdrBoxInfo["SiteName"].ToString();
                                        Session["CurCustomerNumber"] = rdrBoxInfo["CustomerNumber"].ToString().Trim();
                                    }
                                    lblFacilityName.Text = Session["CurTSDFCompany"].ToString();
                                    lblProfileName.Text = Session["CurProfileName"].ToString();
                                    tblBoxNotFound.Visible = false;
                                    trBoxNotFound.BgColor = "White";
                                    BoxInSPAK = true;
                                }
                                else
                                {
                                    WebMsgBox.Show("This Box Bar code was not found in SPAK.  Please capture as much information as possible in the additional fields. " +
                                        "Please place this box on an exception pallet and alert your supervisor.");
                                    lblFacilityName.Text = "UNKNOWN";
                                    lblProfileName.Text = "UNKNOWN";
                                    tblBoxNotFound.Visible = true;
                                    trBoxNotFound.BgColor = "#fofofo";
                                    lblBoxCntrID.ForeColor = System.Drawing.Color.Goldenrod;
                                    chkCntrl.Focus();
                                    BoxInSPAK = false;
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
                            con.Close();
                        }
                    }
                    #endregion

                    // Determine if the manifest is in Steriwise 
                    #region ManifestInSteriWise
                    if (BoxInSPAK)
                    {
                        if (string.IsNullOrEmpty(Session["CurManifest"].ToString()))
                        {
                            WebMsgBox.Show("There was no corresponding manifest found in Steriwise associated with this barcode.");
                            lblBoxCntrID.ForeColor = System.Drawing.Color.Goldenrod;
                            ManifestInSPAK = false;
                        }
                        else
                        {
                            ManifestInSPAK = true;
                        }                    
                    }

                    #endregion

                    // Determine if manifest is in IMDB
                    #region ManifestInIMDB

                    if (ManifestInSPAK)
                    {
                        String spManIMDB = "SPAK_BoxRcvd_ManifestInIMDB_Sel";
                        SqlCommand spCmdManIMDB = new SqlCommand(spManIMDB, con);
                        spCmdManIMDB.CommandType = CommandType.StoredProcedure;

                        con.Open();
                        using (spCmdManIMDB)
                        {
                            try
                            {
                                spCmdManIMDB.Parameters.AddWithValue("@InboundDocNo", Session["CurManifest"].ToString());
                                using(SqlDataReader rdrManIMDB = spCmdManIMDB.ExecuteReader())
                                {
                                    if (rdrManIMDB.HasRows)
                                    {
                                        ManifestinIMDB = true;  // The manifest exists in IMDB and therefore the record has the potential to be added

                                        while (rdrManIMDB.Read())
                                        {
                                            // Determine if the manifest exists for the same site
                                            if (txbTruckCntrID.Text.Substring(0, 2) == rdrManIMDB["TruckID"].ToString().Substring(0,2))
                                            {
                                                SameManifestSite = true;
                                                // Determine if manifest in IMDB is for the same TruckID
                                                if (txbTruckCntrID.Text.Substring(0, 15) == rdrManIMDB["TruckID"].ToString())
                                                {
                                                    SameTruckID = true;  // This is the expected result
                                                    Session["ActTruckID"] = string.Empty;
                                                }
                                                else
                                                {
                                                    SameTruckID = false;  // Record will not be added with error msg "Already at this site but with different TruckID"
                                                    Session["ActTruckID"] = rdrManIMDB["TruckID"].ToString();
                                                }
                                            }
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
                                con.Close();
                            }
                        }
                    }
                    #endregion
                    // Prompt if manifest is not in IMDB and exit from routine
                    #region ManifestinIMDB
                    if (!ManifestinIMDB && ManifestInSPAK)
                    {
                        WebMsgBox.Show("The manifest associated with this BoxCntrID is not in IMDB.  You cannot process this box.  Please alert your supervisor.");
                        txbBoxCntrID.Text = string.Empty;
                        txbBoxCntrID.Focus();
                        lblBoxCntrID.ForeColor = System.Drawing.ColorTranslator.FromHtml("#696969");
                        lblFacilityName.Text = string.Empty;
                        lblProfileName.Text = string.Empty;
                        trBoxNotFound.Visible = false;
                        return;
                    }
                    #endregion

                    // Prompt if manifest in IMDB is not for the same TruckID
                    #region SameTruckID
                    if (ManifestInSPAK)
                    {
                        if (ManifestinIMDB)
                        {
                            if (SameManifestSite)
                            {
                                if (!SameTruckID)
                                {

                                    WebMsgBox.Show("The manifest associated with this box has been received at this site but it is NOT associated with this TruckID.  " +
                                    "This box is associated with " + Session["ActTruckID"] + ".  You cannot process this box.  Please alert your supervisor.");

                                    txbBoxCntrID.Text = string.Empty;
                                    txbBoxCntrID.Focus();
                                    lblBoxCntrID.ForeColor = System.Drawing.ColorTranslator.FromHtml("#696969");
                                    lblFacilityName.Text = string.Empty;
                                    lblProfileName.Text = string.Empty;
                                    trBoxNotFound.Visible = false;
                                    return;
                                }
                            }
                            else
                            {
                                WebMsgBox.Show("The manifest associated with this BoxCntrID is not in IMDB for this site.  You cannot process this box.  Please alert your supervisor.");
                                txbBoxCntrID.Text = string.Empty;
                                txbBoxCntrID.Focus();
                                lblBoxCntrID.ForeColor = System.Drawing.ColorTranslator.FromHtml("#696969");
                                lblFacilityName.Text = string.Empty;
                                lblProfileName.Text = string.Empty;
                                trBoxNotFound.Visible = false;
                                return;
                            }
                        }
                        else
                        {
                            WebMsgBox.Show("The manifest associated with this BoxCntrID is not in IMDB.  You cannot process this box.  Please alert your supervisor.");
                            txbBoxCntrID.Text = string.Empty;
                            txbBoxCntrID.Focus();
                            lblBoxCntrID.ForeColor = System.Drawing.ColorTranslator.FromHtml("#696969");
                            lblFacilityName.Text = string.Empty;
                            lblProfileName.Text = string.Empty;
                            trBoxNotFound.Visible = false;
                            return;
                        }
                    }
                    #endregion

                    // Determine if the barcode exists in IMDB
                    #region BoxinIMDB
                    String spBoxIMDB = "SPAK_BoxRcvd_BoxInIMDB_Sel";
                    SqlCommand spCmdBoxIMDB = new SqlCommand(spBoxIMDB, con);
                    spCmdBoxIMDB.CommandType = CommandType.StoredProcedure;

                    con.Open();
                    using (spCmdBoxIMDB)
                    {
                        try
                        {
                            spCmdBoxIMDB.Parameters.AddWithValue("@BoxCntrID", txbBoxCntrID.Text);
                            using(SqlDataReader rdrBoxIMDB = spCmdBoxIMDB.ExecuteReader())
                                {
                                if (rdrBoxIMDB.HasRows)
                                {
                                    while (rdrBoxIMDB.Read())
                                    {
                                        if (txbTruckCntrID.Text.Substring(0, 2) == rdrBoxIMDB["TruckCntrID"].ToString().Substring(0, 2))
                                        {
                                            SameBoxInIMDB = true;
                                        }

                                    }
                                    BoxInIMDB = true;
                                }
                                else
                                {
                                    BoxInIMDB = false;
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
                            con.Close();
                        }
                    }
                    #endregion

                    // Determine if the IMDB barcode is for a different TruckID
                    #region SameBoxInIMDB
                    if (BoxInIMDB)
                    {
                        if (SameBoxInIMDB)
                        {
                            WebMsgBox.Show("Note: This Box Container ID has already been entered into the system for this site. You cannot enter duplicate barcodes.");
                            lblBoxCntrID.ForeColor = System.Drawing.Color.Red;
                            txbBoxCntrID.Text = string.Empty;
                            lblFacilityName.Text = string.Empty;
                            lblProfileName.Text = string.Empty;
                            txbBoxCntrID.Focus();
                        }                    
                    }

                    #endregion

                    // Check for site specific validation checks (controls, flammables, etc)
                    #region SiteValidations
                    if (BoxInSPAK)
                    {
                        if (txbTruckCntrID.Text.Substring(0, 2) == "01")  // Indy Validation
                        {
                            switch(Session["CurPharmControl"].ToString())
                            {
                                case "2":
                                    WebMsgBox.Show("This is a Level 2 Control.  Please affix the appropriate label and place the box in the control cage.");
                                    lblBoxCntrID.ForeColor = System.Drawing.Color.Goldenrod;
                                    break;
                                case "3-5":
                                    WebMsgBox.Show("This is a Level 3-5 Control.  Please Place the box in the control cage.");
                                    lblBoxCntrID.ForeColor = System.Drawing.Color.Goldenrod;
                                    break;
                                case "NonReg":  //NonReg pharma may be hazardous.  If so, must be managed differently from nonhaz pharm
                                    if (Session["CurHazCode"].ToString().Length > 0 && Session["CurStoreState"].ToString().TrimEnd() == "WA")  
                                    {  
                                        WebMsgBox.Show("This is a WASHINGTON HAZARDOUS pharmaceutical.  Please place on an appropriate pallet for incineration.");
                                        lblBoxCntrID.ForeColor = System.Drawing.Color.Goldenrod;
                                    }
                                    else if (Session["CurCustomerNumber"].ToString() == "AL20090641" && !Session["curStoreName"].ToString().Contains("Caremark") && !Session["curStoreName"].ToString().Contains("CVS DC")) //CVS NonReg Pharma
                                    {
                                        WebMsgBox.Show("This box from CVS contains pharmaceuticals.  Please place it on a pallet designated for CVS Processing");
                                        lblBoxCntrID.ForeColor = System.Drawing.Color.Goldenrod;
                                    }
                                    break;
                                default:
                                    break;
                            }
                            if(Session["CurProfileName"].ToString().Contains("Explosive"))
                            {
                                WebMsgBox.Show("This is an EXPLOSIVE MATERIAL.  Please place on an Outbound Pallet AS IS to EEI.  Boxes should not be mixed with any Stericycle product");
                                lblBoxCntrID.ForeColor = System.Drawing.Color.Goldenrod;
                            }
                            if (Session["CurProfileName"].ToString().ToUpper().Contains("NON-HAZARDOUS FUEL FILTERS"))
                            {
                                WebMsgBox.Show("This box contains Fuel Filters and must be sent to Hazardous Waste Facility for disposal. Please place on appropriate outbound pallet");
                                lblBoxCntrID.ForeColor = System.Drawing.Color.Goldenrod;
                            }
                        }
                        else if (txbTruckCntrID.Text.Substring(0, 2) == "02")  // Veolia Validation
                        {
                            if(Session["CurProfileName"].ToString().Contains("Flammable Solid"))
                            {
                                WebMsgBox.Show("This is a FLAMMABLE SOLID. Please place on a outbound pallet with only other flammable solids.");
                                lblBoxCntrID.ForeColor = System.Drawing.Color.Goldenrod;
                            }
                        }
                        #endregion

                    //Check for 10Day Status

                    #region Check10Day

                    Session["CurProcSite"] = string.Empty;
                    String spCurSite = "SPAK_BoxRcvd_Site_Sel";
                    SqlCommand spCmdCurSite = new SqlCommand(spCurSite, con);
                    spCmdCurSite.CommandType = CommandType.StoredProcedure;

                    con.Open();
                    using (spCmdCurSite)  //Get the name of the receiving site from the TruckID
                    {
                        try
                        {
                            spCmdCurSite.Parameters.AddWithValue("@SiteCode", txbTruckCntrID.Text.Substring(0, 2));
                            using(SqlDataReader rdrCurSite = spCmdCurSite.ExecuteReader())
                            {
                                if (rdrCurSite.HasRows)
                                {
                                    while (rdrCurSite.Read())
                                    {
                                        Session["CurProcSite"] = rdrCurSite["SiteName"].ToString();
                                        MngAs10day = (Boolean)rdrCurSite["MngAs10d"];
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
                            con.Close();
                        }
                    }

                    if (MngAs10day)
                    {
                        if (!String.IsNullOrEmpty(Session["CurTSDFCompany"].ToString()))  // Only check for TSDF/10Day situation if the TSDFCompany was found in Sterwise
                        {
                            if (!Session["CurTSDFCompany"].ToString().Contains(Session["CurProcSite"].ToString()))  //If SiteName is not part of the TSDF company, it is a 10Day manifest.
                            {
                                Is10day = true;
                                WebMsgBox.Show("The BoxCntrID you scanned does not have this facility as the TSDF, please place this Box on a separate pallet " +
                                    " and treat this Box and associated waste as 10 Day Waste unless otherwise directed.");
                            }
                            else
                            {
                                Is10day = false;
                            }
                        }
                    }
                }
                    
                #endregion
                }
            }
            else if (string.IsNullOrEmpty(txbTruckCntrID.Text) && string.IsNullOrWhiteSpace(txbTruckCntrID.Text))
            {
                WebMsgBox.Show("Please enter a TruckCntrID first!");
                txbBoxCntrID.Text = string.Empty;
                txbTruckCntrID.Focus();
                lblBoxCntrID.ForeColor = System.Drawing.ColorTranslator.FromHtml("#696969");
            }
            else
            {
                lblBoxCntrID.ForeColor = System.Drawing.ColorTranslator.FromHtml("#696969");
            }
        }

        protected void txbPalletCntrID_TextChanged(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(txbPalletCntrID.Text) && !string.IsNullOrWhiteSpace(txbPalletCntrID.Text))
            {
                if (!Regex.IsMatch(txbPalletCntrID.Text, @"^[P][T][-]\d{9}$"))
                {
                    WebMsgBox.Show("Please use a format of PT-#########");
                    txbPalletCntrID.Focus();
                    lblPalletCntrID.ForeColor = System.Drawing.Color.Red;
                }
                else
                {
                    lblPalletCntrID.ForeColor = System.Drawing.Color.Green;
                }
            }
            else
            {
                lblPalletCntrID.ForeColor = System.Drawing.ColorTranslator.FromHtml("#696969");
            }
            if (lblFacilityName.Text == "UNKNOWN" && ddStore.SelectedIndex == 0)
            {
                WebMsgBox.Show("You must select a store if possible.  If no information is available, please select 'No Information Availalbe' from the dropdown");
                lblPalletCntrID.ForeColor = System.Drawing.ColorTranslator.FromHtml("#696969"); 
                txbPalletCntrID.Text = string.Empty;
            }
            else
            {
                if (lblTruckCntrID.ForeColor.ToString().Contains("Green") && (lblBoxCntrID.ForeColor.ToString().Contains("Green")
                || lblBoxCntrID.ForeColor.ToString().Contains("Goldenrod")) && lblPalletCntrID.ForeColor.ToString().Contains("Green"))
                {
                    String spIns = "SPAK_BoxRcvd_Ins";
                    SqlConnection con = new SqlConnection();
                    con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
                    SqlCommand spCmdCurSite = new SqlCommand(spIns, con);
                    spCmdCurSite.CommandType = CommandType.StoredProcedure;

                    int IsControl = 0;
                    if (chkCntrl.Checked)
                    {
                        IsControl = 1;
                    }

                    String StoreNumber = ddStore.SelectedValue.ToString().Substring(0, ddStore.SelectedValue.ToString().IndexOf(":") - 1);
                    String StoreName = ddStore.SelectedValue.ToString().Substring(ddStore.SelectedValue.ToString().IndexOf(":") + 1, ddStore.SelectedValue.ToString().Length - ddStore.SelectedValue.ToString().IndexOf(":") - 1);

                    con.Open();
                    using (spCmdCurSite)
                    {
                        try
                        {
                            spCmdCurSite.Parameters.AddWithValue("@TruckCntrID", txbTruckCntrID.Text);
                            spCmdCurSite.Parameters.AddWithValue("@BoxCntrID", txbBoxCntrID.Text);
                            spCmdCurSite.Parameters.AddWithValue("@PalletCntrID", txbPalletCntrID.Text);
                            spCmdCurSite.Parameters.AddWithValue("@FacilityName", lblFacilityName.Text);
                            spCmdCurSite.Parameters.AddWithValue("@ProfileName", lblProfileName.Text);
                            spCmdCurSite.Parameters.AddWithValue("@StoreName", StoreName);
                            spCmdCurSite.Parameters.AddWithValue("@StoreNumber", StoreNumber);
                            spCmdCurSite.Parameters.AddWithValue("@UserSelectedProfile", ddProfile.SelectedValue.ToString());
                            spCmdCurSite.Parameters.AddWithValue("@Controlled", IsControl);
                            spCmdCurSite.Parameters.AddWithValue("@Manifest", txbManifest.Text);
                            spCmdCurSite.Parameters.AddWithValue("@Comments", txbComments.Text);
                            spCmdCurSite.Parameters.AddWithValue("@UserName", HttpContext.Current.User.Identity.Name.ToString());
                            spCmdCurSite.ExecuteNonQuery();
                        }
                        catch (Exception ex)
                        {
                            lblErrMsg.Visible = true;
                            lblErrMsg.Text = ex.Message.ToString();
                        }
                        finally
                        {
                            txbTruckCntrID.Text = Session["CurTruckCntrID"].ToString();
                            txbBoxCntrID.Text = string.Empty;
                            txbPalletCntrID.Text = string.Empty;
                            lblFacilityName.Text = string.Empty;
                            lblProfileName.Text = string.Empty;
                            lblErrMsg.Visible = false;
                            lblTruckCntrID.ForeColor = System.Drawing.Color.Green;
                            lblBoxCntrID.ForeColor = System.Drawing.ColorTranslator.FromHtml("#696969");
                            lblPalletCntrID.ForeColor = System.Drawing.ColorTranslator.FromHtml("#696969");
                            chkCntrl.Checked = false;
                            ddProfile.SelectedIndex = 0;
                            ddStore.SelectedIndex = 0;
                            txbManifest.Text = string.Empty;
                            txbComments.Text = string.Empty;
                            trBoxNotFound.BgColor = "White";
                            tblBoxNotFound.Visible = false;
                            gvBoxData.DataBind();
                            txbBoxCntrID.Focus();
                            con.Close();
                        }
                    }
                    con.Close();
                }
                else
                {
                    WebMsgBox.Show("There is an invalid value in one of your entries.  Please make sure all entries titles are Green or Gold");
                }
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            txbPalletCntrID_TextChanged(null, null);
        }
    }
}