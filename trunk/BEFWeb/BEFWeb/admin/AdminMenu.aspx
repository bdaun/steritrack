<%@ Page Title="" Language="C#" MasterPageFile="~/Secure/Page.Master" AutoEventWireup="true" CodeBehind="AdminMenu.aspx.cs" Inherits="TeleiosDemo.Administration.AdminMenu" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Application Administration</h2>
    <h3> You can perform the following administrative tasks:</h3><br />
    <ul>
        <li><a href="PasswordReset.aspx">Quick PasswordReset</a></li>
        <li><a href="access/users.aspx">User Management</a></li>
    </ul>
</asp:Content>