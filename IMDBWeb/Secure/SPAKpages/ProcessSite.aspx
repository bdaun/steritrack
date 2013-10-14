<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProcessSite.aspx.cs" Inherits="IMDBWeb.Secure.SPAKpages.ProcessSite" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<h3>SPAK Process Site Management</h3><hr /><br />
<asp:Label ID="lblErrMsg" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" />
<asp:Label ID="lblMsg" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Green" />
<table id="tblSearch" runat="server">
<tr><td><asp:Label ID="lblSiteName" runat="server" Text="SiteName:" /></td>
    <td style="padding-left:10px">
    <asp:DropDownList ID="ddSitename" runat="server" AutoPostBack="True" AppendDataBoundItems="true"
            DataSourceID="sdsSiteSel" DataTextField="SiteName" 
            DataValueField="SiteCode" 
            onselectedindexchanged="ddSitename_SelectedIndexChanged" >
        <asp:ListItem Text="Select From List" Value="0" />
    </asp:DropDownList>
    </td>
    <td>&nbsp;&nbsp;&nbsp;
    <asp:Button ID="btnNewSite" runat="server" Text="New Site"  onclick="btnNewSite_Click" />
    </td>
</tr>
</table><br />
<asp:FormView ID="fvSite" runat="server" DataSourceID="sdsSiteInfo" DefaultMode="Edit">
    <EditItemTemplate>
    <table>
        <tr><td>ID:</td><td><asp:Label ID="IDLable" runat="server" Text='<%# Eval("ID") %>' /></td></tr>
        <tr><td>SiteName:</td><td><asp:TextBox ID="SiteNameTextBox" runat="server" Text='<%# Bind("SiteName") %>' /></td></tr>
        <tr><td>SiteCode:</td><td><asp:Label ID="Sitecode" runat="server" Text='<%# Bind("SiteCode") %>' /></td></tr>
        <tr><td>MngAs10d:</td><td><asp:CheckBox ID="MngAs10dCheckBox" runat="server" Checked='<%# Bind("MngAs10d") %>' /></td></tr>  
    </table>
        <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />&nbsp;
        <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" OnClick="UpdateCancel" Text="Cancel" />
    </EditItemTemplate>
    <InsertItemTemplate>
    <table>
        <tr><td>SiteName:</td><td><asp:TextBox ID="SiteNameTextBox" runat="server" Text='<%# Bind("SiteName") %>' /></td></tr>
        <tr><td>SiteCode:</td><td><asp:TextBox ID="SiteCodeTextBox" runat="server" Width="50px" Text='<%# Bind("SiteCode") %>' /></td></tr>
        <tr><td>MngAs10d:</td><td><asp:CheckBox ID="MngAs10dCheckBox" runat="server" Checked='<%# Bind("MngAs10d") %>' /></td></tr> 
        <asp:RegularExpressionValidator ID="revSiteCode" runat="server" ValidationExpression="^[0-9][0-9]$" ForeColor="Red" 
            ControlToValidate="SiteCodeTextBox" ErrorMessage="You must enter a unique, two digit value for the site code" />     
    </table>
        <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />&nbsp;
        <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" OnClick="InsertCancel" Text="Cancel" />
    </InsertItemTemplate>
</asp:FormView>
    <asp:SqlDataSource ID="sdsSiteInfo" runat="server" 
        ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
        SelectCommand="SPAK_SiteMgt_SiteInfo_Sel" SelectCommandType="StoredProcedure"
        UpdateCommand="SPAK_SiteMgt_SiteInfo_Upd" UpdateCommandType="StoredProcedure"
        InsertCommand="SPAK_siteMgt_SiteInfo_Ins" InsertCommandType="StoredProcedure"
        OnUpdating="sdsSiteInfo_OnUpdating" OnUpdated="sdsSiteInfo_OnUpdated"
        OnInserting="sdssiteInfo_OnInserting" OnInserted="sdsSiteInfo_OnInserted" >
        <SelectParameters>
            <asp:ControlParameter ControlID="ddSitename" DefaultValue="0" Name="SiteCode" 
                PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="UserName" Type="String" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="UserName" Type="String" />
        </InsertParameters>
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
