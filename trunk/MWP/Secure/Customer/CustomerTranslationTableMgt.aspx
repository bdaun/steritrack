<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CustomerTranslationTableMgt.aspx.cs" Inherits="MWP.Secure.CustomerTranslationTableMgt" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table>
        <tr>
            <td><asp:DropDownList ID="ddUnMatched" runat="server" DataSourceID="sdsUnmatchedDept" 
                DataTextField="CustomerDeptName" DataValueField="CustomerDeptName"></asp:DropDownList>
                <asp:SqlDataSource ID="sdsUnmatchedDept" runat="server" ConnectionString="<%$ ConnectionStrings:MPS_SQL %>" 
                    SelectCommand="Customer_UnmatchedDept_Sel" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
            <td><asp:DropDownList ID="ddDepts" runat="server" DataSourceID="sdsDepts"
                DataTextField="Dept" DataValueField="ID"></asp:DropDownList>
                <asp:SqlDataSource ID="sdsDepts" runat="server" ConnectionString="<%$ ConnectionStrings:MPS_SQL %>" 
                    SelectCommand="SELECT distinct [ID], [CustomerDepartmentName] as Dept FROM [CustomerDepartment]"></asp:SqlDataSource>
            </td>
        </tr>
    </table>
    
</asp:Content>
