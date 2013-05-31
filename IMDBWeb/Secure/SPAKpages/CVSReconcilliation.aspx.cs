using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace IMDBWeb.Secure.SPAKpages
{
    public partial class CVSReconcilliation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                trBoxNotFound.Visible = false;
                trBoxFound.Visible = false;
                gvBoxRecon.Visible = false;
                lblReconErrMsg.Visible = false;
                lblReconBox.Visible = false;
                lblCurReconBox.Text = string.Empty;
                lblReconMoreBoxes.Text = string.Empty;
                lblReconMoreBoxes.Visible = false;
                txbReconBox.Visible = false;
                btnReconBox.Visible = false;
            }
        }

        protected void txbTruckID_TextChanged(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(txbTruckID.Text) && !string.IsNullOrWhiteSpace(txbTruckID.Text))
            {
                lblErrMsg.Visible = false;
                int totalBoxes = 0;
                int reconBoxes = 0;
                string spCVSBoxes = "SPAK_CVSRecon_Boxes_Sel";
                using (SqlConnection con = new SqlConnection())
                { 
                    con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
                    con.Open();
                    SqlCommand CmdBoxes = new SqlCommand(spCVSBoxes, con) {CommandType = CommandType.StoredProcedure};
                    try 
	                {	        
                        CmdBoxes.Parameters.AddWithValue("@TruckCntrID", txbTruckID.Text.Substring(0,15));
                        using (SqlDataReader rdrBoxes = CmdBoxes.ExecuteReader())
                        {
                            if (rdrBoxes.HasRows)
                            {
                                gvBoxRecon.Visible = true;
                                while (rdrBoxes.Read())
                                {
                                    totalBoxes = totalBoxes + 1;
                                    if (Convert.ToInt32(rdrBoxes["Reconciled"]) > 0)
                                    {
                                        reconBoxes = reconBoxes + 1;
                                    }
                                }
                                trBoxNotFound.Visible = false;
                                trBoxFound.Visible = true;
                                lblBoxText1.Text = "You have reconciled";
                                lblBoxCount1.Text = reconBoxes.ToString();
                                lblBoxText2.Text = "of";
                                lblBoxCount2.Text = totalBoxes.ToString();
                                lblBoxText3.Text = "boxes for TruckID";
                                lblTruckID.Text = txbTruckID.Text.Substring(0, 15);
                                if (totalBoxes == reconBoxes)
                                {
                                    lblReconErrMsg.Visible = true;
                                    lblReconErrMsg.Text = "You have Reconciled all the boxes for this TruckID";
                                    lblReconBox.Visible = false;
                                    txbReconBox.Visible = false;
                                    btnReconBox.Visible = false;
                                    return;
                                }
                                else
                                {
                                    lblReconBox.Visible = true;
                                    txbReconBox.Visible = true;
                                    btnReconBox.Visible = true;
                                }
                            }
                            else
                            {
                                trBoxFound.Visible = false;
                                trBoxNotFound.Visible = true;
                                lblCurReconBox.Text = string.Empty;
                                lblReconErrMsg.Text = string.Empty;
                                lblReconErrMsg.Visible = false;
                                lblReconBox.Text = string.Empty;
                                txbReconBox.Visible = false;
                                btnReconBox.Visible = false;
                                lblReconBox.Visible = false;
                                gvReconMoreBoxes.DataBind();
                            }
                        }
	                }
	                catch (Exception ex)
	                {
                        lblErrMsg.Visible = true;
                        lblErrMsg.Text = ex.Message;
	                }
                    finally
                    {
                        con.Close();
                    }
                }  
            }
            else
            {
                txbTruckID.Focus();
                trBoxFound.Visible = false;
                trBoxNotFound.Visible = false;
                gvBoxRecon.Visible = false;
                gvReconMoreBoxes.Visible = true;
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            txbTruckID_TextChanged(null, null);
        }

        protected void txbReconBox_TextChanged(object sender, EventArgs e)
        {
            /* ******************************** Algorithm *********************************************
             * 
             * Check if the BoxCntrID is found in SpakBoxRcvd.  If not Error msg.   Else
             * Check if the BoxCntrID is in SpakBoxRcvd for the same site and Truck.   If not, Error Msg.  Else
             * Check if BoxCntrID is associated with the CVS NonReg.  If not Error msg.  Else
             * Check if the BoxCntrID is associated with the same TruckTag.   if not error msg.  Else
             * Check if the BoxCntrID has already been reconciled.  If yes, Error msg.  Else
             * Insert Box into SPAK_CVSReconcilliation and set Reconcile to 1.  Update counts and 
             * refresh page.
             * When all boxes have been reconciled, hide the "Reconcile Box" textbox
             * 
             * **************************************************************************************** */

            if (!string.IsNullOrEmpty(txbReconBox.Text) && !string.IsNullOrWhiteSpace(txbReconBox.Text))
            {

                Boolean BoxInSPAK = false;
                Boolean BoxInSPAKSameSite = false;
                Boolean BoxInSPAKSameTruck = false;
                Boolean IsCVS = false;
                string spBoxInSPAK = "SPAK_CVSRecon_BoxInSpak_Sel";
                string spBoxIsCVS = "SPAK_CVSRecon_BoxIsCVS_Sel";
                string spBoxRecon = "SPAK_CVSRecon_BoxIsRecon_Sel";
                string spUpdateRecon = "SPAK_CVSRecon_BoxRecon_upd";
                string spInsertRecon = "SPAK_CVSRecon_BoxRecon_ins";
                using (SqlConnection con = new SqlConnection())
                {
                    con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
                    con.Open();
                    SqlCommand cmdBoxCheck = new SqlCommand(spBoxInSPAK, con) { CommandType = CommandType.StoredProcedure };
                    try
                    {
                        cmdBoxCheck.Parameters.AddWithValue("@BoxCntrID", txbReconBox.Text);
                        using (SqlDataReader rdrInSpak = cmdBoxCheck.ExecuteReader())
                        {
                            if (rdrInSpak.HasRows)
                            {
                                BoxInSPAK = true;
                                while (rdrInSpak.Read())
                                {
                                    if (rdrInSpak["TruckCntrID"].ToString().Substring(0, 2) == txbTruckID.Text.Substring(0, 2))
                                    {
                                        BoxInSPAKSameSite = true;
                                    }
                                    if (rdrInSpak["TruckCntrID"].ToString().Substring(0, 15) == txbTruckID.Text.Substring(0, 15))
                                    {
                                        BoxInSPAKSameTruck = true;
                                    }
                                }
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        lblErrMsg.Visible = true;
                        lblErrMsg.Text = ex.Message;
                    }
                    finally
                    {
                        con.Close();
                    }
                }
                if (!BoxInSPAK)
                {
                    lblReconErrMsg.Visible = true;
                    lblReconErrMsg.Text = "The Box you scanned (" + txbReconBox.Text + ") was not found in SPAK.  IMPORTANT!!! Contact your supervisor.";
                    txbReconBox.Text = string.Empty;
                    txbReconBox.Focus();
                    return;
                }
                else if (!BoxInSPAKSameSite)
                {
                    lblReconErrMsg.Visible = true;
                    lblReconErrMsg.Text = "The Box you scanned (" + txbReconBox.Text + ") was found in SPAK but not for this site.  " +
                        "IMPORTANT!!! you must receive the box at this site before you can reconcile it.";
                    txbReconBox.Text = string.Empty;
                    txbReconBox.Focus();
                    return;
                }
                else if (!BoxInSPAKSameTruck)
                {
                    lblReconErrMsg.Visible = true;
                    lblReconErrMsg.Text = "The Box you scanned (" + txbReconBox.Text + ") was found in SPAK for this site but not for this TruckID.  " +
                        "IMPORTANT!!! you must resolve this issue before you can reconcile the box.";
                    txbReconBox.Text = string.Empty;
                    txbReconBox.Focus();
                    return;
                }
                else
                {
                    using (SqlConnection con = new SqlConnection())
                    {
                        con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
                        con.Open();
                        SqlCommand cmdCVSBox = new SqlCommand(spBoxIsCVS, con) { CommandType = CommandType.StoredProcedure };
                        try
                        {
                            cmdCVSBox.Parameters.AddWithValue("@BoxCntrID", txbReconBox.Text);
                            object recordID = new object();
                            recordID = cmdCVSBox.ExecuteScalar();
                            if (recordID != null)
                            {
                                IsCVS = true;
                            }
                        }
                        catch (Exception ex)
                        {
                            lblErrMsg.Visible = true;
                            lblErrMsg.Text = ex.Message;
                        }
                        finally
                        {
                            con.Close();
                        }
                    }
                }
                if (!IsCVS)
                {
                    lblReconErrMsg.Visible = true;
                    lblReconErrMsg.Text = "This box is not a CVS NonReg pharmaceutical.  Please contact your supervisor";
                    gvBoxRecon.DataBind();
                    gvReconMoreBoxes.DataBind();
                }
                else if (IsCVS)
                {
                    using (SqlConnection con = new SqlConnection())
                    {
                        con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
                        con.Open();
                        SqlCommand cmdBoxRecon = new SqlCommand(spBoxRecon, con) { CommandType = CommandType.StoredProcedure };
                        try
                        {
                            cmdBoxRecon.Parameters.AddWithValue("@BoxCntrID", txbReconBox.Text);
                            object reconStatus = new object();
                            reconStatus = cmdBoxRecon.ExecuteScalar();
                            if (reconStatus != null)
                            {
                                if (Convert.ToInt32(reconStatus) > 0)
                                {
                                    lblReconErrMsg.Visible = true;
                                    lblReconErrMsg.Text = "This Box has already been reconciled!  Please scan a different Box.";
                                    lblCurReconBox.Text = txbReconBox.Text;
                                    gvReconMoreBoxes.DataBind();
                                    txbReconBox.Text = string.Empty;
                                    txbReconBox.Focus();
                                }
                                else
                                {
                                    using (SqlConnection con1 = new SqlConnection())
                                    {
                                        con1.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
                                        con1.Open();
                                        SqlCommand cmdReconUpd = new SqlCommand(spUpdateRecon, con) { CommandType = CommandType.StoredProcedure };
                                        try
                                        {
                                            cmdReconUpd.Parameters.AddWithValue("@BoxCntrID", txbReconBox.Text);
                                            cmdReconUpd.Parameters.AddWithValue("@UserName", HttpContext.Current.User.Identity.Name.ToString());
                                            cmdReconUpd.ExecuteNonQuery();
                                        }
                                        catch (Exception ex)
                                        {
                                            lblErrMsg.Visible = true;
                                            lblErrMsg.Text = ex.Message;
                                            con.Close();
                                        }
                                        finally
                                        {
                                            gvBoxRecon.DataBind();
                                            gvReconMoreBoxes.DataBind();
                                            txbReconBox.Text = string.Empty;
                                            txbReconBox.Focus();
                                            lblReconErrMsg.Visible = false;
                                            lblErrMsg.Visible = false;
                                            con1.Close();
                                        }
                                    }
                                }
                            }
                            else
                            {
                                SqlCommand cmdReconIns = new SqlCommand(spInsertRecon, con) { CommandType = CommandType.StoredProcedure };
                                try
                                {
                                    cmdReconIns.Parameters.AddWithValue("@BoxCntrID", txbReconBox.Text);
                                    cmdReconIns.Parameters.AddWithValue("@TruckID", txbTruckID.Text.Substring(0, 15));
                                    cmdReconIns.Parameters.AddWithValue("@UserName", HttpContext.Current.User.Identity.Name.ToString());
                                    cmdReconIns.ExecuteNonQuery();
                                }
                                catch (Exception ex)
                                {
                                    lblErrMsg.Visible = true;
                                    lblErrMsg.Text = ex.Message;
                                }
                                finally
                                {
                                    lblCurReconBox.Text = txbReconBox.Text;
                                    gvBoxRecon.DataBind();
                                    gvReconMoreBoxes.DataBind();
                                    txbReconBox.Text = string.Empty;
                                    txbReconBox.Focus();
                                    lblReconErrMsg.Visible = false;
                                    lblErrMsg.Visible = false;
                                    con.Close();
                                }
                            }
                        }
                        catch (Exception ex)
                        {
                            lblErrMsg.Visible = true;
                            lblErrMsg.Text = ex.Message;
                        }
                        finally
                        {
                            con.Close();
                            txbTruckID_TextChanged(null, null);
                        }
                    }
                }
            }
            else
            {
                lblReconErrMsg.Visible = true;
                lblReconErrMsg.Text = "You must scan or enter a BoxCntrID first!";
                txbReconBox.Focus();
            }
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            txbTruckID.Text = string.Empty;
            lblErrMsg.Text = string.Empty;
            lblErrMsg.Visible = false;
            lblReconErrMsg.Text = string.Empty;
            lblReconErrMsg.Visible = false;
            lblReconBox.Visible = false;
            lblReconMoreBoxes.Visible = false;
            lblCurReconBox.Text = string.Empty;
            txbReconBox.Visible = false;
            btnReconBox.Visible = false;
            txbTruckID_TextChanged(null, null);
        }

        protected void btnReconBox_Click(object sender, EventArgs e)
        {
            txbTruckID_TextChanged(null, null);
            gvBoxRecon.DataBind();
            gvReconMoreBoxes.DataBind();
        }

        protected void sdsReconMoreBoxes_DataBound(object sender, EventArgs e)
        {
            if (gvReconMoreBoxes.Rows.Count == 0)
            {
                lblReconMoreBoxes.Visible = false;
                lblReconMoreBoxes.Text = string.Empty;
            }
            else if (gvReconMoreBoxes.Rows.Count <= 1)
            {
                lblReconMoreBoxes.Visible = true;
                lblReconMoreBoxes.Text = "There are no other boxes associated with this manifest";
            }
            else
            {
                lblReconMoreBoxes.Visible = true;
                lblReconMoreBoxes.Text = "These boxes are also associated with this manifest:";
            }
        }
    }
}