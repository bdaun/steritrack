using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;

namespace IMDBWeb.Secure.SPAKpages
{
    public partial class Labels : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void txbTruckDate_TextChanged(object sender, EventArgs e)
        {
            if (!Regex.IsMatch(txbTruckDate.Text, @"^(0[1-9]|1[012])[/](0[1-9]|[12][0-9]|3[01])[/][01]\d$"))
            {
                WebMsgBox.Show("Please use the format of mm/dd/yy");
                txbTruckDate.Text = string.Empty;
                txbTruckDate.Focus();
            }
        }

        protected void txbNumberContainers_TextChanged(object sender, EventArgs e)
        {
            if (!Regex.IsMatch(txbNumberContainers.Text, @"^[0-9]{1,3}$"))
            {
                WebMsgBox.Show("Please enter a value between 1 and 999");
                txbNumberContainers.Text = string.Empty;
                txbNumberContainers.Focus();
            }
        }

        protected void btnCreateLabel_Click(object sender, EventArgs e)
        {
            //check that values have been selected
            if (string.IsNullOrEmpty(txbNumberContainers.Text) || string.IsNullOrWhiteSpace(txbNumberContainers.Text) || Convert.ToInt32(txbNumberContainers.Text) < 1)
            {
                WebMsgBox.Show("Please enter a valid number of containers");
                txbNumberContainers.Focus();
            }
            else if (ddSiteSelect.SelectedIndex == 0)
            {
                WebMsgBox.Show("Please select a site from the dropdown list");
                ddSiteSelect.Focus();
            }
            else if(string.IsNullOrEmpty(txbTruckDate.Text)||string.IsNullOrWhiteSpace(txbTruckDate.Text))
            {
                WebMsgBox.Show("Please enter a valid date for the truck arrival");
                txbTruckDate.Focus();
            }
            else if(string.IsNullOrEmpty(txbTruckSeqNumber.Text)||string.IsNullOrWhiteSpace(txbTruckSeqNumber.Text))
            {
                WebMsgBox.Show("Please enter a truck sequence number in the format of ###");
                txbTruckSeqNumber.Focus();
            }
            else
	        {
                //Create labels

	        }
        }

        protected void txbTruckSeqNumber_TextChanged(object sender, EventArgs e)
        {

        }
    }
}