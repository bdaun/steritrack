using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MWP.Secure.MailData
{
    public partial class DataMgt : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ddCustomer_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            if (ddCustomer.SelectedIndex == 0)
            {

            }
        }

        protected void btnCancelSearch_Click(object sender, EventArgs e)
        {
            ddCustomer.SelectedIndex = 0;
        }
    }
}