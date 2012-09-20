<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ShipHeader.aspx.cs" Inherits="IMDBWeb.Secure.deskTopPages.ShipHeader" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<asp:ScriptManager ID="sm1" runat="server" />
<h3>Shipment Management</h3><hr /><br />
<table><tr id="trSubNav" runat="server">
<td><asp:Button ID="btnAddShipment" runat="server" Text="New Shipment " 
        onclick="btnAddShipment_Click" Width="129px" /></td>
<td><asp:Button ID="btnFindShipment" runat="server" Text="Find Shipment" 
        onclick="btnFindShipment_Click" Width="132px" /></td>
</tr></table>
<table>
    <tr id="trFind" runat="server">
        <td align="right">Wise Order:&nbsp;<br />OutboundDocNo:&nbsp;</td>
        <td><asp:TextBox ID="txbWiseOrder" runat="server" /><br />
            <asp:TextBox ID="txbOutboundDocNo" runat="server" /></td>
        <td valign="bottom">&nbsp;&nbsp;
        <asp:Button ID="btnSearch" runat="server" Text="Search" onClick="btnSearch_Click" />&nbsp;&nbsp;
        <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click" /></td>
    </tr>
</table>
<asp:Label ID="lblErrMsg" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" />
<table>
<tr><td>
    <asp:FormView ID="fvShipHdr" runat="server" DataSourceID="sdsShipHdr" 
        DataKeyNames="ID" DefaultMode="ReadOnly" >
        <EditItemTemplate>
        <table border="1">
        <tr style="font-weight:bold; text-align:center"><td>Field</td><td>Value</td></tr>
        <tr><td style="font-weight:bold" align="right">ID:&nbsp;</td><td><asp:Label ID="IDLabel1" runat="server" Text='<%# Eval("ID") %>' /></td></tr>
        <tr><td style="font-weight:bold" align="right">OutboundDocNo:&nbsp;</td><td><asp:TextBox ID="OutboundDocNoTextBox" runat="server" Text='<%# Bind("OutboundDocNo") %>' /></td></tr>
        <tr><td style="font-weight:bold" align="right">Destination:&nbsp;</td>
        <td>
            <asp:DropDownList ID="ddDestination" runat="server" SelectedValue='<%# Bind("Destination") %>'
                DataSourceID="sdsDestination" DataTextField="VendorName" DataValueField="VendorName">
            </asp:DropDownList>        
        </td></tr>
        <tr><td style="font-weight:bold" align="right">ShipDate:&nbsp;</td>
        <td><asp:TextBox ID="ShipDateTextBox" runat="server" Text='<%# Bind("ShipDate") %>' />
        <ajaxToolkit:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="ShipDateTextBox" /></td></tr>
        <tr><td style="font-weight:bold" align="right">Carrier:&nbsp;</td>
        <td>
            <asp:DropDownList ID="ddCarrier" runat="server" SelectedValue='<%# Bind("Carrier") %>'
                DataSourceID="sdsCarrier" DataTextField="VendorName" DataValueField="VendorName">
            </asp:DropDownList>        
        </td></tr>
        <tr><td style="font-weight:bold" align="right">Trailer Number:&nbsp;</td>
        <td><asp:TextBox ID="Trailer_NumberTextBox" runat="server" Text='<%# Bind("[Trailer Number]") %>' /></td></tr>
        <tr><td style="font-weight:bold" align="right">ShippingDock:&nbsp;</td>
        <td>
            <asp:DropDownList ID="ddDock" runat="server" SelectedValue='<%# Bind("ShippingDock") %>'>
                <asp:ListItem Text="Select from List" Value="0" />
                <asp:ListItem Text="33" Value="33" />
                <asp:ListItem Text="34" Value="34" />
                <asp:ListItem Text="35" Value="35" />
                <asp:ListItem Text="36" Value="36" />
                <asp:ListItem Text="37" Value="37" />
                <asp:ListItem Text="Other" Value="Other" />
            </asp:DropDownList>        
        </td></tr>
        <tr><td style="font-weight:bold" align="right">WiseOrder:&nbsp;</td>
        <td><asp:TextBox ID="WiseOrderTextBox" runat="server" Text='<%# Bind("WiseOrder") %>' />
        <asp:RequiredFieldValidator ID="rfvWiseOrder" runat="server" ControlToValidate="WiseOrderTextBox" ErrorMessage="Wise Order" Font-Bold="true" ForeColor="Red" Text="*" />
        </td></tr>
        <tr><td style="font-weight:bold" align="right">Completed:&nbsp;</td>
        <td><asp:CheckBox ID="Completed" runat="server" Checked='<%# Bind("Completed") %>' /></td></tr>
        </table>
        <asp:LinkButton ID="btnUpdate" runat="server" CausesValidation="True" onClick="btnUpdate_Click" Text="Update" />&nbsp;
        <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
        <asp:ValidationSummary ID="vsShipHdrUpd" runat="server" DisplayMode="BulletList" ShowMessageBox="true" ShowSummary="false" HeaderText="You must enter a value in the following fields:" EnableClientScript="true" />
        </EditItemTemplate>
        <InsertItemTemplate>
        <table border="1">
        <tr style="font-weight:bold; text-align:center"><td>Field</td><td>Value</td></tr>
        <tr><td style="font-weight:bold" align="right">OutboundDocNo:&nbsp;</td>
            <td><asp:TextBox ID="OutboundDocNoTextBox" runat="server" Text='<%# Bind("OutboundDocNo") %>' />
                <asp:RequiredFieldValidator ID="rfvDocNo" runat="server" ControlToValidate="OutboundDocNoTextBox" ErrorMessage="Document Number" Font-Bold="true" ForeColor="Red" Text="*" />
            </td></tr>
        <tr><td style="font-weight:bold" align="right">Destination:&nbsp;</td>
        <td>
            <asp:DropDownList ID="ddDestination" runat="server" AppendDataBoundItems = "true" SelectedValue='<%# Bind("Destination") %>'
                DataSourceID="sdsDestination" DataTextField="VendorName" DataValueField="VendorName">
                <asp:ListItem Text="Select from List" Value="Not Specified" />
            </asp:DropDownList>
            <asp:RequiredFieldValidator ID="rfvDestination" runat="server" ControlToValidate="ddDestination" InitialValue="Not Specified" ErrorMessage="Destination" Font-Bold="true" ForeColor="Red" Text="*" />
        </td></tr>
        <tr><td style="font-weight:bold" align="right">ShipDate:&nbsp;</td>
        <td><asp:TextBox ID="ShipDateTextBox" runat="server" Text='<%# Bind("ShipDate") %>' />
        <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="ShipDateTextBox" /></td></tr>
        <tr><td style="font-weight:bold" align="right">Carrier:&nbsp;</td>
        <td>
            <asp:DropDownList ID="ddCarrier" runat="server" AppendDataBoundItems = "true" SelectedValue='<%# Bind("Carrier") %>'
                DataSourceID="sdsCarrier" DataTextField="VendorName" DataValueField="VendorName">
                <asp:ListItem Text="Select from List" Value="Not Specified" />
            </asp:DropDownList>
        </td></tr>
        <tr><td style="font-weight:bold" align="right">Trailer Number:&nbsp;</td><td><asp:TextBox ID="Trailer_NumberTextBox" runat="server" Text='<%# Bind("[Trailer Number]") %>' /></td></tr>
        <tr><td style="font-weight:bold" align="right">ShippingDock:&nbsp;</td>
        <td>
            <asp:DropDownList ID="ddDock" runat="server" SelectedValue='<%# Bind("ShippingDock") %>'>
                <asp:ListItem Text="Select from List" Value="0" />
                <asp:ListItem Text="33" Value="33" />
                <asp:ListItem Text="34" Value="34" />
                <asp:ListItem Text="35" Value="35" />
                <asp:ListItem Text="36" Value="36" />
                <asp:ListItem Text="37" Value="37" />
                <asp:ListItem Text="Other" Value="Other" />
            </asp:DropDownList>
        </td></tr>
        <tr><td style="font-weight:bold" align="right">WiseOrder:&nbsp;</td>
        <td><asp:TextBox ID="WiseOrderTextBox" runat="server" Text='<%# Bind("WiseOrder") %>' />
            <asp:RequiredFieldValidator ID="rfvWiseOrder" runat="server" ControlToValidate="WiseOrderTextBox" ErrorMessage="Wise Order" Font-Bold="true" ForeColor="Red" Text="*" />
        </td></tr>
        </table>
        <asp:LinkButton ID="btnInsert" runat="server" CausesValidation="True" onClick="btnInsert_Click" Text="Insert" />&nbsp;
        <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
        <asp:ValidationSummary ID="vsShipHdrIns" runat="server" DisplayMode="BulletList" ShowMessageBox="true" ShowSummary="false" HeaderText="You must enter a value in the following fields:" EnableClientScript="true" />
        </InsertItemTemplate>
        <ItemTemplate>
        <table border="1" width="100%">
        <tr style="font-weight:bold; text-align:center"><td>Field</td><td>Value</td></tr>
        <tr><td style="font-weight:bold" align="right">ID:&nbsp;</td><td><asp:Label ID="IDLabel" runat="server" Text='<%# Eval("ID") %>' /></td></tr>
        <tr><td style="font-weight:bold" align="right">OutboundDocNo:&nbsp;</td><td><asp:Label ID="OutboundDocNo" runat="server" Text='<%# Bind("OutboundDocNo") %>' /></td></tr>
        <tr><td style="font-weight:bold" align="right">Destination:&nbsp;</td><td><asp:Label ID="Destination" runat="server" Text='<%# Bind("Destination") %>' /></td></tr>
        <tr><td style="font-weight:bold" align="right">ShipDate:&nbsp;</td><td><asp:Label ID="ShipDate" runat="server" Text='<%# Bind("ShipDate","{0:d}") %>'  /></td></tr>
        <tr><td style="font-weight:bold" align="right">Carrier:&nbsp;</td><td><asp:Label ID="Carrier" runat="server" Text='<%# Bind("Carrier") %>' /></td></tr>
        <tr><td style="font-weight:bold" align="right">Trailer Number:&nbsp;</td><td><asp:Label ID="Trailer_Number" runat="server" Text='<%# Bind("[Trailer Number]") %>' /></td></tr>
        <tr><td style="font-weight:bold" align="right">ShippingDock:&nbsp;</td><td><asp:Label ID="ShippingDock" runat="server" Text='<%# Bind("ShippingDock") %>' /></td></tr>
        <tr><td style="font-weight:bold" align="right">WiseOrder:&nbsp;</td><td><asp:Label ID="WiseOrder" runat="server" Text='<%# Bind("WiseOrder") %>' /></td></tr>
        <tr><td style="font-weight:bold" align="right">Completed:&nbsp;</td><td><asp:CheckBox ID="Completed" runat="server" Checked='<%# Bind("Completed") %>' Enabled="false" /></td></tr>
        <tr><td colspan="2" align="right"><asp:Button ID="btnEdit" runat="server" Text="Edit" onclick="btnEdit_Click" /></td></tr>
        </table>
        </ItemTemplate>
    </asp:FormView>
    </td>
    </tr>
</table>  
<asp:SqlDataSource ID="sdsShipHdr" runat="server" 
    ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" OnInserting="sdsShipHdr_Inserting" OnUpdating="sdsShipHdr_Updating"
    SelectCommand="IMDB_ShipHdr_Sel" SelectCommandType="StoredProcedure"
    UpdateCommand="IMDB_ShipHdr_Upd" UpdateCommandType="StoredProcedure">
    <SelectParameters>
        <asp:ControlParameter ControlID="txbWiseOrder" DefaultValue="" Name="WiseOrder" ConvertEmptyStringToNull="true" />
        <asp:ControlParameter ControlID="txbOutboundDocNo" DefaultValue="" Name="OutboundDocNo" ConvertEmptyStringToNull="true" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="sdsDestination" runat="server" 
    ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
    SelectCommand="IMDB_ShipHdr_Destination_Sel" 
    SelectCommandType="StoredProcedure">
</asp:SqlDataSource>
<asp:SqlDataSource ID="sdsCarrier" runat="server" 
    ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
    SelectCommand="IMDB_ShipHdr_Carrier_Sel" 
    SelectCommandType="StoredProcedure">
</asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Clear" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Footer" runat="server">
</asp:Content>
