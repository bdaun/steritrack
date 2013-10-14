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
    }
}