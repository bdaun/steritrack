using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

namespace IMDBWeb.Secure.deskTopPages
{
    public partial class Receiving2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblTruckMsg.Visible = false;
                tblSearch.Visible = false;
                tblBegin.Visible = true;
                trContainerDetails.Visible = false;
            }
        }

        protected void btnSearchTruck_Click(object sender, EventArgs e)
        {
            tblSearch.Visible = true;
            tblBegin.Visible = false;
        }

        protected void btnCancelSearch_Click(object sender, EventArgs e)
        {
            tblBegin.Visible = true;
            tblSearch.Visible = false;
        }

        protected void ddClient_SelectedIndexChanged(object sender, EventArgs e)
        {
            gvRcvHdr.SelectedIndex = -1;
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            gvRcvHdr.DataBind();
            if (gvRcvHdr.Rows.Count > 0)
            {
                lblTruckMsg.Visible = true;
            }
            else
            {
                lblTruckMsg.Visible = false;
            }
        }

        protected void gvRcvHdr_DataBound(object sender, EventArgs e)
        {
            if (gvRcvHdr.Rows.Count > 0)
            {
                lblTruckMsg.Visible = true;
                if (gvRcvHdr.SelectedIndex == -1)
                {
                    lblTruckMsg.Text = "Click on a row from the available trucks to manage containers";
                }  
                else if(gvRcvHdr.SelectedIndex > 0)
                {
                    lblTruckMsg.Text = "Showing Containers for this truck ";
                }
            }
            else
            {
                lblTruckMsg.Visible = false;
            }
        }

        protected void gvRcvHdr_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes.Add("onmouseover", "this.previous_color=this.style.backgroundColor;this.style.backgroundColor='#ceedfc'");
                e.Row.Attributes.Add("onmouseout", "this.style.backgroundColor=this.previous_color");
                e.Row.Attributes.Add("style", "cursor:pointer;");
                e.Row.Attributes.Add("onclick", ClientScript.GetPostBackClientHyperlink(this.gvRcvHdr, "Select$" + e.Row.RowIndex));
            }
        }
        protected void gvRcvHdr_SelectedIndexChanged(object sender, EventArgs e)
        {
            trAddContainers.Visible = true;
            trContainerDetails.Visible = true;
            tblSearch.Visible = false;
            Session["CurRcvHdrID"] = gvRcvHdr.SelectedDataKey.Value.ToString();
            txbOrderNumber.Text = "";
            ddClient.SelectedIndex = 0;
            gvRcvHdr.DataBind();
            gvContainers.DataBind();
        }
        protected void btnDone_Click(object sender, EventArgs e)
        {
            trAddContainers.Visible = false;
            tdContainerEdit.Visible = false;
            tblSearch.Visible = false;
            tblBegin.Visible = true;
            ddClient.SelectedIndex = 0;
            txbOrderNumber.Text = string.Empty;
            Session["CurRcvHdrID"] = 0;
            gvRcvHdr.DataBind();
            Session.Abandon();
        }

        protected void btnAddContainer_Click(object sender, EventArgs e)
        {
            trContainerDetails.Visible = true;
            tdContainerEdit.Visible = true;
            fvContainerDetail.ChangeMode(FormViewMode.Insert);
        }
        protected void InsCancel_Click(object sender, EventArgs e)
        {
            tdContainerEdit.Visible = false;
        }

        protected void fvContainerDetailsIns_Click(object sender, EventArgs e)
        {
            String spIns = "IMDB_Receiving_Container_Ins";
            SqlConnection con = new SqlConnection();
            con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
            SqlCommand InsCmd = new SqlCommand(spIns, con);
            InsCmd.CommandType = CommandType.StoredProcedure;
            con.Open();
            using (InsCmd)
            {
                try
                {
                    InsCmd.Parameters.AddWithValue("@UserName", HttpContext.Current.User.Identity.Name.ToString());
                    InsCmd.Parameters.AddWithValue("@InboundDocNo", fvContainerDetail.FindControl("InboundDocNoTextBox"));
                    InsCmd.Parameters.AddWithValue("@ManifestLineNumber", fvContainerDetail.FindControl("ManLineTextBox"));
                    InsCmd.Parameters.AddWithValue("@RcvHdrID", Session["CurRcvHdrID"].ToString());
                    InsCmd.Parameters.AddWithValue("@InboundProfileID", fvContainerDetail.FindControl("ProfileTextBox"));
                    InsCmd.Parameters.AddWithValue("@InboundContainerType", fvContainerDetail.FindControl("InboundContainerType"));
                    InsCmd.Parameters.AddWithValue("@InboundPalletType", fvContainerDetail.FindControl("InboundPalletTypeTextBox"));
                    InsCmd.Parameters.AddWithValue("@InboundPalletWeight", fvContainerDetail.FindControl("InboundPalletWeightTextBox"));
                    InsCmd.Parameters.AddWithValue("@InboundContainerQty", fvContainerDetail.FindControl("InboundContainerQtyTextBox"));
                    InsCmd.Parameters.AddWithValue("@InboundContainerID", fvContainerDetail.FindControl("InboundContainerIDTextBox"));
                    InsCmd.Parameters.AddWithValue("@InventoryLocation", fvContainerDetail.FindControl("InventoryLocationTextBox"));
                    InsCmd.Parameters.AddWithValue("@BrandCode", fvContainerDetail.FindControl("BrandCodeTextBox"));
                    InsCmd.Parameters.AddWithValue("@ProcessPlan", fvContainerDetail.FindControl("ProcessPlan"));
                    InsCmd.Parameters.AddWithValue("@RcvdAs", fvContainerDetail.FindControl("RcvdAsTextBox"));

                    InsCmd.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    lblErrMsg.Visible = true;
                    lblErrMsg.Text = ex.ToString();
                }
                finally
                {
                    con.Close();
                    fvContainerDetail.DataBind();
                }
            }
        }

        protected void fvContainerDetail_DataBound(object sender, EventArgs e)
        { 
            Control ctrl = fvContainerDetail.FindControl("InboundDocNoTextBox"); 
            if (ctrl != null) 
            { 
                ctrl.Focus(); 
            } 
        } 
    }
}