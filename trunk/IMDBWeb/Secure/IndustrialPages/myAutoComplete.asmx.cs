using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
	

    /// <summary>
    /// Summary description for myAutoComplete
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.Web.Script.Services.ScriptService]

    public class myAutoComplete : System.Web.Services.WebService
    {

        [WebMethod]
        public string[] GetOrderNums(string prefixText)
        {
            DataSet dtst = new DataSet();
            SqlConnection sqlCon = new SqlConnection();
            sqlCon.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
            String strSql = "SELECT DISTINCT OrderNumber FROM [RcvHdr] WHERE OrderNumber Like '" + prefixText + "%'";
            SqlCommand sqlComd = new SqlCommand(strSql, sqlCon);
            sqlCon.Open();
            SqlDataAdapter sqlAdpt = new SqlDataAdapter();
            sqlAdpt.SelectCommand = sqlComd;
            sqlAdpt.Fill(dtst);
            string [] ONum = new string[dtst.Tables[0].Rows.Count];
            int i = 0;

            try
            {
                foreach (DataRow rdr in dtst.Tables[0].Rows)
                {
                    ONum.SetValue(rdr["OrderNumber"].ToString(), i);
                    i++;
                }
            }
            catch 
            { 
            
            }
            finally
            {
                sqlCon.Close();
            }
            sqlCon.Close();
            return ONum;
        }

        [WebMethod]
        public string[] GetNewOrderNums(string prefixText)
        {
            DataSet dtst = new DataSet();
            SqlConnection sqlCon = new SqlConnection();
            sqlCon.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
            String strSql = "IMDB_Receive_Gano_OrderNum_Sel";
            SqlCommand sqlComd = new SqlCommand(strSql, sqlCon);
            sqlComd.CommandType = CommandType.StoredProcedure;
            sqlCon.Open();
            using (sqlComd)
            {
                sqlComd.Parameters.AddWithValue("@prefixtext", prefixText + "%");
            }
            SqlDataAdapter sqlAdpt = new SqlDataAdapter();
            sqlAdpt.SelectCommand = sqlComd;
            sqlAdpt.Fill(dtst);
            string[] ONum = new string[dtst.Tables[0].Rows.Count];
            int i = 0;

            try
            {
                foreach (DataRow rdr in dtst.Tables[0].Rows)
                {
                    ONum.SetValue(rdr["OrderNum"].ToString(), i);
                    i++;
                }
            }
            catch { }
            finally
            {
                sqlCon.Close();
            }
            sqlCon.Close();
            return ONum;
        }

        [WebMethod]
        public string[] GetClientName(string prefixText)
        {
            DataSet dtst = new DataSet();
            SqlConnection sqlCon = new SqlConnection();
            sqlCon.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
            String strSql = "SELECT DISTINCT Name FROM Client c INNER JOIN rcvhdr r on c.id = r.clientname WHERE Name Like '" + prefixText + "%'";
            SqlCommand sqlComd = new SqlCommand(strSql, sqlCon);
            sqlCon.Open();
            SqlDataAdapter sqlAdpt = new SqlDataAdapter();
            sqlAdpt.SelectCommand = sqlComd;
            sqlAdpt.Fill(dtst);
            string[] CN = new string[dtst.Tables[0].Rows.Count];
            int i = 0;

            try
            {
                foreach (DataRow rdr in dtst.Tables[0].Rows)
                {
                    CN.SetValue(rdr["Name"].ToString(), i);
                    i++;
                }
            }
            catch { }
            finally
            {
                sqlCon.Close();
            }
            sqlCon.Close();
            return CN;
        }
        
        [WebMethod]
        public string[] GetBrandCodes(string prefixText)
        {
            DataSet dtst = new DataSet();
            SqlConnection sqlCon = new SqlConnection();
            sqlCon.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["IMDB_SQL"].ConnectionString;
            String strSql = "IMDB_Receive_GetBrandCodes_Sel";
            SqlCommand sqlComd = new SqlCommand(strSql, sqlCon);
            sqlComd.CommandType = CommandType.StoredProcedure;
            sqlCon.Open();
            using (sqlComd)
            {
                sqlComd.Parameters.AddWithValue("@prefixtext", prefixText + "%");
            }
            SqlDataAdapter sqlAdpt = new SqlDataAdapter();
            sqlAdpt.SelectCommand = sqlComd;
            sqlAdpt.Fill(dtst);
            string[] CN = new string[dtst.Tables[0].Rows.Count];
            int i = 0;

            try
            {
                foreach (DataRow rdr in dtst.Tables[0].Rows)
                {
                    CN.SetValue(rdr["Product"].ToString(), i);
                    i++;
                }
            }
            catch { }
            finally
            {
                sqlCon.Close();
            }
            sqlCon.Close();
            return CN;
        }

    }


