using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TeleiosDemo
{
    public partial class SiteMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.User.Identity.Name.ToString()=="")
            {
                MenuItemCollection menuItems = NavigationMenu.Items;
                MenuItem report = new MenuItem();
                MenuItem mobile = new MenuItem();
                MenuItem Inventory = new MenuItem();
                foreach (MenuItem menuItem in menuItems)
                {
                    if (menuItem.Text == "Report Pages")
                        report = menuItem;
                    else if (menuItem.Text == "Mobile Pages")
                        mobile = menuItem;
                    else if (menuItem.Text == "Inventory")
                        Inventory = menuItem;
                }
                menuItems.Remove(mobile);
                menuItems.Remove(report);
                menuItems.Remove(Inventory);
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
        }
    }    
}
