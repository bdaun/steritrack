<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="IndustrialPages.aspx.cs" Inherits="IMDBWeb.IndustrialPages" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<h3>Industrial Menu Options</h3>
<hr />
<table border="2" cellpadding="10" style="background-color:#f1f1f1">
    <tr style="text-align:center;font-size:x-large;font-weight:bold;color:#003300">
        <td>Mobile Menu</td>
        <td>Desktop Menu</td>
    </tr>
    <tr>
        <td>
            <ul>
              <li><a href="mAggregateContainer.aspx" style="font-size: large; color: #008000;">Manage Aggregate Containers</a></li>
              <li><a href="mLocationChange.aspx" style="font-size: large; color: #008000;">Inbound Location Change</a></li>
              <li><a href="mProcessing.aspx" style="font-size: large; color: #008000;">Processing</a></li>
            </ul>
        </td>
        <td>
            <ul>
              <li><a href="Receiving2.aspx" style="font-size: large; color: #008000;">Receiving</a></li>
              <li><a href="ShipHeader.aspx" style="font-size: large; color: #008000;">Create Shipping Manifest</a></li>
              <li><a href="Truckout.aspx" style="font-size: large; color: #008000;">Truck Out Containers</a></li>
            </ul>
        </td>
    </tr>
</table>
</asp:Content>
