using System;
using System.Web.UI.WebControls;
using System.Data;



namespace TeleiosDemo.Secure.SPAKpages
{
    public partial class GridViewGrouping : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblRecordCount.Visible = false;
                txbRecordCount.Visible = false;
                btnExport.Visible = false;
                hr1.Visible = false;
                gvSummaryData.EmptyDataRowStyle.ForeColor = System.Drawing.Color.ForestGreen;
                gvSummaryData.EmptyDataRowStyle.Font.Italic = true;
                gvSummaryData.EmptyDataText = "To begin, please select a value for Customer Rep. ";
                DateTime dt = DateTime.Now.StartOfWeek(DayOfWeek.Monday);
                txbBegDate.Text = dt.ToShortDateString();
                txbEndDate.Text = dt.AddDays(6).ToShortDateString();
            }
            else
            {
                lblRecordCount.Visible = true;
                txbRecordCount.Visible = true;
                btnExport.Visible = true;
                hr1.Visible = true;
                gvSummaryData.EmptyDataRowStyle.ForeColor = System.Drawing.Color.Red;
                gvSummaryData.EmptyDataRowStyle.Font.Bold = true;
                gvSummaryData.EmptyDataText = "There were no records found.  Please try using fewer criteria.  Note, you must select a value for Customer Rep. ";

                GridViewHelper helper = new GridViewHelper(this.gvSummaryData);
                if (chkGroupRep.Checked)
                {
                    helper.RegisterGroup("CustServRepID", true, true);
                }
                else
                {
                    gvSummaryData.Columns[2].Visible = true;
                }
                if (chkGroupTech.Checked)
                {
                    helper.RegisterGroup("TechName", true, true);
                }
                else
                {
                    gvSummaryData.Columns[3].Visible = true;
                }
                if (chkGroupRep.Checked || chkGroupTech.Checked)
                {
                    helper.GroupHeader += new GroupEvent(helper_GroupHeader);
                    helper.ApplyGroupSort();
                }
                else
                { 
                    gvSummaryData.DataBind();
                }
            }
            gvSummaryData.DataBind();
            txbRecordCount.Text = gvSummaryData.Rows.Count.ToString();
        }
        private void helper_GroupHeader(string groupName, object[] values, GridViewRow row)
        {
            if (groupName == "CustServRepID")
            {
                row.BackColor = System.Drawing.Color.Khaki;
                row.Cells[0].Text = "&nbsp;&nbsp;" + row.Cells[0].Text;
            }
            else if (groupName == "TechName")
            {
                row.BackColor = System.Drawing.Color.Cornsilk;
                row.Cells[0].Text = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + row.Cells[0].Text;
            }
        } 
        protected void ddCustomerRep_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddCustomerRep.SelectedIndex!= 0)
            {
                ddTechName.DataBind();
                ddTechName.Focus();
            }
            else
            {
                ddCustomerRep.Focus();
                return;
            } 
        }
        protected void ddTechName_SelectedIndexChanged(object sender, EventArgs e)
        {
            gvSummaryData.DataBind();
        }
        protected void ddCustomer_SelectedIndexChanged(object sender, EventArgs e)
        {
            gvSummaryData.DataBind();
        }
        protected void txbSiteName_TextChanged(object sender, EventArgs e)
        {
            gvSummaryData.DataBind();
        }
        protected void txb_TextChanged(object sender, EventArgs e)
        {
            gvSummaryData.DataBind();
        }
        protected void txbSiteState_TextChanged(object sender, EventArgs e)
        {
            gvSummaryData.DataBind();
        }
        protected void txbBegDate_TextChanged(object sender, EventArgs e)
        {
            gvSummaryData.DataBind();
        }
        protected void txbEndDate_TextChanged(object sender, EventArgs e)
        {
            gvSummaryData.DataBind();
        }
        protected void ddSSpakStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            gvSummaryData.DataBind();
        }
        protected void ddCallStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            gvSummaryData.DataBind();
        }
        protected void gvSummaryData_PreRender(object sender, EventArgs e)
        {
            gvSummaryData.DataBind();
            txbRecordCount.Text = gvSummaryData.Rows.Count.ToString();
        }
        protected void gvSummaryData_RowDataBound(object sender, GridViewRowEventArgs e)
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (e.Row.Cells[1].Text == "Shipped")
                {
                    e.Row.Cells[1].ForeColor = System.Drawing.Color.Green;
                    e.Row.Cells[1].Font.Bold = true;
                }
                else if (e.Row.Cells[1].Text == "WV")
                {
                    e.Row.Cells[1].ForeColor = System.Drawing.Color.Orange;
                    e.Row.Cells[1].Font.Bold = true;
                }
                else
                {
                    e.Row.Cells[1].ForeColor = System.Drawing.Color.Red;
                    e.Row.Cells[1].Font.Bold = true;
                }
                if (e.Row.Cells[0].Text == "Shipped")
                {
                    e.Row.Cells[0].ForeColor = System.Drawing.Color.Orange;
                    e.Row.Cells[0].Font.Bold = true;
                }
                else if (e.Row.Cells[0].Text == "Completed")
                {
                    e.Row.Cells[0].ForeColor = System.Drawing.Color.Green;
                    e.Row.Cells[0].Font.Bold = true;
                }
                else if (e.Row.Cells[0].Text == "Review")
                {
                    e.Row.Cells[0].ForeColor = System.Drawing.Color.Orchid;
                    e.Row.Cells[0].Font.Bold = true;
                }
            } 
        }
        protected void btnExport_Click(object sender, EventArgs e)
        {
            GridViewExportUtil.Export("TechData.xls", this.gvExport);
        }
    }
}