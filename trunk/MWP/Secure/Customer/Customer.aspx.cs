using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;


namespace MWP.Secure.Customer
{
    public partial class Customer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                tblBegin.Visible = true;
                trAddDept.Visible = false;
            }
            if (ddCustomer.SelectedIndex != 0)
            {
                trCustomerHdr.Visible = true;
            }
            else
            {
                trCustomerHdr.Visible = false;
            }
        }

        protected void btnNewCustomer_Click(object sender, EventArgs e)
        {
            fvCustomer.ChangeMode(FormViewMode.Insert);
            ddCustomer.SelectedIndex = 0;
            trCustomerHdr.Visible = false;
            txbAddDept.Text = string.Empty;
            trAddDept.Visible = false;
        }

        protected void ddCustomer_SelectedIndexChanged(object sender, EventArgs e)
        {
            txbAddDept.Text = string.Empty;
            trAddDept.Visible = false;
            fvCustomer.ChangeMode(FormViewMode.ReadOnly);
            if (ddCustomer.SelectedIndex != 0)
            {
                trCustomerHdr.Visible = true;
            }
            else
            {
                trCustomerHdr.Visible = false;
            }
        }

        protected void EditCustomer_Click(object sender, EventArgs e)
        {
            fvCustomer.ChangeMode(FormViewMode.Edit);
            trCustomerHdr.Visible = true;
        }

        protected void btnCancelSearch_Click(object sender, EventArgs e)
        {
            tblBegin.Visible = true;
        }
        protected void sdsCustomerInfo_Inserting(Object sender, SqlDataSourceCommandEventArgs e)
        {
            e.Command.Parameters["@UserName"].Value = HttpContext.Current.User.Identity.Name.ToString();
        }
        protected void sdsCustomerInfo_Updating(Object sender, SqlDataSourceCommandEventArgs e)
        {
            e.Command.Parameters["@UserName"].Value = HttpContext.Current.User.Identity.Name.ToString();
        }

        protected void sdsCustomerDept_Updating(Object sender, SqlDataSourceCommandEventArgs e)
        {
            e.Command.Parameters["@UserName"].Value = HttpContext.Current.User.Identity.Name.ToString();
        }

        protected void lnkAdd_Insert(object sender, EventArgs e)
        {
            trAddDept.Visible = true;
            txbAddDept.Focus();
        }

        protected void sdsCustomerInfo_Inserted(object sender, EventArgs e)
        {
            ddCustomer.Items.Clear();
            ddCustomer.DataBind();
            ddCustomer.Items.Insert(0, new ListItem("Select from List", "0"));
        }

        protected void sdsCustomerInfo_Updated(object sender, EventArgs e)
        {
            trCustomerHdr.Visible = false;
            ddCustomer.Items.Clear();
            ddCustomer.DataBind();
            ddCustomer.Items.Insert(0, new ListItem("Select from List", "0"));
        }
        protected void btnCancel_Click(object sender, EventArgs e)
        {
            txbAddDept.Text = string.Empty;
            trAddDept.Visible = false;
            lblErrMsg.Text = string.Empty;
            lblErrMsg.Visible = false;
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            String sp = "Customer_CustomerDept_Ins";
            SqlConnection con = new SqlConnection();
            con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MPS_SQL"].ConnectionString;
            SqlCommand spCmd = new SqlCommand(sp, con);
            spCmd.CommandType = CommandType.StoredProcedure;
            con.Open();
            using (spCmd)
            {
                try
                {
                    spCmd.Parameters.AddWithValue("@UserName", HttpContext.Current.User.Identity.Name.ToString());
                    spCmd.Parameters.AddWithValue("@DeptName", txbAddDept.Text);
                    spCmd.Parameters.AddWithValue("@CustomerID", ddCustomer.SelectedValue.ToString());
                    spCmd.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    lblErrMsg.Visible = true;
                    lblErrMsg.Text = ex.ToString();
                }
                finally
                {
                    txbAddDept.Text = string.Empty;
                    txbAddDept.Focus();
                    con.Close();
                    gvDept.DataBind();
                }
            }
        }
    }
}