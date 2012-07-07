<%@ Page Title="" Language="C#" MasterPageFile="~/mobile.Master" AutoEventWireup="true" CodeBehind="mobilePages.aspx.cs" Inherits="IMDBWeb.mobilePages" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <br />
    <ul>
    <li>
    <asp:HyperLink ID="hypInLocChng" runat="server" NavigateUrl="~/secure/mobilepages/mlocationchange.aspx">
    Inbound Location Change</asp:HyperLink><br />
    </li>
    <li>
    <asp:HyperLink ID="hypProc" runat="server" NavigateUrl="~/secure/mobilepages/mProcessing.aspx">
    Processing</asp:HyperLink><br />
    </li>
    <li>
    <asp:HyperLink ID="hypAggregate" runat="server" NavigateUrl="~/secure/mobilepages/mAggregateContainer.aspx">Manage Aggregate Containers</asp:HyperLink>
    </li>
    </ul>
</asp:Content>
