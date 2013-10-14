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
            lblErrMsg.Visible = false;
            lblMsg.Visible = false;
        }

        protected void btnNewSite_Click(object sender, EventArgs e)
        {
            lblMsg.Visible = true;
            lblMsg.Text = "Enter a unique Sitename and SiteCode and select if site should prompt for 10d warnings";
            ddSitename.Visible = false;
            btnNewSite.Visible = false;
            lblSiteName.Visible = false;
            fvSite.ChangeMode(FormViewMode.Insert);
        }
        protected void UpdateCancel(object sender, EventArgs e)
        {
            ddSitename.Items.Clear();
            ddSitename.Items.Add(new ListItem("Select From List","0"));
            ddSitename.DataBind();
            ddSitename.SelectedIndex = 0;
        }
        protected void InsertCancel(object sender, EventArgs e)
        {
            ddSitename.Visible = true;
            btnNewSite.Visible = true;
            lblSiteName.Visible = true;
            ddSitename.SelectedIndex = 0;
            fvSite.ChangeMode(FormViewMode.Edit);
        }
        protected void sdsSiteInfo_OnUpdating(Object sender, SqlDataSourceCommandEventArgs e)
        {
            e.Command.Parameters["@UserName"].Value = HttpContext.Current.User.Identity.Name.ToString();
        }
        protected void sdsSiteInfo_OnUpdated(object sender, EventArgs e)
        {
            lblMsg.Visible = true;
            if (lblMsg.Text.ToString() == "Updated!")
            {
                lblMsg.Text = "Updated!!!";
            }
            else
            {
                lblMsg.Text = "Updated!";
            }
            ddSitename.Items.Clear();
            ddSitename.Items.Add(new ListItem("Select from List", "0"));
            ddSitename.DataBind();
        }

        protected void sdssiteInfo_OnInserting(Object sender, SqlDataSourceCommandEventArgs e)
        {
            e.Command.Parameters["@UserName"].Value = HttpContext.Current.User.Identity.Name.ToString();
        }

        protected void sdsSiteInfo_OnInserted(object sender, EventArgs e)
        {
            lblMsg.Visible = true;
            lblMsg.Text = "Inserted!";
            ddSitename.Items.Clear();
            ddSitename.Items.Add(new ListItem("Select from List", "0"));
            ddSitename.DataBind();
            lblSiteName.Visible = true;
            ddSitename.Visible = true;
            btnNewSite.Visible = true;
        }
        protected void ddSitename_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblMsg.Visible = false;
            lblErrMsg.Visible = false;
            fvSite.ChangeMode(FormViewMode.Edit);
        }
    }
}