﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BEFOnTheWeb.Secure
{
    public partial class Page : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.User.Identity.Name.ToString() == "")
            {
                MenuItemCollection menuItems = NavigationMenu.Items;
                MenuItem Home = new MenuItem();
                MenuItem Contact = new MenuItem();
                MenuItem About = new MenuItem();
                MenuItem Grants = new MenuItem();
                MenuItem Events = new MenuItem();
                MenuItem Me = new MenuItem();
                MenuItem BEF = new MenuItem();

                foreach (MenuItem menuItem in menuItems)
                {
                    if (menuItem.Text == "Home")
                        Home = menuItem;
                    else if (menuItem.Text == "Contact Us")
                        Contact = menuItem;
                    else if (menuItem.Text == "About")
                        About = menuItem;
                    else if (menuItem.Text == "Grants")
                        Grants = menuItem;
                    else if (menuItem.Text == "Events")
                        Events = menuItem;
                    else if (menuItem.Text == "Me")
                        Me = menuItem;
                    else if (menuItem.Text == "BEF")
                        BEF = menuItem;

                }
                menuItems.Remove(Home);
                menuItems.Remove(Contact);
                menuItems.Remove(About);
                menuItems.Remove(Grants);
                menuItems.Remove(Events);
                menuItems.Remove(Me);
                menuItems.Remove(BEF);
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
            if (Page.User.IsInRole("User")||Page.User.IsInRole("Guest"))
            {
                MenuItemCollection menuItems = NavigationMenu.Items;
                MenuItem Admin = new MenuItem();
                MenuItem Grants = new MenuItem();
                MenuItem Events = new MenuItem();
                MenuItem BEF = new MenuItem();

                foreach (MenuItem menuItem in menuItems)
                {
                    if (menuItem.Text == "Admin")
                    {
                        Admin = menuItem;
                    }
                    else if (menuItem.Text=="Grants")
                    {
                        Grants = menuItem;
                    }
                    else if (menuItem.Text == "Events")
                    {
                        Events = menuItem;
                    }
                    else if (menuItem.Text == "BEF")
                    {
                        BEF = menuItem;
                    }
                }
                menuItems.Remove(Admin);
                menuItems.Remove(Grants);
                menuItems.Remove(Events);
                menuItems.Remove(BEF);

            }
            if (Page.User.IsInRole("SuperUser") || Page.User.IsInRole("Principal"))
            {
                MenuItemCollection menuItems = NavigationMenu.Items;
                MenuItem Admin = new MenuItem();
                MenuItem Grants = new MenuItem();
                MenuItem Events = new MenuItem();
                MenuItem BEF = new MenuItem();

                foreach (MenuItem menuItem in menuItems)
                {
                    if (menuItem.Text == "Admin")
                    {
                        Admin = menuItem;
                    }
                    else if (menuItem.Text == "Grants")
                    {
                        Grants = menuItem;
                    }
                    else if (menuItem.Text == "Events")
                    {
                        Events = menuItem;
                    }
                    else if (menuItem.Text == "BEF")
                    {
                        BEF = menuItem;
                    }
                }
                menuItems.Remove(Admin);
                menuItems.Remove(Grants);
                menuItems.Remove(Events);
                menuItems.Remove(BEF);
            }
        }
    }
}