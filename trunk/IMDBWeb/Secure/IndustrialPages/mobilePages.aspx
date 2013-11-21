<%@ Page Title="" Language="C#" MasterPageFile="~/mobile.Master" AutoEventWireup="true" CodeBehind="mobilePages.aspx.cs" Inherits="IMDBWeb.mobilePages" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<h3>Industrial Pages</h3>
    <ul>
    <li>
    <asp:HyperLink ID="hypInLocChng" runat="server" NavigateUrl="~/secure/IndustrialPages/mlocationchange.aspx">
    Inbound Location Change</asp:HyperLink><br />
    </li>
    <li>
    <asp:HyperLink ID="hypProc" runat="server" NavigateUrl="~/secure/IndustrialPages/mProcessing.aspx">
    Processing</asp:HyperLink><br />
    </li>
    <li>
    <asp:HyperLink ID="hypAggregate" runat="server" NavigateUrl="~/secure/IndustrialPages/mAggregateContainer.aspx">Manage Aggregate Containers</asp:HyperLink>
    </li>
    </ul>
<h3>SPAK Pages</h3>
    <ul>
    <li>
    <asp:HyperLink ID="hlSpakBox" runat="server" NavigateUrl="~/secure/SpakPages/mBoxRcvd.aspx">
    SPAK Box Receiving</asp:HyperLink><br />
    </li>
    </ul>
</asp:Content>
