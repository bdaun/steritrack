using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IMDBWeb.Secure.deskTopPages
{
    public partial class Improvements : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                gvComments.EmptyDataText = "There are no open Improvements, Issues, or Comments at this time";
            }
        }
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            gvComments.DataBind();
        }
        protected void btnInsert_Click(object sender, EventArgs e)
        {
            fvInsertComment.Visible = true;
            TextBox txbComm = fvInsertComment.FindControl("CommentTextBox") as TextBox;
            txbComm.Text = "";
        }
        protected void ddSubmitterName_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddSubmitterName.SelectedIndex != 0)
            {
                fvInsertComment.Visible = false;
                btnInsert.Visible = true;
                gvComments.DataBind();
            }
        }
        protected void InsertCancelButton_OnClick(object sender, EventArgs e)
        {
            fvInsertComment.Visible = false;
        }
        protected void sdsComments_Inserting(object sender, SqlDataSourceCommandEventArgs e)
        {
            e.Command.Parameters["@ModBy"].Value = HttpContext.Current.User.Identity.Name.ToString();
        }
        protected void sdsComments_Inserted(Object source, SqlDataSourceStatusEventArgs e)
        {
            gvComments.DataBind();
            fvInsertComment.Visible = false;
            btnInsert.Visible = true;
        }
        protected void sdsComments_Updating(object sender, SqlDataSourceCommandEventArgs e)
        {
            e.Command.Parameters["@ModBy"].Value = HttpContext.Current.User.Identity.Name.ToString();
        }
        protected void sdsComments_Updated(Object source, SqlDataSourceStatusEventArgs e)
        {
            gvComments.DataBind();
            fvInsertComment.Visible = false;
            btnInsert.Visible = true;
        }

        protected void ddStatus_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            ddStatus.SelectedIndex = 0;
            ddSubmitterName.SelectedIndex = 0;
            gvComments.DataBind();
            fvInsertComment.DataBind();
        }
    }
}