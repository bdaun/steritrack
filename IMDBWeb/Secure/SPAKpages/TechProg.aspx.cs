using System;
using System.Web;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;


namespace IMDBWeb.Secure.SPAKpages
{
    public partial class TechProg : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DateTime dt = DateTime.Now.StartOfWeek(DayOfWeek.Monday);
                txbBeginDate.Text = dt.ToShortDateString();
                txbEndDate.Text = dt.AddDays(6).ToShortDateString();
                gvTechName.EmptyDataText = "Please Select a CustomerRep, Technician, Customer, and date range";
                lblPhone.Visible = false;
            }
            else
            {
                gvTechName.EmptyDataText = "There were no Orders found for this CustomerRep, Customer, and date range";
            }
            if (ddCustRepList.SelectedIndex == 0)
            {
                ddCustRepList.Focus();
                return;
            }
            else if (ddTechName_CSRep.SelectedIndex == 0)
            {
                ddTechName_CSRep.Focus();
                return;
            }
            else if (ddCustomer.SelectedIndex == 0)
            {
                ddCustomer.Focus();
                return;
            }
            else if (txbBeginDate.Text == "")
            {
                txbBeginDate.Focus();
                return;
            }
            else if (txbEndDate.Text == "")
            {
                txbEndDate.Focus();
                return;
            }
            else
            {
                btnGO.Focus();
            }
        }
        protected void btnGo_Click(object sender, EventArgs e)
        {

        }
        protected void ddCustRepList_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddCustRepList.SelectedIndex != 0)
            {
                ddTechName_CSRep.DataBind();
                ddTechName_CSRep.Focus();
                return;
            }
            else
            {
                ddCustRepList.Focus();
                return;
            }
        }
        protected void gvTechName_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes.Add("onmouseover", "this.previous_color=this.style.backgroundColor;this.style.backgroundColor='#ceedfc'");
                e.Row.Attributes.Add("onmouseout", "this.style.backgroundColor=this.previous_color");
                e.Row.Attributes.Add("style", "cursor:pointer;");
                e.Row.Attributes.Add("onclick", ClientScript.GetPostBackClientHyperlink(this.gvTechName, "Select$" + e.Row.RowIndex));   

                if (e.Row.Cells[10].Text == "Shipped")
                {
                    e.Row.Cells[10].ForeColor = System.Drawing.Color.Green;
                    e.Row.Cells[10].Font.Bold = true;
                }
                else if (e.Row.Cells[10].Text == "WV")
                {
                    e.Row.Cells[10].ForeColor = System.Drawing.Color.Orange;
                    e.Row.Cells[10].Font.Bold = true;
                }
                else
                {
                    e.Row.Cells[10].ForeColor = System.Drawing.Color.Red;
                    e.Row.Cells[10].Font.Bold = true;
                }
                if(e.Row.Cells[9].Text == "Shipped")
                {
                    e.Row.Cells[9].ForeColor = System.Drawing.Color.Orange;
                    e.Row.Cells[9].Font.Bold = true;
                }
                else if (e.Row.Cells[9].Text == "Completed")
                {
                    e.Row.Cells[9].ForeColor = System.Drawing.Color.Green;
                    e.Row.Cells[9].Font.Bold = true;                    
                }
                else if (e.Row.Cells[9].Text == "Review")
                {
                    e.Row.Cells[9].ForeColor = System.Drawing.Color.Orchid;
                    e.Row.Cells[9].Font.Bold = true;
                }
            }
        }
        protected void gvTechName_SelectedIndexChanged(Object sender, EventArgs e)
        {
            GridViewRow row = gvTechName.SelectedRow;
            string curOrder = row.Cells[2].Text;

            //  Create if statement that uses selected value in sql to determine
            //  if insert is needed or update.

            String sp = "SP_SpaklogExists";
            SqlConnection con = new SqlConnection();
            con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
            SqlCommand spCmd = new SqlCommand(sp, con);
            spCmd.CommandType = CommandType.StoredProcedure;
            con.Open();
            using (spCmd)
            {
                spCmd.Parameters.AddWithValue("@ordernum", curOrder);
                object isValid = new object();
                isValid = spCmd.ExecuteScalar();
                if (isValid == null)
                {
                    // No record exists, so insert a new blank record into the table and show 
                    // the record details in update mode.

                    string insertSQL = "INSERT INTO Spak_CallInfo (ordernumber,custservrepid,status,PlannedVisitDate,moddate,modby)" +
                    "VALUES (@ordernum,@RepID,'WV',Getdate(),Getdate(),@User)";
                    SqlCommand cmdInsert = new SqlCommand(insertSQL, con);
                    using (cmdInsert)
                    {

                        // define insert parameters

                        cmdInsert.Parameters.AddWithValue("@ordernum", curOrder);
                        cmdInsert.Parameters.AddWithValue("@RepID", ddCustRepList.SelectedValue);
                        cmdInsert.Parameters.AddWithValue("@User", HttpContext.Current.User.Identity.Name.ToString());

                        // Execute query

                        cmdInsert.ExecuteNonQuery();
                        gvTechName.DataBind();
                    }
                }
            }
            con.Close();
            gvTechName.DataBind();
        }
        protected void sdsCallDetail_Updating(object sender, SqlDataSourceCommandEventArgs e)
        {
            e.Command.Parameters["@ModBy"].Value = HttpContext.Current.User.Identity.Name.ToString();
        }
        protected void sdsCallDetail_Updated(Object source, SqlDataSourceStatusEventArgs e)
        {
            gvTechName.DataBind();
        }
        protected void ddTechName_CSRep_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddTechName_CSRep.SelectedIndex != 0)
            {
                String sp = "SP_SpakTechPhone";
                SqlConnection con = new SqlConnection();
                con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
                SqlCommand spCmd = new SqlCommand(sp, con);
                spCmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                using (spCmd)
                {
                    spCmd.Parameters.AddWithValue("@TechnicianID", ddTechName_CSRep.SelectedValue.ToString());
                    object myPhone = new object();
                    myPhone = spCmd.ExecuteScalar();
                    if (myPhone != null)
                    {
                        lblPhone.Text = myPhone.ToString();
                        lblPhone.Visible = true;
                    }
                }
                con.Close();
            }
            else
            {
                lblPhone.Text = "";
                lblPhone.Visible = false;
            }
            if (ddCustRepList.SelectedIndex == 0)
            {
                ddCustRepList.Focus();
                return;
            }
            else if (ddCustomer.SelectedIndex == 0)
            {
                ddCustomer.Focus();
                return;
            }
            else if (txbBeginDate.Text == "")
            {
                txbBeginDate.Focus();
                return;
            }
            else if (txbEndDate.Text == "")
            {
                txbEndDate.Focus();
                return;
            }
            else
            {
                btnGO.Focus();
                return;
            }
        }
    }
    public static class DateTimeExtensions
    {
        public static DateTime StartOfWeek(this DateTime dt, DayOfWeek startOfWeek)
        {
            int diff = dt.DayOfWeek - startOfWeek;
            if (diff < 0)
            {
                diff += 7;
            }
            return dt.AddDays(-1 * diff).Date;
        }
    } 
}

  