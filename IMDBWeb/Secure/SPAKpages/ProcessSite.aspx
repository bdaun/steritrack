<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProcessSite.aspx.cs" Inherits="IMDBWeb.Secure.SPAKpages.ProcessSite" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<h3>SPAK Process Site Management</h3><hr /><br />
<asp:Label ID="lblErrMsg" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" />
<table id="tblSearch" runat="server">
<tr><td>SiteName:</td>
    <td style="padding-left:10px">
    <asp:DropDownList ID="ddSitename" runat="server" AutoPostBack="True" AppendDataBoundItems="true"
            DataSourceID="sdsSiteSel" DataTextField="SiteName" DataValueField="SiteCode" >
        <asp:ListItem Text="Select From List" Value="0" />
    </asp:DropDownList>
    </td>
    <td>&nbsp;&nbsp;&nbsp;
    <asp:Button ID="btnNewSite" runat="server" Text="New Site" 
            onclick="btnNewSite_Click" />
    </td>
</tr>
</table>
<asp:FormView ID="fvSite" runat="server" DataSourceID="sdsSiteInfo" DefaultMode="Edit">
    <EditItemTemplate>
    <table>
        <tr><td>ID:</td><td><asp:Label ID="IDLable" runat="server" Text='<%# Eval("ID") %>' /></td></tr>
        <tr><td>SiteName:</td><td><asp:TextBox ID="SiteNameTextBox" runat="server" Text='<%# Bind("SiteName") %>' /></td></tr>
        <tr><td>SiteCode:</td><td><asp:TextBox ID="SiteCodeTextBox" runat="server" Text='<%# Bind("SiteCode") %>' /></td></tr>
        <tr><td>MngAs10d:</td><td><asp:CheckBox ID="MngAs10dCheckBox" runat="server" Checked='<%# Bind("MngAs10d") %>' /></td></tr>  
        <asp:RegularExpressionValidator ID="revSiteCode" runat="server" ValidationExpression="^\d\d$" ForeColor="Red" 
            ControlToValidate="SiteCodeTextBox" ErrorMessage="You must enter a unique, two digit value for the site code" />  
    </table>
        <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />&nbsp;
        <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" OnClick="UpdateCancel" Text="Cancel" />
    </EditItemTemplate>
    <InsertItemTemplate>
    <table>
        <tr><td>SiteName:</td><td><asp:TextBox ID="SiteNameTextBox" runat="server" Text='<%# Bind("SiteName") %>' /></td></tr>
        <tr><td>SiteCode:</td><td><asp:TextBox ID="SiteCodeTextBox" runat="server" Text='<%# Bind("SiteCode") %>' /></td></tr>
        <tr><td>MngAs10d:</td><td><asp:CheckBox ID="MngAs10dCheckBox" runat="server" Checked='<%# Bind("MngAs10d") %>' /></td></tr> 
        <asp:RegularExpressionValidator ID="revSiteCode" runat="server" ValidationExpression="^\d\d$" ForeColor="Red" 
            ControlToValidate="SiteCodeTextBox" ErrorMessage="You must enter a unique, two digit value for the site code" />     
    </table>
        <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />&nbsp;
        <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" OnClick="InsertCancel" Text="Cancel" />
    </InsertItemTemplate>
    <ItemTemplate>
        ID:
        <asp:Label ID="IDLabel" runat="server" Text='<%# Eval("ID") %>' />
        <br />
        SiteName:
        <asp:Label ID="SiteNameLabel" runat="server" Text='<%# Bind("SiteName") %>' />
        <br />
        SiteCode:
        <asp:Label ID="SiteCodeLabel" runat="server" Text='<%# Bind("SiteCode") %>' />
        <br />
        MngAs10d:
        <asp:CheckBox ID="MngAs10dCheckBox" runat="server" 
            Checked='<%# Bind("MngAs10d") %>' Enabled="false" />
        <br />
        CreateDate:
        <asp:Label ID="CreateDateLabel" runat="server" 
            Text='<%# Bind("CreateDate") %>' />
        <br />
        ModDate:
        <asp:Label ID="ModDateLabel" runat="server" Text='<%# Bind("ModDate") %>' />
        <br />
        UserName:
        <asp:Label ID="UserNameLabel" runat="server" Text='<%# Bind("UserName") %>' />
        <br />

    </ItemTemplate>
</asp:FormView>
    <asp:SqlDataSource ID="sdsSiteInfo" runat="server" 
        ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
        SelectCommand="SPAK_SiteMgt_SiteInfo_Sel" SelectCommandType="StoredProcedure"
        UpdateCommand="SPAK_SiteMgt_SiteInfo_Upd" UpdateCommandType="StoredProcedure"
        InsertCommand="SPAK_siteMgt_SiteInfo_Ins" InsertCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddSitename" DefaultValue="0" Name="SiteCode" 
                PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
<asp:SqlDataSource ID="sdsSiteSel" runat="server" 
    ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
    SelectCommand="SPAK_SiteMgt_Site_Sel" SelectCommandType="StoredProcedure">
</asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Clear" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Footer" runat="server">
</asp:Content>
