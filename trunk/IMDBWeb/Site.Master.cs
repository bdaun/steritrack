using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IMDBWeb
{
    public partial class SiteMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.User.Identity.Name.ToString()=="")
            {
                MenuItemCollection menuItems = NavigationMenu.Items;
                MenuItem report = new MenuItem();
                MenuItem spak = new MenuItem();
                MenuItem desk = new MenuItem();
                MenuItem mobile = new MenuItem();
                MenuItem super = new MenuItem();
                foreach (MenuItem menuItem in menuItems)
                {
                    if (menuItem.Text == "Report Pages")
                        report = menuItem;
                    else if (menuItem.Text == "SPAK CS Pages")
                        spak = menuItem;
                    else if (menuItem.Text == "Desktop Pages")
                        desk = menuItem;
                    else if (menuItem.Text == "Mobile Pages")
                        mobile = menuItem;
                    else if (menuItem.Text == "SuperFund")
                        super = menuItem;
                }
                menuItems.Remove(mobile);
                menuItems.Remove(desk);
                menuItems.Remove(spak);
                menuItems.Remove(report);
                menuItems.Remove(super);
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
            if (Page.User.IsInRole("SuperFund"))
            {
                MenuItemCollection menuItems = NavigationMenu.Items;
                MenuItem report = new MenuItem();
                MenuItem spak = new MenuItem();
                MenuItem desk = new MenuItem();
                MenuItem mobile = new MenuItem();
                foreach (MenuItem menuItem in menuItems)
                {
                    if (menuItem.Text == "Report Pages")
                        report = menuItem;
                    else if (menuItem.Text == "SPAK Pages")
                        spak = menuItem;
                    else if (menuItem.Text == "Desktop Pages")
                        desk = menuItem;
                    else if (menuItem.Text == "Mobile Pages")
                        mobile = menuItem;
                }
                menuItems.Remove(mobile);
                menuItems.Remove(desk);
                menuItems.Remove(spak);
                menuItems.Remove(report);
            }
            if (Page.User.IsInRole("User"))
            {
                MenuItemCollection menuItems = NavigationMenu.Items;
                MenuItem super = new MenuItem();
                foreach (MenuItem menuItem in menuItems)
                { 
                    if(menuItem.Text=="SuperFund")
                    {
                        super = menuItem;
                    }
                }
                menuItems.Remove(super);
            }
        }
    }    
}
