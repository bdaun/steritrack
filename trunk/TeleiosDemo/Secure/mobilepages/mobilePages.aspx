<%@ Page Title="" Language="C#" MasterPageFile="~/mobile.Master" AutoEventWireup="true" CodeBehind="mobilePages.aspx.cs" Inherits="TeleiosDemo.mobilePages" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <br />
    <ul>
    <li>
    <asp:HyperLink ID="hypInLocChng" runat="server" NavigateUrl="~/secure/mobilepages/mAggregateContainer.aspx">
    New Container Mgt</asp:HyperLink><br />
    </li>
    <li>
    <asp:HyperLink ID="hypProc" runat="server" NavigateUrl="~/secure/mobilepages/mAggregateContainer.aspx">
    Container Disposition</asp:HyperLink><br />
    </li>
    <li>
    <asp:HyperLink ID="hypAggregate" runat="server" NavigateUrl="~/secure/mobilepages/mAggregateContainer.aspx">Manage Containers</asp:HyperLink>
    </li>
    </ul>
    <br /><br /><br /><br /><br /><br /><br /><br /><br />
    <asp:Label ID="lblFooter" runat="server" Text="Teleios Mobile View" Font-Italic="true" />
</asp:Content>
 