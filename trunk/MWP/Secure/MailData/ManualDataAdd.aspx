<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManualDataAdd.aspx.cs" Inherits="MWP.Secure.MailData.ManualDataAdd" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <ajaxToolkit:ToolkitScriptManager ID="AjaxSM" runat="server" EnablePageMethods="true" />
    <h2>Data Entry Page</h2>
    <asp:Label ID="lblErrMsg" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" />
<table>
<tr>
    <td colspan="6" style="font-style:italic">Add items to the billable items table</td>
</tr>
<tr align="center" style="font-weight:bold">
    <td>Customer</td>
    <td>Department</td>
    <td>Entry&nbsp; Desc</td>
    <td>Pc Cnt</td>
    <td>Amount</td>
    <td>DataDate</td>
</tr>
<tr id="trCustDept" align="center">
    <td><asp:DropDownList ID="ddCustomer" runat="server" DataSourceID="sdsCustomer" 
            AppendDataBoundItems="True" DataTextField="CustomerName" AutoPostBack="true" 
            DataValueField="CustomerID" 
            onselectedindexchanged="ddCustomer_SelectedIndexChanged" >
            <asp:ListItem Text="Select from List" Value="0" />
        </asp:DropDownList></td><td><asp:DropDownList ID="ddDept" runat="server" DataSourceID="sdsCustomerDept" 
            AppendDataBoundItems="True" DataTextField="CustomerDeptName" AutoPostBack="true" 
            DataValueField="CustomerDeptID" OnSelectedIndexChanged="ddDept_SelectedIndexChanged">
            <asp:ListItem Text="Select from List" Value="0" />
            <asp:ListItem Text="All Depts" Value="-1" Selected="True" />
        </asp:DropDownList></td><td>
        <asp:DropDownList ID="ddEntryType" runat="server" AutoPostBack="true" Height="19px" OnSelectedIndexChanged="ddEntryType_SelectedIndexChanged" >
            <asp:ListItem Text="Select from List" Value="0" />
            <asp:ListItem Text="2 oz. + Bump up" Value="1" />
            <asp:ListItem Text="Foreign" Value="2" />
            <asp:ListItem Text="No Postage at all" Value="3" />
            <asp:ListItem Text="Wrong weight" Value="4" />
        </asp:DropDownList>
    </td>
    <td><asp:TextBox ID="txbPcCnt" runat="server" Width="75" OnTextChanged="txbPcCnt_TextChanged"></asp:TextBox></td>
    <td><asp:TextBox ID="txbAmt" runat="server" Width="100" OnTextChanged="txbAmt_TextChanged"></asp:TextBox></td>
    <td><asp:TextBox ID="txbDataDate" runat="server" Width="100" OnTextChanged="txbDataDate_TextChanged"></asp:TextBox></td>
    <ajaxToolkit:CalendarExtender ID="calDataDate" runat="server" TargetControlID="txbDataDate" />
    <ajaxToolkit:TextBoxWatermarkExtender ID="wmDataDate" runat="server" TargetControlID="txbDataDate" WatermarkText="Data Date" WatermarkCssClass="watermarked" />
</tr>
<tr>
    <td><asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" CausesValidation="true" /></td>
    <td><asp:Label ID="lblResult" runat="server" Visible="false" Font-Bold="true" Font-Italic="true" ForeColor="Green" /></td><td></td><td></td><td></td><td></td>
</tr>
</table>
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
</asp:Content>
