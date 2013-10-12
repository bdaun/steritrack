<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminMenu.aspx.cs" Inherits="IMDBWeb.Administration.AdminMenu" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
You can perform the following administrative options:<br />
<ul>
    <li><a href="PasswordReset.aspx">Quick PasswordReset</a></li>
    <li><a href="access/users.aspx">User Management</a></li>
    <li><a href="../Secure/SPAKpages/ProcessSite.aspx">SPAK Site Management</a></li>
</ul>
</asp:Content>