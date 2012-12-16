using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Web.Security;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

namespace MWP.Secure.MailData
{
    public partial class DataMgt : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            if (ddCustomer.SelectedIndex == 0)
            {
                WebMsgBox.Show("You must select a customer!");

            }
        }

        protected void btnCancelSearch_Click(object sender, EventArgs e)
        {
            ddCustomer.SelectedIndex = 0;
            ddDept.SelectedIndex = 0;
            ddDataSource.SelectedIndex = 0;
            txbBegDate.Text = string.Empty;
            txbEndDate.Text = string.Empty;
        }

        protected void ddDataSource_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}