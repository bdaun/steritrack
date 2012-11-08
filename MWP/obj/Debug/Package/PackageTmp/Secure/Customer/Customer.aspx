<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Customer.aspx.cs" Inherits="MWP.Secure.Customer.Customer" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<h2>Customer Management</h2>
<asp:ScriptManager ID="SM1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
<table id="tblBegin" runat="server">
<tr id="trBegin">
    <td style="font-style:italic">To begin, Select&nbsp;
    <asp:Button ID="btnSearchCustomer" runat="server" Text="Search Existing Customers" onclick="btnSearchCustomer_Click" />&nbsp;or&nbsp;
    <asp:Button ID="btnNewCustomer" runat="server" Text="Create New Customer" onclick="btnNewCustomer_Click" /></td></tr></table>
<table id="tblSearch" runat="server">
<tr><td colspan="2" style="font-style:italic">Enter your search criteria and click "Search"</td></tr>
<tr><td align="right">Customer:&nbsp;</td>
    <td><asp:DropDownList ID="ddCustomer" runat="server" DataSourceID="sdsCustomer" 
            AppendDataBoundItems="True" DataTextField="CustomerName" AutoPostBack="true" 
            DataValueField="CustomerID" onselectedindexchanged="ddCustomer_SelectedIndexChanged">
            <asp:ListItem Text="Select from List" Value="0" />
        </asp:DropDownList></td>
</tr>
<tr><td align="right">RcvDate Range:&nbsp;</td>
<td><asp:TextBox ID="txbBegDate" runat="server" Width="75px" AutoPostBack="true" />
        <ajaxToolkit:TextBoxWatermarkExtender ID="wmBegDate" runat="server" TargetControlID="txbBegDate" WatermarkText="Begin Date" WatermarkCssClass="watermarked" />
        <ajaxToolKit:CalendarExtender ID="CalExBegDate" runat="server" TargetControlID="txbBegDate" />&nbsp;and&nbsp;
        <asp:TextBox ID="txbEndDate" runat="server" Width="75px" AutoPostBack="true" />
        <ajaxToolkit:TextBoxWatermarkExtender ID="wmEndDate" runat="server" TargetControlID="txbEndDate" WatermarkText="End Date" WatermarkCssClass="watermarked" />
        <ajaxToolKit:CalendarExtender ID="CalExEndDate" runat="server" TargetControlID="txbEndDate" />
    </td></tr>
<tr><td></td>
    <td><asp:Button ID="btnSearch" runat="server" Text="Search" onclick="btnSearch_Click" /> &nbsp;&nbsp;
        <asp:Button ID="btnCancelSearch" runat="server" Text="Cancel" onclick="btnCancelSearch_Click" /></td></tr>
</table>
<asp:SqlDataSource ID="sdsCustomer" runat="server" 
    ConnectionString="<%$ ConnectionStrings:MWP_SQL %>" 
    SelectCommand="MWP_Customer_Customer_Sel" SelectCommandType="StoredProcedure">
</asp:SqlDataSource> 
</asp:Content>
