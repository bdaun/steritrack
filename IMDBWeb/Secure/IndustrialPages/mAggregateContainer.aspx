<%@ Page Title="" Language="C#" MasterPageFile="~/Mobile.Master" AutoEventWireup="true" CodeBehind="mAggregateContainer.aspx.cs" Inherits="IMDBWeb.Secure.IndustrialPages.AggregateContainer" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headcontent" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pagename" runat="server"><div class="pagename">Aggregate Container</div></asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="maincontent" runat="server"><hr />
<p style="font-size:x-small">Select a Container:&nbsp
<asp:DropDownList ID="ddContainer" runat="server" onselectedindexchanged="ddContainer_SelectedIndexChanged" AutoPostBack="true" TabIndex="1">
    <asp:ListItem Text="Select a Value" Value="" Selected="True" />
    <asp:ListItem Text="Compactor" Value="Compactor" />
    <asp:ListItem Text="Tank 1" Value="Tank1" />
    <asp:ListItem Text="Tank 2" Value="Tank2" />
    <asp:ListItem Text="Baler" Value="Baler" />
</asp:DropDownList><br />
<asp:Label ID="lblErrMsg" runat="server" Text="" ForeColor="Red" Font-Bold="true" /></p>
<asp:Label ID="lblCurCntr" runat="server" Text="Current Container: " Font-Size="X-Small" />
<asp:Label ID="lblCurValue" runat="server" Text="" ForeColor="Black" /><br />
<asp:Label ID="lblNewCntr" runat="server" Text="New Container: " Font-Size="X-Small" />
<asp:TextBox ID="txbNewCntr" runat="server" ontextchanged="txbNewContainer_TextChanged" Width="125px" 
    AutoPostBack="True" CausesValidation="True" TabIndex="2"></asp:TextBox><br />
<asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click" CausesValidation="false" /><br />
</asp:Content>
