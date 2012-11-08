using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MWP
{
    public partial class SiteMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.User.Identity.Name.ToString() == "")
            {
                MenuItemCollection menuItems = NavigationMenu.Items;
                MenuItem Admin = new MenuItem();
                MenuItem DataMgt = new MenuItem(); 
                MenuItem CustomerMgt = new MenuItem();

                foreach (MenuItem menuItem in menuItems)
                {
                    if (menuItem.Text == "Admin")
                        Admin = menuItem;
                    else if (menuItem.Text == "DataMgt")
                        DataMgt = menuItem;
                    else if (menuItem.Text == "CustomerMgt")
                        CustomerMgt = menuItem;
                }
                menuItems.Remove(Admin);
                menuItems.Remove(DataMgt);
                menuItems.Remove(CustomerMgt);
            }
            if (!Page.User.IsInRole("Admin"))
            {
                MenuItemCollection menuItems = NavigationMenu.Items;
                MenuItem adminItem = new MenuItem();
                foreach (MenuItem menuItem in menuItems)
                {
                    if (menuItem.Text == "Admin")
                    {
                        adminItem = menuItem;
                    }
                }
                menuItems.Remove(adminItem);
            }
            if (Page.User.IsInRole("User"))
            {
                MenuItemCollection menuItems = NavigationMenu.Items;
                MenuItem Admin = new MenuItem();
                foreach (MenuItem menuItem in menuItems)
                {
                    if (menuItem.Text == "Admin")
                    {
                        Admin = menuItem;
                    }
                }
                menuItems.Remove(Admin);
            }
        }
    }
}
