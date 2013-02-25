using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BEFOnTheWeb.Secure
{
	public partial class GrantManagement : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			if (!IsPostBack)
			{
				gvGrantInfo.EmptyDataText = "You have not submitted any grants.  Click 'Start New Grant' button to begin the process";
				btnPrint.Visible = false;
			}
			else
			{
				gvGrantInfo.EmptyDataText = "You have not submitted any grants.  Click 'Start New Grant' button to begin the process";
			}
			gvGrantInfo.DataBind();
		}

		protected void sdsGrant_OnSelecting(object sender, SqlDataSourceSelectingEventArgs e)
		{
			System.Web.HttpContext context = System.Web.HttpContext.Current;
			bool superUser = context.User.IsInRole("Admin")||context.User.IsInRole("PowerUser");
			string isAble = string.Empty;
			if (superUser)
			{ 
				isAble = "yo";
			}
			else
			{
	            isAble = "no";
			}
			e.Command.Parameters["@UserName"].Value = HttpContext.Current.User.Identity.Name.ToString();
			e.Command.Parameters["@role"].Value = isAble.ToString();
		}

		protected void gvGrantInfo_RowEditing(object sender, GridViewEditEventArgs e)
		{
			{
				gvGrantInfo.SelectedIndex = -1;
				btnPrint.Visible = false;
			}
		}

		protected void btnPrint_Click(Object sender, EventArgs e)
		{
			Session["ctrl"] = Panel1;
			ClientScript.RegisterStartupScript(this.GetType(), "onclick", "<script language=javascript>window.open('PrintLabel.aspx','PrintMe','height=300px,width=300px,scrollbars=1');</script>");
			Control ctrl = (Control)Session["ctrl"];
			PrintHelper.PrintWebControl(ctrl);
		}

		protected void gvGrantInfo_RowDataBound(Object sender, GridViewRowEventArgs e)
		{
			if ((e.Row.RowState == DataControlRowState.Normal) || (e.Row.RowState == DataControlRowState.Alternate))
			{
				if (e.Row.RowType == DataControlRowType.DataRow)
				{
					e.Row.Attributes.Add("onmouseover", "this.previous_color=this.style.backgroundColor;this.style.backgroundColor='#ceedfc'");
					e.Row.Attributes.Add("onmouseout", "this.style.backgroundColor=this.previous_color");
					e.Row.Attributes.Add("style", "cursor:pointer;");
					e.Row.Attributes.Add("onclick", ClientScript.GetPostBackClientHyperlink(this.gvGrantInfo, "Select$" + e.Row.RowIndex));
				}
			}
		}

		protected void btnStep1ShowHide_Click(object sender, EventArgs e)
		{
			var DivStep1 = fvGrantInfo.Row.FindControl("Step1");
			if (DivStep1.Visible)
			{
				DivStep1.Visible = false;
				Button btnSH = fvGrantInfo.FindControl("btnStep1ShowHide") as Button;
				btnSH.Text = "Show Basic Information";
			}
			else
			{
				DivStep1.Visible = true;
				Button btnSH = fvGrantInfo.FindControl("btnStep1ShowHide") as Button;
				btnSH.Text = "Hide Basic Information";
			}
		}

        protected void btnStep2ShowHide_Click(object sender, EventArgs e)
        {
            var DivStep2 = fvGrantInfo.Row.FindControl("Step2");
            if (DivStep2.Visible)
            {
                DivStep2.Visible = false;
                Button btnSH = fvGrantInfo.FindControl("btnStep2ShowHide") as Button;
                btnSH.Text = "Show Activity Description";
            }
            else
            {
                DivStep2.Visible = true;
                Button btnSH = fvGrantInfo.FindControl("btnStep2ShowHide") as Button;
                btnSH.Text = "Hide Activity Description";
            }
        }
	}
}