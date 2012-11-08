<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Shipping.aspx.cs" Inherits="TeleiosDemo.Secure.SuperFundPages.Shipping" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<table>
<tr align="center"><td>TruckCode</td><td>ManifestNumber</td><td>ContainerID</td><td>&nbsp;</td></tr>
<tr><td>
    <asp:DropDownList ID="ddTruck" runat="server" 
        DataSourceID="sdsTruckSelect" DataTextField="TruckCode" 
        DataValueField="ID" AutoPostBack="True" AppendDataBoundItems="True" 
        EnableViewState="false" onselectedindexchanged="ddTruck_SelectedIndexChanged">
        <asp:ListItem Text="Select" Value="0" />
    </asp:DropDownList>
</td><td>
    <asp:DropDownList ID="ddManifestNumber" runat="server" 
        DataSourceID="sdsManifestSelect" DataTextField="ManifestNumber" 
        DataValueField="ID" AutoPostBack="True" AppendDataBoundItems="True" 
        EnableViewState="False" onselectedindexchanged="ddManifestNumber_SelectedIndexChanged">
        <asp:ListItem Text="Select" Value="0" />
    </asp:DropDownList>
</td><td>
    <asp:TextBox ID="txbContainerID" runat="server" ontextchanged="txbContainerID_TextChanged" AutoPostBack="true" /></td><td>
    <asp:Button ID="btnReset" runat="server" Text="Reset" onclick="btnReset_Click" />
    </td></tr>
<tr align="center"><td>
    <asp:Button ID="btnTruck" runat="server" Text="New" Font-Size="XX-Small" onclick="btnTruck_Click" />
    </td><td>
        <asp:Button ID="btnManifest" runat="server" Text="New" Font-Size="XX-Small" onclick="btnManifest_Click" />
    </td><td></td><td>&nbsp;</td></tr>
</table>
<hr />
<table>
<tr id="trErrorMsg" runat="server"><td colspan="3">
    <asp:Label ID="lblErrMsg" runat="server" Text="" Font-Bold="true" ForeColor="Red" Font-Size="Larger"></asp:Label>
     </td><td>
    &nbsp;</td><td>
    &nbsp;</td><td>
    &nbsp;</td></tr>
<tr id="trValidationMsg" runat="server"><td colspan="3">
    <asp:RegularExpressionValidator ID="revTruck" runat="server" ControlToValidate="txbNewTruck" SetFocusOnError="true"
    ValidationExpression="(0[1-9]|1[012])[/](0[1-9]|[12][0-9]|3[01])[/][01]\d[-]\d\d" 
    ErrorMessage="Please enter a truck code in a format of mm/dd/yy-##" 
    Font-Bold="true" ForeColor="Red" Font-Size="Larger"></asp:RegularExpressionValidator>
     </td><td>
        &nbsp;</td><td>
        &nbsp;</td><td>
        &nbsp;</td></tr>
<tr id="trTruck" runat="server"><td align="right">
    <asp:Label ID="lblNewTruck" runat="server" Text="Truck Code: "></asp:Label></td>
    <td><asp:TextBox ID="txbNewTruck" runat="server" ontextchanged="txbNewTruck_TextChanged" />
    </td>
    <td>
        <asp:Button ID="btnAddTruck" runat="server" Text="Add" Font-Size="Small" onclick="btnAddTruck_Click" />&nbsp;&nbsp;
        <asp:Button ID="btnTruckCancel" runat="server" Text="Cancel" Font-Size="Small" onclick="btnTruckCancel_Click" CausesValidation="false" />
    </td>
    <td>
        &nbsp;</td></tr>
<tr id="trManifest" runat="server"><td align="right">
    <asp:Label ID="lblNewManifest" runat="server" Text="New Manifest: "></asp:Label></td>
    <td><asp:TextBox ID="txbNewManifest" runat="server" ontextchanged="txbNewManifest_TextChanged" TabIndex="98" AutoPostBack="True" /></td>
    <td>
        <asp:Button ID="btnAddManifest" runat="server" Font-Size="Small" Text="Add" onclick="btnAddManifest_Click" TabIndex="100" />&nbsp;&nbsp;
        <asp:Button ID="btnManifestCancel" runat="server" Text="Cancel" Font-Size="Small" onclick="btnManifestCancel_Click" />
    </td>
    <td>
        &nbsp;</td></tr>
<tr id="trDestination" runat="server"><td align="right">
    Destination:&nbsp</td>
    <td>
        <asp:TextBox ID="txbDestination" runat="server" ontextchanged="txbDestination_TextChanged" TabIndex="99" />
    </td>
    <td>&nbsp;</td>
    <td>&nbsp;</td></tr>
<tr id="trContainerMsg" runat="server" valign="bottom" style="height:50px"><td align="left" colspan="4">
    <asp:Label ID="lblContainerMsg" runat="server" Text="Scan/Enter a valid Container ID" 
    Font-Bold="true" Font-Italic="true" Font-Size="Larger" ForeColor="Black" /></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td></tr>
<tr id="trContainer" runat="server"><td align="left" colspan="4">
    <asp:Label ID="lblNewContainer" runat="server" Text="Add Container: " Font-Size="Large" />&nbsp;&nbsp;&nbsp;
    <asp:TextBox ID="txbNewContainer" runat="server" ontextchanged="txbNewContainer_TextChanged" AutoPostBack="true" /></td>
    <td></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td></tr>
</table><br />
<asp:GridView ID="gvShipContainer" runat="server" AutoGenerateColumns="False" 
        DataSourceID="sdsShipContainers"  AllowSorting="True" 
        CellPadding="4" ForeColor="#333333" GridLines="Horizontal"
        OnDataBound="gvShipContainer_OnDatabound"
        OnRowDataBound="gvShipContainer_RowDataBound"
        OnRowDeleted="gvShipContainer_RowDeleted"
        OnRowDeleting="gvShipContainer_RowDeleting"
        SelectedRowStyle-BackColor = "#ffff99" DataKeyNames="CntrID">
    <Columns>
        <asp:TemplateField>
        <ItemTemplate>
            <asp:LinkButton ID="lnkBtnDel" CommandArgument='<%# Eval("CntrID") %>' CommandName="Delete" runat="server" Text="Delete" />
        </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="TruckID" HeaderText="TruckID" InsertVisible="False" Visible="false" ReadOnly="True" SortExpression="ID" />
        <asp:BoundField DataField="TruckCode" HeaderText="Truck Code" SortExpression="TruckCode" />
        <asp:BoundField DataField="ManifestID" HeaderText="ManifestID" InsertVisible="False" Visible="false" ReadOnly="True" SortExpression="ID1" />
        <asp:BoundField DataField="ManifestNumber" HeaderText="Manifest Number" SortExpression="ManifestNumber" />
        <asp:BoundField DataField="DestinationFacility" HeaderText="Destination Facility" SortExpression="DestinationFacility" />
        <asp:BoundField DataField="ContainerID" HeaderText="Container ID" SortExpression="ContainerID" />
        <asp:BoundField DataField="shipCntrID" HeaderText="ShipCntrID" SortExpression="CntrID" Visible="false" />
    </Columns>
    <EditRowStyle BackColor="#7C6F57" />
    <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
    <HeaderStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#333333" />
    <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />

<SelectedRowStyle BackColor="#FFFF99"></SelectedRowStyle>
</asp:GridView>
<asp:SqlDataSource ID="sdsShipContainers" runat="server" 
    ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
    SelectCommand="SFund_gvShipContainers" SelectCommandType="StoredProcedure"
     DeleteCommand="SFund_ShipCntr_Del" DeleteCommandType="StoredProcedure">
    <SelectParameters>
        <asp:ControlParameter ControlID="ddTruck" Name="TruckID" PropertyName="SelectedValue" Type="Int32" />
        <asp:ControlParameter ControlID="ddManifestNumber" Name="ManifestID" PropertyName="SelectedValue" Type="Int32" />
        <asp:ControlParameter ControlID="txbContainerID" DefaultValue="0" Name="ContainerID" PropertyName="Text" Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="sdsTruckSelect" runat="server" 
    ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
    SelectCommand="SFund_TruckCode_Sel" SelectCommandType="StoredProcedure">
</asp:SqlDataSource>
<asp:SqlDataSource ID="sdsManifestSelect" runat="server" 
    ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
    SelectCommand="SFund_Manifest_Sel" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:ControlParameter ControlID="ddTruck" Name="TruckID" PropertyName="SelectedValue" Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>
    </asp:Content>
