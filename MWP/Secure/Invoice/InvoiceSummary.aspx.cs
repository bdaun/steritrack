using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MWP.Secure.Invoice
{
    public partial class InvoiceSummary : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                trCustDept.Visible = false;

                //  Set the BillingYear dropdown list with current year and 2 years prior
                DateTime SelYear = Convert.ToDateTime(DateTime.Now);
                SelYear = SelYear.AddYears(-2);
                for (int i = 0; i < 3; i++)
                {
                    DateTime NextYear = SelYear.AddYears(i);
                    ListItem list = new ListItem();
                    list.Value = NextYear.Year.ToString();
                    ddBillingYear.Items.Add(list);
                }
                ddBillingYear.Items.FindByValue(DateTime.Now.Year.ToString()).Selected = true;
            }
            ddBillingPeriod.Items.Add("Select a Billing Cycle");
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {

        }
        
        protected void btnCancelSearch_Click(object sender, EventArgs e)
        {
            ddBillingCycle.SelectedIndex = 0;
            ddDept.SelectedIndex = 0;
            ddBillingPeriod.Items.Clear();
            ddBillingPeriod.Items.Add("Select a Billing Cycle");
        }

        protected void ddBillingCycle_SelectedIndexChanged(object sender, EventArgs e)
        {
            PopulateDropDown();
        }

        protected void ddBillingYear_SelectedIndexChanged(object sender, EventArgs e)
        {
            PopulateDropDown();
        }
        public void PopulateDropDown()
        {
            // Show customers baseed on billing cycle selection
            ddBillingPeriod.Items.Clear();
            ddCustomer.Items.Clear();
            ddCustomer.DataBind();
            ddCustomer.Items.Insert(0, new ListItem("Select from List", "0"));
            ListItem li = new ListItem();
            li.Text = "All";
            li.Value = "-1";
            ddBillingPeriod.Items.Add(li);

            switch (ddBillingCycle.SelectedValue)
            {
                case "Weekly":
                    {
                        // Populate ddBillingPeriod based on year in BillingYear and BillingCycle

                        // Determine the date of first Saturday in the selected Billing Year
                        string TestBusinessDay;
                        TestBusinessDay = "01/01/" + ddBillingYear.SelectedValue.ToString();
                        String FirstBusinessDay;
                        DateTime dt;
                        dt = Convert.ToDateTime(TestBusinessDay);

                        for (int i = 1; i < 7; i++)
                        {
                            if (dt.DayOfWeek.ToString() != "Saturday")
                            {
                                dt = dt.AddDays(1);
                            }
                            else
                            {
                                FirstBusinessDay = dt.ToShortDateString();
                            }
                        }

                        // Populate the dropdown
                        for (int i = 1; i < 53; i++)
                        {
                            ddBillingPeriod.Items.Add(dt.ToShortDateString() + " - " + dt.AddDays(6).ToShortDateString());
                            dt = dt.AddDays(7);
                        }
                        return;
                    }
                case "Semi-Monthly":
                    {
                        // Populate the dropdown
                        String YrStart;
                        YrStart = "01/01/" + ddBillingYear.SelectedValue.ToString();
                        DateTime dt;
                        dt = Convert.ToDateTime(YrStart);
                        for (int i = 1; i < 13; i++)
                        {
                            // create a datetime variable set to the passed in date
                            DateTime dtTo = dt;
                            dtTo = dtTo.AddMonths(1);
                            dtTo = dtTo.AddDays(-(dtTo.Day));
                            ddBillingPeriod.Items.Add(dt.ToShortDateString() + " - " + dt.AddDays(14).ToShortDateString());
                            ddBillingPeriod.Items.Add(dt.AddDays(15).ToShortDateString() + " - " + dtTo.ToShortDateString());
                            dt = dt.AddMonths(1);
                        }
                        return;
                    }
                case "Monthly":
                    {
                        // Populate the dropdown
                        String YrStart;
                        YrStart = "01/01/" + ddBillingYear.SelectedValue.ToString();
                        DateTime dt;
                        dt = Convert.ToDateTime(YrStart);
                        for (int i = 1; i < 13; i++)
                        {
                            // create a datetime variable set to the passed in date
                            DateTime dtTo = dt;
                            dtTo = dtTo.AddMonths(1);
                            dtTo = dtTo.AddDays(-(dtTo.Day));
                            ddBillingPeriod.Items.Add(dt.ToShortDateString() + " - " + dtTo.ToShortDateString());
                            dt = dt.AddMonths(1);
                        }
                        return;
                    }
                default:
                    return;

            }        
        }

        protected void ddCustomer_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddCustomer.SelectedIndex != 0)
            { 
                trCustDept.Visible = true;
            }
            else
            {
                trCustDept.Visible = false;
            }
            ddDept.Items.Clear();
            ListItem li = new ListItem();
            li.Text = "Select a Department";
            li.Value = "0";
            ddDept.Items.Add(li);
            ListItem li2 = new ListItem();
            li2.Text = "All Departments";
            li2.Value = "-1";
            ddDept.Items.Add(li2);
            ddDept.DataBind();
        }

        protected void ddDept_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}