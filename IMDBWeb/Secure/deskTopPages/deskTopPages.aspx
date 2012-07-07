<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="deskTopPages.aspx.cs" Inherits="IMDBWeb.deskTopPages" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<h3>Desktop Menu Options</h3>
<hr />
    <ul style="font-size: large; color: #008000;">
        <li><a href="ManifestMailing.aspx" style="font-size: large; color: #008000;">Manage Manifest Mailing</a> </li>
        <li><a href="Truckout.aspx" style="font-size: large; color: #008000;">Truck Out Containers</a> </li>
        <li><a href="Receiving.aspx" style="font-size: large; color: #008000;">Receiving</a> </li>
    </ul>
</asp:Content>
