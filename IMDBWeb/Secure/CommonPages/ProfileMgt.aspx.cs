using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IMDBWeb.Secure.CommonPages
{
    public partial class ProfileMgt : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lblErrMsg.Visible = false;
            lblMsg.Visible = false;
        }

        protected void btnNewProfile_Click(object sender, EventArgs e)
        {
            lblMsg.Visible = true;
            lblMsg.Text = "Enter all required values below";
            ddProfilename.Visible = false;
            btnNewProfile.Visible = false;
            lblProfileName.Visible = false;
            fvprofileInfo.ChangeMode(FormViewMode.Insert);
        }

        protected void UpdateCancel(object sender, EventArgs e)
        {
            ddProfilename.Items.Clear();
            ddProfilename.Items.Add(new ListItem("Select From List", "0"));
            ddProfilename.DataBind();
            ddProfilename.SelectedIndex = 0;
        }

        protected void InsertCancel(object sender, EventArgs e)
        {
            fvprofileInfo.ChangeMode(FormViewMode.Edit); 
            ddProfilename.Items.Clear();
            ddProfilename.Items.Add(new ListItem("Select From List", "0"));
            ddProfilename.DataBind();
            ddProfilename.SelectedIndex = 0;
            lblMsg.Visible = false;
            ddProfilename.Visible = true;
            btnNewProfile.Visible = true;
            lblProfileName.Visible = true;
        }

        protected void ddProfilename_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblMsg.Text = "";
            lblMsg.Visible = false;
        }

        protected void sdsProfileInfo_Updating(object sender, SqlDataSourceCommandEventArgs e)
        {
            e.Command.Parameters["@Username"].Value = HttpContext.Current.User.Identity.Name.ToString();
        }

        protected void sdsProfileInfo_Updated(object sender, EventArgs e)
        {
            lblMsg.Visible = true;
            lblMsg.Text = "Updated!";
        }

        protected void sdsProfileInfo_Inserting(object sender, SqlDataSourceCommandEventArgs e)
        {
            e.Command.Parameters["@Username"].Value = HttpContext.Current.User.Identity.Name.ToString();
        }

        protected void sdsProfileInfo_Inserted(object sender, EventArgs e)
        {
            lblMsg.Visible = true;
            lblMsg.Text = "Inserted!";
            fvprofileInfo.ChangeMode(FormViewMode.Edit);
            ddProfilename.SelectedIndex = 0;
            lblProfileName.Visible = true;
            ddProfilename.Visible = true;
            btnNewProfile.Visible = true;
            fvprofileInfo.DataBind();
        }
    }
}