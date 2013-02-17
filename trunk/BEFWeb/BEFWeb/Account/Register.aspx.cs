using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Membership.OpenAuth;

namespace BEFWeb.Account
{
    public partial class Register : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            RegisterUser.ContinueDestinationPageUrl = Request.QueryString["ReturnUrl"];
        }

        protected void RegisterUser_CreatedUser(object sender, EventArgs e)
        {
            FormsAuthentication.SetAuthCookie(RegisterUser.UserName, createPersistentCookie: false);
            Roles.AddUserToRole(RegisterUser.UserName, "User");

            string continueUrl = RegisterUser.ContinueDestinationPageUrl;
            if (!OpenAuth.IsLocalUrl(continueUrl))
            {
                continueUrl = "~/Secure/home.aspx";
            }
            Response.Redirect(continueUrl);
        }

        protected void RegisterUser_CreatingUser(object sender, LoginCancelEventArgs e)
        {
            string trimmedUserName = RegisterUser.UserName.Trim();
            if (RegisterUser.UserName.Length != trimmedUserName.Length)
            {
                // Show the error message
                InvalidUserNameOrPasswordMessage.Text = "The username cannot contain leading or trailing spaces.";
                InvalidUserNameOrPasswordMessage.Visible = true;

                // Cancel the create user workflow
                e.Cancel = true;
            }
            else
            {
                // Username is valid, make sure that the password does not contain the username
                if (RegisterUser.Password.IndexOf(RegisterUser.UserName, StringComparison.OrdinalIgnoreCase) >= 0)
                {
                    // Show the error message
                    InvalidUserNameOrPasswordMessage.Text = "The username may not appear anywhere in the password.";
                    InvalidUserNameOrPasswordMessage.Visible = true;

                    // Cancel the create user workflow
                    e.Cancel = true;
                }
            }
        }
    }
}