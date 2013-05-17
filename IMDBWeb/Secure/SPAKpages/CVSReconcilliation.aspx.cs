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
            trBoxNotFound.Visible = false;
            trBoxFound.Visible = false;
            gvBoxRecon.Visible = false;
            lblReconErrMsg.Visible = false;
            lblReconBox.Visible = false;
            txbReconBox.Visible = false;
            btnReconBox.Visible = false;
        }

        protected void txbTruckID_TextChanged(object sender, EventArgs e)
        {
            
            if (!string.IsNullOrEmpty(txbTruckID.Text) && !string.IsNullOrWhiteSpace(txbTruckID.Text))
            {
                lblErrMsg.Visible = false;
                int totalBoxes = 0;
                int reconBoxes = 0;
                string spCVSBoxes = "SPAK_CVSRecon_Boxes_Sel";
                SqlConnection con = new SqlConnection();
                con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
                SqlCommand CmdBoxes = new SqlCommand(spCVSBoxes, con);
                CmdBoxes.CommandType = CommandType.StoredProcedure;
                
                using(CmdBoxes)
                { 
                    con.Open();
                    try 
	                {	        
                        CmdBoxes.Parameters.AddWithValue("@TruckCntrID", txbTruckID.Text.Substring(0,15));
                        SqlDataReader rdrBoxes = CmdBoxes.ExecuteReader();
                        if(rdrBoxes.HasRows)
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
                            lblTruckID.Text = txbTruckID.Text.Substring(0,15);
                            if (totalBoxes == reconBoxes)
                            {
                                lblReconErrMsg.Visible = true;
                                lblReconErrMsg.Text = "You have Reconciled all the boxes for this TruckID";
                                lblReconBox.Visible = false;
                                txbReconBox.Visible = false;
                                btnReconBox.Visible = false;
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

	                    }
                        rdrBoxes.Close();
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

            Boolean BoxInSPAK = false;
            Boolean BoxInSPAKSameSite = false;
            Boolean BoxInSPAKSameTruck = false;
            Boolean IsCVS = false;
            string spBoxInSPAK = "SPAK_CVSRecon_BoxInSpak_Sel";
            string spBoxIsCVS = "SPAK_CVSRecon_BoxIsCVS_Sel";
            string spBoxRecon = "SPAK_CVSRecon_BoxIsRecon_Sel";
            string spUpdateRecon = "SPAK_CVSRecon_BoxRecon_upd";
            string spInsertRecon = "SPAK_CVSRecon_BoxRecon_ins";
            SqlConnection con = new SqlConnection();
            con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
            SqlCommand cmdBoxCheck = new SqlCommand(spBoxInSPAK, con);
            SqlCommand cmdCVSBox = new SqlCommand(spBoxIsCVS, con);
            SqlCommand cmdBoxRecon = new SqlCommand(spBoxRecon,con);
            SqlCommand cmdReconUpd = new SqlCommand(spUpdateRecon, con);
            SqlCommand cmdReconIns = new SqlCommand(spInsertRecon, con);
            cmdBoxCheck.CommandType = CommandType.StoredProcedure;
            cmdCVSBox.CommandType = CommandType.StoredProcedure;
            cmdBoxRecon.CommandType = CommandType.StoredProcedure;
            cmdReconUpd.CommandType = CommandType.StoredProcedure;
            cmdReconIns.CommandType = CommandType.StoredProcedure;

            using(cmdBoxCheck)
            {
                con.Open();
                try
                {           
		            cmdBoxCheck.Parameters.AddWithValue("@BoxCntrID", txbReconBox.Text);
                    SqlDataReader rdrInSpak = cmdBoxCheck.ExecuteReader();
                    if(rdrInSpak.HasRows)
                    {
                        BoxInSPAK = true;
                        while (rdrInSpak.Read())
                        {
                            if(rdrInSpak["TruckCntrID"].ToString().Substring(0,2)== txbTruckID.Text.Substring(0,2))
                            {
                                BoxInSPAKSameSite = true;
                            }
                            if(rdrInSpak["TruckCntrID"].ToString().Substring(0,15)== txbTruckID.Text.Substring(0,15))
                            {
                                BoxInSPAKSameTruck = true;
                            }
                        }
	                }
                    rdrInSpak.Close();
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
                lblReconErrMsg.Text = "This Box was not found in Spak.  IMPORTANT!!! Contact your supervisor";
            }
            else if(!BoxInSPAKSameSite)
            {
                lblReconErrMsg.Visible = true;
                lblReconErrMsg.Text = "This Box was found in Spak but not for this site.  "+
                    "IMPORTANT!!! you must receive the box at this site before you can reconcile it.";   
            }
            else if (!BoxInSPAKSameTruck)
            {
                lblReconErrMsg.Visible = true;
                lblReconErrMsg.Text = "This Box was found in Spak for this site but not for this TruckID.  " +
                    "IMPORTANT!!! you must resolve this issue site before you can reconcile the box.";  
            }
            else
            {
                using (cmdCVSBox)
                {
                    con.Open();
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
            if(!IsCVS)
            {
                lblReconErrMsg.Visible = true;
                lblReconErrMsg.Text = "This box is not a CVS NonReg pharmaceutical.  Please contact your supervisor";
            }
            else
	        {
                using (cmdBoxRecon)
                {
                    con.Open();
                    try
                    {
                        cmdBoxRecon.Parameters.AddWithValue("@BoxCntrID", txbReconBox.Text);
                        SqlDataReader rdrBoxRecon = cmdBoxRecon.ExecuteReader();
                        if (rdrBoxRecon.HasRows)
                        {
                            while (rdrBoxRecon.Read())
                            {
                                if (Convert.ToInt32(rdrBoxRecon["Reconciled"]) > 0)
                                {
                                    lblReconErrMsg.Visible = true;
                                    lblReconErrMsg.Text = "This Box has already been reconciled!  Please scan a different Box.";
                                    txbReconBox.Text = string.Empty;
                                    txbReconBox.Focus();
                                }
                                else
                                {
                                    using (cmdReconUpd)
                                    {
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
                                        }
                                        finally
                                        {
                                            gvBoxRecon.DataBind();
                                            txbReconBox.Text = string.Empty;
                                            txbReconBox.Focus();
                                        }
                                    }

                                }
                            }
                            rdrBoxRecon.Close();
                        }
                        else
                        {
                            rdrBoxRecon.Close();
                            using (cmdReconIns)
                            {
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
                                    gvBoxRecon.DataBind();
                                    txbReconBox.Text = string.Empty;
                                    txbReconBox.Focus();
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
                        txbTruckID_TextChanged(null, null);
                    }
                }
	        }
        }

        protected void btnReconBox_Click(object sender, EventArgs e)
        {
            txbReconBox_TextChanged(null, null);
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            txbTruckID.Text = string.Empty;
            txbTruckID_TextChanged(null, null);
        }
    }
}