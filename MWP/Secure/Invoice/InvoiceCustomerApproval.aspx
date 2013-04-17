<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="InvoiceCustomerApproval.aspx.cs" Inherits="MWP.Secure.Invoice.InvoiceSummary" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
<script type="text/javascript">
        var TotalChkBx;
        var Counter;
        window.onload = function () {
            //Get total no. of CheckBoxes in side the GridView.
            TotalChkBx = parseInt('<%= this.gvInvoiceData.Rows.Count %>');
    //Get total no. of checked CheckBoxes in side the GridView.
    Counter = 0;
}

function HeaderClick(CheckBox) {
    //Get target base & child control.
    var TargetBaseControl =
        document.getElementById('<%= this.gvInvoiceData.ClientID %>');
    var TargetChildControl = "chkBxSelect";
    //Get all the control of the type INPUT in the base control.
    var Inputs = TargetBaseControl.getElementsByTagName("input");
    //Checked/Unchecked all the checkBoxes in side the GridView.
    for (var n = 0; n < Inputs.length; ++n)
        if (Inputs[n].type == 'checkbox' &&
                  Inputs[n].id.indexOf(TargetChildControl, 0) >= 0)
            Inputs[n].checked = CheckBox.checked;
    //Reset Counter
    Counter = CheckBox.checked ? TotalChkBx : 0;
}

    function ChildClick(CheckBox, HCheckBox) {
        //get target control.
        var HeaderCheckBox = document.getElementById(HCheckBox);
        //Modifiy Counter; 
        if (CheckBox.checked && Counter < TotalChkBx)
            Counter++;
        else if (Counter > 0)
            Counter--;
        //Change state of the header CheckBox.
        if (Counter < TotalChkBx)
            HeaderCheckBox.checked = false;
        else if (Counter == TotalChkBx)
            HeaderCheckBox.checked = true;
    }
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <ajaxToolkit:ToolkitScriptManager ID="AjaxSM" runat="server" EnablePageMethods="true" />
    <h2>Customer Invoice Data Approval Page</h2>
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
    <td align="right"> Status:&nbsp;</td>
    <td><asp:DropDownList ID="ddStatus" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddStatus_SelectedIndexChanged">
        <asp:ListItem Value="Unapproved" />
        <asp:ListItem Value="Approved" />
        <asp:ListItem Value="Billed" />
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
        <asp:DropDownList ID="ddBillingPeriod" runat="server" OnSelectedIndexChanged="ddBillingPeriod_SelectedIndexChanged" AutoPostBack="True">
        </asp:DropDownList>
</td>
    <td align="right">Invoice:</td>
    <td><asp:DropDownList ID="ddInvoice" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddInvoice_SelectedIndexChanged" 
        DataSourceID="sdsInvoiceNumbers" DataTextField="InvoiceNumber" DataValueField="InvoiceNumber" AppendDataBoundItems="True"   >
        <asp:ListItem Value="All" />
    </asp:DropDownList>
    </td>
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
    <td>&nbsp;</td>
</tr>
<tr>
    <td colspan="2"><asp:Button ID="btnSearch" runat="server" Text="Search" onclick="btnSearch_Click" /> &nbsp;&nbsp;
                    <asp:Button ID="btnCancelSearch" runat="server" Text="Cancel" onclick="btnCancelSearch_Click" /></td><td></td><td>
    </td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
</tr>
<tr id="trStatusUpdate" runat="server" visible="false">
    <td colspan="6">Update Selected Records to a status of&nbsp;&nbsp; 
        <asp:DropDownList ID="ddNewStatus" runat="server" OnSelectedIndexChanged="ddNewStatus_SelectedIndexChanged" AutoPostBack="true">
            <asp:ListItem Value="" Text="Select New Status" />
            <asp:ListItem Value="Unapproved" />
            <asp:ListItem Value="Approved" />
            <asp:ListItem Value="Billed" />
        </asp:DropDownList>&nbsp;&nbsp;
        <asp:Label ID="lblInvoiceNumber" runat="server" Text="InvoiceNumber:" Visible="false" />&nbsp;&nbsp;
        <asp:TextBox ID="txbInvoiceNumber" runat="server" Visible="false" OnTextChanged="txbInvoiceNumber_TextChanged" AutoPostBack="true" />
        <asp:Button ID="btnStatusupdate" runat="server" Text="Update" OnClick="btnStatusupdate_Click" Visible="false" />
    </td>
</tr>
</table>
<asp:GridView ID="gvInvoiceData" runat="server" DataSourceID="sdsInvoiceData" DataKeyNames="CustomerDeptID" CellPadding="2" 
     OnRowCreated="gvInvoiceData_RowCreated" OnSelectedIndexChanged="gvInvoiceData_SelectedIndexChanged" 
     OnRowDataBound="gvInvoiceData_RowDataBound" AutoGenerateColumns="False" AllowSorting="True">
    <Columns>
        <asp:BoundField DataField="CustomerID" HeaderText="CustomerID" Visible="False" ReadOnly="True" SortExpression="CustomerID" />
        <asp:BoundField DataField="CustomerName" HeaderText="Customer" SortExpression="customername" />
        <asp:BoundField DataField="CustomerDeptID" HeaderText="CustomerDeptID" Visible="False" ReadOnly="True" SortExpression="CustomerDeptID" />
        <asp:BoundField DataField="CustomerDepartmentName" HeaderText="Department" SortExpression="customerdepartmentname" />
        <asp:BoundField DataField="Datasource" HeaderText="Datasource" SortExpression="Datasource" />
        <asp:BoundField DataField="MailType" HeaderText="MailType" SortExpression="MailType" />
        <asp:BoundField DataField="RateLevel" HeaderText="RateLevel" SortExpression="RateLevel" />
        <asp:BoundField DataField="PostageAffixed" HeaderText="Postage Affixed" SortExpression="PostageAffixed" ItemStyle-HorizontalAlign="Right"
            HeaderStyle-Wrap="true" HeaderStyle-Width="65px" DataFormatString="{0:c2}" />
        <asp:BoundField DataField="PostageClaimed" HeaderText="Postage Claimed" SortExpression="PostageClaimed" ItemStyle-HorizontalAlign="Right"
            HeaderStyle-Wrap="true" HeaderStyle-Width="65px" DataFormatString="{0:c2}" />
        <asp:BoundField DataField="MailQty" HeaderText="MailQty" SortExpression="MailQty" ItemStyle-HorizontalAlign="Center" />
        <asp:BoundField DataField="DataDate" HeaderText="DataDate" SortExpression="DataDate" DataFormatString="{0:MM-dd-yyyy}" />
        <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
        <asp:BoundField DataField="InvoiceNumber" HeaderText="Invoice" SortExpression="InvoiceNumber" />
      <asp:TemplateField HeaderText="Select" >
         <HeaderTemplate>
            Select All<br /><asp:CheckBox ID="chkBxHeader" onclick="javascript:HeaderClick(this);" runat="server" 
                OnCheckedChanged="chkBxSelect_CheckedChanged" AutoPostBack="true" />
         </HeaderTemplate>         
         <ItemTemplate>
            <asp:CheckBox ID="chkBxSelect" runat="server" OnCheckedChanged="chkBxSelect_CheckedChanged" AutoPostBack="true" />
         </ItemTemplate>
         <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" Wrap="false" />
         <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
      </asp:TemplateField>
    </Columns>
</asp:GridView>
<asp:SqlDataSource ID="sdsInvoiceNumbers" runat="server" ConnectionString="<%$ ConnectionStrings:MPS_SQL %>" 
    SelectCommand="InvoiceApproval_InvoiceNumbers_Sel" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:ControlParameter ControlID="ddDept" Name="CustomerDeptID" PropertyName="SelectedValue" Type="Int32" />
        <asp:ControlParameter ControlID="ddCustomer" Name="CustomerID" PropertyName="SelectedValue" Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="sdsInvoiceData" runat="server" 
    ConnectionString="<%$ ConnectionStrings:MPS_SQL %>" 
    SelectCommand="InvoiceApproval_DataItems_Sel" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:ControlParameter ControlID="ddCustomer" Name="CustomerID" PropertyName="SelectedValue" Type="Int32" />
        <asp:ControlParameter ControlID="ddDept" Name="CustomerDepartmentID" PropertyName="SelectedValue" Type="Int32" />
        <asp:controlParameter ControlID="ddStatus" Name="Status" Type="String" />
        <asp:ControlParameter ControlID="ddInvoice" Name="InvoiceNumber" Type="String" />
        <asp:ControlParameter ControlID="ddBillingPeriod" Name="BillingPeriod" Type="String" DefaultValue="1/1/2001 - 1/1/2101" />
        <asp:ControlParameter ControlID="ddBillingCycle" Name="BillingCycle" Type="String" />
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
    SelectCommand="InvoiceApproval_CustomerDept_Sel" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:ControlParameter ControlID="ddCustomer" Name="CustomerID" Type="Int32" />
        <asp:ControlParameter ControlID="ddBillingCycle" Name="BillingCycle" Type="String" />
    </SelectParameters>
</asp:SqlDataSource>
</asp:Content>
