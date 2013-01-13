<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="InvoiceMenu.aspx.cs" Inherits="MWP.Secure.Invoice.InvoiceMenu" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<h2>Invoice Menu</h2>
<asp:Table ID="tblMenu" runat="server">
    <asp:TableRow>
        <asp:TableCell><asp:HyperLink runat="server" NavigateUrl="~/Secure/Invoice/InvoiceSummary.aspx">Invoice Summary</asp:HyperLink></asp:TableCell>
        <asp:TableCell></asp:TableCell></asp:TableRow>
</asp:Table>
</asp:Content>
