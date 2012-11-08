<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="spakpages.aspx.cs" Inherits="TeleiosDemo.Secure.SPAKpages.spakmenu" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<h3>SPAK Menu Options</h3>
<hr />
    <ul style="font-size: large; color: #008000;">
        <li><a href="TechProg.aspx" style="font-size: large; color: #008000;">Technician Progress Update</a> </li>
        <li><a href="TechCSMap.aspx" style="font-size: large; color: #008000;">Technician/CS Rep Mapping</a> </li>
        <li><a href="TechComments.aspx" style="font-size: large; color: #008000;">Technician Issue Log</a></li>
        <li><a href="MgtSummary.aspx" style="font-size: large; color: #008000;">Technician Progress Summary</a></li>
    </ul>
</asp:Content>
