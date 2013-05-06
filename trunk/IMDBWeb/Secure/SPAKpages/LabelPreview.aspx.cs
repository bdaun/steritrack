using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CrystalDecisions.CrystalReports.Engine;

namespace IMDBWeb.Secure.SPAKpages
{
    public partial class LabelPreview : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //Control ctrl = (Control)Session["ctrl"];
            //PrintHelper.PrintWebControl(ctrl);
            ReportDocument reportdocument = new ReportDocument();
            reportdocument.Load(Server.MapPath("PreviewLabel.rpt"));
            crvPreviewLabel.ReportSource = reportdocument;
        }
    }
}