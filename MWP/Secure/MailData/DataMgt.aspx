<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DataMgt.aspx.cs" Inherits="MWP.Secure.MailData.DataMgt" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <ajaxToolkit:ToolkitScriptManager ID="AjaxSM" runat="server" EnablePageMethods="true" />
    <h2>Data Management</h2>
<asp:Label ID="lblErrMsg" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" />
<table id="tblSearch" runat="server">
<tr><td colspan="2" style="font-style:italic">Enter your search criteria and click "Search"</td><td></td><td></td></tr>
<tr><td align="right">Customer:&nbsp;</td>
    <td><asp:DropDownList ID="ddCustomer" runat="server" DataSourceID="sdsCustomer" 
            AppendDataBoundItems="True" DataTextField="CustomerName" AutoPostBack="true" 
            DataValueField="CustomerID" >
            <asp:ListItem Text="Select from List" Value="0" />
            <asp:ListItem Text="All Customers" Value="-1" />
        </asp:DropDownList></td>
    <td align="right">DataSource:&nbsp;</td>
    <td><asp:DropDownList ID="ddDataSource" runat="server" DataSourceID="sdsDataSource"
            AppendDataBoundItems="true" DataTextField="DataSource" AutoPostBack="true"
            DataValueField="DataSource" onselectedindexchanged="ddDataSource_SelectedIndexChanged">
            <asp:ListItem Text="Select from List" Value="0" />
            <asp:ListItem Text="All DataSources" Value="-1" Selected="True" />
        </asp:DropDownList>
    </td>
</tr>
<tr id="trDept" runat="server" visible="true"><td align="right">Department:&nbsp;</td>
    <td><asp:DropDownList ID="ddDept" runat="server" DataSourceID="sdsCustomerDept" 
            AppendDataBoundItems="True" DataTextField="CustomerDeptName" AutoPostBack="true" 
            DataValueField="CustomerDeptID">
            <asp:ListItem Text="Select from List" Value="0" />
            <asp:ListItem Text="All Depts" Value="-1" Selected="True" />
        </asp:DropDownList></td><td>Mail Date Range:&nbsp;</td>
    <td><asp:TextBox ID="txbBegDate" runat="server" Width="75px" AutoPostBack="true" />
        <ajaxToolkit:TextBoxWatermarkExtender ID="wmBegDate" runat="server" TargetControlID="txbBegDate" WatermarkText="Begin Date" WatermarkCssClass="watermarked" />
        <ajaxToolKit:CalendarExtender ID="CalExBegDate" runat="server" TargetControlID="txbBegDate" />&nbsp;and&nbsp;
        <asp:TextBox ID="txbEndDate" runat="server" Width="75px" AutoPostBack="true" />
        <ajaxToolkit:TextBoxWatermarkExtender ID="wmEndDate" runat="server" TargetControlID="txbEndDate" WatermarkText="End Date" WatermarkCssClass="watermarked" />
        <ajaxToolKit:CalendarExtender ID="CalExEndDate" runat="server" TargetControlID="txbEndDate" />&nbsp;</td>
</tr>
<tr>
    <td colspan="2"><asp:Button ID="btnSearch" runat="server" Text="Search" onclick="btnSearch_Click" /> &nbsp;&nbsp;
                    <asp:Button ID="btnCancelSearch" runat="server" Text="Cancel" onclick="btnCancelSearch_Click" /></td><td></td><td></td><td></td>
</tr>
</table>
<asp:GridView ID="gvMailData" runat="server" DataKeyNames="MailID" AutoGenerateColumns="False" 
        DataSourceID="sdsMailData" AllowPaging="True" AllowSorting="True" CellPadding="4" ForeColor="#333333">
    <Columns>
        <asp:CommandField ShowEditButton="True" />
        <asp:CommandField ShowDeleteButton="True" />
        <asp:BoundField DataField="MailID" HeaderText="MailID" InsertVisible="False" ReadOnly="True" SortExpression="MailID" />
        <asp:BoundField DataField="DataSource" HeaderText="DataSource" ReadOnly="true" SortExpression="DataSource" />
        <asp:TemplateField HeaderText="CustomerName" SortExpression="CustomerName">
            <EditItemTemplate>
                <asp:DropDownList ID="ddCustomerName_gv" runat="server" 
                    SelectedValue='<%# Bind("CustomerID") %>' DataSourceID="sdsCustomer" 
                    DataTextField="CustomerName" DataValueField="CustomerID" />
                <ajaxtoolkit:CascadingDropDown ID="CustomerCascading" runat="server" Category="Customer" TargetControlID="ddCustomerName_gv" 
                    LoadingText="Loading Customers..." PromptText="Select Customer" ServiceMethod="BindCustomerdropdown" 
                    ServicePath="~/DropdownWebService.asmx"></ajaxtoolkit:CascadingDropDown>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="lblCustomerName" runat="server" Text='<%# Eval("CustomerName") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="DeptName" SortExpression="DeptName">
            <EditItemTemplate>
                <asp:DropDownList ID="ddDept_gv" runat="server" 
                    SelectedValue='<%# Bind("CustomerDeptID") %>' DataSourceID="sdsCustomerDept" 
                    DataTextField="CustomerDeptName" DataValueField="CustomerDeptID" />
                <ajaxtoolkit:CascadingDropDown ID="DeptCascading" runat="server" Category="Dept" TargetControlID="ddDept_gv" 
                    LoadingText="Loading Depts..." PromptText="Select Dept" ServiceMethod="BindDeptdropdown" ParentControlID="ddCustomerName_gv" 
                    ServicePath="~/DropdownWebService.asmx"></ajaxtoolkit:CascadingDropDown>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="lblCustomerName" runat="server" Text='<%# Eval("CustomerDeptName") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="Weight" HeaderText="Weight" SortExpression="Weight" />
        <asp:BoundField DataField="WeightUnit" HeaderText="WeightUnit" SortExpression="WeightUnit" />
        <asp:BoundField DataField="MailType" HeaderText="MailType" SortExpression="MailType" />
        <asp:BoundField DataField="RateLevel" HeaderText="RateLevel" SortExpression="RateLevel" />
        <asp:BoundField DataField="RateAffixed" HeaderText="RateAffixed" SortExpression="RateAffixed" />
        <asp:BoundField DataField="RateClaimed" HeaderText="RateClaimed" SortExpression="RateClaimed" />
        <asp:BoundField DataField="MailQty" HeaderText="MailQty" SortExpression="MailQty" />
        <asp:BoundField DataField="DataDate" HeaderText="DataDate" SortExpression="DataDate" />
    </Columns>
</asp:GridView>
<asp:SqlDataSource ID="sdsMailData" runat="server" 
    ConnectionString="<%$ ConnectionStrings:MPS_SQL %>" 
    SelectCommand="DataMgt_MailData_Sel" SelectCommandType="StoredProcedure">
    <SelectParameters>
    <asp:ControlParameter ControlID="ddCustomer" Name="CustomerID" PropertyName="SelectedValue" Type="String" DefaultValue="0"/>
    <asp:ControlParameter ControlID="ddDept" Name="CustomerDeptID" PropertyName="SelectedValue" Type="String" DefaultValue="0"/>
    <asp:ControlParameter ControlID="ddDataSource" Name="DataSource" PropertyName="SelectedValue" Type="String" DefaultValue="0"/>
    <asp:ControlParameter ControlID="txbBegDate" Name="BegDate" PropertyName="Text" Type="String" DefaultValue="01/01/1900" />
    <asp:ControlParameter ControlID="txbEndDate" Name="EndDate" PropertyName="Text" Type="String" DefaultValue="01/01/2200" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="sdsCustomer" runat="server" 
    ConnectionString="<%$ ConnectionStrings:MPS_SQL %>" 
    SelectCommand="DataMgt_Customer_Sel" SelectCommandType="StoredProcedure">
</asp:SqlDataSource> 
<asp:SqlDataSource ID="sdsCustomerDept" runat="server" 
    ConnectionString="<%$ ConnectionStrings:MPS_SQL %>" 
    SelectCommand="DataMgt_CustomerDept_Sel" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:ControlParameter ControlID="ddCustomer" Name="CustomerID" Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="sdsDataSource" runat="server" 
    ConnectionString="<%$ ConnectionStrings:MPS_SQL %>" 
    SelectCommand="DataMgt_DataSource_Sel" SelectCommandType="StoredProcedure">
</asp:SqlDataSource> 
</asp:Content>
