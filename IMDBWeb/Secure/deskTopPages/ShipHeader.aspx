<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ShipHeader.aspx.cs" Inherits="IMDBWeb.Secure.deskTopPages.ShipHeader" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<table><tr id="trSubNav" runat="server">
<td><asp:Button ID="btnAddShipment" runat="server" Text="New Shipment " 
        onclick="btnAddShipment_Click" /></td>
<td><asp:Button ID="btnFindShipment" runat="server" Text="Find Shipment" /></td>
</tr></table>
<h3>Shipment Management</h3>
<table>
<tr id="trFind" runat="server"><td>
    <asp:FormView ID="fvShipHdr" runat="server" DataSourceID="sdsShipHdr" DataKeyNames="ID" DefaultMode="ReadOnly">
        <EditItemTemplate>
        <table border="1">
        <tr><td>ID:</td><td><asp:Label ID="IDLabel1" runat="server" Text='<%# Eval("ID") %>' /></td></tr>
        <tr><td>OutboundDocNo:</td><td><asp:TextBox ID="OutboundDocNoTextBox" runat="server" Text='<%# Bind("OutboundDocNo") %>' /></td></tr>
        <tr><td>Destination:</td><td><asp:TextBox ID="DestinationTextBox" runat="server" Text='<%# Bind("Destination") %>' /></td></tr>
        <tr><td>ShipDate:</td><td><asp:TextBox ID="ShipDateTextBox" runat="server" Text='<%# Bind("ShipDate") %>' /></td></tr>
        <tr><td>Carrier:</td><td><asp:TextBox ID="CarrierTextBox" runat="server" Text='<%# Bind("Carrier") %>' /></td></tr>
        <tr><td>Trailer Number:</td><td><asp:TextBox ID="Trailer_NumberTextBox" runat="server" Text='<%# Bind("[Trailer Number]") %>' /></td></tr>
        <tr><td>ShippingDock:</td><td><asp:TextBox ID="ShippingDockTextBox" runat="server" Text='<%# Bind("ShippingDock") %>' /></td></tr>
        <tr><td>WiseOrder:</td><td><asp:TextBox ID="WiseOrderTextBox" runat="server" Text='<%# Bind("WiseOrder") %>' /></td></tr>
        <tr><td>Completed:</td><td><asp:CheckBox ID="CompletedCheckBox" runat="server" Checked='<%# Bind("Completed") %>' /></td></tr>
        </table>
        <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />&nbsp;
        <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
        </EditItemTemplate>
        <InsertItemTemplate>
        <table border="1">
        <tr><td>OutboundDocNo:</td><td><asp:TextBox ID="OutboundDocNoTextBox" runat="server" Text='<%# Bind("OutboundDocNo") %>' /></td></tr>
        <tr><td>Destination:</td><td><asp:TextBox ID="DestinationTextBox" runat="server" Text='<%# Bind("Destination") %>' /></td></tr>
        <tr><td>ShipDate:</td><td><asp:TextBox ID="ShipDateTextBox" runat="server" Text='<%# Bind("ShipDate") %>' /></td></tr>
        <tr><td>Carrier:</td><td><asp:TextBox ID="CarrierTextBox" runat="server" Text='<%# Bind("Carrier") %>' /></td></tr>
        <tr><td>Trailer Number:</td><td><asp:TextBox ID="Trailer_NumberTextBox" runat="server" Text='<%# Bind("[Trailer Number]") %>' /></td></tr>
        <tr><td>ShippingDock:</td><td><asp:TextBox ID="ShippingDockTextBox" runat="server" Text='<%# Bind("ShippingDock") %>' /></td></tr>
        <tr><td>WiseOrder:</td><td><asp:TextBox ID="WiseOrderTextBox" runat="server" Text='<%# Bind("WiseOrder") %>' /></td></tr>
        <tr><td>Completed:</td><td><asp:CheckBox ID="CompletedCheckBox" runat="server" Checked='<%# Bind("Completed") %>' /></td></tr>
        </table>
        <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />&nbsp;
        <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
        </InsertItemTemplate>
        <ItemTemplate>
        <table border="1">
        <tr><td>ID:</td><td><asp:Label ID="IDLabel" runat="server" Text='<%# Eval("ID") %>' /></td></tr>
        <tr><td>OutboundDocNo:</td><td><asp:Label ID="OutboundDocNoLabel" runat="server" Text='<%# Bind("OutboundDocNo") %>' /></td></tr>
        <tr><td>Destination:</td><td><asp:Label ID="DestinationLabel" runat="server" Text='<%# Bind("Destination") %>' /></td></tr>
        <tr><td>ShipDate:</td><td><asp:Label ID="ShipDateLabel" runat="server" Text='<%# Bind("ShipDate") %>' /></td></tr>
        <tr><td>Carrier:</td><td><asp:Label ID="CarrierLabel" runat="server" Text='<%# Bind("Carrier") %>' /></td></tr>
        <tr><td>Trailer Number:</td><td><asp:Label ID="Trailer_NumberLabel" runat="server" Text='<%# Bind("[Trailer Number]") %>' /></td></tr>
        <tr><td>ShippingDock:</td><td><asp:Label ID="ShippingDockLabel" runat="server" Text='<%# Bind("ShippingDock") %>' /></td></tr>
        <tr><td>WiseOrder:</td><td><asp:Label ID="WiseOrderLabel" runat="server" Text='<%# Bind("WiseOrder") %>' /></td></tr>
        <tr><td>Completed:</td><td><asp:CheckBox ID="CompletedCheckBox" runat="server" Checked='<%# Bind("Completed") %>' Enabled="false" /></td></tr>
        </table>
        </ItemTemplate>
    </asp:FormView>
    </td>
    </tr>
</table>    
<asp:SqlDataSource ID="sdsShipHdr" runat="server" 
    ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
    SelectCommand="IMDB_Shipment_Sel" SelectCommandType="StoredProcedure">
</asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Clear" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Footer" runat="server">
</asp:Content>
