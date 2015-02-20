<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SpiritualGrowthAdmin.aspx.cs" Inherits="SiteBuilder.Secure.SpiritualGrowth.SpiritualGrowthMenu" %>
<asp:Content ID="SublinksSpeakers" ContentPlaceHolderID="blankSublinks" runat="server">
    <div style="margin: 0px; text-align: right; float: right; font-size: x-small; font-style: italic; margin: 0">
        <asp:Menu ID="subMenu" runat="server" DataSourceID="SiteMapAdmin" SkinID="subMenu" Orientation="Horizontal" StaticItemFormatString="|&nbsp;&nbsp; {0} &nbsp;&nbsp; "
            StaticMenuItemStyle-CssClass="menuItem" StaticSelectedStyle-CssClass="menuItemSelected" />
        <asp:SiteMapDataSource ID="SiteMapAdmin" runat="server" ShowStartingNode="False" StartingNodeUrl="~/Secure/SiteAdminMenu.aspx" />
    </div>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <h3>Spiritual Growth Management</h3>
</asp:Content>
