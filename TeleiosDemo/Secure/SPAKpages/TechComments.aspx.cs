using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TeleiosDemo.Secure.SPAKpages
{
    public partial class TechComments : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                btnInsert.Visible = false;
                DateTime dt = DateTime.Now.StartOfWeek(DayOfWeek.Monday);
                txbBeginDate.Text = dt.ToShortDateString();
                txbEndDate.Text = dt.AddDays(4).ToShortDateString();
                gvTechComments.EmptyDataText = "There are no records in this date range for this technician.";
            }  
        }
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            gvTechComments.DataBind();
        }
        protected void btnInsert_Click(object sender, EventArgs e)
        {
            fvInsertComment.Visible = true;
            Label lblTechID = fvInsertComment.FindControl("lblTechnicianID") as Label;
            if (lblTechID != null)
            {
                lblTechID.Text = ddTechName.SelectedValue.ToString();
            }
            Label lblTechName = fvInsertComment.FindControl("lblTechName") as Label;
            if (lblTechName != null)
            {
                lblTechName.Text = ddTechName.SelectedItem.ToString();
            }

            Label lblDate = fvInsertComment.FindControl("lblCommentDate") as Label;
            if (lblDate != null)
            {
                lblDate.Text = DateTime.Now.ToShortDateString();
            }

            TextBox txbComm = fvInsertComment.FindControl("CommentTextBox") as TextBox;
            txbComm.Text = "";
        }
        protected void ddTechName_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddTechName.SelectedIndex != 0)
            {
                fvInsertComment.Visible = false;
                btnInsert.Visible = true;
                gvTechComments.DataBind();
            }
        }
        protected void InsertCancelButton_OnClick(object sender, EventArgs e)
        {
            fvInsertComment.Visible = false;
        }
        protected void sdsTechcomments_Inserting(object sender, SqlDataSourceCommandEventArgs e)
        {
            e.Command.Parameters["@ModBy"].Value = HttpContext.Current.User.Identity.Name.ToString();
        }
        protected void sdsTechcomments_Inserted(Object source, SqlDataSourceStatusEventArgs e)
        {
            gvTechComments.DataBind();
            fvInsertComment.Visible = false;
            btnInsert.Visible = true;
        }
        protected void sdsTechcomments_Updating(object sender, SqlDataSourceCommandEventArgs e)
        {
            e.Command.Parameters["@ModBy"].Value = HttpContext.Current.User.Identity.Name.ToString();
        }
        protected void sdsTechcomments_Updated(Object source, SqlDataSourceStatusEventArgs e)
        {
            gvTechComments.DataBind();
            fvInsertComment.Visible = false;
            btnInsert.Visible = true;
        }
    }
}