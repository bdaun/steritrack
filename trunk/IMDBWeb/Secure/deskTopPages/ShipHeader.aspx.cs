using System;
using System.Web;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Text;
using System.Web.UI;

namespace IMDBWeb.Secure.deskTopPages
{
    public partial class ShipHeader : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                trFind.Visible = false;
                lblErrMsg.Visible = false;
            }
        }

        protected void btnAddShipment_Click(object sender, EventArgs e)
        {
            lblErrMsg.Visible = false;
            txbOutboundDocNo.Text = "";
            txbWiseOrder.Text = "";
            sdsShipHdr.SelectParameters["WiseOrder"].DefaultValue = "";
            sdsShipHdr.SelectParameters["OutboundDocNo"].DefaultValue = "";
            trFind.Visible = false;
            fvShipHdr.DataBind();
            fvShipHdr.ChangeMode(FormViewMode.Insert);
        }

        protected void btnFindShipment_Click(object sender, EventArgs e)
        {
            lblErrMsg.Visible = false;
            txbOutboundDocNo.Text = "";
            txbWiseOrder.Text = "";
            sdsShipHdr.SelectParameters["WiseOrder"].DefaultValue = "";
            sdsShipHdr.SelectParameters["OutboundDocNo"].DefaultValue = "";
            trFind.Visible = true;
            btnSearch.Focus();
            txbWiseOrder.Focus();
            fvShipHdr.DataBind();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            lblErrMsg.Visible = false;
            sdsShipHdr.SelectParameters["WiseOrder"].DefaultValue = "All";
            sdsShipHdr.SelectParameters["OutboundDocNo"].DefaultValue = "All";
            fvShipHdr.DataBind();
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            lblErrMsg.Visible = false;
            fvShipHdr.ChangeMode(FormViewMode.Edit);
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            lblErrMsg.Visible = false;
            txbOutboundDocNo.Text = "";
            txbWiseOrder.Text = "";
            sdsShipHdr.SelectParameters["WiseOrder"].DefaultValue = "";
            sdsShipHdr.SelectParameters["OutboundDocNo"].DefaultValue = "";
            trFind.Visible = false;
            fvShipHdr.DataBind();
        }
        protected void btnInsert_Click(object sender, EventArgs e)
        {
            String spIns = "IMDB_ShipHdr_Ins";
            SqlConnection con = new SqlConnection();
            con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
            SqlCommand spCmdIns = new SqlCommand(spIns, con);
            spCmdIns.CommandType = CommandType.StoredProcedure;
            con.Open();
            using (spCmdIns)
            {
                try
                {
                    TextBox txb1 = FindControlRecursive(fvShipHdr, "OutboundDocNoTextBox") as TextBox;
                    DropDownList dd1 = FindControlRecursive(fvShipHdr, "ddDestination") as DropDownList;
                    TextBox txb3 = FindControlRecursive(fvShipHdr, "ShipDateTextBox") as TextBox;
                    DropDownList dd2 = FindControlRecursive(fvShipHdr, "ddCarrier") as DropDownList;
                    TextBox txb5 = FindControlRecursive(fvShipHdr, "Trailer_NumberTextBox") as TextBox;
                    DropDownList dd3 = FindControlRecursive(fvShipHdr, "ddDock") as DropDownList;
                    TextBox txb7 = FindControlRecursive(fvShipHdr, "WiseOrderTextBox") as TextBox;

                    spCmdIns.Parameters.AddWithValue("@OutboundDocNo", txb1.Text);
                    spCmdIns.Parameters.AddWithValue("@Destination", dd1.Text);
                    spCmdIns.Parameters.AddWithValue("@ShipDate", txb3.Text);
                    spCmdIns.Parameters.AddWithValue("@Carrier", dd2.Text);
                    spCmdIns.Parameters.AddWithValue("@Trailer_Number", txb5.Text);
                    spCmdIns.Parameters.AddWithValue("@ShippingDock", dd3.Text);
                    spCmdIns.Parameters.AddWithValue("@WiseOrder", txb7.Text);
                    spCmdIns.ExecuteNonQuery();
                    lblErrMsg.Visible = true;
                    lblErrMsg.Text = "OutboundDocNo " + txb1.Text + " was created.";
                }
                catch (Exception ex)
                {
                    lblErrMsg.Visible = true;
                    lblErrMsg.Text = ex.ToString();
                }
                finally
                {
                    con.Close();
                    txbOutboundDocNo.Text = string.Empty;
                    txbWiseOrder.Text = string.Empty;
                    fvShipHdr.ChangeMode(FormViewMode.ReadOnly);
                    fvShipHdr.DataBind();
                }
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            String spUpd = "IMDB_ShipHdr_Upd";
            SqlConnection con = new SqlConnection();
            con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
            SqlCommand spCmdUpd = new SqlCommand(spUpd, con);
            spCmdUpd.CommandType = CommandType.StoredProcedure;
            con.Open();
            using (spCmdUpd)
            {
                try
                {
                    Label lbl1 = FindControlRecursive(fvShipHdr, "IDLabel1") as Label;
                    TextBox txb1 = FindControlRecursive(fvShipHdr, "OutboundDocNoTextBox") as TextBox;
                    DropDownList dd1 = FindControlRecursive(fvShipHdr, "ddDestination") as DropDownList;
                    TextBox txb3 = FindControlRecursive(fvShipHdr, "ShipDateTextBox") as TextBox;
                    DropDownList dd2 = FindControlRecursive(fvShipHdr, "ddCarrier") as DropDownList;
                    TextBox txb5 = FindControlRecursive(fvShipHdr, "Trailer_NumberTextBox") as TextBox;
                    DropDownList dd3 = FindControlRecursive(fvShipHdr, "ddDock") as DropDownList;
                    TextBox txb7 = FindControlRecursive(fvShipHdr, "WiseOrderTextBox") as TextBox;
                    CheckBox chk1 = FindControlRecursive(fvShipHdr, "Completed") as CheckBox;
                    string strChk = "False";
                    if (chk1.Checked)
                    {
                        strChk = "True";
                    }
                    else
	                {
                        strChk = "False";
	                }

                    spCmdUpd.Parameters.AddWithValue("@ID", lbl1.Text);
                    spCmdUpd.Parameters.AddWithValue("@OutboundDocNo", txb1.Text);
                    spCmdUpd.Parameters.AddWithValue("@Destination", dd1.Text);
                    spCmdUpd.Parameters.AddWithValue("@ShipDate", txb3.Text);
                    spCmdUpd.Parameters.AddWithValue("@Carrier", dd2.Text);
                    spCmdUpd.Parameters.AddWithValue("@Trailer_Number", txb5.Text);
                    spCmdUpd.Parameters.AddWithValue("@ShippingDock", dd3.Text);
                    spCmdUpd.Parameters.AddWithValue("@WiseOrder", txb7.Text);
                    spCmdUpd.Parameters.AddWithValue("@Completed", strChk.ToString());
                    spCmdUpd.ExecuteNonQuery();
                    lblErrMsg.Visible = true;
                    lblErrMsg.Text = "OutboundDocNo " + txb1.Text + " was updated.";
                }
                catch (Exception ex)
                {
                    lblErrMsg.Visible = true;
                    lblErrMsg.Text = ex.ToString();
                }
                finally
                {
                    con.Close();
                    txbOutboundDocNo.Text = string.Empty;
                    txbWiseOrder.Text = string.Empty;
                    fvShipHdr.ChangeMode(FormViewMode.ReadOnly);
                    fvShipHdr.DataBind();
                }
            }
        }
        protected void sdsShipHdr_Updating(Object sender, SqlDataSourceCommandEventArgs e)
        {
            e.Command.Parameters["@UserName"].Value = HttpContext.Current.User.Identity.Name.ToString();
        }
        protected void sdsShipHdr_Inserting(Object sender, SqlDataSourceCommandEventArgs e)
        {
            e.Command.Parameters["@UserName"].Value = HttpContext.Current.User.Identity.Name.ToString();
        }
        private Control FindControlRecursive(Control control, string id)
        {
            Control returnControl = control.FindControl(id);
            if (returnControl == null)
            {
                foreach (Control child in control.Controls)
                {
                    returnControl = child.FindControl(id);
                    if (returnControl != null && returnControl.ID == id)
                    {
                        return returnControl;
                    }
                }
            }
            return returnControl;
        }
    }

}