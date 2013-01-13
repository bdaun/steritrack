<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="InvoiceSummary.aspx.cs" Inherits="MWP.Secure.Invoice.InvoiceSummary" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <ajaxToolkit:ToolkitScriptManager ID="AjaxSM" runat="server" EnablePageMethods="true" />
    <h2>Invoice Summary Page</h2>
    <asp:Label ID="lblErrMsg" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" />
<table id="tblSearch" runat="server">
<tr><td colspan="2" style="font-style:italic">Enter your search criteria and click "Search"</td><td></td><td></td><td>
    &nbsp;</td><td>&nbsp;</td></tr>
<tr><td align="right">Billing Cycle:&nbsp;&nbsp;</td>
    <td>
        <asp:DropDownList ID="ddBillingCycle" runat="server" AutoPostBack="true"
            DataTextField="BillingCycle" DataValueField="BillingCycle" 
            onselectedindexchanged="ddBillingCycle_SelectedIndexChanged">
            <asp:ListItem Text="Select a Cycle" Value="NotSelected" />
            <asp:ListItem Text="Weekly" Value="Weekly" />
            <asp:ListItem Text="Semi-Monthly" Value="Semi-Monthly" />
            <asp:ListItem Text="Monthly" Value="Monthly" />
        </asp:DropDownList>
    </td>
    <td align="right">Data Date Year:&nbsp;</td><td>
        <asp:DropDownList ID="ddBillingYear" runat="server" AutoPostBack="true" 
            onselectedindexchanged="ddBillingYear_SelectedIndexChanged">
        </asp:DropDownList>
    </td>
    <td align="right"> Approval Status:&nbsp;</td>
    <td><asp:DropDownList ID="ddApproved" runat="server" AutoPostBack="True">
        <asp:ListItem Value="Unapproved" />
        <asp:ListItem Value="Approved" />
        <asp:ListItem Value="All" />
    </asp:DropDownList></td>
</tr>
<tr id="trCustomer" runat="server" visible="true"><td align="right">Customer:&nbsp;</td>
    <td><asp:DropDownList ID="ddCustomer" runat="server" DataSourceID="sdsCustomer" 
            AppendDataBoundItems="True" DataTextField="CustomerName" AutoPostBack="true" 
            DataValueField="CustomerID" 
            onselectedindexchanged="ddCustomer_SelectedIndexChanged" >
            <asp:ListItem Text="Select from List" Value="0" />
            <asp:ListItem Text="All Customers" Value="-1" />
        </asp:DropDownList></td><td>Data Date Range:&nbsp;</td>
    <td>
        <asp:DropDownList ID="ddBillingPeriod" runat="server">
        </asp:DropDownList>
</td>
    <td align="right">Billing Status:</td>
    <td><asp:DropDownList ID="ddBillingStatus" runat="server" AutoPostBack="True">
        <asp:ListItem Text="Not Billed" Value="" Selected="True" />
        <asp:ListItem Text="Billed" Value="_"  />
        <asp:ListItem Text="All" Value="All" />
    </asp:DropDownList></td>
</tr>
<tr id="trCustDept" runat="server" visible="false">
    <td align="right">Customer Dept:</td>
    <td><asp:DropDownList ID="ddDept" runat="server" DataSourceID="sdsCustomerDept" 
            AppendDataBoundItems="True" DataTextField="CustomerDeptName" AutoPostBack="true" 
            DataValueField="CustomerDeptID" 
            onselectedindexchanged="ddDept_SelectedIndexChanged">
            <asp:ListItem Text="Select from List" Value="0" />
            <asp:ListItem Text="All Depts" Value="-1" Selected="True" />
        </asp:DropDownList></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
</tr>
<tr>
    <td colspan="2"><asp:Button ID="btnSearch" runat="server" Text="Search" onclick="btnSearch_Click" /> &nbsp;&nbsp;
                    <asp:Button ID="btnCancelSearch" runat="server" Text="Cancel" onclick="btnCancelSearch_Click" /></td><td></td><td>
    </td>
    <td>
        &nbsp;</td>
    <td>
        &nbsp;</td>
</tr>
</table>
<asp:GridView ID="gvInvoiceData" runat="server" DataSourceID="sdsInvoiceData" DataKeyNames="CustomerDeptID" AutoGenerateColumns="false">
    <Columns>
        <asp:BoundField DataField="CustomerID" HeaderText="CustomerID" InsertVisible="False" ReadOnly="True" SortExpression="CustomerID" Visible="false" />
        <asp:BoundField DataField="customername" HeaderText="customername" SortExpression="customername" />
        <asp:BoundField DataField="CustomerDeptID" HeaderText="CustomerDeptID" InsertVisible="False" ReadOnly="True" SortExpression="CustomerDeptID" Visible="false" />
        <asp:BoundField DataField="customerdepartmentname" HeaderText="customerdepartmentname" SortExpression="customerdepartmentname" />
        <asp:BoundField DataField="Datasource" HeaderText="Datasource" SortExpression="Datasource" />
        <asp:BoundField DataField="MailType" HeaderText="MailType" SortExpression="MailType" />
        <asp:BoundField DataField="RateLevel" HeaderText="RateLevel" SortExpression="RateLevel" />
        <asp:BoundField DataField="RateAffixed" HeaderText="RateAffixed" SortExpression="RateAffixed" />
        <asp:BoundField DataField="RateClaimed" HeaderText="RateClaimed" SortExpression="RateClaimed" />
        <asp:BoundField DataField="MailQty" HeaderText="MailQty" SortExpression="MailQty" />
        <asp:BoundField DataField="DataDate" HeaderText="DataDate" SortExpression="DataDate" />
        <asp:BoundField DataField="Approved" HeaderText="Approved" SortExpression="Approved" />
        <asp:BoundField DataField="InvoiceNumber" HeaderText="InvoiceNumber" SortExpression="InvoiceNumber" />
    </Columns>
</asp:GridView>

<asp:SqlDataSource ID="sdsInvoiceData" runat="server" 
    ConnectionString="<%$ ConnectionStrings:MPS_SQL %>" 
    SelectCommand="Invoice_Summary_Sel" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:Parameter Name="CustomerID" Type="Int32" />
        <asp:Parameter Name="CustomerDepartmentID" Type="Int32" />
        <asp:controlParameter ControlID="ddApproved" Name="Approved" Type="String" />
        <asp:ControlParameter ControlID="ddBillingStatus" Name="BillingStatus" Type="String" />
    </SelectParameters></asp:SqlDataSource>
<asp:SqlDataSource ID="sdsCustomer" runat="server" 
    ConnectionString="<%$ ConnectionStrings:MPS_SQL %>" 
    SelectCommand="DataMgt_Customer_ByCycle_Sel" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:ControlParameter ControlID="ddBillingCycle" Name="BillingCycle" Type="String" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="sdsCustomerDept" runat="server" 
    ConnectionString="<%$ ConnectionStrings:MPS_SQL %>" 
    SelectCommand="DataMgt_CustomerDept_Sel" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:ControlParameter ControlID="ddCustomer" Name="CustomerID" Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>
</asp:Content>
