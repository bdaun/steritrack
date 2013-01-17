using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;

namespace MWP.Secure.MailData
{
    public partial class ManualDataAdd : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            { 
                ddCustomer.Focus();
            }
            
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
                    Cmd.Parameters.AddWithValue("@CustomerDeptID", ddDept.SelectedValue.ToString());
                    Cmd.Parameters.AddWithValue("@MailType", ddEntryType.SelectedItem.ToString());
                    Cmd.Parameters.AddWithValue("@MailQty", txbPcCnt.Text);
                    Cmd.Parameters.AddWithValue("@RateClaimed", txbAmt.Text);
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
                    Con.Close();
                }
                
            }

            //temp make this a reset button
            ddCustomer.SelectedIndex = 0;
            ddEntryType.SelectedIndex = 0;
            txbAmt.Text = string.Empty;
            txbPcCnt.Text = string.Empty; 
            ddDept.Items.Clear();
            ListItem li = new ListItem();
            li.Text = "Select a Department";
            li.Value = "0";
            ddDept.Items.Add(li);
            ddDept.DataBind();
            ddCustomer.Focus();
        }

        protected void ddCustomer_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblResult.Visible = false;
            ddDept.Items.Clear();
            ListItem li = new ListItem();
            li.Text = "Select a Department";
            li.Value = "0";
            ddDept.Items.Add(li);
            ddDept.DataBind();
            ddDept.Focus();
        }

        protected void ddDept_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblResult.Visible = false;
            ddEntryType.Focus();
        }

        protected void ddEntryType_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblResult.Visible = false;
            txbPcCnt.Focus();
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
    }
}