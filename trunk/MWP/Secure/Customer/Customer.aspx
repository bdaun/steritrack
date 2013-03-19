﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Customer.aspx.cs" Inherits="MWP.Secure.Customer.Customer" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<h2>Customer Management</h2>
<asp:ScriptManager ID="SM1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
<asp:Label ID="lblErrMsg" runat="server" 
        style="color: #FF0000; font-weight: 700; background-color: #FFFFFF" />
<table id="tblBegin" runat="server">
<tr id="trBegin">
    <td style="font-style:italic">To begin, Select a customer&nbsp;&nbsp;
    <asp:DropDownList ID="ddCustomer" runat="server" DataSourceID="sdsCustomerName" 
        AppendDataBoundItems="True" DataTextField="CustomerName" AutoPostBack="true"
        DataValueField="CustomerID" onselectedindexchanged="ddCustomer_SelectedIndexChanged">
        <asp:ListItem Text="Select from List" Value="0" />
    </asp:DropDownList>&nbsp;&nbsp;or&nbsp;
    <asp:Button ID="btnNewCustomer" runat="server" Text="Create New Customer" onclick="btnNewCustomer_Click" /></td></tr></table>
<table>
<tr id="trCustomerHdr" runat="server">
<td style="font-style:italic;font-size:large; background-color: #FFFFFF;" 
        align="center"><br />Customer Information</td>
<td style="font-style:italic;font-size:large" align="center"><br />Customer Department Information</td></tr>
<tr id="trCustomerInfo" runat="server">
    <td valign="top">
    <asp:FormView ID="fvCustomer" runat="server" DataSourceID="sdsCustomerInfo" DataKeyNames="ID">
        <EditItemTemplate>
        <table frame="box">
        <tr><td class="formviewText">ID:</td><td class="formviewValue"><asp:Label ID="IDLabel1" runat="server" Text='<%# Eval("ID") %>' /></td></tr>
        <tr><td class="formviewText">Name:</td><td class="formviewValue"><asp:TextBox ID="CustomerNameTextBox" runat="server" Width="400px" Text='<%# Bind("CustomerName") %>' /></td></tr>
        <tr><td class="formviewText">Address1:</td><td class="formviewValue"><asp:TextBox ID="CustomerAddress1TextBox" runat="server" Width="400px" Text='<%# Bind("CustomerAddress1") %>' /></td></tr>
        <tr><td class="formviewText">Address2:</td><td class="formviewValue"><asp:TextBox ID="CustomerAddress2TextBox" runat="server" Width="400px" Text='<%# Bind("CustomerAddress2") %>' /></td></tr>
        <tr><td class="formviewText">City:</td><td class="formviewValue"><asp:TextBox ID="CustomerCityTextBox" runat="server" Width="400px" Text='<%# Bind("CustomerCity") %>' /></td></tr>
        <tr><td class="formviewText">State:</td><td class="formviewValue"><asp:TextBox ID="CustomerStateTextBox" runat="server" Width="400px" Text='<%# Bind("CustomerState") %>' /></td></tr>
        <tr><td class="formviewText">Zip:</td><td class="formviewValue"><asp:TextBox ID="CustomerZipTextBox" runat="server" Width="400px" Text='<%# Bind("CustomerZip") %>' /></td></tr>
        <tr><td class="formviewText">Web Address:</td><td class="formviewValue"><asp:TextBox ID="CustomerWebTextBox" runat="server" Width="400px" Text='<%# Bind("CustomerWeb") %>' /></td></tr>
        <tr><td class="formviewText">Phone:</td><td class="formviewValue"><asp:TextBox ID="CustomerPhoneTextBox" runat="server" Width="400px" Text='<%# Bind("CustomerPhone") %>' /></td></tr>
        <tr><td class="formviewText">Fax:</td><td class="formviewValue"><asp:TextBox ID="CustomerFaxTextBox" runat="server" Width="400px" Text='<%# Bind("CustomerFax") %>' /></td></tr>
        <tr><td class="formviewText">BillingCycle:</td><td class="formviewValue">
            <asp:DropDownList ID="ddBillingCycle" runat="server" SelectedValue='<%# Bind("BillingCycle") %>'
                 DataTextField="BillingCycle" DataValueField="BillingCycle">
                    <asp:ListItem Text="Weekly" Value="Weekly" />
                    <asp:ListItem Text="Semi-Monthly" Value="Semi-Monthly" />
                    <asp:ListItem Text="Monthly" Value="Monthly" />
            </asp:DropDownList></td></tr>
        <tr><td class="formviewText">Active:</td><td class="formviewValue"><asp:CheckBox ID="ActiveCheckBox" runat="server" Checked='<%# Bind("Active") %>' /></td></tr>
        <tr><td><asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />&nbsp;
                <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" /></td><td></td></tr>
        </table>
        </EditItemTemplate>
        <InsertItemTemplate>
        <table style="width: 500px" frame="box">
        <tr><td class="formviewText" >Name:</td><td class="formviewValue" nowrap="nowrap"><asp:TextBox ID="CustomerNameTextBox" runat="server" Width="400px" Text='<%# Bind("CustomerName") %>' />
            <asp:RequiredFieldValidator ID="rfvName" runat="server" ForeColor="Red" Font-Bold="true" ErrorMessage="Customer Name is required" ControlToValidate="CustomerNameTextBox" Text="*" /></td></tr>
        <tr><td class="formviewText">Address1:</td><td class="formviewValue"><asp:TextBox ID="CustomerAddress1TextBox" runat="server" Width="400px" Text='<%# Bind("CustomerAddress1") %>' /></td></tr>
        <tr><td class="formviewText">Address2:</td><td class="formviewValue"><asp:TextBox ID="CustomerAddress2TextBox" runat="server" Width="400px" Text='<%# Bind("CustomerAddress2") %>' /></td></tr>
        <tr><td class="formviewText">City:</td><td class="formviewValue"><asp:TextBox ID="CustomerCityTextBox" runat="server" Width="400px" Text='<%# Bind("CustomerCity") %>' /></td></tr>
        <tr><td class="formviewText">State:</td><td class="formviewValue"><asp:TextBox ID="CustomerStateTextBox" runat="server" Width="400px" Text='<%# Bind("CustomerState") %>' /></td></tr>
        <tr><td class="formviewText">Zip:</td><td class="formviewValue"><asp:TextBox ID="CustomerZipTextBox" runat="server" Width="400px" Text='<%# Bind("CustomerZip") %>' /></td></tr>
        <tr><td class="formviewText">Web Address:</td><td class="formviewValue"><asp:TextBox ID="CustomerWebTextBox" runat="server" Width="400px" Text='<%# Bind("CustomerWeb") %>' /></td></tr>
        <tr><td class="formviewText">Phone:</td><td class="formviewValue"><asp:TextBox ID="CustomerPhoneTextBox" runat="server" Width="400px" Text='<%# Bind("CustomerPhone") %>' /></td></tr>
        <tr><td class="formviewText">Fax:</td><td class="formviewValue"><asp:TextBox ID="CustomerFaxTextBox" runat="server" Width="400px" Text='<%# Bind("CustomerFax") %>' /></td></tr>
        <tr><td class="formviewText">BillingCycle:</td><td class="formviewValue">
            <asp:DropDownList ID="ddBillingCycle" runat="server" SelectedValue='<%# Bind("BillingCycle") %>'
                 DataTextField="BillingCycle" DataValueField="BillingCycle">
                    <asp:ListItem Text="Weekly" Value="Weekly" />
                    <asp:ListItem Text="Semi-Monthly" Value="Semi-Monthly" />
                    <asp:ListItem Text="Monthly" Value="Monthly" />
            </asp:DropDownList></td></tr>
        <tr><td class="formviewText">Active:</td><td><asp:CheckBox ID="ActiveCheckBox" runat="server" Checked="true" /></td></tr>
        <tr><td align="left" colspan="2"><asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />&nbsp;
            <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" /></td><td></td></tr>
        </table>
        <asp:ValidationSummary ID="vsInsert" runat="server" ShowMessageBox="True" HeaderText="Field Validator Summary" ShowSummary="False" />
        </InsertItemTemplate>
        <ItemTemplate>
        <table frame="box">
        <tr><td class="formviewText">ID:</td><td><asp:Label ID="IDLabel1" runat="server" Text='<%# Eval("ID") %>' /></td></tr>
        <tr><td class="formviewText">Name:</td><td class="formviewValue"><asp:Label ID="lblCustomerName" runat="server" Text='<%# Eval("CustomerName") %>' /></td></tr>
        <tr><td class="formviewText">Address1:</td><td class="formviewValue"><asp:Label ID="lblCustomerAddress1" runat="server" Text='<%# Eval("CustomerAddress1") %>' /></td></tr>
        <tr><td class="formviewText">Address2:</td><td class="formviewValue"><asp:Label ID="lblCustomerAddress2" runat="server" Text='<%# Eval("CustomerAddress2") %>' /></td></tr>
        <tr><td class="formviewText">City:</td><td class="formviewValue"><asp:Label ID="lblCustomerCity" runat="server" Text='<%# Eval("CustomerCity") %>' /></td></tr>
        <tr><td class="formviewText">State:</td><td class="formviewValue"><asp:Label ID="lblCustomerState" runat="server" Text='<%# Eval("CustomerState") %>' /></td></tr>
        <tr><td class="formviewText">Zip:</td><td class="formviewValue"><asp:Label ID="lblCustomerZip" runat="server" Width="400px" Text='<%# Eval("CustomerZip") %>' /></td></tr>
        <tr><td class="formviewText">Web Address:</td><td class="formviewValue"><asp:Label ID="lblCustomerWeb" runat="server" Text='<%# Eval("CustomerWeb") %>' /></td></tr>
        <tr><td class="formviewText">Phone:</td><td class="formviewValue"><asp:Label ID="lblCustomerPhone" runat="server" Text='<%# Eval("CustomerPhone") %>' /></td></tr>
        <tr><td class="formviewText">Billing Cycle:</td><td class="formviewValue"><asp:Label ID="BillingCycleTextBox" runat="server" Width="400px" Text='<%# Eval("BillingCycle") %>' /></td></tr>        
        <tr><td class="formviewText">Fax:</td><td class="formviewValue"><asp:Label ID="lblCustomerFax" runat="server" Text='<%# Eval("CustomerFax") %>' /></td></tr>
        <tr><td class="formviewText">Active:</td><td class="formviewValue"><asp:CheckBox ID="ActiveCheckBox" runat="server" Checked='<%# Eval("Active") %>' Enabled="false" /></td></tr>
        <tr><td class="formviewText"><asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" OnClick="EditCustomer_Click"  Text="Edit" /></td><td></td></tr>
        </table>
        </ItemTemplate>
    </asp:FormView>
    </td>
    <td valign="top">
    <table>
    <tr><td>
        <asp:GridView ID="gvDept" runat="server" AutoGenerateColumns="False" 
            DataKeyNames="ID" DataSourceID="sdsCustomerDept" ShowFooter="True">
        <Columns>
            <asp:CommandField ShowEditButton="True" />
            <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ID" Visible="false" />
            <asp:TemplateField HeaderText="ID" SortExpression="CustomerDepartmentID">
                <EditItemTemplate>
                    <asp:Label ID="CustomerDepartmentIDLabel" runat="server" Text='<%# Eval("ID") %>' />
                </EditItemTemplate>
                <ItemTemplate>
                   <asp:Label ID="CustomerDepartmentIDLabel" runat="server" Text='<%# Eval("ID") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Department Name" SortExpression="CustomerDepartmentName">
                <EditItemTemplate>
                    <asp:TextBox ID="CustomerDeptName" runat="server" Text='<%# Bind("CustomerDeptName") %>'></asp:TextBox>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:LinkButton ID="lnkAdd" runat="server" Font-Bold="true" OnClick="lnkAdd_Insert">Add</asp:LinkButton>
                </FooterTemplate>
                <ItemTemplate>
                    <asp:Label ID="CustomerDepartmentNameLabel" runat="server" Text='<%# Eval("CustomerDeptName") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Active" SortExpression="Active">
                <EditItemTemplate>
                    <asp:CheckBox ID="ActiveChkBox" runat="server" Checked='<%# Bind("Active") %>' />
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:CheckBox ID="ActiveChkBox" runat="server" Checked='<%# Eval("Active") %>' Enabled="false" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView></td>    
</tr>
    <tr id="trAddDept" runat="server"><td>
        <asp:Label ID="lblAddDept" runat="server" Text="Dept Name:"></asp:Label>&nbsp;
        <asp:TextBox ID="txbAddDept" runat="server" Width="250px"></asp:TextBox><br />
        <asp:Button ID="btnAdd" runat="server" Text="Add Dept" Font-Size="Smaller" 
            onclick="btnAdd_Click" />&nbsp;&nbsp;
        <asp:Button ID="btnCancel" runat="server" Text="Cancel" Font-Size="Smaller" 
            onclick="btnCancel_Click" /></td></tr>
    </table>

    </td>
</tr>
</table>
<asp:SqlDataSource ID="sdsCustomerName" runat="server" 
    ConnectionString="<%$ ConnectionStrings:MPS_SQL %>" 
    SelectCommand="Customer_CustomerName_Sel" SelectCommandType="StoredProcedure">
</asp:SqlDataSource>
<asp:SqlDataSource ID="sdsCustomerInfo" runat="server" 
    ConnectionString="<%$ ConnectionStrings:MPS_SQL %>" 
    SelectCommand="Customer_CustomerInfo_Sel" SelectCommandType="StoredProcedure"
    InsertCommand="Customer_CustomerInfo_Ins" InsertCommandType="StoredProcedure"
    UpdateCommand="UPDATE [Customer] SET
	    [CustomerName]=@CustomerName,
	    [CustomerAddress1]=@CustomerAddress1,
	    [CustomerAddress2]=@CustomerAddress2,
	    [CustomerCity]=@CustomerCity,
	    [CustomerState]=@CustomerState,
        [CustomerZip]=@CustomerZip,
	    [CustomerWeb]=@CustomerWeb,
	    [CustomerPhone]=@CustomerPhone,
	    [CustomerFax]=@CustomerFax,
        [BillingCycle]=@BillingCycle,
	    [Active]=@Active,
	    [ModDate]=getdate(),
	    [UserName]=@UserName
        WHERE [ID]=@ID"
    UpdateCommandType="Text"
    OnInserting="sdsCustomerInfo_Inserting" OnUpdating="sdsCustomerInfo_Updating"
    OnInserted="sdsCustomerInfo_Inserted" OnUpdated="sdsCustomerInfo_Updated">
    <SelectParameters>
        <asp:ControlParameter ControlID="ddCustomer" Name="CustomerID" PropertyName="SelectedValue" Type="Int32" />
    </SelectParameters>
    <InsertParameters>
        <asp:Parameter Name="Username" Type="String" />
    </InsertParameters>
    <UpdateParameters>
        <asp:Parameter Name="Username" Type="String" />
    </UpdateParameters>
</asp:SqlDataSource>  
<asp:SqlDataSource ID="sdsCustomerDept" runat="server" ConnectionString="<%$ ConnectionStrings:MPS_SQL %>" 
    SelectCommand="Customer_CustomerDept_Sel" SelectCommandType="StoredProcedure"
    UpdateCommand="UPDATE [CustomerDepartment] SET
        [CustomerDepartmentName]=@CustomerDeptName,
	    [Active]=@Active,
	    [ModDate]=getdate(),
	    [UserName]=@UserName
        WHERE [ID]=@ID" 
    UpdateCommandType="Text"
    OnUpdating="sdsCustomerDept_Updating">
    <SelectParameters>
    <asp:ControlParameter ControlID="ddCustomer" Name="CustomerID" PropertyName="SelectedValue" Type="Int32" />
    </SelectParameters>
    <UpdateParameters>
        <asp:Parameter Name="Username" Type="String" />
        <asp:Parameter Name="CustomerDeptName" Type="String" />
        <asp:Parameter Name="ID" Type="Int32" />
    </UpdateParameters>
</asp:SqlDataSource>
</asp:Content>
