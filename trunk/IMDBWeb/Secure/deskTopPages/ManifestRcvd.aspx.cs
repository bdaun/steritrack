using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace IMDBWeb.Secure.deskTopPages
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
                else
                {
                    /* ******************************** Algorithm *********************************************
                     * Check if Manifest has already been received.  If yes, determine if from a different site.  
                     * If yes, prompt/warning but allow insert.  If Manifest has already been received at same site, 
                     * prompt/warning but do not allow insert.

	                **************************************************************************************** */

                    Boolean found = false;
                    String spExist = "SPAK_ManifestRcvd_Exist";
                    String spIns = "SPAK_ManifestRcvd_Ins";
                    SqlConnection con = new SqlConnection();
                    con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
                    SqlCommand spCmdExist = new SqlCommand(spExist, con);
                    SqlCommand spCmdIns = new SqlCommand(spIns, con);
                    spCmdExist.CommandType = CommandType.StoredProcedure;
                    spCmdIns.CommandType = CommandType.StoredProcedure;
                    con.Open();
                    using (spCmdExist)
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
                                else
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
                    if(!found)
                    {
                        using (spCmdIns)
                        {
                            con.Open();
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
                                con.Close();
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
    }
}