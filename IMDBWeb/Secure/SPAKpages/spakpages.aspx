<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="spakpages.aspx.cs" Inherits="IMDBWeb.Secure.SPAKpages.spakmenu" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<h3>Retail Menu Options</h3>
<hr />
    <table border="2" cellpadding="10" style="background-color:#f9f9f9">
        <tr style="text-align:center;font-size:x-large;font-weight:bold;color:#003300">
            <td>Retail Operations</td>
            <td>Technician Management</td>
        </tr>
        <tr valign="top">
            <td>
                <ul>
                    <li><a href="ManifestRcvd.aspx" style="font-size: large; color: #008000;">Manifest Receiving</a></li>
                    <li><a href="ManifestMailing.aspx" style="font-size: large; color: #008000;">Manage Manifest Mailing</a></li>
                    <li><a href="AlertItems.aspx" style="font-size: large; color: #008000;">Manage Alert Items</a></li>
                </ul>
            </td>
            <td>
                <ul>
                    <li><a href="TechProg.aspx" style="font-size: large; color: #008000;">Technician Progress Update</a></li>
                    <li><a href="TechCSMap.aspx" style="font-size: large; color: #008000;">Technician/CS Rep Mapping</a></li>
                    <li><a href="TechComments.aspx" style="font-size: large; color: #008000;">Technician Issue Log</a></li>
                    <li><a href="MgtSummary.aspx" style="font-size: large; color: #008000;">Technician Progress Summary</a></li>
                </ul>
            </td>
        </tr>
    </table>
</asp:Content>
