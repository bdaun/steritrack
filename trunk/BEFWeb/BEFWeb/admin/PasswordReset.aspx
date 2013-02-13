<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PasswordReset.aspx.cs" Inherits="TeleiosDemo.Account.PasswordReset" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<div class="accountInfo">
<fieldset class="login">
<legend>Reset Password</legend>
<table width= "25%">
<tr><td> U/N:&nbsp</td><td><asp:TextBox ID="txbUName" runat="server" Width="240px"></asp:TextBox></td></tr>
<tr><td>PW:&nbsp</td><td><asp:TextBox ID="txbuPW" runat="server" Width="240px" ></asp:TextBox></td></tr>
<tr><td></td><td></td></tr>
</table>
    <asp:Label ID="lblMsg" runat="server" Text="" ForeColor="Red" Font-Bold="true"></asp:Label><br /><br />
    <asp:Button ID="bntSubmit" runat="server" Text="Submit" 
        onclick="bntSubmit_Click" />
</fieldset>
</div>
</asp:Content>
