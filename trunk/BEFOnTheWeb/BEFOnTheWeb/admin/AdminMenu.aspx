<%@ Page Title="" Language="C#" MasterPageFile="~/Secure/Page.Master" AutoEventWireup="true" CodeBehind="AdminMenu.aspx.cs" Inherits="BEFOnTheWeb.admin.AdminMenu" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<div>
    <h1>Application Administration</h1>
    <h2>You can perform the following administrative tasks:</h2>
    <ul>
        <li><asp:HyperLink ID="hlReset" runat="server" NavigateUrl="~/admin/PasswordReset.aspx">Quick PasswordReset</asp:HyperLink></li>
        <li><asp:HyperLink ID="hlUser" runat="server" NavigateUrl="~/admin/access/users.aspx" >User Management</asp:HyperLink></li>
    </ul>
</div>
</asp:Content>
