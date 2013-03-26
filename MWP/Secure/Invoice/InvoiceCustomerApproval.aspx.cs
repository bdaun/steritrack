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
                trStatusUpdate.Visible = false;

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
                ListItem li = new ListItem();
                li.Text = "Select a Billing Cycle";
                li.Value = "1/1/2001 - 1/1/2101";
                ddBillingPeriod.Items.Add(li);
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {

        }
        
        protected void btnCancelSearch_Click(object sender, EventArgs e)
        {
            ddBillingCycle.SelectedIndex = 0;
            ddStatus.SelectedIndex = 0;
            PopulateDropDown();
            trCustDept.Visible = false;
            trStatusUpdate.Visible = false;
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
            ddCustomer.Items.Insert(0, new ListItem("Select from List", "0"));
            ddCustomer.DataBind();
            ListItem li = new ListItem();
            li.Text = "All";
            li.Value = "1/1/2001 - 1/1/2101";
            ddBillingPeriod.Items.Add(li);
            ddInvoice.Items.Clear();
            ddInvoice.Items.Add("All");
            ddInvoice.DataBind();

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
                case "NotSelected":
                    {
                        ddCustomer.Items.Clear();
                        ddCustomer.Items.Insert(0, new ListItem("Select from List", "0"));
                        ddCustomer.Items.Insert(1, new ListItem("All Customers", "-1"));
                        ddCustomer.DataBind();
                        ddBillingPeriod.Items.Clear();
                        ListItem li2 = new ListItem();
                        li2.Text = "Select a Billing Cycle";
                        li2.Value = "1/1/2001 - 1/1/2101";
                        ddBillingPeriod.Items.Add(li2);
                        trCustDept.Visible = false;
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
            ddInvoice.Items.Clear();
            ddInvoice.Items.Add("All");
            ddInvoice.DataBind();
        }

        protected void ddDept_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddInvoice.Items.Clear();
            ddInvoice.Items.Add("All");
            ddInvoice.DataBind();
        }

        protected void ddInvoice_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddInvoice.SelectedIndex != 0)
            {
                ddStatus.SelectedValue = "Billed";
            }
        }

        protected void ddStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddInvoice.Items.Clear();
            ddInvoice.Items.Add("All");
            ddInvoice.DataBind();
        }

        protected void ddBillingPeriod_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void gvInvoiceData_RowCreated(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow &&
                (e.Row.RowState == DataControlRowState.Normal ||
                e.Row.RowState == DataControlRowState.Alternate))
            {
                CheckBox chkBxSelect = (CheckBox)e.Row.Cells[1].FindControl("chkBxSelect");
                CheckBox chkBxHeader = (CheckBox)this.gvInvoiceData.HeaderRow.FindControl("chkBxHeader");
                chkBxSelect.Attributes["onclick"] = string.Format
                (
                    "javascript:ChildClick(this,'{0}');",
                    chkBxHeader.ClientID
                );
                trStatusUpdate.Visible = true;
            }
        }

        protected void btnStatusupdate_Click(object sender, EventArgs e)
        {
            
        }

        protected void ddNewStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddNewStatus.SelectedIndex != 0)
            {
                if (ddNewStatus.SelectedValue == "Billed")
                {
                    lblInvoiceNumber.Visible = true;
                    txbInvoiceNumber.Text = string.Empty;
                    txbInvoiceNumber.Visible = true;
                    txbInvoiceNumber.Focus();
                    btnStatusupdate.Visible = false;
                }
                else
                {
                    lblInvoiceNumber.Visible = false;
                    txbInvoiceNumber.Visible = false;
                    btnStatusupdate.Visible = true;
                }
                
            }
            else
            {
                btnStatusupdate.Visible = false;
                lblInvoiceNumber.Visible = false;
                txbInvoiceNumber.Visible = false;
            }
        }

        protected void txbInvoiceNumber_TextChanged(object sender, EventArgs e)
        {
            if ((txbInvoiceNumber.Text.Length) > 0)
            {
                btnStatusupdate.Visible = true;
            }
            else
            {
                btnStatusupdate.Visible = false;
            }
        }
        protected void gvInvoiceData_SelectedIndexChanged(Object sender, EventArgs e)
        {
            gvInvoiceData.Rows[gvInvoiceData.SelectedIndex].BackColor = System.Drawing.Color.Yellow;
        }

        protected void gvInvoiceData_RowDataBound(object sender, GridViewRowEventArgs e)
        {
 
        }

        protected void chkBxSelect_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox chkStatus = (CheckBox)sender;
            GridViewRow gvrow = (GridViewRow)chkStatus.NamingContainer;
            bool status = chkStatus.Checked;
            if (gvrow.RowIndex > -1)
            { 
                if (status)//this is checkbox is unchecked then set backcolor to Gray
                {
                    gvrow.BackColor = System.Drawing.Color.LightGray;
                }
                else
                {
                    gvrow.BackColor = System.Drawing.Color.White;
                }
            }
        }
    }
}