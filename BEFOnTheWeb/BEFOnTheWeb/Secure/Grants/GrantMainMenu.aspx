<%@ Page Title="" Language="C#" MasterPageFile="~/Secure/Page.Master" AutoEventWireup="true" CodeBehind="GrantMainMenu.aspx.cs" Inherits="BEFOnTheWeb.Secure.GrantMainMenu" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Grant Application Main Menu</h1>
    <h2>You can do the following from this site:</h2>
    <div class="bulletlist">
        <ul>
            <li><asp:HyperLink ID="hlGrantManagement" runat="server" NavigateUrl="~/Secure/Grants/GrantManagement.aspx">Create/Manage Grants</asp:HyperLink></li>
            <li><asp:HyperLink ID="hlGrantInfo" runat="server" NavigateUrl="~/Secure/Grants/GrantInformation.aspx">Grant Info and Instructions</asp:HyperLink></li>
            <li><asp:HyperLink ID="hlGrantRubric" runat="server" NavigateUrl="~/Secure/Grants/GrantRubric.aspx">Review Rubric Criteria</asp:HyperLink></li>
        </ul>
    </div>
</asp:Content>
