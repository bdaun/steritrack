using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Security.Application;

namespace BEFOnTheWeb.Secure
{
    public partial class GrantManagement : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                gvGrantsAvailable.EmptyDataText = "You have not submitted any grants.  Click 'Start New Grant' button to begin the process";
                btnPrint.Visible = false;
                btnReset.Visible = false;
            }
            else
            {
                gvGrantsAvailable.EmptyDataText = "You have not submitted any grants.  Click 'Start New Grant' button to begin the process";
            }
        }
        protected void sdsGrantsAvailable_OnSelecting(object sender, SqlDataSourceSelectingEventArgs e)
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
            e.Command.Parameters["@Role"].Value = isAble.ToString();
        }
        protected void gvGrantsAvailable_RowEditing(object sender, GridViewEditEventArgs e)
        {
            {
                gvGrantsAvailable.SelectedIndex = -1;
                btnPrint.Visible = false;
            }
        }
        protected void gvGrantsAvailable_RowDataBound(Object sender, GridViewRowEventArgs e)
        {
            if ((e.Row.RowState == DataControlRowState.Normal) || (e.Row.RowState == DataControlRowState.Alternate))
            {
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    e.Row.Attributes.Add("onmouseover", "this.previous_color=this.style.backgroundColor;this.style.backgroundColor='#ceedfc'");
                    e.Row.Attributes.Add("onmouseout", "this.style.backgroundColor=this.previous_color");
                    e.Row.Attributes.Add("style", "cursor:pointer;");
                    e.Row.Attributes.Add("onclick", ClientScript.GetPostBackClientHyperlink(this.gvGrantsAvailable, "Select$" + e.Row.RowIndex));
                }
            }
        }
        protected void gvGrantsAvailable_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["CurGrantID"] = gvGrantsAvailable.SelectedDataKey.Value.ToString();
            gvGrantsAvailable.DataBind();
            fvGrantInfo.DataBind();
            btnPrint.Visible = true;
            btnReset.Visible = true;
        }
        protected void btnPrint_Click(Object sender, EventArgs e)
        {
            Session["ctrl"] = Panel1;
            ClientScript.RegisterStartupScript(this.GetType(), "onclick", "<script language=javascript>window.open('PrintLabel.aspx','PrintMe','height=300px,width=300px,scrollbars=1');</script>");
            Control ctrl = (Control)Session["ctrl"];
            PrintHelper.PrintWebControl(ctrl);
        }
        protected void btnReset_Click(object sender, EventArgs e)
        {
            btnPrint.Visible = false;
            btnReset.Visible = false;
            gvGrantsAvailable.SelectedIndex = -1;
            Session["CurGrantID"] = 0;
            gvGrantsAvailable.DataBind();
            fvGrantInfo.DataBind();
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
        protected void btnStep3ShowHide_Click(object sender, EventArgs e)
        {
            var DivStep3 = fvGrantInfo.Row.FindControl("Step3");
            if (DivStep3.Visible)
            {
                DivStep3.Visible = false;
                Button btnSH = fvGrantInfo.FindControl("btnStep3ShowHide") as Button;
                btnSH.Text = "Show Needs Assessment";
            }
            else
            {
                DivStep3.Visible = true;
                Button btnSH = fvGrantInfo.FindControl("btnStep3ShowHide") as Button;
                btnSH.Text = "Hide Needs Assessment";
            }
        }
        protected void btnStep4ShowHide_Click(object sender, EventArgs e)
        {
            var DivStep4 = fvGrantInfo.Row.FindControl("Step4");
            if (DivStep4.Visible)
            {
                DivStep4.Visible = false;
                Button btnSH = fvGrantInfo.FindControl("btnStep4ShowHide") as Button;
                btnSH.Text = "Show Goals and Objectives";
            }
            else
            {
                DivStep4.Visible = true;
                Button btnSH = fvGrantInfo.FindControl("btnStep4ShowHide") as Button;
                btnSH.Text = "Hide Goals and Objectives";
            }
        }
        protected void btnStep5ShowHide_Click(object sender, EventArgs e)
        {
            var DivStep5 = fvGrantInfo.Row.FindControl("Step5");
            if (DivStep5.Visible)
            {
                DivStep5.Visible = false;
                Button btnSH = fvGrantInfo.FindControl("btnStep5ShowHide") as Button;
                btnSH.Text = "Show Assessment/Evaluation";
            }
            else
            {
                DivStep5.Visible = true;
                Button btnSH = fvGrantInfo.FindControl("btnStep5ShowHide") as Button;
                btnSH.Text = "Hide Assessment/Evaluation";
            }
        }
        protected void btnStep6ShowHide_Click(object sender, EventArgs e)
        {
            var DivStep6 = fvGrantInfo.Row.FindControl("Step6");
            if (DivStep6.Visible)
            {
                DivStep6.Visible = false;
                Button btnSH = fvGrantInfo.FindControl("btnStep6ShowHide") as Button;
                btnSH.Text = "Show Expenditures";
            }
            else
            {
                DivStep6.Visible = true;
                Button btnSH = fvGrantInfo.FindControl("btnStep6ShowHide") as Button;
                btnSH.Text = "Hide Expenditures";
            }
        }
        protected void btnStep7ShowHide_Click(object sender, EventArgs e)
        {
            var DivStep7 = fvGrantInfo.Row.FindControl("Step7");
            if (DivStep7.Visible)
            {
                DivStep7.Visible = false;
                Button btnSH = fvGrantInfo.FindControl("btnStep7ShowHide") as Button;
                btnSH.Text = "Show Alt Funding";
            }
            else
            {
                DivStep7.Visible = true;
                Button btnSH = fvGrantInfo.FindControl("btnStep7ShowHide") as Button;
                btnSH.Text = "Hide Alt Funding";
            }
        }
    }
}