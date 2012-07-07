using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace IMDBWeb.Secure.SuperFundPages
{
    public partial class Shipping : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                trTruck.Visible = false;
                trManifest.Visible = false;
                trDestination.Visible = false;
                trContainerMsg.Visible = false;
                trContainer.Visible = false;
                trErrorMsg.Visible = false;
            }
        }

        protected void btnTruck_Click(object sender, EventArgs e)
        {   
            trTruck.Visible = true;
            txbNewTruck.Focus();
        }

        protected void btnManifest_Click(object sender, EventArgs e)
        {
            if (ddTruck.SelectedIndex == 0)
            {
                trErrorMsg.Visible = true;
                lblErrMsg.Text = "You must first select a TruckCode!";
            }
            else
            {
            trTruck.Visible = true;
            btnAddTruck.Visible = false;
            btnTruckCancel.Visible = false;
            txbNewTruck.Text = ddTruck.SelectedItem.ToString();
            txbNewTruck.Enabled = false;
            trManifest.Visible = true;
            trDestination.Visible = true;
            txbNewManifest.Focus();
            }

        }

        protected void txbNewContainer_TextChanged(object sender, EventArgs e)
        {
            String sp = "SP_SFund_GridCntr_Exists";
            SqlConnection con = new SqlConnection();
            con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
            SqlCommand spCmd = new SqlCommand(sp, con);
            spCmd.CommandType = CommandType.StoredProcedure;
            con.Open();
            using (spCmd)
            {
                try
                {
                //  Verify that this container is in GridContainer table and meets "add to truck" criteria

                    spCmd.Parameters.AddWithValue("@ContainerID", txbNewContainer.Text);
                    object isValid = new object();
                    isValid = spCmd.ExecuteScalar();
                    if (isValid == null)
                    {
                        trErrorMsg.Visible = true;
                        lblErrMsg.Text = "The Container you entered is not in the System!";
                    }
                    else
                    {
                    // Verify that the container has not already been entered into the ShipContainer table

                        String spCntrChk = "SP_SFund_ShipCntr_Exist";
                        SqlCommand ChkCmd = new SqlCommand(spCntrChk, con);
                        ChkCmd.CommandType = CommandType.StoredProcedure;
                        ChkCmd.Parameters.AddWithValue("@ContainerID", txbNewContainer.Text);
                        object CntrExists = new object();
                        CntrExists = ChkCmd.ExecuteScalar();
                        if (CntrExists != null)
                        {
                            trErrorMsg.Visible = true;
                            lblErrMsg.Text = "This container has already been added to a truck.  Please contact Supervision";
                        }
                        else
                        {
                            String spCntrElig = "SP_SFund_CntrDetails_Eligible";
                            SqlCommand CntrElig = new SqlCommand(spCntrElig, con);
                            CntrElig.Parameters.AddWithValue("@ContainerID", txbNewContainer.Text);
                            CntrElig.CommandType = CommandType.StoredProcedure;
                            Object isElig = new object();
                            isElig = CntrElig.ExecuteScalar();
                            if (isElig == null)
                            {
                                trErrorMsg.Visible = true;
                                lblErrMsg.Text = "This container has not been approved for Transport";
                            }
                            else
                            {
                                String spIns = "SP_SFund_ShipCntr_Ins";
                                SqlCommand insCmd = new SqlCommand(spIns, con);
                                insCmd.CommandType = CommandType.StoredProcedure;
                                insCmd.Parameters.AddWithValue("@ContainerID", txbNewContainer.Text);
                                insCmd.Parameters.AddWithValue("@ManifestID", ddManifestNumber.SelectedValue);
                                insCmd.Parameters.AddWithValue("@UserName", HttpContext.Current.User.Identity.Name.ToString());
                                insCmd.ExecuteNonQuery();
                            }
                        }  
                    }
                }
                catch (Exception ex)
                {
                    trErrorMsg.Visible = true;
                    lblErrMsg.Text = ex.ToString();
                }
                finally
                {
                    con.Close();
                    txbNewContainer.Text = "";
                    gvShipContainer.DataBind();
                }
            }
        }

        protected void btnAddTruck_Click(object sender, EventArgs e)
        {
            ddTruck.EnableViewState = true;
            if (txbNewTruck.Text != "")
            {
                String sp = "SP_SFund_TruckCode_ins";
                SqlConnection con = new SqlConnection();
                con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
                SqlCommand spCmd = new SqlCommand(sp, con);
                spCmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                using (spCmd)
                {
                    try
                    {
                        spCmd.Parameters.AddWithValue("@TruckCode", txbNewTruck.Text);
                        spCmd.Parameters.AddWithValue("@ModBy", HttpContext.Current.User.Identity.Name.ToString());
                        SqlParameter newIDparameter = new SqlParameter("@LastID", SqlDbType.Int);
                        newIDparameter.Direction = ParameterDirection.Output;
                        spCmd.Parameters.Add(newIDparameter);
                        spCmd.ExecuteNonQuery();
                        int LastID = new Int32();
                        LastID = (int)newIDparameter.Value;
                        txbNewTruck.Text = "";
                        Session["CurTruckID"] = LastID;
                        gvShipContainer.DataBind();
                        Response.Redirect(Request.RawUrl);
                    }
                    catch (Exception ex)
                    {
                        trErrorMsg.Visible = true;
                        lblErrMsg.Text = ex.ToString();
                    }
                    finally
                    {
                        con.Close();
                    }
                }
            }
            else
            {
                trErrorMsg.Visible = true;
                lblErrMsg.Text = "You must enter a valid truck number";
            }
        }

        protected void btnAddManifest_Click(object sender, EventArgs e)
        {
            if (txbNewManifest.Text == "")
            {
                trErrorMsg.Visible = true;
                lblErrMsg.Text = "You must enter a Manifest Number!";
                txbNewManifest.Focus();
            }
            else if (txbDestination.Text == "")
            {
                trErrorMsg.Visible = true;
                lblErrMsg.Text = "You must enter a Destination for this Manifest";
                txbDestination.Focus();
            }
            else
            {
                String sp = "SP_SFund_Manifest_ins";
                SqlConnection con = new SqlConnection();
                con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
                SqlCommand spCmd = new SqlCommand(sp, con);
                spCmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                using (spCmd)
                {
                    try
                    {
                        spCmd.Parameters.AddWithValue("@ManifestNumber", txbNewManifest.Text);
                        spCmd.Parameters.AddWithValue("@TruckID", ddTruck.SelectedValue);
                        spCmd.Parameters.AddWithValue("@DestinationFacility", txbDestination.Text);
                        spCmd.Parameters.AddWithValue("@ModBy", HttpContext.Current.User.Identity.Name.ToString());
                        spCmd.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        trErrorMsg.Visible = true;
                        lblErrMsg.Text = ex.ToString();
                    }
                    finally
                    {
                        con.Close();
                        Response.Redirect(Request.RawUrl);
                    }
                }
            }
        }

        protected void ddTruck_SelectedIndexChanged(object sender, EventArgs e)
        {
            trErrorMsg.Visible = false;
        }

        protected void txbNewTruck_TextChanged(object sender, EventArgs e)
        {
                btnAddTruck.Focus();
        }

        protected void btnTruckCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect(Request.RawUrl);
            return;
        }

        protected void btnManifestCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect(Request.RawUrl);
            return;
        }

        protected void txbNewManifest_TextChanged(object sender, EventArgs e)
        {
            //  Verify that the Manifest does not already exist in the system

            String sp = "SP_SFund_Manifest_Exists";
            SqlConnection con = new SqlConnection();
            con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
            SqlCommand spCmd = new SqlCommand(sp, con);
            spCmd.CommandType = CommandType.StoredProcedure;
            con.Open();
            using (spCmd)
            {
                try
                {
                    spCmd.Parameters.AddWithValue("@ManifestNumber", txbNewManifest.Text);
                    object isValid = new object();
                    isValid = spCmd.ExecuteScalar();
                    if (isValid != null)
                    {
                        trErrorMsg.Visible = true;
                        lblErrMsg.Text = "The Manifest you entered is already in the System!";
                        txbNewManifest.Focus();
                    }
                    else
                    {   
                        txbDestination.Focus();
                    }
                }
                catch (Exception ex)
                {
                    trErrorMsg.Visible = true;
                    lblErrMsg.Text = ex.ToString();
                }
                finally
                {
                    con.Close();
                }
            }
        }

        protected void txbDestination_TextChanged(object sender, EventArgs e)
        {
            btnAddManifest.Focus();
        }

        protected void ddManifestNumber_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            Response.Redirect(Request.RawUrl);
        }

        protected void txbContainerID_TextChanged(object sender, EventArgs e)
        {
            
        }

        protected void gvShipContainer_OnDatabound(object sender, EventArgs e)
        {
            if (ddTruck.SelectedIndex != 0 && ddManifestNumber.SelectedIndex != 0)
            {
                trContainerMsg.Visible = true;
                trContainer.Visible = true;
                txbNewContainer.Focus();
            }
            else
            {
                trContainerMsg.Visible = false;
                trContainer.Visible = false;
            }
        }
        protected void gvShipContainer_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (DataBinder.Eval(e.Row.DataItem, "ContainerID").ToString() != "")
                {
                    LinkButton l = (LinkButton)e.Row.FindControl("lnkBtnDel");
                    l.Attributes.Add("onclick", "javascript:return " +
                    "confirm('Are you sure you want to delete this record " +
                    DataBinder.Eval(e.Row.DataItem, "ContainerID") + "')");
                }
                else
                {
                    LinkButton l = (LinkButton)e.Row.FindControl("lnkBtnDel");
                    l.Attributes.Add("onclick","javascript:return " + "alert('You cannot delete a row that does not have a containerID')");
                }
            }
        }
        protected void gvShipContainer_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            if (gvShipContainer.DataKeys[e.RowIndex].Value.ToString()!="")
            {
                int ID = (int)gvShipContainer.DataKeys[e.RowIndex].Value;
                String sp = "SP_SFund_ShipCntr_Del";
                SqlConnection con = new SqlConnection();
                con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
                SqlCommand spCmd = new SqlCommand(sp, con);
                spCmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                using (spCmd)
                {
                    try
                    {
                        spCmd.Parameters.AddWithValue("@CntrID", ID);
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
            }
        }
        protected void gvShipContainer_RowDeleted(object sender, GridViewDeletedEventArgs e)
        {

        }
    }
}