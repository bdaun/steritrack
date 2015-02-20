<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CommunityAdmin.aspx.cs" Inherits="SiteBuilder.WebForm1" %>
<asp:Content ID="SublinksSpeakers" ContentPlaceHolderID="blankSublinks" runat="server">
    <div style="margin: 0px; text-align: right; float: right; font-size:x-small; font-style:italic; margin:0" >
    <asp:Menu ID="subMenu" runat="server" DataSourceID="SiteMapAdmin" SkinID="subMenu" Orientation="Horizontal" StaticItemFormatString="|&nbsp;&nbsp; {0} &nbsp;&nbsp; "
        StaticMenuItemStyle-CssClass="menuItem" StaticSelectedStyle-CssClass="menuItemSelected" />
        <asp:SiteMapDataSource ID="SiteMapAdmin" runat="server" ShowStartingNode="False" StartingNodeUrl="~/Secure/SiteAdminMenu.aspx" />
    </div>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
    <asp:Label ID="lblErrMsg" runat="server" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <h3>Community Management</h3>
    <table id="tblStart" runat="server">
        <tr>
            <td style="font-style:italic">Click on a button to proceed</td>
        </tr>
        <tr>
            <td><asp:Button ID="btnSearch" runat="server" Text="Search Existing" OnClick="btnSearch_Click" />&nbsp;&nbsp;
                <asp:Button ID="btnNewCommunity" runat="server" Text="Create New Community" OnClick="btnNewCommunity_Click" />
            </td>
        </tr>
    </table>
    <table id="tblSearch" runat="server">
        <tr>
            <td style="font-style:italic" colspan="2">Enter any known information</td>
        </tr>
        <tr>
            <td style="text-align:right;padding-right:4px">Name:</td>
            <td style="text-align:left;padding-left:4px"><asp:TextBox ID="txbName" runat="server" /></td>
        </tr>
        <tr>
            <td style="text-align:right;padding-right:2px">Country/Currency:</td>
            <td style="text-align:left;padding-left:4px">
                <asp:DropDownList ID="ddCountry" runat="server" AppendDataBoundItems="true" DataSourceID="sdsCountry" 
                    DataTextField="StateCurrency" DataValueField="ID" AutoPostBack="true">
                    <asp:ListItem Text="Select from List" Value="-1" />
                    <asp:ListItem Text="Show all" Value ="0" />
                </asp:DropDownList></td>
        </tr>
        <tr>
            <td style="text-align:right;padding-right:2px">Show Only My Sites:</td>
            <td style="text-align:left;padding-left:4px">
                <asp:CheckBox ID="chkMe" runat="server" Checked="true" AutoPostBack="true"/>
            </td>
        </tr>
        <tr>
            <td colspan="2" style="padding-left:4px">
                <asp:Button ID="btnlookup" runat="server" Text="Search" OnClick="btnlookup_Click" />&nbsp;&nbsp;
                <asp:Button ID="btnlookupCancel" runat="server" Text="Cancel" OnClick="btnlookupCancel_Click" />
            </td>
        </tr>
    </table>
    <asp:GridView ID="gvCommunities" runat="server" AutoGenerateColumns="False" DataKeyNames="ID" DataSourceID="sdsCommunityInfo">
        <Columns>
            <asp:CommandField ShowEditButton="True" />
            <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ID" />
            <asp:BoundField DataField="SiteName" HeaderText="SiteName" SortExpression="SiteName" />
            <asp:TemplateField HeaderText="StateTerritory" SortExpression="StateTerritory">
                <EditItemTemplate>
                    <asp:DropDownList ID="ddCountry" runat="server" selectedvalue='<%# Bind("CountryID") %>'
                        DataSourceID="sdsCountry" DataTextField="StateCurrency" DataValueField="ID"></asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblStateTerritory" runat="server" Text='<%# Bind("StateTerritory") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="CreateDate" HeaderText="Date Created" InsertVisible="False" ReadOnly="True" SortExpression="CreateDate" />
            <asp:BoundField DataField="ModDate" HeaderText="Date Modified" InsertVisible="False" ReadOnly="True" SortExpression="ModDate" />
            <asp:BoundField DataField="UserName" HeaderText="UserName" InsertVisible="False" ReadOnly="True" SortExpression="UserName" />
        </Columns>
    </asp:GridView>
    <table id="tblNewSite" runat="server">
        <tr>
            <td style="font-style:italic" colspan="2">Fields with "*" are required</td>
        </tr>
        <tr>
            <td style="text-align:right;padding-right:4px">Name*:</td>
            <td style="text-align:left;padding-left:4px"><asp:TextBox ID="txbNewSite" runat="server" /></td>
        </tr>
        <tr>
            <td style="text-align:right;padding-right:2px">Country/Currency*:</td>
            <td style="text-align:left;padding-left:4px">
                <asp:DropDownList ID="ddNewCountry" runat="server" DataSourceID="sdsCountry" DataTextField="StateCurrency" DataValueField="ID" AppendDataBoundItems="true" >
                    <asp:ListItem Text="Select From List" Value="0" />
                </asp:DropDownList></td>
        </tr>
        <tr>
            <td style="text-align:right;padding-right:2px">Upload google Map:</td>
            <td><asp:FileUpload ID="uplMap" runat="server" ToolTip="Upload a map of the area"  /></td>
        </tr>
                <tr>
            <td style="text-align:right;padding-right:2px">Site Pic:</td>
            <td><asp:FileUpload ID="FileUpload1" runat="server" ToolTip="Upload a picture of the team leader, group photo, or other site pic" /></td>
        </tr>
       <tr>
            <td style="text-align:right;padding-right:4px">Comments:</td>
            <td style="text-align:left;padding-left:4px"><asp:TextBox ID="txbComments" runat="server" TextMode="MultiLine" Rows="4" /></td>
       </tr>
        <tr>
            <td colspan="2" style="padding-left:4px">
                <asp:Button ID="btnNewSite" runat="server" Text="Create" OnClick="btnNewSite_Click" />&nbsp;&nbsp;
                <asp:Button ID="btnNewSiteCancel" runat="server" Text="Cancel" OnClick="btnNewSiteCancel_Click" />
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="sdsCommunityInfo" runat="server" ConnectionString="<%$ ConnectionStrings:SiteBuilderCon %>" OnSelecting="sdsCommunityInfo_Selecting"
        SelectCommand="CommunityInfo_sel" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="txbName" Name="name" PropertyName="Text" Type="String" DefaultValue="All" />
            <asp:ControlParameter ControlID="ddCountry" Name="countryID" DefaultValue="0" Type="Int32" />
            <asp:ControlParameter ControlID="chkMe" Name="OnlyMe" Type="byte" DefaultValue="0" />
            <asp:Parameter Name="UserName" Type="string" DefaultValue="All" />
        </SelectParameters>
    </asp:SqlDataSource>
<asp:SqlDataSource ID="sdsCountry" runat="server" ConnectionString="<%$ ConnectionStrings:SiteBuilderCon %>" 
        SelectCommand="Country_sel" SelectCommandType="StoredProcedure">
</asp:SqlDataSource>
</asp:Content>
