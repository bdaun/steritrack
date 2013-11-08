<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProfileMgt.aspx.cs" Inherits="IMDBWeb.Secure.CommonPages.ProfileMgt" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<h3>Profile Management</h3><hr /><br />
<asp:Label ID="lblErrMsg" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" />
<asp:Label ID="lblMsg" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Green" />
<table id="tblSearch" runat="server">
<tr><td><asp:Label ID="lblProfileName" runat="server" Text="ProfileName:" /></td>
    <td style="padding-left:10px">
    <asp:DropDownList ID="ddProfilename" runat="server" AutoPostBack="True" AppendDataBoundItems="true"
            DataSourceID="sdsProfileSel" DataTextField="Name" DataValueField="ID" 
            onselectedindexchanged="ddProfilename_SelectedIndexChanged" >
        <asp:ListItem Text="Select From List" Value="0" />
    </asp:DropDownList>
    </td>
    <td>&nbsp;&nbsp;&nbsp;
    <asp:Button ID="btnNewProfile" runat="server" Text="New Profile" onclick="btnNewProfile_Click" />
    </td>
</tr>
</table>
<asp:FormView ID="fvprofileInfo" runat="server" DataSourceID="sdsProfileInfo" DataKeyNames="ID" DefaultMode="Edit">
    <EditItemTemplate>
    <table>
        <tr><td>ID:</td><td><asp:Label ID="lblID" runat="server" Text='<%# Eval("ID") %>' /></td></tr>
        <tr><td>Name:</td><td><asp:TextBox ID="txbName" runat="server" Width="6in" Text='<%# Bind("Name") %>' /></td></tr>
        <tr><td>Type:</td><td><asp:DropDownList ID="ddType" runat="server" SelectedValue='<%# Bind("Type") %>'>
            <asp:ListItem Text="Inbound" />
            <asp:ListItem Text="Outbound" />
        </asp:DropDownList></td></tr>
        <tr><td>EPA Code:</td><td><asp:TextBox ID="EPACode" runat="server" Text='<%# Bind("EPACode") %>' /></td></tr>
        <tr><td>10Day:</td><td><asp:CheckBox ID="chk10Day" runat="server" Checked='<%# Bind("10Day") %>' /></td></tr>
        <tr><td>Hazardous:</td><td><asp:CheckBox ID="chkHazardous" runat="server" Checked='<%# Bind("Hazardous") %>' /></td></tr>
        <tr><td>WasteCodes:</td><td><asp:TextBox ID="txbWasteCodes" runat="server" Text='<%# Bind("Waste_Codes") %>' /></td></tr>
        <tr><td>ContractID:</td><td><asp:TextBox ID="txbContractID" runat="server" Width="50px" Text='<%# Bind("ContractID") %>' /></td></tr>
        <tr><td>Location Type:</td><td><asp:DropDownList ID="ddLocationType" runat="server" SelectedValue='<%# Bind("LocationType") %>'>
            <asp:ListItem Text="Select from List" Value = "Select" />
            <asp:ListItem Text="Hazardous Flammable" />
            <asp:ListItem Text="Hazardous NonFlammable" />
            <asp:ListItem Text="NonHazardous" />
            <asp:ListItem Text="Aerosol" />
        </asp:DropDownList></td></tr>
        <tr><td>Default Disposition:</td><td><asp:DropDownList ID="ddDefaultDisposition" runat="server" SelectedValue='<%# Bind("Default_Disposition") %>'>
            <asp:ListItem Text="Incinerate" />
            <asp:ListItem Text="Landfill" />
            <asp:ListItem Text="Recycle" />
            <asp:ListItem Text="WTE" />
            <asp:ListItem Text="NA" />
        </asp:DropDownList></td></tr>
        <tr><td>Default Destination:</td><td><asp:DropDownList ID="ddDefaultDestination" 
                runat="server" AppendDataBoundItems="True" DataSourceID="sdsDefaultDestination" 
                SelectedValue='<%# Bind("Default_Destination") %>' DataTextField="VendorName" DataValueField="VendorName">
             <asp:ListItem Text="NA" Value="0" />
        </asp:DropDownList></td></tr>
        <tr><td>UserName:</td><td><asp:Label ID="Label1" runat="server" Text='<%# Eval("UserName") %>' /></td></tr>
        <tr><td>CreateDate:</td><td><asp:Label ID="Label2" runat="server" Text='<%# Eval("CreateDate") %>' /></td></tr>
        <tr><td>ModDate:</td><td><asp:Label ID="Label3" runat="server" Text='<%# Eval("ModDate") %>' /></td></tr>
    </table>
        <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />&nbsp;
        <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" OnClick="UpdateCancel" Text="Cancel" />
    </EditItemTemplate>
    <InsertItemTemplate>
    <asp:ValidationSummary ID="vsInsert" CssClass="failureNotification" HeaderText="You must enter a value in the following fields:" 
    DisplayMode="BulletList" EnableClientScript="true" runat="server" />
    <table>
        <tr><td>Profile Name:</td><td><asp:TextBox ID="txbName" runat="server" Width="6in" Text='<%# Bind("Name") %>' />
            <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txbName" Text="*" ErrorMessage="Profile Name" CssClass="failureNotification" /></td></tr>
        <tr><td>Profile Type:</td><td><asp:DropDownList ID="ddType" runat="server" SelectedValue='<%# Bind("Type") %>'>
            <asp:ListItem Text="Select from List" />
            <asp:ListItem Text="Inbound" />
            <asp:ListItem Text="Outbound" />
        </asp:DropDownList>
            <asp:CompareValidator ID="cvType" runat="server" ControlToValidate="ddType" ErrorMessage="Profile Type" Operator="NotEqual"
            ValueToCompare="Select from List" ForeColor="Red" SetFocusOnError="true" Text="*" /></td></tr>
        <tr><td>EPA Code:</td><td><asp:TextBox ID="EPACode" runat="server" Text='<%# Bind("EPACode") %>' /></td></tr>
        <tr><td>10Day:</td><td><asp:CheckBox ID="chk10Day" runat="server" Checked='<%# Bind("10Day") %>' /></td></tr>
        <tr><td>Hazardous:</td><td><asp:CheckBox ID="chkHazardous" runat="server" Checked='<%# Bind("Hazardous") %>' /></td></tr>
        <tr><td>WasteCodes:</td><td><asp:TextBox ID="txbWasteCodes" runat="server" Text='<%# Bind("Waste_Codes") %>' /></td></tr>
        <tr><td>ContractID:</td><td><asp:TextBox ID="txbContractID" runat="server" Width="50px" Text='<%# Bind("ContractID") %>' /></td></tr>
        <tr><td>Location Type:</td><td><asp:DropDownList ID="ddLocationType" runat="server" SelectedValue='<%# Bind("LocationType") %>'>
            <asp:ListItem Text="Select from List" Value = "Select" />
            <asp:ListItem Text="Hazardous Flammable" />
            <asp:ListItem Text="Hazardous NonFlammable" />
            <asp:ListItem Text="NonHazardous" />
            <asp:ListItem Text="Aerosol" />
        </asp:DropDownList>
        <asp:CompareValidator ID="cvLocType" runat="server" ControlToValidate="ddLocationType" ErrorMessage="Location Type" Operator="NotEqual"
            ValueToCompare="Select" ForeColor="Red" SetFocusOnError="true" Text="*" /></td></tr>
        <tr><td>Default Disposition:</td><td><asp:DropDownList ID="ddDefaultDisposition" runat="server" SelectedValue='<%# Bind("Default_Disposition") %>'>
            <asp:ListItem Text="Select from List" />
            <asp:ListItem Text="Incinerate" />
            <asp:ListItem Text="Landfill" />
            <asp:ListItem Text="Recycle" />
            <asp:ListItem Text="WTE" />
            <asp:ListItem Text="NA" />
        </asp:DropDownList>
        <asp:CompareValidator ID="cvDisposition" runat="server" ControlToValidate="ddDefaultDisposition" ErrorMessage="Disposition" Operator="NotEqual"
            ValueToCompare="Select from List" ForeColor="Red" SetFocusOnError="true" Text="*" /></td></tr>
        <tr><td>Default Destination:</td><td><asp:DropDownList ID="ddDefaultDestination" 
                runat="server" AppendDataBoundItems="True" DataSourceID="sdsDefaultDestination" 
                SelectedValue='<%# Bind("Default_Destination") %>' DataTextField="VendorName" DataValueField="VendorName">
             <asp:ListItem Text="Select from List" />
        </asp:DropDownList>
        <asp:CompareValidator ID="cvDestination" runat="server" ControlToValidate="ddDefaultDestination" ErrorMessage="Destination" Operator="NotEqual"
            ValueToCompare="Select from List" ForeColor="Red" SetFocusOnError="true" Text="*" /></td></tr>
    </table>
    <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />&nbsp;
        <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" OnClick="InsertCancel" Text="Cancel" /><br />    
    </InsertItemTemplate>
</asp:FormView>
<asp:SqlDataSource ID="sdsProfileInfo" runat="server" 
    ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
    SelectCommand="COMM_ProfileMgt_ProfileInfo_Sel" SelectCommandType="StoredProcedure"
    UpdateCommand="COMM_ProfileMgt_ProfileInfo_Upd" UpdateCommandType="StoredProcedure" OnUpdating="sdsProfileInfo_Updating" OnUpdated="sdsProfileInfo_Updated"
    InsertCommand="COMM_ProfileMgt_ProfileInfo_ins" InsertCommandType="StoredProcedure" OnInserting="sdsProfileInfo_Inserting" OnInserted="sdsProfileInfo_Inserted" >
    <SelectParameters>
        <asp:ControlParameter ControlID="ddProfilename" DefaultValue="0" Name="ID" 
            PropertyName="SelectedValue" Type="Int32" />
    </SelectParameters>
    <UpdateParameters>
        <asp:Parameter Name="Username" Type="String" />    
    </UpdateParameters>
    <InsertParameters>
        <asp:Parameter Name="UserName" Type="String" />
    </InsertParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="sdsProfileSel" runat="server" 
    ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
    SelectCommand="COMM_ProfileMgt_Profile_Sel" SelectCommandType="StoredProcedure">
</asp:SqlDataSource>
<asp:SqlDataSource ID="sdsDefaultDestination" runat="server" 
    ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
    SelectCommand="COMM_ProfileMgt_Destination_Sel" SelectCommandType="StoredProcedure">
</asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Clear" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Footer" runat="server">
</asp:Content>
