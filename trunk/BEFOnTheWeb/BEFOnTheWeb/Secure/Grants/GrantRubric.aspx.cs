using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BEFOnTheWeb.Secure
{
    public partial class GrantRubric : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ddGrant.DataBind();
        }

        protected void sdsGrant_OnSelecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.Parameters["@UserName"].Value = HttpContext.Current.User.Identity.Name.ToString();
        }

        protected void sdsRubricInfo_OnInserting(object sender, SqlDataSourceCommandEventArgs e)
        {
            e.Command.Parameters["@UserName"].Value = HttpContext.Current.User.Identity.Name.ToString();
        }

        protected void sdsRubricInfo_OnUpdating(object sender, SqlDataSourceCommandEventArgs e)
        {
            e.Command.Parameters["@UserName"].Value = HttpContext.Current.User.Identity.Name.ToString();
        }

        protected void sdsRubricInfo_Inserted(object sender, SqlDataSourceStatusEventArgs e)
        {
            Response.Redirect("~/secure/grants/grantrubric.aspx");
        }

        protected void InsertCancelButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/secure/grants/grantrubric.aspx");
        }

        protected void UpdateCancelButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/secure/grants/grantrubric.aspx");
        }

        protected void lnkDownLoadRubric_Click(object sender, EventArgs e)
        {
            Response.ContentType = "application/pdf";
            Response.AppendHeader("Content-Disposition", "attachment; filename=2013Rubric.pdf");
            Response.TransmitFile(Server.MapPath("~/Secure/Grants/Files/2013Rubric.pdf"));
            Response.End();
        }
    }
}