using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

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
        }

        protected void ddCustomer_SelectedIndexChanged(object sender, EventArgs e)
        {
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

        protected void lnkAdd_Insert(object sender, EventArgs e)
        {
            trAddDept.Visible = true;
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            trAddDept.Visible = false;
        }

        protected void sdsCustomerInfo_Inserted(object sender, EventArgs e)
        {
            ddCustomer.Items.Clear();
            ddCustomer.DataBind();
            ddCustomer.Items.Insert(0, new ListItem("Select from List", "0"));

        }
    }
}