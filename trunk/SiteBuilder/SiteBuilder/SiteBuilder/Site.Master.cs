using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SiteBuilder
{
    public partial class SiteMaster : MasterPage
    {
        private const string AntiXsrfTokenKey = "__AntiXsrfToken";
        private const string AntiXsrfUserNameKey = "__AntiXsrfUserName";
        private string _antiXsrfTokenValue;

        protected void Page_Init(object sender, EventArgs e)
        {
            // The code below helps to protect against XSRF attacks
            var requestCookie = Request.Cookies[AntiXsrfTokenKey];
            Guid requestCookieGuidValue;
            if (requestCookie != null && Guid.TryParse(requestCookie.Value, out requestCookieGuidValue))
            {
                // Use the Anti-XSRF token from the cookie
                _antiXsrfTokenValue = requestCookie.Value;
                Page.ViewStateUserKey = _antiXsrfTokenValue;
            }
            else
            {
                // Generate a new Anti-XSRF token and save to the cookie
                _antiXsrfTokenValue = Guid.NewGuid().ToString("N");
                Page.ViewStateUserKey = _antiXsrfTokenValue;

                var responseCookie = new HttpCookie(AntiXsrfTokenKey)
                {
                    HttpOnly = true,
                    Value = _antiXsrfTokenValue
                };
                if (FormsAuthentication.RequireSSL && Request.IsSecureConnection)
                {
                    responseCookie.Secure = true;
                }
                Response.Cookies.Set(responseCookie);
            }

            Page.PreLoad += master_Page_PreLoad;
        }

        protected void master_Page_PreLoad(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Set Anti-XSRF token
                ViewState[AntiXsrfTokenKey] = Page.ViewStateUserKey;
                ViewState[AntiXsrfUserNameKey] = Context.User.Identity.Name ?? String.Empty;
            }
            else
            {
                // Validate the Anti-XSRF token
                if ((string)ViewState[AntiXsrfTokenKey] != _antiXsrfTokenValue
                    || (string)ViewState[AntiXsrfUserNameKey] != (Context.User.Identity.Name ?? String.Empty))
                {
                    throw new InvalidOperationException("Validation of Anti-XSRF token failed.");
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            //if (HttpContext.Current.User.Identity.Name.ToString() == "")
            //{
            //    MenuItemCollection menuItems = NavigationMenu.Items;
            //    MenuItem Admin = new MenuItem();
            //    MenuItem DataMgt = new MenuItem();
            //    MenuItem CustomerMgt = new MenuItem();
            //    MenuItem Invoice = new MenuItem();

            //    foreach (MenuItem menuItem in menuItems)
            //    {
            //        if (menuItem.Text == "Admin")
            //            Admin = menuItem;
            //        else if (menuItem.Text == "DataMgt")
            //            DataMgt = menuItem;
            //        else if (menuItem.Text == "CustomerMgt")
            //            CustomerMgt = menuItem;
            //        else if (menuItem.Text == "Invoice")
            //            Invoice = menuItem;
            //    }
            //    menuItems.Remove(Admin);
            //    menuItems.Remove(DataMgt);
            //    menuItems.Remove(CustomerMgt);
            //    menuItems.Remove(Invoice);
            //}
            //if (!Page.User.IsInRole("Admin"))
            //{
            //    MenuItemCollection menuItems = NavigationMenu.Items;
            //    MenuItem adminItem = new MenuItem();
            //    foreach (MenuItem menuItem in menuItems)
            //    {
            //        if (menuItem.Text == "Admin")
            //        {
            //            adminItem = menuItem;
            //        }
            //    }
            //    menuItems.Remove(adminItem);
            //}
            //if (Page.User.IsInRole("User"))
            //{
            //    MenuItemCollection menuItems = NavigationMenu.Items;
            //    MenuItem Admin = new MenuItem();
            //    foreach (MenuItem menuItem in menuItems)
            //    {
            //        if (menuItem.Text == "Admin")
            //        {
            //            Admin = menuItem;
            //        }
            //    }
            //    menuItems.Remove(Admin);
            //}
        }

        protected void SiteMapPath1_ItemCreated(object sender, SiteMapNodeItemEventArgs e)
        {
            if (e.Item.ItemType == SiteMapNodeItemType.Root ||
                (e.Item.ItemType == SiteMapNodeItemType.PathSeparator && e.Item.ItemIndex ==1))
            {
                e.Item.Visible = false;
            }
        }
    }
}