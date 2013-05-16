using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IMDBWeb.Secure.Reports
{
    public partial class reportPages : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSPAKReports_Click(object sender, EventArgs e)
        {
            string url = "http://ganosql01/Reports/Pages/Folder.aspx?ItemPath=%2fSPAKReports&ViewMode=List";
            ScriptManager.RegisterStartupScript(this, typeof(Page), "RedirectTo", "window.open('" + url + "?random=' + Math.random())", true);
        }

        protected void btnIndustrialReports_Click(object sender, EventArgs e)
        {
            WebMsgBox.Show("We're still working on these!  Check back soon.");
        }
    }
}