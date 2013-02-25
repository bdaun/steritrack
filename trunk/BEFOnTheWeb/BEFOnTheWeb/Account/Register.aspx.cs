using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Membership.OpenAuth;

namespace BEFOnTheWeb.Account
{
    public partial class Register : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            RegisterUser.ContinueDestinationPageUrl = Request.QueryString["ReturnUrl"];
            if (!IsPostBack) 
            { 
                RegisterUser.Visible = false; 
            }
        }

        protected void RegisterUser_CreatedUser(object sender, EventArgs e)
        {
            FormsAuthentication.SetAuthCookie(RegisterUser.UserName, createPersistentCookie: false);
            string newRole = string.Empty;
            Roles.AddUserToRole(RegisterUser.UserName, ddUserType.SelectedValue.ToString());

            string continueUrl = RegisterUser.ContinueDestinationPageUrl;
            if (!OpenAuth.IsLocalUrl(continueUrl))
            {
                continueUrl = "~/Secure/MeManagement.aspx";
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

        protected void ddUserType_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddUserType.SelectedIndex != 0)
            {
                RegisterUser.Visible = true;
                lblUserTypeNote.Text = string.Empty;
            }
            else
            {
                RegisterUser.Visible = false;
                switch (ddUserType.SelectedValue.ToString())
                {
                    case "Guest":
                        lblUserTypeNote.Text = "As a Volunteer/Guest, you will be able to see general BEF " +
                            "information and sign up for BEF volunteer opportunities";
                        break;
                    case "Teacher":
                        lblUserTypeNote.Text = "As a Teacher, you will be able to make grant requests, edit requests, " +
                            "see that status of your grant requests, and volunteer for BEF events";
                        break;
                    case "Principal":
                        lblUserTypeNote.Text = "As a Principal, you will be able to see and approve/reject requests as well as " +
                            "volunteer for BEF events.";
                        break;
                    case "BEF":
                        lblUserTypeNote.Text = "As a BEF Director, you will be able to manage your BEF contact information, " +
                            "upadate your committe involvement, and create/edit/volunteer for BEF events.";
                        break;
                    default:
                        lblUserTypeNote.Text = string.Empty;
                        break;
                }
            }
        }
    }
}