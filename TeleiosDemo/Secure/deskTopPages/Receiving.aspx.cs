﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Drawing.Printing;
using System.Text;
using System.Collections;
using System.Web.Services;


namespace TeleiosDemo.Secure.SPAKpages
{
    public partial class Receiving : System.Web.UI.Page
    {
        // Page Load
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session.Abandon();
            }
        }

        // Order Number Change
        protected void txbOrderNum_OnTextChanged(object sender, EventArgs e)
        {
            Session.Abandon();
            txbClientName.Text = "";
            Session["CurOrderNum"] = txbOrderNum.Text;
        }

        // Client Change
        protected void txbClientName_OnTextChanged(object sender, EventArgs e)
        {
            Session.Abandon();
            txbOrderNum.Text = "";
            Session["CurClientName"] = txbClientName.Text;
        }

        //Beginning Date Rage Changed
        protected void txbBegDate_OnTextChanged(object sender, EventArgs e)
        {
            Session["CurBegDate"] = txbBegDate.Text;
        }

        //Ending Date Rage Changed
        protected void txbEndDate_OnTextChanged(object sender, EventArgs e)
        {
            Session["CurEndDate"] = txbEndDate.Text;
        }

        // Add Truck, Add InboundDoc & Clear Buttons
        protected void btnNewTruck_Click(object sender, EventArgs e)
        {
            txbClientName.Text = "";
            txbOrderNum.Text = "";
            Session.Abandon();
            dvHdrDetail.Visible = true;
        }
        protected void btnClear_Click(object sender, EventArgs e)
        {
            txbClientName.Text = "";
            txbOrderNum.Text = "";
            Session.Abandon();
            Response.Redirect(Request.RawUrl);
        }
        protected void btnAddDoc_Click(object sender, EventArgs e)
        {
            Label1.Text = "Doc";
            dvContainerDetail.DataBind();
            dvContainerDetail.ChangeMode(DetailsViewMode.Insert);
            dvContainerDetail.Visible = true;
            this.ModalPopupExtender1.Show();
        }
        protected void btnAddContainer_Click(object sender, EventArgs e)
        {
            LinkButton selected = sender as LinkButton;
            Session["CurInboundDocNo"] = selected.Text.ToString();
            Label1.Text = "Con";
            dvContainerDetail.DataBind();
            dvContainerDetail.ChangeMode(DetailsViewMode.Insert);
            this.ModalPopupExtender1.Show();
        }

        // Search Results Grid View Truck/Header view
        protected void sdsHdrList_OnSelecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            if (Session["CurRcvHrdID"] != null)
            {
                Session.Remove("CurClientName");
                Session.Remove("CurOrderNum");
                Session.Remove("CurBegDate");
                Session.Remove("CurEndDate");
                gvSubCatDocs.DataBind();
            }
        }

        protected void gvHdrList_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes.Add("onmouseover", "this.previous_color=this.style.backgroundColor;this.style.backgroundColor='#ceedfc'");
                e.Row.Attributes.Add("onmouseout", "this.style.backgroundColor=this.previous_color");
                e.Row.Attributes.Add("style", "cursor:pointer;");
                e.Row.Attributes.Add("onclick", ClientScript.GetPostBackClientHyperlink(this.gvHdrList, "Select$" + e.Row.RowIndex));
            }
        }

        protected void gvHdrList_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["CurRcvHrdID"] = gvHdrList.SelectedDataKey.Value.ToString();
        }

        // Inbound Docs / Receive Detail View
        protected void gvContainerList_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case "EditDetail":
                    int index = Int32.Parse(e.CommandArgument.ToString());
                    Session["CurDetailID"] = index;
                    dvContainerDetail.ChangeMode(DetailsViewMode.Edit);
                    this.ModalPopupExtender1.Show();
                    break;
                case "DupeDetail":
                    Session["CurDetailID"] = Int32.Parse(e.CommandArgument.ToString());
                    dvContainerDetail.DataBind();
                    dvContainerDetail.ChangeMode(DetailsViewMode.ReadOnly);
                    TextBox tbCustomerID = dvContainerDetail.FindControl("txbInboundDoc") as TextBox;
                    tbCustomerID.Focus();
                    this.ModalPopupExtender1.Show();
                    break;
            }

        }
        protected void sdsContainerList_Ondeleted(Object source, SqlDataSourceStatusEventArgs e)
        {
            gvHdrList.DataBind();
            upDocList.DataBind();
        }


        // Details View 1 Header/Truck Details, Adding, & Editing

        // Updates bound fields after using Autocomplete to select
        protected void txbClientName2_OnTextChanged(object sender, EventArgs e)
        {
            string curCntr = ((TextBox)dvHdrDetail.FindControl("txbClientName2")).Text;
            String sp = "IMDB_Rcv_GetID_Sel";
            SqlConnection con = new SqlConnection();
            con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
            SqlCommand spCmd = new SqlCommand(sp, con);
            spCmd.CommandType = CommandType.StoredProcedure;
            con.Open();
            using (spCmd)
            {
                spCmd.Parameters.AddWithValue("@Client", curCntr);
                object isValid = new object();
                isValid = spCmd.ExecuteScalar();
                ((Label)dvHdrDetail.FindControl("lblClientID")).Text = isValid.ToString();
            }
            con.Close();
        }
        protected void txbTSDFName_OnTextChanged(object sender, EventArgs e)
        {
            string curCntr = ((TextBox)dvHdrDetail.FindControl("txbTSDFname")).Text;

            String sp = "IMDB_Rcv_TSDFID_Sel";
            SqlConnection con = new SqlConnection();
            con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
            SqlCommand spCmd = new SqlCommand(sp, con);
            spCmd.CommandType = CommandType.StoredProcedure;
            con.Open();
            using (spCmd)
            {
                spCmd.Parameters.AddWithValue("@TSDF", curCntr);
                object isValid = new object();
                isValid = spCmd.ExecuteScalar();
                ((Label)dvHdrDetail.FindControl("lblTSDFID")).Text = isValid.ToString();
            }
            con.Close();
        }
        protected void txbCarrierName_OnTextChanged(object sender, EventArgs e)
        {
            string curCntr = ((TextBox)dvHdrDetail.FindControl("txbCarriername")).Text;

            String sp = "IMDB_Rcv_CarrierID_Sel";
            SqlConnection con = new SqlConnection();
            con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
            SqlCommand spCmd = new SqlCommand(sp, con);
            spCmd.CommandType = CommandType.StoredProcedure;
            con.Open();
            using (spCmd)
            {
                spCmd.Parameters.AddWithValue("@Carrier", curCntr);
                object isValid = new object();
                isValid = spCmd.ExecuteScalar();
                ((Label)dvHdrDetail.FindControl("lblCarrierID")).Text = isValid.ToString();
            }
            con.Close();
        }


        protected void dvHdrDetail_ItemCommand(Object sender, DetailsViewCommandEventArgs e)
        {

            switch (e.CommandName)
            {
                case "Insert":
                    dvHdrDetail.Visible = false;
                    break;
                case "Cancel":
                    dvHdrDetail.Visible = false;
                    break;
                case "Update":
                    dvHdrDetail.Visible = false;
                    break;
                case "Delete":
                    dvHdrDetail.Visible = false;
                    upDocList.DataBind();
                    break;
            }

        }
        protected void dvHdrDetail_OnDataBound(object sender, EventArgs e)
        {
            TextBox txb = (TextBox)dvHdrDetail.FindControl("txbOrderNumber");
            ScriptManager.GetCurrent(this).SetFocus(txb);

        }
        protected void sdsHdrDetail_Inserted(Object sender, SqlDataSourceStatusEventArgs e)
        {
            Session["CurRcvHrdID"] = e.Command.Parameters["@id"].Value;
            gvHdrList.DataBind();
        }
        protected void sdsHdrDetail_Updated(Object source, SqlDataSourceStatusEventArgs e)
        {
            gvHdrList.DataBind();
        }
        protected void sdsHdrDetail_Updating(Object sender, SqlDataSourceCommandEventArgs e)
        {
            e.Command.Parameters["@UserName"].Value = HttpContext.Current.User.Identity.Name.ToString();
        }

        // Details View 2 Inbound Doc Details, Adding & Editing 

        // Updates bound fields after using Autocomplete to select
        protected void txbBrandCodes_OnTextChanged(object sender, EventArgs e)
        {
            string curCntr = ((TextBox)dvContainerDetail.FindControl("txbBrandCodes")).Text;

            String sp = "IMDB_Rcv_GetBrandCodeIDs_Sel";
            SqlConnection con = new SqlConnection();
            con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
            SqlCommand spCmd = new SqlCommand(sp, con);
            spCmd.CommandType = CommandType.StoredProcedure;
            con.Open();
            spCmd.Parameters.AddWithValue("@Product", curCntr);
            SqlDataReader rdr = spCmd.ExecuteReader();
            while (rdr.Read())
            {
                ((Label)dvContainerDetail.FindControl("lblBrandCodeID")).Text = rdr["cid"].ToString();
                curCntr = rdr["cid"].ToString();
                ((DropDownList)dvContainerDetail.FindControl("ddProfile")).SelectedValue = rdr["pid"].ToString();
            }
            rdr.Close();
            con.Close();
            ((DropDownList)dvContainerDetail.FindControl("ddRecAs")).Focus();


            String sp1 = "IMDB_Rcv_GetProcessPlan_Sel";
            SqlConnection con1 = new SqlConnection();
            con1.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
            SqlCommand spCmd1 = new SqlCommand(sp1, con1);
            spCmd1.CommandType = CommandType.StoredProcedure;
            con1.Open();
            spCmd1.Parameters.AddWithValue("@BrandCodeID", curCntr);
            SqlDataReader rdr1 = spCmd1.ExecuteReader();
            while (rdr1.Read())
            {
                curCntr = rdr1["pp"].ToString();
                
                if (string.IsNullOrEmpty(curCntr)== true)
                {
                    curCntr = "Select...";
                }
                ((DropDownList)dvContainerDetail.FindControl("ddProcessPlan")).SelectedValue = curCntr;
            }
            rdr1.Close();
            con1.Close();

        }
        protected void txbContainerID_OnTextChanged(object sender, EventArgs e)
        {
            string curCntr = ((TextBox)dvContainerDetail.FindControl("txbContainerID")).Text;
            String sp = "IMDB_Rcv_InboundContainerID_Exist";
            SqlConnection con = new SqlConnection();
            con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
            SqlCommand spCmd = new SqlCommand(sp, con);
            spCmd.CommandType = CommandType.StoredProcedure;
            con.Open();
            using (spCmd)
            {
                spCmd.Parameters.AddWithValue("@InboundContainerID", curCntr);
                object isValid = new object();
                isValid = spCmd.ExecuteScalar();
                if (isValid != null)
                {
                    ((Label)dvContainerDetail.FindControl("label6")).Visible = true;
                    ((Label)dvContainerDetail.FindControl("label6")).Text = "Container ID muct be Unique";
                    ((TextBox)dvContainerDetail.FindControl("txbContainerID")).Text = string.Empty;
                    ((TextBox)dvContainerDetail.FindControl("txbContainerID")).Focus();
                }
                else
                {
                    ((Label)dvContainerDetail.FindControl("label6")).Visible = false;
                    ((TextBox)dvContainerDetail.FindControl("txbLineNo")).Focus();
                }
            }
            con.Close();
        }

        protected void dvContainerDetail_ItemCommand(Object sender, DetailsViewCommandEventArgs e)
        {

            switch (e.CommandName)
            {
                case "myInsert":
                    if (Label1.Text == "Doc")
                    {
                        String sp = "IMDB_Rcv_DupeDetail_Ins";
                        SqlConnection con = new SqlConnection();
                        con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
                        SqlCommand spCmd = new SqlCommand(sp, con);
                        spCmd.CommandType = CommandType.StoredProcedure;
                        con.Open();
                        using (spCmd)
                        {
                            try
                            {
                                spCmd.Parameters.AddWithValue("@InboundDocNo", ((TextBox)dvContainerDetail.FindControl("txbInboundDoc")).Text);
                                spCmd.Parameters.AddWithValue("@ManifestLineNumber", Convert.ToInt32(((TextBox)dvContainerDetail.FindControl("txbLineNo")).Text));
                                spCmd.Parameters.AddWithValue("@RcvHdrID", Session["CurRcvHrdID"]);
                                spCmd.Parameters.AddWithValue("@InboundProfileID", Convert.ToInt32(((DropDownList)dvContainerDetail.FindControl("ddProfile")).Text));
                                spCmd.Parameters.AddWithValue("@InboundPalletType", ((DropDownList)dvContainerDetail.FindControl("ddPalletType")).Text);
                                spCmd.Parameters.AddWithValue("@InboundPalletWeight", Convert.ToInt32(((TextBox)dvContainerDetail.FindControl("txbPalletWeight")).Text));
                                spCmd.Parameters.AddWithValue("@InboundContainerQty", Convert.ToInt32(((TextBox)dvContainerDetail.FindControl("txbContainerQty")).Text));
                                spCmd.Parameters.AddWithValue("@InboundContainerType", ((DropDownList)dvContainerDetail.FindControl("ddContainerTyper")).Text);
                                spCmd.Parameters.AddWithValue("@InboundContainerID", ((TextBox)dvContainerDetail.FindControl("txbContainerID")).Text);
                                spCmd.Parameters.AddWithValue("@InventoryLocation", ((DropDownList)dvContainerDetail.FindControl("ddLocation")).Text);
                                spCmd.Parameters.AddWithValue("@BrandCode", ((Label)dvContainerDetail.FindControl("lblBrandCodeID")).Text);
                                spCmd.Parameters.AddWithValue("@ProcessPlan", ((DropDownList)dvContainerDetail.FindControl("ddProcessPlan")).Text);
                                spCmd.Parameters.AddWithValue("@RcvdAs", ((DropDownList)dvContainerDetail.FindControl("ddRecAs")).Text);
                                spCmd.Parameters.AddWithValue("@UserName", HttpContext.Current.User.Identity.Name.ToString());
                                spCmd.ExecuteNonQuery();

                            }
                            catch
                            {

                            }
                            finally
                            {
                                con.Close();
                                this.ModalPopupExtender1.Hide();
                                gvHdrList.DataBind();
                                upContainerDetail.DataBind();
                                upDocList.DataBind();
                                gvSubCatDocs.DataBind();
                            }
                        }

                    }
                    else
                    {
                        String sp = "IMDB_Rcv_DupeDetail_Ins";
                        SqlConnection con = new SqlConnection();
                        con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
                        SqlCommand spCmd = new SqlCommand(sp, con);
                        spCmd.CommandType = CommandType.StoredProcedure;
                        con.Open();
                        using (spCmd)
                        {
                            try
                            {
                                spCmd.Parameters.AddWithValue("@InboundDocNo", Session["CurInboundDocNo"]);
                                spCmd.Parameters.AddWithValue("@ManifestLineNumber", Convert.ToInt32(((TextBox)dvContainerDetail.FindControl("txbLineNo")).Text));
                                spCmd.Parameters.AddWithValue("@RcvHdrID", Session["CurRcvHrdID"]);
                                spCmd.Parameters.AddWithValue("@InboundProfileID", Convert.ToInt32(((DropDownList)dvContainerDetail.FindControl("ddProfile")).Text));
                                spCmd.Parameters.AddWithValue("@InboundPalletType", ((DropDownList)dvContainerDetail.FindControl("ddPalletType")).Text);
                                spCmd.Parameters.AddWithValue("@InboundPalletWeight", Convert.ToInt32(((TextBox)dvContainerDetail.FindControl("txbPalletWeight")).Text));
                                spCmd.Parameters.AddWithValue("@InboundContainerQty", Convert.ToInt32(((TextBox)dvContainerDetail.FindControl("txbContainerQty")).Text));
                                spCmd.Parameters.AddWithValue("@InboundContainerType", ((DropDownList)dvContainerDetail.FindControl("ddContainerTyper")).Text);
                                spCmd.Parameters.AddWithValue("@InboundContainerID", ((TextBox)dvContainerDetail.FindControl("txbContainerID")).Text);
                                spCmd.Parameters.AddWithValue("@InventoryLocation", ((DropDownList)dvContainerDetail.FindControl("ddLocation")).Text);
                                spCmd.Parameters.AddWithValue("@BrandCode", ((Label)dvContainerDetail.FindControl("lblBrandCodeID")).Text);
                                spCmd.Parameters.AddWithValue("@ProcessPlan", ((DropDownList)dvContainerDetail.FindControl("ddProcessPlan")).Text);
                                spCmd.Parameters.AddWithValue("@RcvdAs", ((DropDownList)dvContainerDetail.FindControl("ddRecAs")).Text);
                                spCmd.Parameters.AddWithValue("@UserName", HttpContext.Current.User.Identity.Name.ToString());
                                spCmd.ExecuteNonQuery();

                            }
                            catch
                            {

                            }
                            finally
                            {
                                con.Close();
                                this.ModalPopupExtender1.Hide();
                                gvHdrList.DataBind();
                                upContainerDetail.DataBind();
                                upDocList.DataBind();
                                gvSubCatDocs.DataBind();

                            }
                        }
                    }
                    break;
                case "Cancel":
                    this.ModalPopupExtender1.Hide();
                    break;
                case "Update":
                    this.ModalPopupExtender1.Hide();
                    break;
                case "Duplicate":
                    String sp1 = "IMDB_Rcv_DupeDetail_Ins";
                    SqlConnection con1 = new SqlConnection();
                    con1.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
                    SqlCommand spCmd1 = new SqlCommand(sp1, con1);
                    spCmd1.CommandType = CommandType.StoredProcedure;
                    con1.Open();
                    using (spCmd1)
                    {
                        try
                        {
                            spCmd1.Parameters.AddWithValue("@InboundDocNo", ((TextBox)dvContainerDetail.FindControl("txbInboundDoc")).Text);
                            spCmd1.Parameters.AddWithValue("@ManifestLineNumber", Convert.ToInt32(((TextBox)dvContainerDetail.FindControl("txbLineNo")).Text));
                            spCmd1.Parameters.AddWithValue("@RcvHdrID", Session["CurRcvHrdID"]);
                            spCmd1.Parameters.AddWithValue("@InboundProfileID", Convert.ToInt32(((DropDownList)dvContainerDetail.FindControl("ddProfile")).Text));
                            spCmd1.Parameters.AddWithValue("@InboundPalletType", ((DropDownList)dvContainerDetail.FindControl("ddPalletType")).Text);
                            spCmd1.Parameters.AddWithValue("@InboundPalletWeight", Convert.ToInt32(((TextBox)dvContainerDetail.FindControl("txbPalletWeight")).Text));
                            spCmd1.Parameters.AddWithValue("@InboundContainerQty", Convert.ToInt32(((TextBox)dvContainerDetail.FindControl("txbContainerQty")).Text));
                            spCmd1.Parameters.AddWithValue("@InboundContainerType", ((DropDownList)dvContainerDetail.FindControl("ddContainerTyper")).Text);
                            spCmd1.Parameters.AddWithValue("@InboundContainerID", ((TextBox)dvContainerDetail.FindControl("txbContainerID")).Text);
                            spCmd1.Parameters.AddWithValue("@InventoryLocation", ((DropDownList)dvContainerDetail.FindControl("ddLocation")).Text);
                            spCmd1.Parameters.AddWithValue("@BrandCode", ((Label)dvContainerDetail.FindControl("lblBrandCodeID")).Text);
                            spCmd1.Parameters.AddWithValue("@ProcessPlan", ((DropDownList)dvContainerDetail.FindControl("ddProcessPlan")).Text);
                            spCmd1.Parameters.AddWithValue("@RcvdAs", ((DropDownList)dvContainerDetail.FindControl("ddRecAs")).Text);
                            spCmd1.Parameters.AddWithValue("@UserName", HttpContext.Current.User.Identity.Name.ToString());
                            spCmd1.ExecuteNonQuery();

                        }
                        catch
                        {

                        }
                        finally
                        {
                            con1.Close();
                            this.ModalPopupExtender1.Hide();
                            gvHdrList.DataBind();
                            upContainerDetail.DataBind();
                            upDocList.DataBind();

                        }
                    }
                    break;
            }
        }
        protected void sdsContainerDetail_Updated(Object source, SqlDataSourceStatusEventArgs e)
        {
            upDocList.DataBind();
            gvSubCatDocs.DataBind();
        }
        protected void sdsContainerDetail_Inserted(Object source, SqlDataSourceStatusEventArgs e)
        {

        }

        protected void gvSubCatDocs_RowCreated(object sender, GridViewRowEventArgs e)
        {
            btnAddDoc.Visible = true;
            Label5.Visible = true;
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                SqlDataSource ctrl = e.Row.FindControl("sdsContainerList") as SqlDataSource;
                if (ctrl != null && e.Row.DataItem != null)
                {
                    ctrl.SelectParameters["InboundDocNo"].DefaultValue =
                        gvSubCatDocs.DataKeys[e.Row.RowIndex].Value.ToString();
                }
            }
        }

        [WebMethod(EnableSession = true)]
        public static string GetInboundDoc()
        {
            if (HttpContext.Current.Session["CurInboundDocNo"] != null)
            {
                var CD = HttpContext.Current.Session["CurInboundDocNo"].ToString();
                return CD;
            }
            else
            {
                return "";
            }
        }

    }
}