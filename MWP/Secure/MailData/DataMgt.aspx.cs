using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Web.Security;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;

namespace MWP.Secure.MailData
{
    public partial class DataMgt : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                tblManualAdd.Visible = false;
                tblTicketAdd.Visible = false;
            }
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            if (ddCustomer.SelectedIndex == 0)
            {
                WebMsgBox.Show("You must select a customer!");

            }
        }
        protected void btnCancelSearch_Click(object sender, EventArgs e)
        {
            ddCustomer.SelectedIndex = 0;
            ddDept.SelectedIndex = 0;
            ddDataSource.SelectedIndex = 0;
            txbBegDate.Text = string.Empty;
            txbEndDate.Text = string.Empty;
        }
        protected void ddDataSource_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
        protected void sdsMailData_Updating(Object sender, SqlDataSourceCommandEventArgs e)
        {
            e.Command.Parameters["@UserName"].Value = HttpContext.Current.User.Identity.Name.ToString();
        }
        protected void ddCustomer_SelectedIndexChanged(object sender, EventArgs e)
        {
                ddDept.Items.Clear();
                ListItem li = new ListItem();
                li.Text = "Select a Department";
                li.Value = "0";
                ddDept.Items.Add(li);
                ListItem li2 = new ListItem();
                li2.Text = "All Departments";
                li2.Value = "-1";
                ddDept.Items.Add(li2);
                ddDept.DataBind();
        }
        protected void btnManualAdd_Click(object sender, EventArgs e)
        {
            ddCustomerAdd.SelectedIndex = 0;
            ddDeptAdd.Items.Clear();
            ListItem li = new ListItem();
            li.Text = "Select a Customer";
            li.Value = "0";
            ddDeptAdd.Items.Add(li);    
            tblManualAdd.Visible = true;
            tblTicketAdd.Visible = false;
        }
        protected void btnDoneManualAdd_Click(object sender, EventArgs e)
        {
            ddCustomerAdd.SelectedIndex = 0;
            ddDeptAdd.SelectedIndex = 0;
            ddEntryType.SelectedIndex = 0;
            txbPcCnt.Text = string.Empty;
            txbAmt.Text = string.Empty;
            txbDataDate.Text = string.Empty;
            tblManualAdd.Visible = false;
        }
        protected void btnTicket_Click(object sender, EventArgs e)
        {
            ddCustomerTx.SelectedIndex = 0;
            ddDeptTx.SelectedIndex = 0;
            txbFlats.Text = string.Empty;
            txbLetters.Text = string.Empty;
            txbDataDateTx.Text = string.Empty;
            tblTicketAdd.Visible = true;
            tblManualAdd.Visible = false;
        }
        protected void btnDoneTx_Click(object sender, EventArgs e)
        {
            ddCustomerTx.SelectedIndex = 0;
            ddDeptTx.SelectedIndex = 0;
            txbFlats.Text = string.Empty;
            txbLetters.Text = string.Empty;
            txbDataDateTx.Text = string.Empty;
            tblTicketAdd.Visible = false;
        }
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string newRecord = "DataMgt_RecordAdd_Ins";
            SqlConnection Con = new SqlConnection();
            Con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MPS_SQL"].ConnectionString;
            SqlCommand Cmd = new SqlCommand(newRecord, Con);
            Cmd.CommandType = CommandType.StoredProcedure;
            Con.Open();
            using (Cmd)
            {
                try
                {
                    Cmd.Parameters.AddWithValue("@CustomerDeptID", ddDeptAdd.SelectedValue.ToString());
                    Cmd.Parameters.AddWithValue("@MailType", ddEntryType.SelectedItem.ToString());
                    Cmd.Parameters.AddWithValue("@MailQty", txbPcCnt.Text);
                    Cmd.Parameters.AddWithValue("@PostageClaimed", txbAmt.Text);
                    Cmd.Parameters.AddWithValue("@DataDate", txbDataDate.Text);
                    Cmd.Parameters.AddWithValue("@UserName", HttpContext.Current.User.Identity.Name.ToString());
                    Cmd.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    lblErrMsg.Visible = true;
                    lblErrMsg.Text = ex.ToString();
                    lblResult.Visible = true;
                    lblResult.ForeColor = System.Drawing.Color.Red;
                    lblResult.Text = "There was a problem.  Record was NOT Added!";
                }
                finally
                {
                    lblResult.Visible = true;
                    lblResult.ForeColor = System.Drawing.Color.Green;
                    lblResult.Text = "Successfully Added!";
                    ddCustomer.SelectedValue = ddCustomerAdd.SelectedValue;
                    ddDept.DataBind();
                    ddDept.SelectedValue = ddDeptAdd.SelectedValue;
                    gvMailData.DataBind();
                    gvTicket.DataBind();
                    Con.Close();
                }

            }
            ddCustomerAdd.SelectedIndex = 0;
            ddEntryType.SelectedIndex = 0;
            txbAmt.Text = string.Empty;
            txbPcCnt.Text = string.Empty;
            txbDataDate.Text = string.Empty;
            ddDeptAdd.Items.Clear();
            ListItem li = new ListItem();
            li.Text = "Select a Department";
            li.Value = "0";
            ddDeptAdd.Items.Add(li);
            ddDeptAdd.DataBind();
            ddCustomerAdd.Focus();
        }
        protected void btnSubmitTx_Click(object sender, EventArgs e)
        {
            string newRecord = "DataMgt_RecordTx_Ins";
            SqlConnection Con = new SqlConnection();
            Con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MPS_SQL"].ConnectionString;
            SqlCommand Cmd = new SqlCommand(newRecord, Con);
            Cmd.CommandType = CommandType.StoredProcedure;
            Con.Open();
            using (Cmd)
            {
                try
                {
                    Cmd.Parameters.AddWithValue("@CustomerDeptID", ddDeptTx.SelectedValue.ToString());
                    Cmd.Parameters.AddWithValue("@QtyFlats", txbFlats.Text);
                    Cmd.Parameters.AddWithValue("@QtyLetters", txbLetters.Text);
                    Cmd.Parameters.AddWithValue("@DataDate", txbDataDateTx.Text);
                    Cmd.Parameters.AddWithValue("@UserName", HttpContext.Current.User.Identity.Name.ToString());
                    Cmd.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    lblErrMsg.Visible = true;
                    lblErrMsg.Text = ex.ToString();
                    lblResultTx.Visible = true;
                    lblResultTx.ForeColor = System.Drawing.Color.Red;
                    lblResultTx.Text = "There was a problem.  Record was NOT Added!";
                }
                finally
                {
                    lblResultTx.Visible = true;
                    lblResultTx.ForeColor = System.Drawing.Color.Green;
                    lblResultTx.Text = "Successfully Added!";
                    ddCustomer.SelectedValue = ddCustomerTx.SelectedValue;
                    ddDept.DataBind();
                    ddDept.SelectedValue = ddDeptTx.SelectedValue;
                    gvMailData.DataBind();
                    gvTicket.DataBind();
                    Con.Close();
                }

            }
            ddCustomerTx.SelectedIndex = 0;
            txbFlats.Text = string.Empty;
            txbLetters.Text = string.Empty;
            txbDataDateTx.Text = string.Empty;
            ddDeptTx.Items.Clear();
            ListItem li = new ListItem();
            li.Text = "Select a Department";
            li.Value = "0";
            ddDeptTx.Items.Add(li);
            ddDeptTx.DataBind();
            ddCustomerTx.Focus();
        }
        protected void ddCustomerAdd_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblResult.Visible = false;
            ddDeptAdd.Items.Clear();
            ListItem li = new ListItem();
            li.Text = "Select a Department";
            li.Value = "0";
            ddDeptAdd.Items.Add(li);
            ddDeptAdd.DataBind();
            ddDeptAdd.Focus();
        }
        protected void ddCustomerTx_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblResultTx.Visible = false;
            ddDeptTx.Items.Clear();
            ListItem li = new ListItem();
            li.Text = "Select a Department";
            li.Value = "0";
            ddDeptTx.Items.Add(li);
            ddDeptTx.DataBind();
            ddDeptTx.Focus();
        }
        protected void ddDeptAdd_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblResult.Visible = false;
            ddEntryType.Focus();
        }
        protected void ddDeptTx_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblResultTx.Visible = false;
            txbFlats.Focus();
        }
        protected void ddEntryType_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblResult.Visible = false;
            txbPcCnt.Focus();
        }
        protected void txbFlats_TextChanged(object sender, EventArgs e)
        {
            lblResultTx.Visible = false;
            txbLetters.Focus();
        }
        protected void txbLetters_TextChanged(object sender, EventArgs e)
        {
            lblResultTx.Visible = false;
            txbDataDateTx.Focus();
        }
        protected void txbPcCnt_TextChanged(object sender, EventArgs e)
        {
            lblResult.Visible = false;
            txbAmt.Focus();
        }
        protected void txbAmt_TextChanged(object sender, EventArgs e)
        {
            lblResult.Visible = false;
            txbDataDate.Focus();
        }
        protected void txbDataDate_TextChanged(object sender, EventArgs e)
        {
            lblResult.Visible = false;
            btnSubmit.Focus();
        }
        protected void txbDataDateTx_TextChanged(object sender, EventArgs e)
        {
            lblResultTx.Visible = false;
            btnSubmitTx.Focus();
        }
        protected void ddDept_SelectedIndexChanged(object sender, EventArgs e)
        {
            if((ddCustomer.SelectedIndex != 0) && (ddDept.SelectedIndex != 0) && (ddDataSource.SelectedIndex == 0))
            {
                ddDataSource.SelectedIndex = 1;
            }
        }
    }
}