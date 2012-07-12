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


namespace IMDBWeb.Secure.SPAKpages
{

    public partial class Receiving : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Label1.Text = "";
                Session["CurRcvHrdID"] = null;
                Session["CurClientName"] = null;
                Session["CurOrderNum"] = null;

            }
            

        }
        protected void txbOrderNum_OnTextChanged(object sender, EventArgs e)
        {
            txbClientName.Text = "";
            Session["CurOrderNum"] = txbOrderNum.Text;
            //Label1.Text = Session["CurOrderNum"].ToString();
        }
        protected void txbClientName_OnTextChanged(object sender, EventArgs e)
        {
            txbOrderNum.Text = "";
            Session["CurClientName"] = txbClientName.Text;
            //Label1.Text = Session["CurClientName"].ToString();
        }
        protected void gvSearchResults_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes.Add("onmouseover", "this.previous_color=this.style.backgroundColor;this.style.backgroundColor='#ceedfc'");
                e.Row.Attributes.Add("onmouseout", "this.style.backgroundColor=this.previous_color");
                e.Row.Attributes.Add("style", "cursor:pointer;");
                e.Row.Attributes.Add("onclick", ClientScript.GetPostBackClientHyperlink(this.gvSearchResults, "Select$" + e.Row.RowIndex));
            }

        }
        protected void sdsHdrList_OnSelecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            if (Session["CurRcvHrdID"] != null)
            {
                Session.Remove("CurClientName");
                Session.Remove("CurOrderNum");
            }
        }
        protected void gvSearchResults_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["CurRcvHrdID"] = gvSearchResults.SelectedDataKey.Value.ToString();
            Label1.Text = Session["CurRcvHrdID"].ToString();
            this.mdlPopup.Show();
        }
        protected void btnClear_Click(object sender, EventArgs e)
        {
            //gvSearchResults.SelectedIndex = -1;
            //Label1.Text = "";
            //label2.Text = "";
            //Label3.Text = "";
            txbClientName.Text = "";
            txbOrderNum.Text = "";
            //Session.Remove("CurClientName");
            //Session.Remove("CurOrderNum");
            //Session.Remove("CurRcvHrdID");
            //gvSearchResults.DataBind();
            //return;
            Session.Abandon();
            Response.Redirect(Request.RawUrl);
        }
        protected void btnEdit_Click(object sender, EventArgs e)
        {
            this.mdlPopup.Hide();
            DetailsView1.ChangeMode(DetailsViewMode.Edit);
            DetailsView1.Visible = true;

        }
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            this.mdlPopup.Hide();
            //label2.Text = "";
            //Label3.Text = "";
            gvRcvDetail.DataBind();
            DetailsView2.DataBind();
            DetailsView2.ChangeMode(DetailsViewMode.Insert);
            DetailsView2.Visible = true;
            //DetailsView1.ChangeMode(DetailsViewMode.Edit);
            //DetailsView1.Visible = true;

        }
        protected void btnOk_Click(object sender, EventArgs e)
        {
            label2.Text = "'";
            int z = -1;
            // Iterate through the Items collection of the CheckBoxList
            // control and display the selected items.
            for (int i = 0; i < CheckBoxList1.Items.Count; i++)
            {
                if (CheckBoxList1.Items[i].Selected)
                {
                    label2.Text += CheckBoxList1.Items[i].Text + "','";
                    z++;
                }
            }
            switch (z)
            {
                case -1:
                    Label3.Text = "You must select at least one Inbound Document Number";
                    label2.Text = null;
                    this.mdlPopup.Hide();
                    break;
                case 0:
                    Label3.Text = "Showing Inbound Document Number:  ";
                    label2.Text = label2.Text.Remove(label2.Text.Length - 2, 2);
                    this.mdlPopup.Hide();
                    break;
                default:
                    Label3.Text = "Showing Inbound Document Numbers:  ";
                    label2.Text = label2.Text.Remove(label2.Text.Length - 2, 2);
                    this.mdlPopup.Hide();
                    break;
            }
        }
        protected void txbClientName2_OnTextChanged(object sender, EventArgs e)
        {
            string curCntr = ((TextBox)DetailsView1.FindControl("txbClientName2")).Text;

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
                ((Label)DetailsView1.FindControl("lblClientID")).Text = isValid.ToString();
            }
            con.Close();
        }
        protected void txbTSDFName_OnTextChanged(object sender, EventArgs e)
        {
            string curCntr = ((TextBox)DetailsView1.FindControl("txbTSDFname")).Text;

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
                ((Label)DetailsView1.FindControl("lblTSDFID")).Text = isValid.ToString();
            }
            con.Close();
        }
        protected void txbCarrierName_OnTextChanged(object sender, EventArgs e)
        {
            string curCntr = ((TextBox)DetailsView1.FindControl("txbCarriername")).Text;

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
                ((Label)DetailsView1.FindControl("lblCarrierID")).Text = isValid.ToString();
            }
            con.Close();
        }
        protected void btnNewTruck_Click(object sender, EventArgs e)
        {
            gvSearchResults.SelectedIndex = -1;
            Label1.Text = "";
            label2.Text = "";
            Label3.Text = "";
            txbClientName.Text = "";
            txbOrderNum.Text = "";
            Session.Remove("CurClientName");
            Session.Remove("CurOrderNum");
            Session.Remove("CurRcvHrdID");
            DetailsView1.Visible = true;
            DetailsView1.DataBind();
        }
        protected void DetailsView1_ItemCommand(Object sender, DetailsViewCommandEventArgs e)
        {

            switch (e.CommandName)
            {
                case "Insert":
                    DetailsView1.Visible = false;
                    break;
                case "Cancel":
                    DetailsView1.Visible = false;
                    //gvSearchResults.DataBind();
                    break;
                case "Update":
                    DetailsView1.Visible = false;
                    //gvSearchResults.DataBind();
                    break;
                case "Delete":
                    DetailsView1.Visible = false;
                    //gvSearchResults.DataBind();
                    break;
            }

        }
        protected void SqlDataSource1_Inserted(Object sender, SqlDataSourceStatusEventArgs e)
        {
            Session["CurRcvHrdID"] = e.Command.Parameters["@id"].Value;
            gvSearchResults.DataBind();
            //Label1.Text = Session["CurRcvHrdID"].ToString();
        }
        protected void gvSearchResults_RowCommand(Object sender, GridViewCommandEventArgs e)
        {

            //    switch (e.CommandName)
            //    {
            //    case "Edit":
            //            Session["CurRcvHrdID"] = gvSearchResults.SelectedDataKey.Value.ToString();
            //            int index = Convert.ToInt32(e.CommandArgument);
            //            GridViewRow row = gvSearchResults.Rows[index];
            //            DetailsView1.DataBind();
            //            DetailsView1.Visible = true;
            //            DetailsView1.ChangeMode(DetailsViewMode.Edit);
            //            break;
            //        case "Cancel":
            //            DetailsView1.Visible = false;
            //            break;
            //    }

        }
        protected void SqlDataSource1_Updated(Object source, SqlDataSourceStatusEventArgs e)
        {
            gvSearchResults.DataBind();
        }
        protected void SqlDataSource1_Updating(Object sender, SqlDataSourceCommandEventArgs e)
        {
            e.Command.Parameters["@UserName"].Value = HttpContext.Current.User.Identity.Name.ToString();
        }
        protected void DetailsView2_ItemCommand(Object sender, DetailsViewCommandEventArgs e)
        {

            switch (e.CommandName)
            {
                case "Insert":
                    DetailsView2.Visible = false;
                    break;
                case "Cancel":
                    DetailsView2.Visible = false;
                    break;
                case "Update":
                    DetailsView2.Visible = false;
                    //gvSearchResults.DataBind();
                    gvRcvDetail.DataBind();
                    //gvSearchResults.DataBind();
                    break;
                case "Duplicate":
                    String sp = "IMDB_DupeDetail_Ins";
                    SqlConnection con = new SqlConnection();
                    con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
                    SqlCommand spCmd = new SqlCommand(sp, con);
                    spCmd.CommandType = CommandType.StoredProcedure;
                    con.Open();
                    using (spCmd)
                    {
                        try
                        {
                            spCmd.Parameters.AddWithValue("@InboundDocNo", ((TextBox)DetailsView2.FindControl("txbInboundDoc")).Text);
                            spCmd.Parameters.AddWithValue("@ManifestLineNumber", Convert.ToInt32(((TextBox)DetailsView2.FindControl("txbLineNo")).Text));
                            spCmd.Parameters.AddWithValue("@RcvHdrID", Session["CurRcvHrdID"]);
                            spCmd.Parameters.AddWithValue("@InboundProfileID", Convert.ToInt32(((DropDownList)DetailsView2.FindControl("ddProfile")).Text));
                            spCmd.Parameters.AddWithValue("@InboundPalletType", ((DropDownList)DetailsView2.FindControl("ddPalletType")).Text);
                            spCmd.Parameters.AddWithValue("@InboundPalletWeight", Convert.ToInt32(((TextBox)DetailsView2.FindControl("txbPalletWeight")).Text));
                            spCmd.Parameters.AddWithValue("@InboundContainerQty", Convert.ToInt32(((TextBox)DetailsView2.FindControl("txbContainerQty")).Text));
                            spCmd.Parameters.AddWithValue("@InboundContainerType", ((DropDownList)DetailsView2.FindControl("ddContainerTyper")).Text);
                            spCmd.Parameters.AddWithValue("@InboundContainerID", ((TextBox)DetailsView2.FindControl("txbContainerID")).Text);
                            spCmd.Parameters.AddWithValue("@InventoryLocation", ((DropDownList)DetailsView2.FindControl("ddLocation")).Text);
                            spCmd.Parameters.AddWithValue("@BrandCode", Convert.ToInt64(((DropDownList)DetailsView2.FindControl("ddBrandCodes")).Text));
                            spCmd.Parameters.AddWithValue("@column1", ((CheckBox)DetailsView2.FindControl("cbProcess")).Checked);
                            spCmd.Parameters.AddWithValue("@ProcessPlan", ((DropDownList)DetailsView2.FindControl("ddProcessPlan")).Text);
                            spCmd.Parameters.AddWithValue("@RcvdAs", ((DropDownList)DetailsView2.FindControl("ddRecAs")).Text);
                            spCmd.Parameters.AddWithValue("@UserName", HttpContext.Current.User.Identity.Name.ToString());
                            spCmd.ExecuteNonQuery();

                        }
                        catch 
                        {
                            
                        }
                        finally
                        {
                            con.Close();
                            DetailsView2.Visible = false;
                            gvRcvDetail.DataBind();
                              

                            //ddCompany.SelectedIndex = 0;
                            //btnAddCntr.Enabled = true;
                            //btnGo.Visible = false;
                            //lblInstructions.Text = "";
                        }
                    }
                    break;
                    //gvGridLoc.SelectedIndex = 0;
                    //gvGridLoc_SelectedIndexChanged(null, null);
               }
        }
        protected void SqlDataSource2_Inserted(Object source, SqlDataSourceStatusEventArgs e)
        {
            gvSearchResults.DataBind();
            UpdatePanel1.DataBind();
            gvRcvDetail.DataBind();
        }
        protected void sdsRcvDetail_Sel_Ondeleted(Object source, SqlDataSourceStatusEventArgs e)
        {
            //Label3.Text = "";
            //label2.Text = "";
            //Session.Remove("curDetailID");
            gvSearchResults.DataBind();
            UpdatePanel1.DataBind();
            this.mdlPopup.Show();
        }
        protected void SqlDataSource2_Inserting(Object sender, SqlDataSourceCommandEventArgs e)
        {
            //label2.Text = e.Command.Parameters["@InboundDocNo"].Value.ToString();
            //Label3.Text = "Showing Inbound Document Number:  ";
            label2.Text = "'" + ((TextBox)DetailsView2.FindControl("txbInboundDoc")).Text + "'";
        }
        protected void gvRcvDetail_RowCommand(object sender, GridViewCommandEventArgs e)    
        {      
            switch (e.CommandName)
            {
                case "EditDetail":
                    int index = Int32.Parse(e.CommandArgument.ToString());
                    Session["CurDetailID"] = index;
                    DetailsView2.ChangeMode(DetailsViewMode.Edit);
                    //Label3.Text = Session["CurDetailID"].ToString() ;
                    //DetailsView2.ChangeMode(DetailsViewMode.Edit);
                    DetailsView2.Visible = true;
                    break;
                case "DupeDetail":
                    Session["CurDetailID"] = Int32.Parse(e.CommandArgument.ToString());
                    //DetailsView2.DataBind();
                    DetailsView2.ChangeMode(DetailsViewMode.ReadOnly);
                    DetailsView2.Visible = true;
                    //TextBox Control = (TextBox)DetailsView2.FindControl("txbContainerID");
                    //Control.Text = "";
                    break;
            }

         }
        protected void gvRcvDetail_SelectedIndexChanged(object sender, EventArgs e)
        {
            //Label3.Text = gvRcvDetail.SelectedDataKey.Value.ToString();
            //Session["CurRcvHrdID"] = gvSearchResults.SelectedDataKey.Value.ToString();
            //Label1.Text = Session["CurRcvHrdID"].ToString();
            //this.mdlPopup.Show();
        }
        protected void SqlDataSource3_Updated(Object source, SqlDataSourceStatusEventArgs e)
        {
            gvRcvDetail.DataBind();
        }
        protected void SqlDataSource3_Inserted(Object source, SqlDataSourceStatusEventArgs e)
        {
            gvSearchResults.DataBind();
            UpdatePanel1.DataBind();
            //gvRcvDetail.DataBind();
            
        }
        protected void SqlDataSource3_Inserting(Object source, SqlDataSourceCommandEventArgs e)
        {
            Label3.Text = "Showing Inbound Document Number:  "; 
            label2.Text = "'" + ((TextBox)DetailsView2.FindControl("txbInboundDoc")).Text + "'";
        }
        
     }
}
