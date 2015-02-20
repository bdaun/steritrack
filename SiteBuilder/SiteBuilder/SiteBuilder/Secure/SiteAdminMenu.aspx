<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SiteAdminMenu.aspx.cs" Inherits="SiteBuilder.Secure.SiteAdmin.SiteAdminMenu" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .auto-style1
        {
            width: 150px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="blankSublinks" runat="server">
    <div style="margin: 0px; text-align: right; float: right; font-size:x-small; font-style:italic" >
    <asp:Menu ID="subMenu" runat="server" DataSourceID="SiteMapAdminMenu" SkinID="subMenu" Orientation="Horizontal" StaticItemFormatString="|&nbsp;&nbsp; {0} &nbsp;&nbsp; "
    StaticMenuItemStyle-CssClass="menuItem" StaticSelectedStyle-CssClass="menuItemSelected" />
</div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">
    <h3>Administration Pages</h3>
    Use the following links to create or manage
        <div style="display:inline-block;font-size:large;color:green;font-style:italic"> Community</div>, 
        <div style="display:inline-block;font-size:large;color:Black;font-style:italic">Nutrition</div>,  
        <div style="display:inline-block;font-size:large;color:red;font-style:italic">Education </div>, or 
        <div style="display:inline-block;font-size:large;color:brown;font-style:italic">Spiritual Growth</div>.<br />
    <table>
        <tr>
            <td class="auto-style1"><asp:HyperLink ID="lnkCommunity" runat="server" NavigateUrl="~/Secure/Community/CommunityAdmin.aspx" style="font-size:large;color:green;font-style:italic">Community</asp:HyperLink></td>
            <td>Use the Community link to create a new site.   Your community definition will include physical location attributes, demographics, and target goals for nutrition, education, and spiritual growth.&nbsp; After creating a site, you can pick existing attributes or create your own to describe your Community.</td>
        </tr>
        <tr>
            <td class="auto-style1"><asp:HyperLink ID="lnkNutrition" runat="server" NavigateUrl="~/Secure/Nutrition/NutritionAdmin.aspx" style="font-size:large;color:black;font-style:italic">Nutrition</asp:HyperLink></td>
            <td>After creating your site, use the Nutrition link to create or manage Nutrition attributes or create your own to describe the Nutritional goals for your Community.&nbsp; Additionally, you will be able to provide design parameters which enable the user to evaluate sustainable food options which are feasible for the location and the community/culture.</td>
        </tr>
        <tr>
            <td class="auto-style1"><asp:HyperLink ID="lnkEducation" runat="server" NavigateUrl="~/Secure/EducationAdmin.aspx" style="font-size:large;color:red;font-style:italic">Education</asp:HyperLink></td>
            <td>After creating your site, use the Education link to create or manage the Education attributes or create your own to describe the Educational goals for your Community.</td>
        </tr>
        <tr>
            <td class="auto-style1"><asp:HyperLink ID="lnkSpiritualGrowth" runat="server" NavigateUrl="~/Secure/SpiritualGrowth/SpiritualGrowthAdmin.aspx" style="font-size:large;color:brown;font-style:italic">Spiritual Growth</asp:HyperLink></td>
            <td>After creating your site, use the Spiritual Growth link to create or manage the Spiritual Growth attributes or create your own to describe the Spiritual goals for your Community.</td>
        </tr>
    </table>
    <asp:SiteMapDataSource ID="SiteMapAdminMenu" runat="server" ShowStartingNode="False" StartingNodeUrl="~/Secure/SiteAdminMenu.aspx" />
</asp:Content>
