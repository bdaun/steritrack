using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IMDBWeb.Secure.SPAKpages
{
    public partial class ProcessSite : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnNewSite_Click(object sender, EventArgs e)
        {
            fvSite.ChangeMode(FormViewMode.Insert);
        }
        protected void UpdateCancel(object sender, EventArgs e)
        {
            ddSitename.SelectedIndex = 0;
        }
        protected void InsertCancel(object sender, EventArgs e)
        {
            ddSitename.SelectedIndex = 0;
            fvSite.ChangeMode(FormViewMode.Edit);
        }
    }
}