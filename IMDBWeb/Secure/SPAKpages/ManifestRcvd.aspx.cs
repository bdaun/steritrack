﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace IMDBWeb.Secure.SPAKPages
{
    public partial class ManifestRcvd : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["CurTruckID"] = string.Empty;
                Session["ManifestWarning"] = null;
                txbTruckID.Text = string.Empty;
                txbTruckID.Focus();
            }
        }

        protected void txbTruckID_TextChanged(object sender, EventArgs e)
        {
            //  Set a Session vlaue for the truckID, this TruckID is perpetuated during insert of Manifest records until changed by the user
            if (Page.IsValid)
            {
                Session["CurTruckID"] = txbTruckID.Text;
                txbInboundDocNo.Focus();
            }
            else
            {
                WebMsgBox.Show("Please enter a valid TruckID in the form of ##-mm/dd/yy-###");
                txbTruckID.Focus();
            }
        }

        protected void txbInboundDocNo_TextChanged(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                if (string.IsNullOrEmpty(txbInboundDocNo.Text) || string.IsNullOrWhiteSpace(txbInboundDocNo.Text))
                {
                    txbTruckID.Focus();
                }
                else if (string.IsNullOrEmpty(txbTruckID.Text) || string.IsNullOrWhiteSpace(txbTruckID.Text))
                {
                    txbTruckID.Focus();
                }
                else if (txbInboundDocNo.Text.Length != 12 && Session["ManifestWarning"]==null)
                {
                    Session["ManifestWarning"] = "On";
                    WebMsgBox.Show("The value you entered is not formatted like most manifests.  Please confirm the format");
                    btnOverride.Visible = true;
                    btnOverride.Focus();
                }
                else  //This is the "Insert Record Process"
                {
                    /* ******************************** Algorithm *********************************************
                     * Determine if manifest TSDF is same as current site.  If not, prompt for 10d storage.  
                     * Check if Manifest has already been received.  If yes, determine if from a different site.  
                     * If yes, prompt/warning but allow insert.  If Manifest has already been received at same site, 
                     * prompt/warning but do not allow insert.  If record is  10Day manifest, insert addtional
                     * fields setting mail date and comment.

	                **************************************************************************************** */

                    Boolean Is10day = false;
                    String SiteName = String.Empty;
                    String TSDF = String.Empty;
                    Boolean found = false;
                    String spSite = "SPAK_ManifestRcvd_Site_Sel";
                    String spTSDF = "SPAK_ManifestRcvd_TSDF_Sel";
                    String spExist = "SPAK_ManifestRcvd_Exist";
                    SqlConnection con = new SqlConnection();
                    con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
                    SqlCommand spCmdSite = new SqlCommand(spSite, con);
                    SqlCommand spCmdTSDF = new SqlCommand(spTSDF, con);
                    SqlCommand spCmdExist = new SqlCommand(spExist, con);
                    spCmdSite.CommandType = CommandType.StoredProcedure;
                    spCmdTSDF.CommandType = CommandType.StoredProcedure;
                    spCmdExist.CommandType = CommandType.StoredProcedure;
                    con.Open();

                    using (spCmdTSDF)  //Get the TSDFCompany Name from manifest table
                    {
                        try
                        {
                            spCmdTSDF.Parameters.AddWithValue("@InboundDocNo", txbInboundDocNo.Text);
                            SqlDataReader rdrTSDF = spCmdTSDF.ExecuteReader();
                            if (rdrTSDF.HasRows)
                            {
                                while (rdrTSDF.Read())
                                { 
                                    TSDF = rdrTSDF["TSDFCompany"].ToString();
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

                    con.Open();
                    using (spCmdSite)  //Get the name of the receiving site from the TruckID
                    {
                        try
                        {
                            spCmdSite.Parameters.AddWithValue("@SiteCode", txbTruckID.Text.Substring(0, 2));
                            SqlDataReader rdrSite = spCmdSite.ExecuteReader();
                            if (rdrSite.HasRows)
                            {
                                while (rdrSite.Read())
                                { 
                                    SiteName = rdrSite["SiteName"].ToString();
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

                    if(!TSDF.Contains(SiteName))  //If SiteName is not part of the TSDF company, it is a 10Day manifest.
                    {
                        Is10day = true;
                        WebMsgBox.Show("The manifest you scanned does not have this facility as the TSDF, please place this manifest separate " +
                            "from the TSDF Manifests and treat this manifest and associated waste as 10 Day Waste unless otherwise directed.");
                    }

                    con.Open();
                    using (spCmdExist)  // Check if manifest is already in the system
                    {
                        try
                        {
                            spCmdExist.Parameters.AddWithValue("@InboundDocNo", txbInboundDocNo.Text);
                            SqlDataReader rdr = spCmdExist.ExecuteReader();
                            if (rdr.HasRows)
                            {
                                while (rdr.Read())
                                {
                                    if (txbTruckID.Text.Substring(0, 2) == rdr["TruckID"].ToString().Substring(0, 2))
                                    {
                                        found = true;
                                    }
                                }
                                if (found == true)
                                {
                                    WebMsgBox.Show("This manifest has already been received at this site.  You cannot re-enter it");
                                    btnOverride.Visible = false;
                                    txbInboundDocNo.Text = string.Empty;
                                    Session["ManifestWarning"] = null;
                                    txbInboundDocNo.Focus();
                                }
                                else if(found==false && !Is10day)
                                {
                                    WebMsgBox.Show("Note that this manifest has already been received at another site and has now also been entered for this site.");
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
                    if(!found)  //Insert the new record with insert values dependent on whether manifest is 10Day or not
                    {
                        String spIns = string.Empty;
                        if (Is10day)
                        {
                            spIns = "SPAK_ManifestRcvd_10Day_Ins";
                        }
                        else
                        {
                            spIns = "SPAK_ManifestRcvd_Ins";
                        }
                        SqlConnection conn = new SqlConnection();
                        conn.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
                        SqlCommand spCmdIns = new SqlCommand(spIns, conn);
                        spCmdIns.CommandType = CommandType.StoredProcedure;
                        conn.Open();
                        using (spCmdIns)
                        {
                            try
                            {
                                spCmdIns.Parameters.AddWithValue("@UserName", HttpContext.Current.User.Identity.Name.ToString());
                                spCmdIns.Parameters.AddWithValue("@TruckID", txbTruckID.Text);
                                spCmdIns.Parameters.AddWithValue("@InboundDocNo", txbInboundDocNo.Text);
                                spCmdIns.ExecuteNonQuery();
                            }
                            catch (Exception ex)
                            {
                                lblErrMsg.Visible = true;
                                lblErrMsg.Text = ex.ToString();
                            }
                            finally
                            {
                                conn.Close();
                                txbTruckID.Text = Session["CurTruckID"].ToString();
                                txbInboundDocNo.Text = string.Empty;
                                txbInboundDocNo.Focus();
                                btnOverride.Visible = false;
                                Session["ManifestWarning"] = null;
                                gvManifestData.DataBind();
                            }
                        }
                    }
                }
            }
        }

        protected void btnOverride_Click(object sender, EventArgs e)
        {
            txbInboundDocNo_TextChanged(this, new EventArgs());
        }

        protected void btnClose_Click(object sender, EventArgs e)
        {
            txbTruckID.Text = string.Empty;
            txbInboundDocNo.Text = string.Empty;
            Response.Redirect("~/secure/SPAKPages/SPAKPages.aspx");
        }
    }
}