<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Receiving2.aspx.cs" 
Inherits="IMDBWeb.Secure.deskTopPages.Receiving2" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<asp:ScriptManager ID="SM1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
<h3>Receiving</h3><hr />
<asp:Label ID="lblErrMsg" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" />
<table id="tblBegin" runat="server">
<tr id="trBegin">
    <td style="font-style:italic">To begin, Select&nbsp;
    <asp:Button ID="btnSearchTruck" runat="server" Text="Search Existing Trucks" onclick="btnSearchTruck_Click" />&nbsp;or&nbsp;
    <asp:Button ID="btnNewTruck" runat="server" Text="Create New Truck" /></td></tr></table>
<table id="tblSearch" runat="server">
<tr><td colspan="2" style="font-style:italic">Enter your search criteria and click "Search"</td></tr>
<tr><td align="right">Order Number:&nbsp;</td>
    <td><asp:TextBox ID="txbOrderNumber" runat="server" AutoPostBack="true"></asp:TextBox>
        <ajaxToolkit:AutoCompleteExtender
            ID="txbOrderNum_AutoCompleteExtender" 
            runat="server"
            Enabled="True"
            CompletionInterval="250"
            TargetControlID="txbOrderNumber"
            ServicePath="myAutoComplete.asmx"
            ServiceMethod="GetOrderNums"
            MinimumPrefixLength="4"
            EnableCaching="true"
            CompletionSetCount="20"
            CompletionListCssClass="autocomplete_completionListElement" 
            CompletionListItemCssClass="autocomplete_listItem" 
            CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
            DelimiterCharacters=","
            ShowOnlyCurrentWordInCompletionListItem="false">
        </ajaxToolkit:AutoCompleteExtender></td><td></td></tr>
<tr><td align="right">Client:&nbsp;</td>
    <td><asp:DropDownList ID="ddClient" runat="server" DataSourceID="sdsClient" 
            AutoPostBack="true" AppendDataBoundItems="True" DataTextField="ClientName" 
            DataValueField="ClientID" onselectedindexchanged="ddClient_SelectedIndexChanged">
            <asp:ListItem Text="Select from List" Value="0" />
        </asp:DropDownList></td>
    <td>&nbsp;&nbsp;
        <asp:Button ID="btnSearch" runat="server" Text="Search" 
            onclick="btnSearch_Click" /> &nbsp;&nbsp;
        <asp:Button ID="btnCancelSearch" runat="server" Text="Cancel" onclick="btnCancelSearch_Click" /></td>
</tr>
</table>
<table>
<tr><td style="font-style:italic">
<asp:Label ID="lblTruckMsg" runat="Server" Text="Click on a row from the available trucks to manage containers"/>
    &nbsp;
</td><td></td></tr>
<tr><td>
    <asp:GridView ID="gvRcvHdr" runat="server" AutoGenerateColumns="False" DataKeyNames="RcvHdrID" DataSourceID="sdsRcvHdr"
            OnRowDataBound="gvRcvHdr_RowDataBound" OnSelectedIndexChanged="gvRcvHdr_SelectedIndexChanged" OnDataBound="gvRcvHdr_DataBound"
            SelectedRowStyle-BackColor="#ffff99" AllowPaging="True" AllowSorting="True" CellPadding="4" ForeColor="#333333">
        <Columns>
            <asp:BoundField DataField="RcvHdrID" HeaderText="Hdr ID" InsertVisible="False" ReadOnly="True" SortExpression="RcvHdrID" />
            <asp:BoundField DataField="OrderNumber" HeaderText="Order" SortExpression="OrderNumber" ItemStyle-Wrap="false" />
            <asp:BoundField DataField="WorkOrder" HeaderText="Work Order" SortExpression="WorkOrder" />
            <asp:BoundField DataField="Clientname" HeaderText="Client" SortExpression="Clientname" />
            <asp:BoundField DataField="Carrier" HeaderText="Carrier" SortExpression="Carrier" />
            <asp:BoundField DataField="TSDF" HeaderText="TSDF" SortExpression="TSDF" />
            <asp:BoundField DataField="ReceivedBy" HeaderText="RcvBy"  SortExpression="ReceivedBy" />
            <asp:BoundField DataField="ReceiveDate" HeaderText="RcvDate" SortExpression="ReceiveDate" DataFormatString="{0:d}" />
            <asp:BoundField DataField="ReceiveDock" HeaderText="Dock" SortExpression="ReceiveDock" />            
            <asp:BoundField DataField="Trailer Number" HeaderText="Trailer Number" SortExpression="Trailer Number" />
            <asp:BoundField DataField="ShipDate" HeaderText="Ship Date" SortExpression="ShipDate" DataFormatString="{0:d}" />
            <asp:BoundField DataField="ClientID" HeaderText="ClientID" SortExpression="ClientID" Visible="false" />
            <asp:BoundField DataField="TSDFID" HeaderText="TSDFID" SortExpression="TSDFID" Visible="false" />
            <asp:BoundField DataField="CarrierID" HeaderText="CarrierID" SortExpression="CarrierID" Visible="false" />
            <asp:BoundField DataField="Memo" HeaderText="Memo" SortExpression="Memo" Visible="false" />
        </Columns>
    </asp:GridView>    
    </td><td></td>
</tr>
</table>
<table>
<tr id="trAddContainers" runat="server" visible="false"><td>
    <asp:Button ID="btnAddContainer" runat="server" Text="Add Containers" onclick="btnAddContainer_Click" />&nbsp;
    <asp:Button ID="btnDone" runat="server" Text="Done" onclick="btnDone_Click" /></td>
</tr>
<tr id="trContainerDetails" runat="server">
    <td id="tdContainerEdit" runat="server" visible="false" style="width:400px">
    <asp:FormView ID="fvContainerDetail" runat="server" DataKeyNames="RcvDetailID" 
            DataSourceID="sdsContainerDetail" Font-Size="Small" OnDataBound="fvContainerDetail_DataBound">
        <EditItemTemplate>
        <table>
        <tr>
            <td style="font-weight:bold;font-size:smaller">ID</td>
            <td style="font-weight:bold;font-size:smaller">InboundDocNo</td>
            <td style="font-weight:bold;font-size:smaller">CntrID</td>
            <td style="font-weight:bold;font-size:smaller">BrandCode</td>  
            <td style="font-weight:bold;font-size:smaller">ManLine</td>
            <td style="font-weight:bold;font-size:smaller">Profile</td>
            <td style="font-weight:bold;font-size:smaller">RcvdAs</td>
            <td style="font-weight:bold;font-size:smaller">PalletType</td>
            <td style="font-weight:bold;font-size:smaller">PalletWt</td>
            <td style="font-weight:bold;font-size:smaller">CntrType</td>
            <td style="font-weight:bold;font-size:smaller">CntrQty</td>
            <td style="font-weight:bold;font-size:smaller">Location</td>
            <td style="font-weight:bold;font-size:smaller">ProcessPlan</td></tr>
        <tr>
            <td><asp:Label ID="RcvDetailIDLabel1" runat="server" Text='<%# Eval("RcvDetailID") %>' /></td>
            <td><asp:TextBox ID="InboundDocNoTextBox" runat="server" Text='<%# Bind("InboundDocNo") %>' /></td>
            <td><asp:TextBox ID="InboundContainerIDTextBox" runat="server" Text='<%# Bind("InboundContainerID") %>' /></td>
            <td><asp:TextBox ID="BrandCodeNameTextBox" runat="server" Text='<%# Bind("BrandCodeName") %>' /></td>
            <td><asp:TextBox ID="ManLineTextBox" runat="server" Text='<%# Bind("ManLine") %>' /></td>
            <td><asp:TextBox ID="ProfileTextBox" runat="server" Text='<%# Bind("Profile") %>' /></td>
            <td><asp:TextBox ID="RcvdAsTextBox" runat="server" Text='<%# Bind("RcvdAs") %>' /></td>
            <td><asp:TextBox ID="InboundPalletTypeTextBox" runat="server" Text='<%# Bind("InboundPalletType") %>' /></td>
            <td><asp:TextBox ID="InboundPalletWeightTextBox" runat="server" Text='<%# Bind("InboundPalletWeight") %>' /></td>
            <td><asp:TextBox ID="InboundContainerTypeTextBox" runat="server" Text='<%# Bind("InboundContainerType") %>' /></td>
            <td><asp:TextBox ID="InboundContainerQtyTextBox" runat="server" Text='<%# Bind("InboundContainerQty") %>' /></td>
            <td><asp:TextBox ID="InventoryLocationTextBox" runat="server" Text='<%# Bind("InventoryLocation") %>' /></td>
            <td><asp:TextBox ID="ProcessPlanTextBox" runat="server" Text='<%# Bind("ProcessPlan") %>' /></td>
            <td><asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />&nbsp;
            <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" /></td>
        </tr>
        </table>                       
        </EditItemTemplate>
        <InsertItemTemplate>
        <table>
        <tr>
            <td style="font-weight:bold;font-size:smaller"></td>
            <td style="font-weight:bold;font-size:smaller">InboundDocNo</td>
            <td style="font-weight:bold;font-size:smaller">CntrID</td>
            <td style="font-weight:bold;font-size:smaller">BrandCode</td>  
            <td style="font-weight:bold;font-size:smaller">ManLine</td>
            <td style="font-weight:bold;font-size:smaller">Profile</td>
            <td style="font-weight:bold;font-size:smaller">RcvdAs</td>
            <td style="font-weight:bold;font-size:smaller">PalletType</td>
            <td style="font-weight:bold;font-size:smaller">PalletWt</td>
            <td style="font-weight:bold;font-size:smaller">CntrType</td>
            <td style="font-weight:bold;font-size:smaller">CntrQty</td>
            <td style="font-weight:bold;font-size:smaller">Location</td>
            <td style="font-weight:bold;font-size:smaller">ProcessPlan</td></tr>
        <tr>
            <td><asp:Label ID="RcvDetailIDLabel1" runat="server" Text='<%# Eval("RcvDetailID") %>' Width="30px" Visible="false" /></td>
            <td><asp:TextBox ID="InboundDocNoTextBox" runat="server" Text='<%# Bind("InboundDocNo") %>' Width="75px" /></td>
            <td><asp:TextBox ID="InboundContainerIDTextBox" runat="server" Text='<%# Bind("InboundContainerID") %>' Width="75px" /></td>
            <td><asp:TextBox ID="BrandCodeTextBox" runat="server" Text='<%# Bind("BrandCode") %>' Width="250px" /></td>
            <td><asp:TextBox ID="ManLineTextBox" runat="server" Text='<%# Bind("ManLine") %>' Width="30px" /></td>
            <td><asp:TextBox ID="ProfileTextBox" runat="server" Text='<%# Bind("Profile") %>' Width="250px" /></td>
            <td><asp:TextBox ID="RcvdAsTextBox" runat="server" Text='<%# Bind("RcvdAs") %>' Width="50px" /></td>
            <td><asp:TextBox ID="InboundPalletTypeTextBox" runat="server" Text='<%# Bind("InboundPalletType") %>' Width="50px" /></td>
            <td><asp:TextBox ID="InboundPalletWeightTextBox" runat="server" Text='<%# Bind("InboundPalletWeight") %>' Width="50px" /></td>
            <td><asp:TextBox ID="InboundContainerTypeTextBox" runat="server" Text='<%# Bind("InboundContainerType") %>' Width="50px" /></td>
            <td><asp:TextBox ID="InboundContainerQtyTextBox" runat="server" Text='<%# Bind("InboundContainerQty") %>' Width="50px" /></td>
            <td><asp:TextBox ID="InventoryLocationTextBox" runat="server" Text='<%# Bind("InventoryLocation") %>' Width="100px" /></td>
            <td><asp:TextBox ID="ProcessPlanTextBox" runat="server" Text='<%# Bind("ProcessPlan") %>' Width="75px" /></td>
            <td><asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" onClick="fvContainerDetailsIns_Click" Text="Insert" />&nbsp;
            <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" OnClick="InsCancel_Click" CommandName="Cancel" Text="Cancel" /></td>
        </tr>
        </table>
        </InsertItemTemplate>
        <ItemTemplate>
       <table>
        <tr>
            <td style="font-weight:bold;font-size:smaller;" width="10px">ID</td>
            <td style="font-weight:bold;font-size:smaller">InboundDocNo</td>
            <td style="font-weight:bold;font-size:smaller">CntrID</td>
            <td style="font-weight:bold;font-size:smaller">BrandCode</td>  
            <td style="font-weight:bold;font-size:smaller">ManLine</td>
            <td style="font-weight:bold;font-size:smaller">Profile</td>
            <td style="font-weight:bold;font-size:smaller">RcvdAs</td>
            <td style="font-weight:bold;font-size:smaller">PalletType</td>
            <td style="font-weight:bold;font-size:smaller">PalletWt</td>
            <td style="font-weight:bold;font-size:smaller">CntrType</td>
            <td style="font-weight:bold;font-size:smaller">CntrQty</td>
            <td style="font-weight:bold;font-size:smaller">Location</td>
            <td style="font-weight:bold;font-size:smaller">ProcessPlan</td></tr>
        <tr>
            <td><asp:Label ID="RcvDetailIDLabel1" runat="server" Text='<%# Eval("RcvDetailID") %>' Width="10px" /></td>
            <td><asp:Label ID="InboundDocNoLabel" runat="server" Text='<%# Bind("InboundDocNo") %>' Width="30px" /></td>
            <td><asp:Label ID="InboundContainerIDLabel" runat="server" Text='<%# Bind("InboundContainerID") %>' Width="30px"  /></td>
            <td><asp:Label ID="BrandCodeNameLabel" runat="server" Text='<%# Bind("BrandCodeName") %>' Width="30px"  /></td>
            <td><asp:Label ID="ManLineLabel" runat="server" Text='<%# Bind("ManLine") %>' Width="30px"  /></td>
            <td><asp:Label ID="ProfileLabel" runat="server" Text='<%# Bind("Profile") %>' Width="30px"  /></td>
            <td><asp:Label ID="RcvdAsLabel" runat="server" Text='<%# Bind("RcvdAs") %>' Width="30px"  /></td>
            <td><asp:Label ID="InboundPalletTypeLabel" runat="server" Text='<%# Bind("InboundPalletType") %>' Width="30px"  /></td>
            <td><asp:Label ID="InboundPalletWeightLabel" runat="server" Text='<%# Bind("InboundPalletWeight") %>' Width="30px"  /></td>
            <td><asp:Label ID="InboundContainerTypeLabel" runat="server" Text='<%# Bind("InboundContainerType") %>' Width="30px"  /></td>
            <td><asp:Label ID="InboundContainerQtyLabel" runat="server" Text='<%# Bind("InboundContainerQty") %>' Width="30px"  /></td>
            <td><asp:Label ID="InventoryLocationLabel" runat="server" Text='<%# Bind("InventoryLocation") %>' Width="30px"  /></td>
            <td><asp:Label ID="ProcessPlanLabel" runat="server" Text='<%# Bind("ProcessPlan") %>' Width="30px"  /></td>
        </tr>
        </table>
        </ItemTemplate>
    </asp:FormView>
    </td>
</tr>
<tr>
    <td>    
    <asp:GridView ID="gvContainers" runat="server" AutoGenerateColumns="False" DataKeyNames="RcvDetailID" DataSourceID="sdsContainer" 
        AllowPaging="True" AllowSorting="True" CellPadding="4"  ForeColor="#333333" Font-Size="Smaller">
        <Columns>
        <asp:templatefield>
            <ItemTemplate>
                <asp:LinkButton ID="lnkEditDetail" runat="server" CommandName="EditDetail" CommandArgument='<%# Eval("RcvDetailID") %>'>Edit</asp:LinkButton>
                <asp:LinkButton ID="lnklDupeDetail" runat="server" CommandName="DupeDetail" CommandArgument='<%# Eval("RcvDetailID") %>'>Duplicate</asp:LinkButton>
            </ItemTemplate>
            <ItemStyle Font-Size="XX-Small" HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:templatefield>
            <asp:BoundField DataField="RcvDetailID" HeaderText="RcvID" InsertVisible="False" ReadOnly="True" SortExpression="RcvDetailID" />
            <asp:BoundField DataField="InboundDocNo" HeaderText="InboundDocNo" SortExpression="InboundDocNo" ItemStyle-Wrap="false" />
            <asp:BoundField DataField="InboundContainerID" HeaderText="CntrID"  SortExpression="InboundContainerID" ItemStyle-Wrap="false" />
            <asp:BoundField DataField="BrandCodeName" HeaderText="BrandCode" ReadOnly="True" SortExpression="BrandCodeName" ItemStyle-Wrap="false" />
            <asp:BoundField DataField="ManLine" HeaderText="Man Line" SortExpression="ManLine" />
            <asp:BoundField DataField="Profile" HeaderText="Profile" SortExpression="Profile" ItemStyle-Wrap="false" />
            <asp:BoundField DataField="RcvdAs" HeaderText="Rcvd As" SortExpression="RcvdAs" />
            <asp:BoundField DataField="InboundPalletType" HeaderText="Pallet Type" SortExpression="InboundPalletType" />
            <asp:BoundField DataField="InboundPalletWeight" HeaderText="Pallet Wt" SortExpression="InboundPalletWeight" />
            <asp:BoundField DataField="InboundContainerType" HeaderText="Cntr Type" SortExpression="InboundContainerType" />
            <asp:BoundField DataField="InboundContainerQty" HeaderText="Cntr Qty" SortExpression="InboundContainerQty" />
            <asp:BoundField DataField="InventoryLocation" HeaderText="Location" SortExpression="InventoryLocation" ItemStyle-Wrap="false" />
            <asp:BoundField DataField="ProcessPlan" HeaderText="Process Plan"  SortExpression="ProcessPlan" />
            <asp:BoundField DataField="RcvHdrID" HeaderText="HdrID" SortExpression="RcvHdrID" Visible="false" />
            <asp:BoundField DataField="BrandCode" HeaderText="BrandCode"  SortExpression="BrandCode" Visible="false" />
        </Columns>
    </asp:GridView></td></tr></table>
<asp:SqlDataSource ID="sdsClient" runat="server" 
    ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
    SelectCommand="IMDB_Receive_Client_Sel" SelectCommandType="StoredProcedure">
</asp:SqlDataSource>        
    <asp:SqlDataSource ID="sdsContainerDetail" runat="server" 
        ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
        SelectCommand="IMDB_Receive_Container_Sel" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="DetailID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
<asp:SqlDataSource ID="sdsContainer" runat="server" 
    ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
    SelectCommand="IMDB_Receive_RcvDetails_Sel" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:SessionParameter Name="RcvHdrID" SessionField="CurRcvHdrID" Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="sdsRcvHdr" runat="server"
    ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>"
    SelectCommand="IMDB_Receive_Hdr_Sel" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:ControlParameter ControlID="txbOrderNumber" Name="ordernumber" PropertyName="Text" Type="String" DefaultValue="All" />
        <asp:ControlParameter ControlID="ddClient" Name="clientID" PropertyName="SelectedValue" Type="String" DefaultValue="0"/>
        <asp:SessionParameter Name="RcvHdrID"  SessionField="CurRcvHdrID" DefaultValue="0" Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Clear" runat="server"></asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Footer" runat="server"></asp:Content>
