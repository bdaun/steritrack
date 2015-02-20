using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace SiteBuilder.Admin
{
    public partial class PasswordReset : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {   
            if (!IsPostBack)
                txbUName.Focus();
                lblMsg.Visible = false;
        }

        protected void bntSubmit_Click(object sender, EventArgs e)
        {
            if (txbUName.Text == "")
            {
                lblMsg.Visible = true;
                lblMsg.Text = "You must enter a username";
                txbUName.Focus();
            }
            else if (txbuPW.Text == "")
            {
                lblMsg.Visible = true;
                lblMsg.Text = "You must enter a new password";
                txbuPW.Focus();
            }
            else
            {
                lblMsg.Visible = false;
                string uname = txbUName.Text;
                string uPW = txbuPW.Text;
                MembershipUser u = Membership.FindUsersByName(uname)[uname.ToString()];
                if (u !=null)
                {
                u.UnlockUser();
                u.ChangePassword(u.ResetPassword(), uPW.ToString());
                txbUName.Text = "";
                txbuPW.Text = "";
                }
                else
                {
                    lblMsg.Visible = true;
                    lblMsg.Text = "That Username was not found in the database.  Seek the advanced counsel of .net master Daun";  
                }
            }
        }
    }
}