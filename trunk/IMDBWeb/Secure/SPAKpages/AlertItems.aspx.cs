using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace IMDBWeb.Secure.SPAKPages
{
    public partial class AlertItems : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                tblInsert.Visible = false;
                tblSearch.Visible = true;
                lblErrMsg.Visible = false;
            }
        }
        protected void btnInsertShow_Click(object sender, EventArgs e)
        {
            txbAlertItem.Text = string.Empty;
            txbComment.Text = string.Empty;
            tblInsert.Visible = true;
            tblSearch.Visible = false;
            txbAlertItem_New.Focus();
            txbAlertItem.Text = string.Empty;
            gvAlertItems.EmptyDataText = string.Empty;
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            txbAlertItem_New.Text = string.Empty;
            txbComment.Text = string.Empty;
            tblInsert.Visible = false;
            tblSearch.Visible = true;
        }

        protected void btnShowActive_Click(object sender, EventArgs e)
        {
            txbAlertItem.Text = String.Empty;
            tblSearch.Visible = true;
            gvAlertItems.DataSourceID = "sdsAlertItem_Active";
            gvAlertItems.DataBind();
            gvAlertItems.EmptyDataText = "There are currently no active Alert Items.";
            lblErrMsg.Visible = false;            
        }

        protected void btnInsert_Click(object sender, EventArgs e)
        {
            /* ******************************** Algorithm *********************************************
             * Determine if the value already exists in the table.  
             *      If it does, show error message and return gridview with current value.
             *      If not, perform insert into SPAK_AlertItems table
            **************************************************************************************** */

            string spExist = "SPAK_AlertItem_Exist";
            string spIns = "SPAK_AlertItem_Ins";
            SqlConnection con = new SqlConnection();
            con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
            SqlCommand spCmdExist = new SqlCommand(spExist, con);
            SqlCommand spCmdIns = new SqlCommand(spIns, con);
            spCmdExist.CommandType = CommandType.StoredProcedure;
            spCmdIns.CommandType = CommandType.StoredProcedure;
            con.Open();
            using (spCmdExist)
            {
                try
                {
                    spCmdExist.Parameters.AddWithValue("@AlertItem", txbAlertItem_New.Text);
                    object isValid = new object();
                    isValid = spCmdExist.ExecuteScalar();
                    if (isValid == null)
                    {
                        using (spCmdIns)
                        {
                            try
                            {
                                spCmdIns.Parameters.AddWithValue("@AlertItem", txbAlertItem_New.Text);
                                spCmdIns.Parameters.AddWithValue("@Comment", txbComment.Text);
                                spCmdIns.Parameters.AddWithValue("@User", HttpContext.Current.User.Identity.Name.ToString());
                                spCmdIns.ExecuteNonQuery();
                                txbAlertItem.Text = txbAlertItem_New.Text;
                                tblSearch.Visible = true;
                                tblInsert.Visible = false;
                                gvAlertItems.DataBind();
                            }
                            catch (Exception ex)
                            {
                                lblErrMsg.Visible = true;
                                lblErrMsg.Text = ex.ToString();
                            }
                        }
                    }
                    else
	                {
                        lblErrMsg.Visible = true;
                        lblErrMsg.Text = "This Alert Item already exists in the system.  Please edit the existing value";
                        tblSearch.Visible = true;
                        txbAlertItem.Text = txbAlertItem_New.Text;
                        txbAlertItem_New.Text = string.Empty;
                        txbComment.Text = string.Empty;
                        tblInsert.Visible = false;
                        gvAlertItems.DataBind();
	                }
                }
                catch (Exception ex)
                {
                    lblErrMsg.Visible = true;
                    lblErrMsg.Text = ex.ToString();
                }
                finally
                {
                    con.Close();
                }
            }
        }
        protected void sdsAlertItem_Updating(Object sender, SqlDataSourceCommandEventArgs e)
        {
            e.Command.Parameters["@User"].Value = HttpContext.Current.User.Identity.Name.ToString();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            if ((txbAlertItem.Text != "")&&(txbAlertItem.Text != null))
            {
                lblErrMsg.Visible = false;
                gvAlertItems.DataSourceID = "sdsAlertItem";
                gvAlertItems.DataBind();
                gvAlertItems.EmptyDataText = "There were no values found for your search value.";
                lblErrMsg.Visible = false;
            }
            else
            {
                lblErrMsg.Visible = true;
                lblErrMsg.Text = "Please enter a value into the search box.";
                txbAlertItem.Focus();
            }
        }
    }
}