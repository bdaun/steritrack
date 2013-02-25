using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BEFOnTheWeb
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.User.Identity.Name.ToString() == "")
            {
                MenuItemCollection menuItems = NavigationMenu.Items;
                MenuItem Contact = new MenuItem();
                MenuItem Home = new MenuItem();
                MenuItem About = new MenuItem();

                foreach (MenuItem menuItem in menuItems)
                {
                    if (menuItem.Text == "Contact")
                        Contact = menuItem;
                    else if (menuItem.Text == "Home")
                        Home = menuItem;
                    else if (menuItem.Text == "About")
                        About = menuItem;
                }
                menuItems.Remove(Contact);
                menuItems.Remove(Home);
                menuItems.Remove(About);
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