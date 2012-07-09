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


namespace IMDBWeb.Secure.SPAKpages
{

    public partial class Receiving : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //FormView1.ChangeMode(FormViewMode.Insert);
                //DateTime dt = DateTime.Now;
                //txbShipDate.Text = dt.ToShortDateString();
                //txbReceiveDate.Text = dt.ToShortDateString();
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
            //Label1.Text = Session["CurRcvHrdID"].ToString();
            this.mdlPopup.Show();
        }
        protected void btnClear_Click(object sender, EventArgs e)
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
            gvSearchResults.DataBind();
            return;
        }
        protected void btnEdit_Click(object sender, EventArgs e)
        {
            this.mdlPopup.Hide();
            DetailsView1.ChangeMode(DetailsViewMode.Edit);
            DetailsView1.Visible = true;

        }
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            //this.mdlPopup.Hide();
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
                    z = i;
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
                    break;
                case "Update":
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



    }
}
