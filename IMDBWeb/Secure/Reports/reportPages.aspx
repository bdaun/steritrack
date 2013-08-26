<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="reportPages.aspx.cs" Inherits="IMDBWeb.Secure.Reports.reportPages" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<br />
<br />
    <asp:Button ID="btnSPAKReports" runat="server" Text="SPAK Reports" onclick="btnSPAKReports_Click" />
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:Button ID="btnIndustrialReports" runat="server" Text="Industrial Reports" onclick="btnIndustrialReports_Click" />
</asp:Content>
