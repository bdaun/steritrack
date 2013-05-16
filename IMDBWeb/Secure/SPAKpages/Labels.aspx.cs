using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;
using System.Data;
using System.Data.SqlClient;

namespace IMDBWeb.Secure.SPAKpages
{
    public partial class Labels : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                tblCreateLabels.Visible = false;
                trLabelData.Visible = false;
                truckrow1.Visible = false;
                truckrow2.Visible = false;
                truckrow3.Visible = false;
                lblCreateMsg.Visible = false;
                ddCreateItems.SelectedIndex = 0;
                ddSiteSelect.SelectedIndex = 0;
                txbNumberContainers.Text = string.Empty;
                txbTruckDate.Text = string.Empty;
                txbTruckSeqNumber.Text = "001";
                btnPrintLabel.Visible = false;
                chkPrintExisting.Visible = false;
//                pnlLblPreview.Visible = false;
            }
        }

        protected void txbTruckDate_TextChanged(object sender, EventArgs e)
        {
            lblCreateMsg.Visible = false;
            if (!Regex.IsMatch(txbTruckDate.Text, @"^(0[1-9]|1[012])[/](0[1-9]|[12][0-9]|3[01])[/][01]\d$"))
            {
                WebMsgBox.Show("Please use the format of mm/dd/yy");
                txbTruckDate.Text = string.Empty;
                txbTruckDate.Focus();
            }
        }

        protected void txbNumberContainers_TextChanged(object sender, EventArgs e)
        {
            lblCreateMsg.Visible = false;
            if (!Regex.IsMatch(txbNumberContainers.Text, @"^[0-9]{1,3}$"))
            {
                WebMsgBox.Show("Please enter a value between 1 and 999");
                txbNumberContainers.Text = string.Empty;
                txbNumberContainers.Focus();
            }
        }

        protected void btnCreateLabel_Click(object sender, EventArgs e)
        {
            if (ddCreateItems.SelectedValue.ToString() == "TruckTag")
            {
                //check that values have been selected
                if (string.IsNullOrEmpty(txbNumberContainers.Text) || string.IsNullOrWhiteSpace(txbNumberContainers.Text) || Convert.ToInt32(txbNumberContainers.Text) < 1)
                {
                    WebMsgBox.Show("Please enter a valid number of containers");
                    txbNumberContainers.Focus();
                }
                else if (ddSiteSelect.SelectedIndex == 0)
                {
                    WebMsgBox.Show("Please select a site from the dropdown list");
                    ddSiteSelect.Focus();
                }
                else if (string.IsNullOrEmpty(txbTruckDate.Text) || string.IsNullOrWhiteSpace(txbTruckDate.Text))
                {
                    WebMsgBox.Show("Please enter a valid date for the truck arrival");
                    txbTruckDate.Focus();
                }
                else if (string.IsNullOrEmpty(txbTruckSeqNumber.Text) || string.IsNullOrWhiteSpace(txbTruckSeqNumber.Text))
                {
                    WebMsgBox.Show("Please enter a truck sequence number in the format of ###");
                    txbTruckSeqNumber.Focus();
                }
                else
                {
                    //Create labels

                    int lblCounter = 1;
                    int initLblCnt = 0;
                    String spLblCnt = "SPAK_Labels_CountLabels_Sel";
                    String spLblIns = "SPAK_Labels_TruckTag_Ins";
                    SqlConnection con = new SqlConnection();
                    con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
                    SqlCommand spCmdLblCnt = new SqlCommand(spLblCnt, con);
                    SqlCommand spCmdLblIns = new SqlCommand(spLblIns, con);
                    spCmdLblCnt.CommandType = CommandType.StoredProcedure;
                    spCmdLblIns.CommandType = CommandType.StoredProcedure;

                    con.Open();
                    using (spCmdLblCnt)
                    {
                        try
                        {
                            spCmdLblCnt.Parameters.AddWithValue("@SiteCode", ddSiteSelect.SelectedValue.ToString());
                            spCmdLblCnt.Parameters.AddWithValue("@TruckDate", txbTruckDate.Text);
                            spCmdLblCnt.Parameters.AddWithValue("@TruckSeq", txbTruckSeqNumber.Text);
                            SqlDataReader rdrLblCnt = spCmdLblCnt.ExecuteReader();
                            if (rdrLblCnt.HasRows)
                            {
                                while (rdrLblCnt.Read())
                                {
                                    initLblCnt = Convert.ToInt32(rdrLblCnt["lblCount"].ToString());
                                    lblCounter = 1 + initLblCnt;
                                }
                            }
                            rdrLblCnt.Close();
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

                    using (spCmdLblIns)
                    {
                        while (lblCounter <= Convert.ToInt32(txbNumberContainers.Text) + initLblCnt)
                        {
                            con.Open();
                            try
                            {
                                string curCntrID = ddSiteSelect.SelectedValue.ToString() + "-" + txbTruckDate.Text + "-" + txbTruckSeqNumber.Text + "-" + lblCounter.ToString();
                                spCmdLblIns.Parameters.AddWithValue("@CntrID", curCntrID);
                                spCmdLblIns.Parameters.AddWithValue("@Type", ddCreateItems.SelectedValue.ToString());
                                spCmdLblIns.Parameters.AddWithValue("@UserName", HttpContext.Current.User.Identity.Name.ToString());
                                spCmdLblIns.ExecuteNonQuery();
                                lblCounter = lblCounter + 1;
                            }
                            catch (Exception ex)
                            {
                                lblErrMsg.Visible = true;
                                lblErrMsg.Text = ex.Message;
                            }
                            finally
                            {
                                spCmdLblIns.Parameters.Clear();
                                con.Close();
                                lblCreateMsg.Visible = true;
                                btnCreateLabel.Visible = false;
                                btnPrintLabel.Visible = true;
                                txbNumberContainers.ReadOnly = true;
                            }
                        }
                    }
                }
            }
            else
            {
                //check that values have been selected
                if (string.IsNullOrEmpty(txbNumberContainers.Text) || string.IsNullOrWhiteSpace(txbNumberContainers.Text) || Convert.ToInt32(txbNumberContainers.Text) < 1)
                {
                    WebMsgBox.Show("Please enter a valid number of containers");
                    txbNumberContainers.Focus();
                }
                else
                {
                    String TagType = string.Empty;
                    if (ddCreateItems.SelectedValue.ToString() == "ProcessTag")
                    {
                        TagType = "PT";
                    }
                    else
                    {
                        TagType = "PS";
                    }

                    int TagCount = 0;
                    String spMaxTag = "SPAK_Labels_MaxTag_Sel";
                    String spTagIns = "SPAK_Labels_PalletTag_Ins";
                    SqlConnection con = new SqlConnection();
                    con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
                    SqlCommand spCmdMaxTag = new SqlCommand(spMaxTag, con);
                    SqlCommand spCmdTagIns = new SqlCommand(spTagIns, con);
                    spCmdMaxTag.CommandType = CommandType.StoredProcedure;
                    spCmdTagIns.CommandType = CommandType.StoredProcedure;

                    con.Open();
                    using (spCmdMaxTag)
                    {
                        try
                        {
                            spCmdMaxTag.Parameters.AddWithValue("@TagType", TagType);
                            object MaxTag = new object();
                            MaxTag = spCmdMaxTag.ExecuteScalar();
                            TagCount = Convert.ToInt32(MaxTag.ToString());
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

                    using (spCmdTagIns)
                    {
                        int TagCounter = 1;
                        int TagValue = 100000000 + TagCount + TagCounter;  // Adding in the 100000000 creates consistent Tag length (for a while anyway)
                        while (TagCounter <= Convert.ToInt32(txbNumberContainers.Text))
                        {
                            String CntrID = TagType + "-" + TagValue;
                            con.Open();
                            try
                            {
                                spCmdTagIns.Parameters.AddWithValue("@CntrID", CntrID);
                                spCmdTagIns.Parameters.AddWithValue("@Type", ddCreateItems.SelectedValue.ToString());
                                spCmdTagIns.Parameters.AddWithValue("@UserName", HttpContext.Current.User.Identity.Name.ToString());
                                spCmdTagIns.ExecuteNonQuery();

                            }
                            catch (Exception ex)
                            {
                                lblErrMsg.Visible = true;
                                lblErrMsg.Text = ex.Message;
                            }
                            finally
                            {
                                TagCounter = TagCounter + 1;
                                TagValue = TagValue + 1;
                                spCmdTagIns.Parameters.Clear();
                                con.Close();
                                lblCreateMsg.Visible = true;
                                btnCreateLabel.Visible = false;
                                btnPrintLabel.Visible = true;
                                txbNumberContainers.ReadOnly = true;
                            }
                        }
                    }
                }
            }
        }
        protected void txbTruckSeqNumber_TextChanged(object sender, EventArgs e)
        {
            lblCreateMsg.Visible = false;
            if (!Regex.IsMatch(txbTruckSeqNumber.Text, @"^\d\d\d$"))
            {
                WebMsgBox.Show("Please enter a 3 Digit sequence number.  For example, '002'.");
                txbTruckSeqNumber.Text = string.Empty;
                txbTruckSeqNumber.Focus();
            }
        }

        protected void ddCreateItems_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblCreateMsg.Visible = false;
            txbNumberContainers.Text = string.Empty;
            ddSiteSelect.SelectedIndex = 0;
            txbTruckDate.Text = string.Empty;
            txbTruckSeqNumber.Text = "001";
            chkPrintExisting.Checked = false;
            txbNumberContainers.ReadOnly = false;

            if (ddCreateItems.SelectedIndex == 0)
            {
                tblCreateLabels.Visible = false;
                trLabelData.Visible = false;
                chkPrintExisting.Visible = false;
            }
            else if (ddCreateItems.SelectedValue == "TruckTag")
            {
                tblCreateLabels.Visible = true;
                trLabelData.Visible = true;
                truckrow1.Visible = true;
                truckrow2.Visible = true;
                truckrow3.Visible = true;
                btnCreateLabel.Visible = true;
                btnPrintLabel.Visible = false;
                chkPrintExisting.Visible = true;
                txbNumberContainers.Focus();
            }
            else if (ddCreateItems.SelectedValue == "ProcessTag" || ddCreateItems.SelectedValue == "PassThruTag")
            {
                tblCreateLabels.Visible = true;
                trLabelData.Visible = true;
                truckrow1.Visible = false;
                truckrow2.Visible = false;
                truckrow3.Visible = false;
                btnCreateLabel.Visible = true;
                btnPrintLabel.Visible = false;
                chkPrintExisting.Visible = false;
                txbNumberContainers.Focus();
            }
        }

        protected void btnPrintLabel_Click(object sender, EventArgs e)
        {
            String spPreviewIns = string.Empty;
            if(ddCreateItems.SelectedValue.ToString() == "TruckTag")
            {
                spPreviewIns = "SPAK_Labels_PreviewTruckTag_Ins";
                string CurCntrID = ddSiteSelect.SelectedValue + "-" + txbTruckDate.Text + "-" + txbTruckSeqNumber.Text;
            }
            else
	        {
                spPreviewIns = "SPAK_Labels_PreviewPalletTag_Ins";
	        }

            SqlConnection con = new SqlConnection();
            con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
            SqlCommand cmdPreviewIns = new SqlCommand(spPreviewIns, con);
            cmdPreviewIns.CommandType = CommandType.StoredProcedure;
            con.Open();
            using (cmdPreviewIns)
            {
                try
                {
                    if (ddCreateItems.SelectedValue.ToString() == "TruckTag")
                    {
                        string CurCntrID = ddSiteSelect.SelectedValue + "-" + txbTruckDate.Text + "-" + txbTruckSeqNumber.Text;
                        cmdPreviewIns.Parameters.AddWithValue("@CntrID", CurCntrID);
                    }
                    else
                    {
                        cmdPreviewIns.Parameters.AddWithValue("@Qty", Convert.ToInt32(txbNumberContainers.Text));
                        cmdPreviewIns.Parameters.AddWithValue("@Type", ddCreateItems.SelectedValue.ToString());
                    }
                    cmdPreviewIns.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    lblErrMsg.Visible = true;
                    lblErrMsg.Text = ex.Message;
                }
                finally
                {
                    ddCreateItems.SelectedIndex = 0;
                    tblCreateLabels.Visible = false;
                    ddSiteSelect.SelectedIndex = 0;
                    txbNumberContainers.Text = string.Empty;
                    txbNumberContainers.ReadOnly = false;
                    txbTruckDate.Text = string.Empty;
                    txbTruckSeqNumber.Text = "001";
                }
            }
            ClientScript.RegisterStartupScript(this.GetType(), "onclick", "<script language=javascript>window.open('LabelPreview.aspx','PrintLabels','height=400px,width=600px,scrollbars=1,left=25px');window.open('ScanSheetPreview.aspx','PrintScanSheet','height=800px,width=600px,scrollbars=1,left=610px');</script>");
        }

        protected void chkPrintExisting_CheckedChanged(object sender, EventArgs e)
        {
            if (chkPrintExisting.Checked)
            { 
                btnCreateLabel.Visible = false;
                btnPrintLabel.Visible = true;
            }
            else
            {
                btnCreateLabel.Visible = true;
                btnPrintLabel.Visible = false;
            }
            
        }
    }
}