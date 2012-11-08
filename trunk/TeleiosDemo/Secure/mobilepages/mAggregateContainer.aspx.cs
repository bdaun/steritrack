using System;
using System.Web;
using System.Data;
using System.Data.SqlClient;

namespace TeleiosDemo.Secure.mobilepages
{
    public partial class AggregateContainer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblErrMsg.Visible = false;
                lblErrMsg.Text = "";
                lblCurCntr.Visible = false;
                lblCurValue.Visible = false;
                lblNewCntr.Visible = false;
                txbNewCntr.Visible = false;
                btnCancel.Visible = false;
                ddContainer.Focus();
            }
        }
        protected void txbNewContainer_TextChanged(object sender, EventArgs e)
        {
            if (txbNewCntr.Text != "")
            {
                string sp = "IMDB_Aggrcntr_upd";
                SqlConnection upd = new SqlConnection();
                upd.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
                SqlCommand updCmd = new SqlCommand(sp, upd);
                updCmd.CommandType = CommandType.StoredProcedure;
                upd.Open();

                using (updCmd)
                {
                    try
                    {
                        updCmd.Parameters.AddWithValue("@newcntrid", txbNewCntr.Text.ToString());
                        updCmd.Parameters.AddWithValue("@cntrname", ddContainer.SelectedValue.ToString());
                        updCmd.Parameters.AddWithValue("@modby", HttpContext.Current.User.Identity.Name.ToString());
                        updCmd.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        lblErrMsg.Visible = true;
                        lblErrMsg.Text = ex.ToString();
                    }
                    finally
                    {
                        upd.Close();
                        txbNewCntr.Text = "";
                        lblErrMsg.Visible = true;
                        lblErrMsg.Text = "Updated!";
                        lblCurCntr.Visible = false;
                        lblCurValue.Visible = false;
                        lblNewCntr.Visible = false;
                        txbNewCntr.Visible = false;
                        ddContainer.SelectedIndex = 0;
                    }
                }
            }
        }
        protected void ddContainer_SelectedIndexChanged(object sender, EventArgs e)
        {
            btnCancel.Visible = true;
            txbNewCntr.Text = "";
            lblErrMsg.Visible = false;
            if (ddContainer.SelectedIndex != 0)
            {
                    lblErrMsg.Visible = false;
                    lblCurCntr.Visible = true;
                    lblCurValue.Visible = true;
                    lblNewCntr.Visible = true;
                    txbNewCntr.Visible = true;
                    txbNewCntr.Focus();

                    string sp = "IMDB_AggCntr_Select";
                    SqlConnection sel = new SqlConnection();
                    sel.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
                    SqlCommand selCmd = new SqlCommand(sp, sel);
                    selCmd.CommandType = CommandType.StoredProcedure;
                    sel.Open();
                    using (selCmd)
                        try
                        {
                            selCmd.Parameters.AddWithValue("@CntrName", ddContainer.SelectedValue.ToString());
                            object CurCntrID = new object();
                            CurCntrID = selCmd.ExecuteScalar();
                            if (CurCntrID == null)
                            {
                                lblErrMsg.Visible = true;
                                lblErrMsg.Text = "There is an issue with this container.  Please see the Database Administrator";
                                lblCurCntr.Visible = false;
                                lblCurValue.Visible = false;
                                lblNewCntr.Visible = false;
                                txbNewCntr.Visible = false;
                                ddContainer.SelectedIndex = 0;
                            }
                            else
                            {
                                lblCurValue.Text = CurCntrID.ToString();
                            }


                        }
                        catch (Exception ex)
                        {
                            lblErrMsg.Visible = true;
                            lblErrMsg.Text = ex.ToString();
                        }
                        finally
                        {
                            sel.Close();
                        }
            }
            else
            {
                lblErrMsg.Visible = false;
                lblCurCntr.Visible = false;
                lblCurValue.Visible = false;
                lblNewCntr.Visible = false;
                txbNewCntr.Visible = false;
            }
        }
        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect(Request.RawUrl);
            return;
        }
    }
}