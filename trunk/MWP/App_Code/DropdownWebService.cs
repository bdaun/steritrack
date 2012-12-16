using System;
using System.Collections;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Collections.Specialized;
using AjaxControlToolkit;
using System.Configuration;
using System.Data;

/// <summary>
/// Summary description for DropdownWebService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
[System.Web.Script.Services.ScriptService()]
public class DropdownWebService : System.Web.Services.WebService
{
   
   [WebMethod]
    public CascadingDropDownNameValue[] BindCustomerdropdown(string knownCategoryValues, string category)
    {
        SqlConnection conCustomer = new SqlConnection(ConfigurationManager.ConnectionStrings["MPS_SQL"].ConnectionString);
        conCustomer.Open();
        SqlCommand cmdCustomer = new SqlCommand("Select ID,CustomerName from Customer Order By CustomerName", conCustomer);
        SqlDataAdapter daCustomer = new SqlDataAdapter(cmdCustomer);
        cmdCustomer.ExecuteNonQuery();
        DataSet dsCustomer = new DataSet();
        daCustomer.Fill(dsCustomer);
        conCustomer.Close();
        List<CascadingDropDownNameValue> Customerdetails = new List<CascadingDropDownNameValue>();
        foreach(DataRow dtrow in dsCustomer.Tables[0].Rows)
        {
            string CustomerID = dtrow["ID"].ToString();
            string CustomerName = dtrow["CustomerName"].ToString();
            Customerdetails.Add(new CascadingDropDownNameValue(CustomerName,CustomerID));
        }
        return Customerdetails.ToArray();
    }
   [WebMethod]
   public CascadingDropDownNameValue[] BindDeptdropdown(string knownCategoryValues, string category)
   {
       int CustomerID;
       StringDictionary Customerdetails = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues);
       CustomerID = Convert.ToInt32(Customerdetails["Customer"]);
       SqlConnection conDept = new SqlConnection(ConfigurationManager.ConnectionStrings["MPS_SQL"].ConnectionString);
       conDept.Open();
       SqlCommand cmdDept = new SqlCommand("Select ID, CustomerDepartmentName from CustomerDepartment where CustomerID=@CustomerID Order By CustomerDepartmentName", conDept);
       cmdDept.Parameters.AddWithValue("@CustomerID", CustomerID);
       cmdDept.ExecuteNonQuery();
       SqlDataAdapter daDept = new SqlDataAdapter(cmdDept);
       DataSet dsDept = new DataSet();
       daDept.Fill(dsDept);
       conDept.Close();
       List<CascadingDropDownNameValue> Deptdetails = new List<CascadingDropDownNameValue>();
       foreach (DataRow dtDeptrow in dsDept.Tables[0].Rows)
       {
           string DeptID = dtDeptrow["ID"].ToString();
           string Deptname = dtDeptrow["CustomerDepartmentName"].ToString();
           Deptdetails.Add(new CascadingDropDownNameValue(Deptname, DeptID));
       }
       return Deptdetails.ToArray();
   }
}

