<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="deskTopPages.aspx.cs" Inherits="TeleiosDemo.deskTopPages" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<h3>Desktop Menu Options</h3>
<hr />
<table>
<tr style="font-style:italic; font-weight:bold" align="center"><td>SPAK Team</td><td>&nbsp;&nbsp;</td><td>General Processing</td></tr>
<tr><td>
    <ul style="font-size: large; color: #008000;">
        <li><a href="ManifestMailing.aspx" style="font-size: large; color: #008000;">Manage Manifest Mailing</a> </li>
        <li><a href="AlertItems.aspx" style="font-size: large; color: #008000;">Manage Alert Items</a> </li>
    </ul>
    </td>
    <td>&nbsp;&nbsp;</td>
    <td>
    <ul style="font-size: large; color: #008000;">
        <li><a href="Truckout.aspx" style="font-size: large; color: #008000;">Truck Out Containers</a> </li>
        <li><a href="Receiving2.aspx" style="font-size: large; color: #008000;">Receiving</a> </li>
        <li><a href="ShipHeader.aspx" style="font-size: large; color: #008000;">Create Shipping Manifest</a> </li>
    </ul>
    </td>
</tr></table>
</asp:Content>
