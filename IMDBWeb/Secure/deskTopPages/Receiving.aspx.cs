using System;
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


namespace IMDBWeb.Secure.SPAKpages
{
    public partial class Receiving : System.Web.UI.Page
    {
// Page Load
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //Label1.Text = "";
                Session["CurRcvHrdID"] = null;
                Session["CurClientName"] = null;
                Session["CurOrderNum"] = null;
            }
        }
        
// Order Number Change
        protected void txbOrderNum_OnTextChanged(object sender, EventArgs e)
        {
            txbClientName.Text = "";
            Session["CurOrderNum"] = txbOrderNum.Text;
        }

// Client Change
        protected void txbClientName_OnTextChanged(object sender, EventArgs e)
        {
            txbOrderNum.Text = "";
            Session["CurClientName"] = txbClientName.Text;
        }

// Add Truck, Add InboundDoc & Clear Buttons
        protected void btnNewTruck_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            txbClientName.Text = "";
            txbOrderNum.Text = "";
            dvHdrDetail.Visible = true;
            //trClient.Visible = false;
            //trOrder.Visible = false;
            //gvHdrList.SelectedIndex = -1;
            //Label1.Text = "";
            //label2.Text = "";
            //Label3.Text = "";
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
            //dvContainerDetail.Visible = true;
            this.ModalPopupExtender1.Show();            
        }
// Search Results Grid View Truck/Header view
        protected void sdsHdrList_OnSelecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            if (Session["CurRcvHrdID"] != null)
            {
                Session.Remove("CurClientName");
                Session.Remove("CurOrderNum");
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
            btnAddDoc.Visible = true;
            //this.mdlPopup.Show();
            //Label1.Text = Session["CurRcvHrdID"].ToString();
        }
        
// Pop Up
        //protected void btnEdit_Click(object sender, EventArgs e)
        //{
        //    dvHdrDetail.ChangeMode(DetailsViewMode.Edit);
        //    //dvHdrDetail.Visible = true;
        //    //btnAddContainer.Visible = true;
        //    //this.mdlPopup.Hide();
        //        }
        //protected void btnAdd_Click(object sender, EventArgs e)
        //{
        //    //this.mdlPopup.Hide();
        //    ////gvContainerList.DataBind();
        //    //dvContainerDetail.DataBind();
        //    ////dvContainerDetail.FindControl("ddInboundDoc").Visible = false;
        //    ////dvContainerDetail.FindControl("txbInboundDoc").Visible = true;
        //    //dvContainerDetail.ChangeMode(DetailsViewMode.Insert);
        //    //dvContainerDetail.Visible = true;
        //    //this.ModalPopupExtender1.Show();
        //    //btnAddContainer.Visible = true;
        //}
        //protected void btnOk_Click(object sender, EventArgs e)
        //{
        //    //btnAddContainer.Visible = true;
        //    //label2.Text = "'";
        //    //int z = -1;
        //    // Iterate through the Items collection of the CheckBoxList
        //    // control and display the selected items.
        //    //for (int i = 0; i < CheckBoxList1.Items.Count; i++)
        //    //{
        //    //    if (CheckBoxList1.Items[i].Selected)
        //    //    {
        //    //       label2.Text += CheckBoxList1.Items[i].Text + "','";
        //    //        z++;
        //    //    }
        //    //}
        //    //switch (z)
        //    //{
        //    //    case -1:
        //    //        Label3.Text = "You must select at least one Inbound Document Number";
        //    //        label2.Text = null;
        //    //        this.mdlPopup.Hide();
        //    //       break;
        //    //    case 0:
        //    //        Label3.Text = "Showing Inbound Document Number:  ";
        //    //        label2.Text = label2.Text.Remove(label2.Text.Length - 2, 2);
        //    //        this.mdlPopup.Hide();
        //    //        break;
        //    //    default:
        //    //        Label3.Text = "Showing Inbound Document Numbers:  ";
        //    //        label2.Text = label2.Text.Remove(label2.Text.Length - 2, 2);
        //    //        this.mdlPopup.Hide();
        //    //        break;
        //    //}
        //}

// Inbound Docs / Receive Detail View
        protected void gvContainerList_RowCommand(object sender, GridViewCommandEventArgs e)    
        {      
            switch (e.CommandName)
            {
                case "EditDetail":
                    int index = Int32.Parse(e.CommandArgument.ToString());
                    Session["CurDetailID"] = index;
                    dvContainerDetail.ChangeMode(DetailsViewMode.Edit);
                    //dvContainerDetail.Visible = true;
                    this.ModalPopupExtender1.Show();
                    break;
                case "DupeDetail":
                    Session["CurDetailID"] = Int32.Parse(e.CommandArgument.ToString());
                    dvContainerDetail.DataBind();
                    dvContainerDetail.ChangeMode(DetailsViewMode.ReadOnly);
                    //dvContainerDetail.Visible = true;
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
            //UpdatepnlContainerDetail.DataBind();
            //this.mdlPopup.Show();
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
                    //trClient.Visible = true;
                    //trOrder.Visible = true;
                    break;
                case "Cancel":
                    dvHdrDetail.Visible = false;
                    //trClient.Visible = true;
                    //trOrder.Visible = true;
                    //Response.Redirect(Request.RawUrl);
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

            String sp = "IMDB_GetBrandCodeIDs_Sel";
            SqlConnection con = new SqlConnection();
            con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
            SqlCommand spCmd = new SqlCommand(sp, con);
            spCmd.CommandType = CommandType.StoredProcedure;
            con.Open();
            using (spCmd)
            {
                spCmd.Parameters.AddWithValue("@Product", curCntr);
                object isValid = new object();
                isValid = spCmd.ExecuteScalar();
                ((Label)dvContainerDetail.FindControl("lblBrandCodeID")).Text = isValid.ToString();
            }
            con.Close();
        }
        //protected void ddInboundDoc_OnTextChanged(object sender, EventArgs e)
        //{
        //    var mVal = ((DropDownList)dvContainerDetail.FindControl("ddInboundDoc")).Text;
        //    ((TextBox)dvContainerDetail.FindControl("txbInboundDoc")).Text = mVal;
        //    Session["CurOrderNum"] = txbOrderNum.Text;
        //}

        protected void dvContainerDetail_ItemCommand(Object sender, DetailsViewCommandEventArgs e)
        {

            switch (e.CommandName)
            {
                case "Insert":
                    //dvContainerDetail.Visible = false;
                    if (Label1.Text == "Doc")
                    {
                        Session["CurInboundDocNo"] = ((TextBox)dvContainerDetail.FindControl("txbInboundDoc")).Text;
                        //Session["CurInboundDocNo"] = ((TextBox)pnlContainerDetail.FindControl("txbInboundDoc")).Text;
                        Label1.Text = Session["CurInboundDoc"].ToString();
                    }
                    this.ModalPopupExtender1.Hide();
                    break;
                case "Cancel":
                    //dvContainerDetail.Visible = false;
                    this.ModalPopupExtender1.Hide();
                    break;
                case "Update":
                    dvContainerDetail.Visible = false;
                    //gvContainerList.DataBind();
                    this.ModalPopupExtender1.Hide();
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
                            spCmd.Parameters.AddWithValue("@column1", ((CheckBox)dvContainerDetail.FindControl("cbProcess")).Checked);
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
                            dvContainerDetail.Visible = false;
                            upDocList.DataBind();
                            this.ModalPopupExtender1.Hide();
                        }
                    }
                    break;
               }
        }
        protected void sdsContainerDetail_Updated(Object source, SqlDataSourceStatusEventArgs e)
        {
            upDocList.DataBind();
        }
        protected void sdsContainerDetail_Inserted(Object source, SqlDataSourceStatusEventArgs e)
        {
            gvHdrList.DataBind();
            upContainerDetail.DataBind();
            upDocList.DataBind();

        }
        //protected void sdsContainerDetail_Inserting(Object source, SqlDataSourceCommandEventArgs e)
        //{
        //    //Label3.Text = "Showing Inbound Document Number:  "; 
        //    //label2.Text = "'" + ((TextBox)dvContainerDetail.FindControl("txbInboundDoc")).Text + "'";
        //}
        protected void dvContainerDetail_OnDataBound(Object sender, EventArgs e)
        {
            

        }
        
        protected void gvSubCatDocs_RowCreated(object sender, GridViewRowEventArgs e)
        {
            
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
     }
}
