﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminMenu.aspx.cs" Inherits="SiteBuilder.Admin.AdminMenu" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<h2>Application Administration</h2>
<h3>You can perform the following administrative tasks:</h3>
<ul style="font-size: large;">
    <li><a href="PasswordReset.aspx">Quick PasswordReset</a></li>
    <li><a href="access/users.aspx">User Management</a></li>
</ul>
</asp:Content>