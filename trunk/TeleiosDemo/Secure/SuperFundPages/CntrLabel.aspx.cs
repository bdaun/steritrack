using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TeleiosDemo.Secure.SuperFundPages
{
    public partial class CntrLabel : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }
        protected void btnPrint_Click(object sender, EventArgs e)
        {
            Session["ctrl"] = Panel1;
            ClientScript.RegisterStartupScript(this.GetType(), "onclick", "<script language=javascript>window.open('PrintLabel.aspx','PrintMe','height=300px,width=300px,scrollbars=1');</script>");
        }
    }

}