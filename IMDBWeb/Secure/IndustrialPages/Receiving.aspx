<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Receiving.aspx.cs" 
Inherits="IMDBWeb.Secure.IndustrialPages.Receiving2" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<script type="text/javascript">    function setHeight(txtdesc) { txtdesc.style.height = txtdesc.scrollHeight + "px"; }</script>
<asp:ScriptManager ID="SM1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
<h3>Receiving</h3><hr />
<asp:Label ID="lblErrMsg" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" />
<table id="tblBegin" runat="server">
<tr id="trBegin">
    <td style="font-style:italic">To begin, Select&nbsp;
    <asp:Button ID="btnSearchTruck" runat="server" Text="Search Existing Trucks" onclick="btnSearchTruck_Click" />&nbsp;or&nbsp;
    <asp:Button ID="btnNewTruck" runat="server" Text="Create New Truck" onclick="btnNewTruck_Click" /></td></tr></table>
<table id="tblNewTruck" runat="server">
<tr><td>
<asp:Label ID="lblNewTruck" runat="server" Text="Enter the New truck information and click 'Insert'" Font-Italic="true" />
<asp:FormView ID="fvNewTruck" runat="server" DataSourceID="sdsNewTruck" OnItemCommand="fvNewTruck_Command" DefaultMode="Insert" >
    <InsertItemTemplate>
    <table>
    <tr><td style="font-weight:bold">OrderNumber:</td>
        <td><asp:TextBox ID="txbNewOrderNumber" runat="server" Width="100px"  Text='<%# Bind("OrderNumber") %>' />
        <ajaxToolkit:AutoCompleteExtender
            ID="txbOrderNum_AutoCompleteExtender" runat="server" Enabled="True" CompletionInterval="50"
            TargetControlID="txbNewOrderNumber" ServicePath="myAutoComplete.asmx" ServiceMethod="GetNewOrderNums"
            MinimumPrefixLength="3" EnableCaching="true" CompletionSetCount="20" CompletionListCssClass="autocomplete_completionListElement" 
            CompletionListItemCssClass="autocomplete_listItem" CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" 
            DelimiterCharacters="," ShowOnlyCurrentWordInCompletionListItem="false">
        </ajaxToolkit:AutoCompleteExtender>
        <asp:RequiredFieldValidator ID="rfvOrderNumber" runat="server" ControlToValidate="txbNewOrderNumber" ErrorMessage="Order Number" Font-Bold="true" ForeColor="Red" Text="*" />
        <asp:CustomValidator ID="cvOrderNumber" runat="server" EnableClientScript="true" 
            ErrorMessage="You must select a value from the list!" ControlToValidate="txbNewOrderNumber" 
            OnServerValidate="txbNewOrderNumber_Validate" Display="Dynamic" Font-Bold="true" ForeColor="Red" > 
</asp:CustomValidator>
    </td></tr>
    <tr><td style="font-weight:bold">WorkOrder:</td>
        <td><asp:TextBox ID="WorkOrderTextBox" runat="server" Text='<%# Bind("WorkOrder") %>' /></td></tr>
    <tr><td style="font-weight:bold">ClientName:</td>
        <td>
            <asp:DropDownList ID="ddClient" runat="server" DataSourceID="sdsClient" DataTextField="ClientName"
                DataValueField="ClientID" SelectedValue='<%# bind("ClientName") %>' AppendDataBoundItems="true" >
                <asp:ListItem Text="Select..." Value="" />
            </asp:DropDownList>
        <asp:RequiredFieldValidator ID="rfvClientName" runat="server" ControlToValidate="ddClient" ErrorMessage="Client Name" 
            InitialValue="" Font-Bold="true" ForeColor="Red" Text="*" />
        </td></tr>
    <tr><td style="font-weight:bold">TSDF:</td>
        <td>
        <asp:DropDownList ID="ddTSDF" runat="server" DataSourceID="sdsTSDF" DataTextField="VendorName"
                DataValueField="VendorID" SelectedValue='<%# bind("TSDF") %>' AppendDataBoundItems="true" >
                <asp:ListItem Text="Select..." Value="" />
            </asp:DropDownList>
        <asp:RequiredFieldValidator ID="rfvTSDF" runat="server" ControlToValidate="ddTSDF" ErrorMessage="TSDF" 
            InitialValue="" Font-Bold="true" ForeColor="Red" Text="*" />
        </td></tr>
    <tr><td style="font-weight:bold">ReceivedBy:</td>
        <td><asp:DropDownList ID="ddRcvBy" Width="250px" runat="server" DataSourceID="sdsGetUsers" 
             DataTextField="Name" DataValueField="Name" AppendDataBoundItems="True" SelectedValue='<%# bind("ReceivedBy") %>' >
                <asp:ListItem Text="Select..." Value = "" />
             </asp:DropDownList>
             <asp:RequiredFieldValidator ID="rfvRcvBy" runat="server" ControlToValidate="ddRcvBy" InitialValue="" ErrorMessage="Received By" Font-Bold="true" ForeColor="Red" Text="*" />
        </td></tr>
    <tr><td style="font-weight:bold">ReceiveDock:</td>
        <td><asp:DropDownList ID="ddRcvDock"  Width="250px"  runat="server" SelectedValue='<%# bind("ReceiveDock") %>'>
                <asp:ListItem Text="Select..." Value="" />
                <asp:ListItem>33</asp:ListItem>
                <asp:ListItem>34</asp:ListItem>
                <asp:ListItem>35</asp:ListItem>
                <asp:ListItem>36</asp:ListItem>
                <asp:ListItem>37</asp:ListItem>
                <asp:ListItem>SuiteA</asp:ListItem>
                <asp:ListItem>Other</asp:ListItem>
            </asp:DropDownList>
            <asp:RequiredFieldValidator ID="rfvRcvDock" runat="server" ControlToValidate="ddRcvDock" InitialValue="" ErrorMessage="Receive Dock" Font-Bold="true" ForeColor="Red" Text="*" />
        </td></tr>
    <tr><td style="font-weight:bold">Carrier:</td>
        <td><asp:DropDownList ID="ddCarrier" runat="server" DataSourceID="sdsCarrier" DataTextField="VendorName"
                DataValueField="CarrierID" SelectedValue='<%# bind("Carrier") %>' AppendDataBoundItems="true" >
                <asp:ListItem Text="Select..." Value="" />
            </asp:DropDownList>
        <asp:RequiredFieldValidator ID="rfvCarrier" runat="server" ControlToValidate="ddCarrier" ErrorMessage="Carrier" 
            InitialValue="" Font-Bold="true" ForeColor="Red" Text="*" />
        </td></tr>
    <tr><td style="font-weight:bold">Trailer_Number:</td>
        <td><asp:TextBox ID="Trailer_NumberTextBox" runat="server" Text='<%# Bind("Trailer_Number") %>' /></td></tr>
        <tr><td style="font-weight:bold">ReceiveDate:</td>
        <td><asp:TextBox ID="ReceiveDateTextBox" runat="server" Text='<%# Bind("ReceiveDate") %>' />
            <ajaxToolKit:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="ReceiveDateTextBox" />
            <asp:RequiredFieldValidator ID="rfvReceiveDate" runat="server" ControlToValidate="ReceiveDateTextBox" ErrorMessage="Received Date" Font-Bold="true" ForeColor="Red" Text="*" />
        </td></tr>
    <tr><td style="font-weight:bold">ShipDate:</td>
        <td><asp:TextBox ID="ShipDateTextBox" runat="server" Text='<%# Bind("ShipDate") %>' />
        <ajaxToolKit:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="ShipDateTextBox" /></td></tr>
    <tr><td style="font-weight:bold">Memo:</td>
        <td><asp:TextBox ID="MemoTextBox" runat="server" TextMode="MultiLine" Width="300px" Text='<%# Bind("Memo") %>'
            onkeyup="setHeight(this);" onkeydown="setHeight(this);" onclick="setHeight(this);" /></td></tr>
    <tr><td><asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />&nbsp;
        <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" /></td></tr>
    </table>
    <asp:ValidationSummary ID="vsNewTruckIns" runat="server" DisplayMode="BulletList" ShowMessageBox="true" ShowSummary="false" HeaderText="You must enter a value in the following fields:" EnableClientScript="true" />
    </InsertItemTemplate>
    <ItemTemplate>
    <table>
    <tr><td style="font-weight:bold">OrderNumber:</td>
        <td><asp:TextBox ID="txbNewOrderNumber" runat="server" Width="100px"  Text='<%# Bind("OrderNumber") %>' />
        <ajaxToolkit:AutoCompleteExtender
            ID="txbOrderNum_AutoCompleteExtender" runat="server" Enabled="True" CompletionInterval="50"
            TargetControlID="txbNewOrderNumber" ServicePath="myAutoComplete.asmx" ServiceMethod="GetNewOrderNums"
            MinimumPrefixLength="3" EnableCaching="true" CompletionSetCount="20" CompletionListCssClass="autocomplete_completionListElement" 
            CompletionListItemCssClass="autocomplete_listItem" CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" 
            DelimiterCharacters="," ShowOnlyCurrentWordInCompletionListItem="false">
        </ajaxToolkit:AutoCompleteExtender>
        <asp:RequiredFieldValidator ID="rfvOrderNumber" runat="server" ControlToValidate="txbNewOrderNumber" ErrorMessage="Order Number" Font-Bold="true" ForeColor="Red" Text="*" />
        <asp:CustomValidator ID="cvOrderNumber" runat="server" EnableClientScript="true" 
            ErrorMessage="You must select a value from the list!" ControlToValidate="txbNewOrderNumber" 
            OnServerValidate="txbNewOrderNumber_Validate" Display="Dynamic" Font-Bold="true" ForeColor="Red" > 
</asp:CustomValidator>
    </td></tr>
    <tr><td style="font-weight:bold">WorkOrder:</td>
        <td><asp:TextBox ID="WorkOrderTextBox" runat="server" Text='<%# Bind("WorkOrder") %>' /></td></tr>
    <tr><td style="font-weight:bold">ClientName:</td>
        <td>
            <asp:DropDownList ID="ddClient" runat="server" DataSourceID="sdsClient" DataTextField="ClientName"
                DataValueField="ClientID" SelectedValue='<%# bind("ClientName") %>' AppendDataBoundItems="true" >
                <asp:ListItem Text="Select..." Value="" />
            </asp:DropDownList>
        <asp:RequiredFieldValidator ID="rfvClientName" runat="server" ControlToValidate="ddClient" ErrorMessage="Client Name" 
            InitialValue="" Font-Bold="true" ForeColor="Red" Text="*" />
        </td></tr>
    <tr><td style="font-weight:bold">TSDF:</td>
        <td>
        <asp:DropDownList ID="ddTSDF" runat="server" DataSourceID="sdsTSDF" DataTextField="VendorName"
                DataValueField="VendorID" SelectedValue='<%# bind("TSDF") %>' AppendDataBoundItems="true" >
                <asp:ListItem Text="Select..." Value="" />
            </asp:DropDownList>
        <asp:RequiredFieldValidator ID="rfvTSDF" runat="server" ControlToValidate="ddTSDF" ErrorMessage="TSDF" 
            InitialValue="" Font-Bold="true" ForeColor="Red" Text="*" />
        </td></tr>
    <tr><td style="font-weight:bold">ReceivedBy:</td>
        <td><asp:DropDownList ID="ddRcvBy" Width="250px" runat="server" DataSourceID="sdsGetUsers" 
             DataTextField="Name" DataValueField="Name" AppendDataBoundItems="True" SelectedValue='<%# bind("ReceivedBy") %>' >
                <asp:ListItem Text="Select..." Value = "" />
             </asp:DropDownList>
             <asp:RequiredFieldValidator ID="rfvRcvBy" runat="server" ControlToValidate="ddRcvBy" InitialValue="" ErrorMessage="Received By" Font-Bold="true" ForeColor="Red" Text="*" />
        </td></tr>
    <tr><td style="font-weight:bold">ReceiveDock:</td>
        <td><asp:DropDownList ID="ddRcvDock"  Width="250px"  runat="server" SelectedValue='<%# bind("ReceiveDock") %>'>
                <asp:ListItem Text="Select..." Value="" />
                <asp:ListItem>33</asp:ListItem>
                <asp:ListItem>34</asp:ListItem>
                <asp:ListItem>35</asp:ListItem>
                <asp:ListItem>36</asp:ListItem>
                <asp:ListItem>37</asp:ListItem>
                <asp:ListItem>SuiteA</asp:ListItem>
                <asp:ListItem>Other</asp:ListItem>
            </asp:DropDownList>
            <asp:RequiredFieldValidator ID="rfvRcvDock" runat="server" ControlToValidate="ddRcvDock" InitialValue="" ErrorMessage="Receive Dock" Font-Bold="true" ForeColor="Red" Text="*" />
        </td></tr>
    <tr><td style="font-weight:bold">Carrier:</td>
        <td><asp:DropDownList ID="ddCarrier" runat="server" DataSourceID="sdsCarrier" DataTextField="VendorName"
                DataValueField="CarrierID" SelectedValue='<%# bind("Carrier") %>' AppendDataBoundItems="true" >
                <asp:ListItem Text="Select..." Value="" />
            </asp:DropDownList>
        <asp:RequiredFieldValidator ID="rfvCarrier" runat="server" ControlToValidate="ddCarrier" ErrorMessage="Carrier" 
            InitialValue="" Font-Bold="true" ForeColor="Red" Text="*" />
        </td></tr>
    <tr><td style="font-weight:bold">Trailer_Number:</td>
        <td><asp:TextBox ID="Trailer_NumberTextBox" runat="server" Text='<%# Bind("Trailer_Number") %>' /></td></tr>
        <tr><td style="font-weight:bold">ReceiveDate:</td>
        <td><asp:TextBox ID="ReceiveDateTextBox" runat="server" Text='<%# Bind("ReceiveDate") %>' />
            <ajaxToolKit:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="ReceiveDateTextBox" />
            <asp:RequiredFieldValidator ID="rfvReceiveDate" runat="server" ControlToValidate="ReceiveDateTextBox" 
                ErrorMessage="Received Date" Font-Bold="true" ForeColor="Red" Text="*" />
        </td></tr>
    <tr><td style="font-weight:bold">ShipDate:</td>
        <td><asp:TextBox ID="ShipDateTextBox" runat="server" Text='<%# Bind("ShipDate") %>' />
        <ajaxToolKit:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="ShipDateTextBox" /></td></tr>
    <tr><td style="font-weight:bold">Memo:</td>
        <td><asp:TextBox ID="MemoTextBox" runat="server" TextMode="MultiLine" Width="300px" Text='<%# Bind("Memo") %>'
            onkeyup="setHeight(this);" onkeydown="setHeight(this);" onclick="setHeight(this);" /></td></tr>
    <tr><td><asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />&nbsp;
        <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" /></td></tr>
    </table>
    <asp:ValidationSummary ID="vsNewTruckIns" runat="server" DisplayMode="BulletList" ShowMessageBox="true" ShowSummary="false" HeaderText="You must enter a value in the following fields:" EnableClientScript="true" />
    </ItemTemplate>
</asp:FormView>
</td></tr>
</table>
<table id="tblSearch" runat="server">
<tr><td colspan="2" style="font-style:italic">Enter your search criteria and click "Search"</td></tr>
<tr><td align="right">Order Number:&nbsp;</td>
    <td><asp:TextBox ID="txbOrderNumber" AutoPostBack="true" runat="server"></asp:TextBox>
        <ajaxToolkit:AutoCompleteExtender
            ID="txbOrderNum_AutoCompleteExtender" 
            runat="server"
            Enabled="True"
            CompletionInterval="100"
            TargetControlID="txbOrderNumber"
            ServicePath="myAutoComplete.asmx"
            ServiceMethod="GetOrderNums"
            MinimumPrefixLength="3"
            EnableCaching="true"
            CompletionSetCount="20"
            CompletionListCssClass="autocomplete_completionListElement" 
            CompletionListItemCssClass="autocomplete_listItem" 
            CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
            DelimiterCharacters=","
            ShowOnlyCurrentWordInCompletionListItem="false">
        </ajaxToolkit:AutoCompleteExtender></td></tr>
<tr><td align="right">Client:&nbsp;</td>
    <td><asp:DropDownList ID="ddClient" runat="server" DataSourceID="sdsClient" 
            AppendDataBoundItems="True" DataTextField="ClientName" AutoPostBack="true" 
            DataValueField="ClientID" onselectedindexchanged="ddClient_SelectedIndexChanged">
            <asp:ListItem Text="Select from List" Value="0" />
        </asp:DropDownList></td>
</tr>
<tr><td align="right">RcvDate Range:&nbsp;</td>
<td><asp:TextBox ID="txbBegDate" runat="server" Width="75px" AutoPostBack="true" CausesValidation="true" />
    <ajaxToolkit:TextBoxWatermarkExtender ID="wmBegDate" runat="server" TargetControlID="txbBegDate" WatermarkText="Begin Date" WatermarkCssClass="watermarked" />
    <ajaxToolKit:CalendarExtender ID="CalExBegDate" runat="server" TargetControlID="txbBegDate" />&nbsp;and&nbsp;
    <asp:TextBox ID="txbEndDate" runat="server" Width="75px" AutoPostBack="true" CausesValidation="true" />
    <ajaxToolkit:TextBoxWatermarkExtender ID="wmEndDate" runat="server" TargetControlID="txbEndDate" WatermarkText="End Date" WatermarkCssClass="watermarked" />
    <ajaxToolKit:CalendarExtender ID="CalExEndDate" runat="server" TargetControlID="txbEndDate" />
    <asp:RegularExpressionValidator ID="revBegDate" runat="server" ControlToValidate="txbBegDate" ForeColor="Red" Font-Bold="true" 
        ErrorMessage="Please use mm/dd/yyyy format" ValidationExpression="^(1[0-2]|0?[1-9])/(3[01]|[12][0-9]|0?[1-9])/(?:[0-9]{2})?[0-9]{2}$" SetFocusOnError="True" />
    <asp:RegularExpressionValidator ID="revEndDate" runat="server" ControlToValidate="txbEndDate" ForeColor="Red" Font-Bold="true" 
        ErrorMessage="Please use mm/dd/yyyy format" ValidationExpression="^(1[0-2]|0?[1-9])/(3[01]|[12][0-9]|0?[1-9])/(?:[0-9]{2})?[0-9]{2}$" SetFocusOnError="True" />
    </td></tr>
<tr><td></td>
    <td><asp:Button ID="btnSearch" runat="server" Text="Search" onclick="btnSearch_Click" /> &nbsp;&nbsp;
        <asp:Button ID="btnCancelSearch" runat="server" Text="Cancel" onclick="btnCancelSearch_Click" /></td></tr>
</table>
<table>
<tr><td style="font-style:italic">
<asp:Label ID="lblTruckMsg" runat="Server" Text="Click on a row from the available trucks to manage containers"/>
</td><td></td></tr>
<tr><td>
    <asp:GridView ID="gvRcvHdr" runat="server" AutoGenerateColumns="False" DataKeyNames="RcvHdrID" DataSourceID="sdsRcvHdr" Width="90%"
            OnRowDataBound="gvRcvHdr_RowDataBound" OnSelectedIndexChanged="gvRcvHdr_SelectedIndexChanged" OnDataBound="gvRcvHdr_DataBound"
            SelectedRowStyle-BackColor="#ffff99" AllowPaging="True" AllowSorting="True" CellPadding="2" ForeColor="#333333" Font-Size="Smaller">
        <Columns>
            <asp:CommandField ShowEditButton="True" />
            <asp:BoundField DataField="RcvHdrID" HeaderText="Hdr ID" InsertVisible="False" ReadOnly="True" SortExpression="RcvHdrID" />
            <asp:TemplateField HeaderText="Order" SortExpression="OrderNumber" ItemStyle-Wrap="false" >
            <EditItemTemplate>
                <asp:TextBox ID="txbOrderNumber" runat="server" Width="60px"  Text='<%# Bind("OrderNumber") %>' Font-Size="8"/>
                    <ajaxToolkit:AutoCompleteExtender
                    ID="AutoCompleteExtender1" runat="server" Enabled="True" CompletionInterval="50"
                    TargetControlID="txbOrderNumber" ServicePath="myAutoComplete.asmx" ServiceMethod="GetNewOrderNums"
                    MinimumPrefixLength="3" EnableCaching="true" CompletionSetCount="20" CompletionListCssClass="autocomplete_completionListElement" 
                    CompletionListItemCssClass="autocomplete_listItem" CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" 
                    DelimiterCharacters="," ShowOnlyCurrentWordInCompletionListItem="false">
                    </ajaxToolkit:AutoCompleteExtender>
                    <asp:RequiredFieldValidator ID="rfvOrderNumber" runat="server" ControlToValidate="txbOrderNumber" ErrorMessage="Order Number" Font-Bold="true" ForeColor="Red" Text="*" />
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="lblOrder" runat="server" Text='<%# Eval("OrderNumber") %>' Font-Size="8" />
            </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Work Order" SortExpression="WorkOrder">
            <EditItemTemplate>
                <asp:TextBox ID="txbWorkOrder" runat="server" Width="40px" Text='<%# Bind("WorkOrder") %>' Font-Size="8" />
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="lblWorkOrder" runat="server" Text='<%# Eval("WorkOrder") %>' Font-Size="8" />
            </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Client" SortExpression="ClientName" ItemStyle-Wrap="false">
            <EditItemTemplate>
            <asp:DropDownList ID="ddClient" runat="server" DataSourceID="sdsClient" DataTextField="ClientName" Width="100px"
                DataValueField="ClientID" SelectedValue='<%# bind("ClientID") %>' AppendDataBoundItems="true" Font-Size="8" >
                <asp:ListItem Text="Select..." Value="" />
            </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvClientName" runat="server" ControlToValidate="ddClient" ErrorMessage="Client Name" 
                    InitialValue="" Font-Bold="true" ForeColor="Red" Text="*" />
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="lblClient" runat="server" Text='<%# Eval("ClientName") %>' Font-Size="8" />
            </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Carrier" SortExpression="CarrierName" ItemStyle-Wrap="false">
            <EditItemTemplate>
                <asp:DropDownList ID="ddCarrier" runat="server" DataSourceID="sdsCarrier" DataTextField="VendorName" Width="100px"
                    DataValueField="CarrierID" SelectedValue='<%# bind("CarrierID") %>' AppendDataBoundItems="true" Font-Size="8" >
                    <asp:ListItem Text="Select..." Value="" />
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvCarrier" runat="server" ControlToValidate="ddCarrier" ErrorMessage="Carrier" 
                    InitialValue="" Font-Bold="true" ForeColor="Red" Text="*" />
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="lblCarrier" runat="server" Text='<%# Eval("Carrier") %>' Font-Size="8" />
            </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="TSDF" SortExpression="TSDF" ItemStyle-Wrap="false">
            <EditItemTemplate>
            <asp:DropDownList ID="ddTSDF" runat="server" DataSourceID="sdsTSDF" DataTextField="VendorName" Width="100px"
                    DataValueField="VendorID" SelectedValue='<%# bind("TSDFID") %>' AppendDataBoundItems="true" Font-Size="8" >
                    <asp:ListItem Text="Select..." Value="" />
                </asp:DropDownList>
            <asp:RequiredFieldValidator ID="rfvTSDF" runat="server" ControlToValidate="ddTSDF" ErrorMessage="TSDF" 
                InitialValue="" Font-Bold="true" ForeColor="Red" Text="*" />
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="lblTSDF" runat="server" Text='<%# Eval("TSDF") %>' Font-Size="8" />
            </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="RcvBy" SortExpression="RcvBy" ItemStyle-Wrap="false">
            <EditItemTemplate>
            <asp:DropDownList ID="ddRcvBy" runat="server" DataSourceID="sdsGetUsers" Font-Size="8" Width="100px"
                DataTextField="Name" DataValueField="Name" AppendDataBoundItems="True" SelectedValue='<%# bind("ReceivedBy") %>' >
                <asp:ListItem Text="Select..." Value = "" />
            </asp:DropDownList>
            <asp:RequiredFieldValidator ID="rfvRcvBy" runat="server" ControlToValidate="ddRcvBy" InitialValue="" ErrorMessage="Received By" 
                Font-Bold="true" ForeColor="Red" Text="*" />
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="lblRcvdBy" runat="server" Text='<%# Eval("ReceivedBy") %>' Font-Size="8" />
            </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="RcvDate" SortExpression="RcvDate">
            <EditItemTemplate>
                <asp:TextBox ID="ReceiveDateTextBox" runat="server" Width="60" Text='<%# Bind("ReceiveDate","{0:d}") %>' Font-Size="8"/>
                <ajaxToolKit:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="ReceiveDateTextBox" />
                <asp:RequiredFieldValidator ID="rfvReceiveDate" runat="server" ControlToValidate="ReceiveDateTextBox" ErrorMessage="Received Date" Font-Bold="true" ForeColor="Red" Text="*" />
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="lblRcvDate" runat="server" Text='<%# Eval("ReceiveDate","{0:d}") %>' Font-Size="8" />
            </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Trailer Number" SortExpression="TrailerNumber">
            <EditItemTemplate>
                <asp:TextBox ID="txbTrailerNumber" runat="server" Width="50" Text='<%# Bind("Trailer_Number") %>' Font-Size="8" />
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="lblTrailerNumber" runat="server" Text='<%# Eval("Trailer_Number") %>' Font-Size="8" />
            </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Dock" SortExpression="Dock">
            <EditItemTemplate>
                <asp:DropDownList ID="ddRcvDock"  Width="50" Font-Size="8" runat="server" SelectedValue='<%# bind("ReceiveDock") %>'>
                <asp:ListItem Text="Select..." Value="" />
                <asp:ListItem>33</asp:ListItem>
                <asp:ListItem>34</asp:ListItem>
                <asp:ListItem>35</asp:ListItem>
                <asp:ListItem>36</asp:ListItem>
                <asp:ListItem>37</asp:ListItem>
                <asp:ListItem>SuiteA</asp:ListItem>
                <asp:ListItem>Other</asp:ListItem>
            </asp:DropDownList>
            <asp:RequiredFieldValidator ID="rfvRcvDock" runat="server" ControlToValidate="ddRcvDock" InitialValue="" 
                ErrorMessage="Receive Dock" Font-Bold="true" ForeColor="Red" Text="*" />
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="lblDock" runat="server" Text='<%# Eval("ReceiveDock") %>' Font-Size="8" />
            </ItemTemplate>
            </asp:TemplateField> 
            <asp:TemplateField HeaderText="ShipDate" SortExpression="ShipDate">
            <EditItemTemplate>
                <asp:TextBox ID="txbShipDate" runat="server" Width="60" Text='<%# Bind("ShipDate","{0:d}") %>' Font-Size="8"/>
                <ajaxToolKit:CalendarExtender ID="CalendarExtender3" runat="server" TargetControlID="txbShipDate" />
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="lblShipDate" runat="server" Text='<%# Eval("ShipDate","{0:d}") %>' Font-Size="8" />
            </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Memo" SortExpression="Memo">
            <EditItemTemplate>
                <asp:TextBox ID="MemoTextBox" runat="server" TextMode="MultiLine" Width="300px" Text='<%# Bind("Memo") %>'
                    onkeyup="setHeight(this);" onkeydown="setHeight(this);" onclick="setHeight(this);" />
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="lblMemo" runat="server" Text='<%# Eval("Memo") %>' Font-Size="8" />
            </ItemTemplate>
            </asp:TemplateField>    
        </Columns>
        <SelectedRowStyle BackColor="#FFFF99"></SelectedRowStyle>
    </asp:GridView>    
    </td>
</tr>
</table>
<table>
<tr id="trAddContainers" runat="server" visible="false"><td>
    <asp:Button ID="btnAddContainer" runat="server" Text="Add Containers" onclick="btnAddContainer_Click" />&nbsp;
    <asp:Button ID="btnDone" runat="server" Text="Done" onclick="btnDone_Click" />&nbsp;&nbsp;
    <asp:Button ID="btnSummary" runat="server" Text="Show Summary" OnClick="btnSummary_Click" />&nbsp;&nbsp;
    </td>
</tr>
<tr id="trSummary" runat="server" Visible="false">
<td>
    <asp:GridView ID="gvSummary" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRcvSummary" Width="425px">
        <Columns>
            <asp:BoundField DataField="ProfileName" HeaderText="Profile Name" SortExpression="ProfileName" ItemStyle-HorizontalAlign="Left" ItemStyle-Wrap="False" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="LineNumber" HeaderText="Line Number" SortExpression="LineNumber" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="CntrType" HeaderText="Cntr Type" SortExpression="CntrType" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="NumberContainers" HeaderText="Number Containers"  ReadOnly="True" SortExpression="NumberContainers" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="TotalWeight" HeaderText="Total Weight"  ReadOnly="True" SortExpression="TotalWeight" DataFormatString="{0:n0}" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center" />
        </Columns> 
    </asp:GridView>
</td></tr>
<tr id="trDuplicate" runat="server">
    <td>
    <asp:Label ID="lblCntrID_Dup" runat="server" Font-Bold="true" ForeColor="Red"></asp:Label><br />
    <asp:FormView ID="fvDuplicate" runat="server" DataKeyNames="RcvDetailID" DataSourceID="sdsContainerDetail" 
        Font-Size="Small" OnDataBound="fvDuplicate_DataBound" DefaultMode="Edit" >
        <EditItemTemplate>
        <table>
        <tr>
        <td colspan="12">
        <asp:ValidationSummary ID="vsCntrUpdate" runat="server" DisplayMode="BulletList" ShowMessageBox="true" ShowSummary="false"
            HeaderText="You must enter a value in the following fields:" EnableClientScript="true" />
        </td>
        </tr>
        <tr>
            <td style="font-weight:bold;font-size:smaller">DocNo
                <asp:RequiredFieldValidator ID="rfvDocNo" runat="server" ControlToValidate="InboundDocNoTextBox" ErrorMessage="Document Number" Font-Bold="true" ForeColor="Red" Text="*" /></td>
            <td style="font-weight:bold;font-size:smaller">CntrID
                <asp:RequiredFieldValidator ID="rfvCntrID" runat="server" ControlToValidate="txbNewCntrID" ErrorMessage="ContainerID" Font-Bold="true" ForeColor="Red" Text="*" /></td>
            <td style="font-weight:bold;font-size:smaller">BrandCode
                <asp:RequiredFieldValidator ID="rfvBrandCode" runat="server" ControlToValidate="txbBrandCodes" ErrorMessage="BrandCode" Font-Bold="true" ForeColor="Red" Text="*" /></td>  
            <td style="font-weight:bold;font-size:smaller">Line
                <asp:RequiredFieldValidator ID="rfvManLine" runat="server" ControlToValidate="ManLineTextBox" ErrorMessage="Manifest Line" Font-Bold="true" ForeColor="Red" Text="*" /></td>
            <td style="font-weight:bold;font-size:smaller">Profile
                <asp:RequiredFieldValidator ID="rfvProfile" runat="server" ControlToValidate="ddProfile" InitialValue="" ErrorMessage="Profile" Font-Bold="true" ForeColor="Red" Text="*" /></td>
            <td style="font-weight:bold;font-size:smaller">RcvdAs
                <asp:RequiredFieldValidator ID="rfvRcvdAs" runat="server" ControlToValidate="ddRcvdAs" InitialValue="Select..." ErrorMessage="RcvdAs" Font-Bold="true" ForeColor="Red" Text="*" /></td>
            <td style="font-weight:bold;font-size:smaller">Pallet Type
                <asp:RequiredFieldValidator ID="rfvPalletType" runat="server" ControlToValidate="ddPalletType" InitialValue="0" ErrorMessage="PalletType" Font-Bold="true" ForeColor="Red" Text="*" /></td>
            <td style="font-weight:bold;font-size:smaller">PalletWt
                <asp:RequiredFieldValidator ID="rfvPalletWt" runat="server" ControlToValidate="InboundPalletWeightTextBox" ErrorMessage="Pallet Weight" Font-Bold="true" ForeColor="Red" Text="*" /></td>
            <td style="font-weight:bold;font-size:smaller">Cntr Type
                <asp:RequiredFieldValidator ID="rfvCntrType" runat="server" ControlToValidate="ddContainerType" InitialValue="0" ErrorMessage="Container Type" Font-Bold="true" ForeColor="Red" Text="*" /></td>
            <td style="font-weight:bold;font-size:smaller">Qty
                <asp:RequiredFieldValidator ID="rfvCntrQty" runat="server" ControlToValidate="InboundContainerQtyTextBox" ErrorMessage="Container Qty" Font-Bold="true" ForeColor="Red" Text="*" /></td>
            <td style="font-weight:bold;font-size:smaller">Location
                <asp:RequiredFieldValidator ID="rfvLocation" runat="server" ControlToValidate="ddLocation" InitialValue="" ErrorMessage="Location" Font-Bold="true" ForeColor="Red" Text="*" /></td>
            <td style="font-weight:bold;font-size:smaller">ProcessPlan
                <asp:RequiredFieldValidator ID="rfvProcessPlan" runat="server" ControlToValidate="ddProcessPlan" InitialValue="Select..." ErrorMessage="Process Plan" Font-Bold="true" ForeColor="Red" Text="*" /></td>
            <asp:RegularExpressionValidator ID="revCntrID" ControlToValidate="txbNewCntrID" runat="server" ForeColor="Red" Font-Bold="true" 
                ErrorMessage="This is not a Valid Container ID" ValidationExpression="^[IiOo][UuNn][Tt]?[-](\d{6})*$" SetFocusOnError="True" /></tr>
        <tr>
  <td><asp:TextBox ID="InboundDocNoTextBox" runat="server" Text='<%# Bind("InboundDocNo") %>' Width="75px" Font-Size="Smaller" /></td>
            <td><asp:TextBox ID="txbNewCntrID" runat="server" Text='<%# Bind("InboundContainerID") %>' Width="50px"  Font-Size="Smaller"/></td>
            <td><asp:TextBox ID="txbBrandCodes" runat="server" Text='<%# Bind("BrandCodeName") %>' OnTextChanged="txbBrandCodes_SelectedIndexChanged_Dup" AutoPostBack="true" Width="200px" Font-Size="Smaller"></asp:TextBox>
                <ajaxToolkit:AutoCompleteExtender
                    ID="txbBrandCodes_AutoCompleteExtender" runat="server" Enabled="True" CompletionInterval="50"
                    TargetControlID="txbBrandCodes" ServicePath="myAutoComplete.asmx" ServiceMethod="GetBrandCodes"
                    MinimumPrefixLength="4" EnableCaching="true" CompletionSetCount="20" CompletionListCssClass="autocomplete_completionListElement" 
                    CompletionListItemCssClass="autocomplete_listItem" CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                    DelimiterCharacters="," ShowOnlyCurrentWordInCompletionListItem="false">
                </ajaxToolkit:AutoCompleteExtender>
                <asp:Label ID="lblBrandCodeID" runat="server" Text='<%# Bind("BrandCode") %>' Visible="false" /></td>
            <td><asp:TextBox ID="ManLineTextBox" runat="server" Text='<%# Bind("ManLine") %>' Width="20px" Font-Size="Smaller" /></td>
            <td><asp:DropDownList ID="ddProfile" runat="server" DataSourceID="sdsGetProfile"  DataTextField="Name" Font-Size="Smaller"
                    DataValueField="ID" SelectedValue='<%# bind("InboundProfileID") %>' Width="150px" AppendDataBoundItems="True">
                    <asp:ListItem Text="Select..." Value = "" />
                </asp:DropDownList></td>
            <td><asp:DropDownList ID="ddRcvdAs" runat="server"  width="50px" SelectedValue='<%# bind("RcvdAs") %>' Font-Size="Smaller">
                    <asp:ListItem>Select...</asp:ListItem>
                    <asp:ListItem>Product</asp:ListItem>
                    <asp:ListItem>ShippedNH</asp:ListItem>
                    <asp:ListItem>Waste</asp:ListItem>
                    <asp:ListItem>Other</asp:ListItem>
                </asp:DropDownList></td>
            <td><asp:DropDownList ID="ddPalletType" runat="server" SelectedValue='<%# bind("InboundPalletType") %>' Width="50px" Font-Size="Smaller">
                    <asp:ListItem Value="0">Select...</asp:ListItem>
                    <asp:ListItem>CHEP</asp:ListItem>
                    <asp:ListItem>GMA</asp:ListItem>
                    <asp:ListItem>Other</asp:ListItem>
                    <asp:ListItem></asp:ListItem>
                </asp:DropDownList></td>
            <td><asp:TextBox ID="InboundPalletWeightTextBox" runat="server" Text='<%# Bind("InboundPalletWeight") %>' Width="30px" Font-Size="Smaller" /></td>
            <td><asp:DropDownList ID="ddContainerType" runat="server" SelectedValue='<%# bind("InboundContainerType") %>' Width="50px" Font-Size="Smaller">
                    <asp:ListItem Value="0">Select...</asp:ListItem>
                    <asp:ListItem>DM</asp:ListItem>
                    <asp:ListItem>CW</asp:ListItem>
                    <asp:ListItem>CS</asp:ListItem>
                    <asp:ListItem>CF</asp:ListItem>
                    <asp:ListItem>DF</asp:ListItem>
                </asp:DropDownList></td>
            <td><asp:TextBox ID="InboundContainerQtyTextBox" runat="server" Text='<%# Bind("InboundContainerQty") %>' Width="25px" Font-Size="Smaller" /></td>
            <td><asp:DropDownList ID="ddLocation" runat="server" Width="75px" SelectedValue='<%# bind("InventoryLocation") %>' 
                    DataSourceID="sdsGetLocation" DataTextField="LocationName" DataValueField="LocationName" AppendDataBoundItems="True" Font-Size="Smaller">
                    <asp:ListItem Text="Select..." Value = "" />
                </asp:DropDownList>
            </td>
            <td><asp:DropDownList ID="ddProcessPlan" runat="server" DataSourceID="sdsGetProcPlan"  DataTextField="ProcessPlan" Font-Size="Smaller"
                    DataValueField="ProcessPlan" Width="100px" SelectedValue='<%# bind("ProcessPlan") %>' AppendDataBoundItems="true">
                    <asp:ListItem>Select...</asp:ListItem>
                </asp:DropDownList></td>
            <td nowrap="nowrap"><asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" onClick="fvDuplicateIns_Click" Text="Insert" Font-Size="Smaller" />&nbsp;
            <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" OnClick="InsCancel_Click" CommandName="Cancel" Text="Cancel" Font-Size="Smaller" /></td>
        </tr>
        </table>                       
        </EditItemTemplate>
        <InsertItemTemplate>
        <table>
        <tr><td colspan="12">
        <asp:ValidationSummary ID="vsCntrInsert" runat="server" DisplayMode="BulletList" ShowMessageBox="true" ShowSummary="false"
            HeaderText="You must enter a value in the following fields:" EnableClientScript="true" />
        </td></tr>
        <tr>
            <td style="font-weight:bold;font-size:smaller">DocNo
                <asp:RequiredFieldValidator ID="rfvDocNo" runat="server" ControlToValidate="InboundDocNoTextBox" ErrorMessage="Document Number" Font-Bold="true" ForeColor="Red" Text="*" /></td>
            <td style="font-weight:bold;font-size:smaller">CntrID
                <asp:RequiredFieldValidator ID="rfvCntrID" runat="server" ControlToValidate="txbNewCntrID" ErrorMessage="ContainerID" Font-Bold="true" ForeColor="Red" Text="*" /></td>
            <td style="font-weight:bold;font-size:smaller">BrandCode
                <asp:RequiredFieldValidator ID="rfvBrandCode" runat="server" ControlToValidate="txbBrandCodes" ErrorMessage="BrandCode" Font-Bold="true" ForeColor="Red" Text="*" /></td>  
            <td style="font-weight:bold;font-size:smaller">Line
                <asp:RequiredFieldValidator ID="rfvManLine" runat="server" ControlToValidate="ManLineTextBox" ErrorMessage="Manifest Line" Font-Bold="true" ForeColor="Red" Text="*" /></td>
            <td style="font-weight:bold;font-size:smaller">Profile
                <asp:RequiredFieldValidator ID="rfvProfile" runat="server" ControlToValidate="ddProfile" InitialValue="" ErrorMessage="Profile" Font-Bold="true" ForeColor="Red" Text="*" /></td>
            <td style="font-weight:bold;font-size:smaller">RcvdAs
                <asp:RequiredFieldValidator ID="rfvRcvdAs" runat="server" ControlToValidate="ddRcvdAs" InitialValue="Select..." ErrorMessage="RcvdAs" Font-Bold="true" ForeColor="Red" Text="*" /></td>
            <td style="font-weight:bold;font-size:smaller">Pallet Type
                <asp:RequiredFieldValidator ID="rfvPalletType" runat="server" ControlToValidate="ddPalletType" InitialValue="0" ErrorMessage="PalletType" Font-Bold="true" ForeColor="Red" Text="*" /></td>
            <td style="font-weight:bold;font-size:smaller">PalletWt
                <asp:RequiredFieldValidator ID="rfvPalletWt" runat="server" ControlToValidate="InboundPalletWeightTextBox" ErrorMessage="Pallet Weight" Font-Bold="true" ForeColor="Red" Text="*" /></td>
            <td style="font-weight:bold;font-size:smaller">Cntr Type
                <asp:RequiredFieldValidator ID="rfvCntrType" runat="server" ControlToValidate="ddContainerType" InitialValue="0" ErrorMessage="Container Type" Font-Bold="true" ForeColor="Red" Text="*" /></td>
            <td style="font-weight:bold;font-size:smaller">Qty
                <asp:RequiredFieldValidator ID="rfvCntrQty" runat="server" ControlToValidate="InboundContainerQtyTextBox" ErrorMessage="Container Qty" Font-Bold="true" ForeColor="Red" Text="*" /></td>
            <td style="font-weight:bold;font-size:smaller">Location
                <asp:RequiredFieldValidator ID="rfvLocation" runat="server" ControlToValidate="ddLocation" InitialValue="" ErrorMessage="Location" Font-Bold="true" ForeColor="Red" Text="*" /></td>
            <td style="font-weight:bold;font-size:smaller">ProcessPlan
                <asp:RequiredFieldValidator ID="rfvProcessPlan" runat="server" ControlToValidate="ddProcessPlan" InitialValue="Select..." ErrorMessage="Process Plan" Font-Bold="true" ForeColor="Red" Text="*" /></td></tr>
        <tr>
            <td><asp:TextBox ID="InboundDocNoTextBox" runat="server" Text='<%# Bind("InboundDocNo") %>' Width="75px" Font-Size="Smaller" /></td>
            <td><asp:TextBox ID="txbNewCntrID" runat="server" Text='<%# Bind("InboundContainerID") %>' Width="50px"  Font-Size="Smaller"/></td>
            <td><asp:TextBox ID="txbBrandCodes" runat="server" OnTextChanged="txbBrandCodes_SelectedIndexChanged_Dup" AutoPostBack="true" Width="200px" Font-Size="Smaller"></asp:TextBox>
                <ajaxToolkit:AutoCompleteExtender
                    ID="txbBrandCodes_AutoCompleteExtender" runat="server" Enabled="True" CompletionInterval="50"
                    TargetControlID="txbBrandCodes" ServicePath="myAutoComplete.asmx" ServiceMethod="GetBrandCodes"
                    MinimumPrefixLength="4" EnableCaching="true" CompletionSetCount="20" CompletionListCssClass="autocomplete_completionListElement" 
                    CompletionListItemCssClass="autocomplete_listItem" CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                    DelimiterCharacters="," ShowOnlyCurrentWordInCompletionListItem="false">
                </ajaxToolkit:AutoCompleteExtender>
                <asp:Label ID="lblBrandCodeID" runat="server" Text='<%# Bind("BrandCode") %>' Visible="false" /></td>
            <td><asp:TextBox ID="ManLineTextBox" runat="server" Text='<%# Bind("ManLine") %>' Width="20px" Font-Size="Smaller" /></td>
            <td><asp:DropDownList ID="ddProfile" runat="server" DataSourceID="sdsGetProfile"  DataTextField="Name" Font-Size="Smaller"
                    DataValueField="ID" SelectedValue='<%# bind("InboundProfileID") %>' Width="150px" AppendDataBoundItems="True">
                    <asp:ListItem Text="Select..." Value = "" />
                </asp:DropDownList></td>
            <td><asp:DropDownList ID="ddRcvdAs" runat="server"  width="50px" SelectedValue='<%# bind("RcvdAs") %>' Font-Size="Smaller">
                    <asp:ListItem>Select...</asp:ListItem>
                    <asp:ListItem>Product</asp:ListItem>
                    <asp:ListItem>ShippedNH</asp:ListItem>
                    <asp:ListItem>Waste</asp:ListItem>
                    <asp:ListItem>Other</asp:ListItem>
                </asp:DropDownList></td>
            <td><asp:DropDownList ID="ddPalletType" runat="server" SelectedValue='<%# bind("InboundPalletType") %>' Width="50px" Font-Size="Smaller">
                    <asp:ListItem Value="0">Select...</asp:ListItem>
                    <asp:ListItem>CHEP</asp:ListItem>
                    <asp:ListItem>GMA</asp:ListItem>
                    <asp:ListItem>Other</asp:ListItem>
                    <asp:ListItem></asp:ListItem>
                </asp:DropDownList></td>
            <td><asp:TextBox ID="InboundPalletWeightTextBox" runat="server" Text='<%# Bind("InboundPalletWeight") %>' Width="30px" Font-Size="Smaller" /></td>
            <td><asp:DropDownList ID="ddContainerType" runat="server" SelectedValue='<%# bind("InboundContainerType") %>' Width="50px" Font-Size="Smaller">
                    <asp:ListItem Value="0">Select...</asp:ListItem>
                    <asp:ListItem>DM</asp:ListItem>
                    <asp:ListItem>CW</asp:ListItem>
                    <asp:ListItem>CS</asp:ListItem>
                    <asp:ListItem>CF</asp:ListItem>
                    <asp:ListItem>DF</asp:ListItem>
                </asp:DropDownList></td>
            <td><asp:TextBox ID="InboundContainerQtyTextBox" runat="server" Text='<%# Bind("InboundContainerQty") %>' Width="25px" Font-Size="Smaller" /></td>
            <td><asp:DropDownList ID="ddLocation" runat="server" Width="75px" SelectedValue='<%# bind("InventoryLocation") %>' 
                    DataSourceID="sdsGetLocation" DataTextField="LocationName" DataValueField="LocationName" AppendDataBoundItems="True" Font-Size="Smaller">
                    <asp:ListItem Text="Select..." Value = "" />
                </asp:DropDownList>
            </td>
            <td><asp:DropDownList ID="ddProcessPlan" runat="server" DataSourceID="sdsGetProcPlan"  DataTextField="ProcessPlan" Font-Size="Smaller"
                    DataValueField="ProcessPlan" Width="100px" SelectedValue='<%# bind("ProcessPlan") %>' AppendDataBoundItems="true">
                    <asp:ListItem>Select...</asp:ListItem>
                </asp:DropDownList></td>
            <td nowrap="nowrap"><asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" onClick="fvDuplicateIns_Click" Text="Insert" Font-Size="Smaller" />&nbsp;
            <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" OnClick="InsCancel_Click" CommandName="Cancel" Text="Cancel" Font-Size="Smaller" /></td>
        </tr>
        </table>
        </InsertItemTemplate>
        <ItemTemplate>
       <table style="font-size:smaller">
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
            <td><asp:Label ID="txbNewCntrID" runat="server" Text='<%# Bind("InboundContainerID") %>' Width="30px"  /></td>
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
<tr id="trContainerDetails" runat="server">
    <td id="tdContainerEdit" runat="server" visible="false" >
    <br />
    <asp:FormView ID="fvContainerDetail" runat="server" DataKeyNames="RcvDetailID" DataSourceID="sdsContainerDetail" 
        Font-Size="Small" OnDataBound="fvDuplicate_DataBound" DefaultMode="Edit" >
        <EditItemTemplate>
        <table>
        <tr>
        <td colspan="12">
        <asp:ValidationSummary ID="vsCntrUpdate" runat="server" DisplayMode="BulletList" ShowMessageBox="true" ShowSummary="false"
            HeaderText="You must enter a value in the following fields:" EnableClientScript="true" />
        </td>
        </tr>
        <tr>
            <td style="font-weight:bold;font-size:smaller">DocNo
                <asp:RequiredFieldValidator ID="rfvDocNo" runat="server" ControlToValidate="InboundDocNoTextBox" ErrorMessage="Document Number" Font-Bold="true" ForeColor="Red" Text="*" /></td>
            <td style="font-weight:bold;font-size:smaller">CntrID
                <asp:RequiredFieldValidator ID="rfvCntrID" runat="server" ControlToValidate="InboundContainerIDTextBox" ErrorMessage="ContainerID" Font-Bold="true" ForeColor="Red" Text="*" /></td>
            <td style="font-weight:bold;font-size:smaller">BrandCode
                <asp:RequiredFieldValidator ID="rfvBrandCode" runat="server" ControlToValidate="txbBrandCodes" ErrorMessage="BrandCode" Font-Bold="true" ForeColor="Red" Text="*" /></td>  
            <td style="font-weight:bold;font-size:smaller">Line
                <asp:RequiredFieldValidator ID="rfvManLine" runat="server" ControlToValidate="ManLineTextBox" ErrorMessage="Manifest Line" Font-Bold="true" ForeColor="Red" Text="*" /></td>
            <td style="font-weight:bold;font-size:smaller">Profile
                <asp:RequiredFieldValidator ID="rfvProfile" runat="server" ControlToValidate="ddProfile" InitialValue="" ErrorMessage="Profile" Font-Bold="true" ForeColor="Red" Text="*" /></td>
            <td style="font-weight:bold;font-size:smaller">RcvdAs
                <asp:RequiredFieldValidator ID="rfvRcvdAs" runat="server" ControlToValidate="ddRcvdAs" InitialValue="Select..." ErrorMessage="RcvdAs" Font-Bold="true" ForeColor="Red" Text="*" /></td>
            <td style="font-weight:bold;font-size:smaller">Pallet Type
                <asp:RequiredFieldValidator ID="rfvPalletType" runat="server" ControlToValidate="ddPalletType" InitialValue="0" ErrorMessage="PalletType" Font-Bold="true" ForeColor="Red" Text="*" /></td>
            <td style="font-weight:bold;font-size:smaller">PalletWt
                <asp:RequiredFieldValidator ID="rfvPalletWt" runat="server" ControlToValidate="InboundPalletWeightTextBox" ErrorMessage="Pallet Weight" Font-Bold="true" ForeColor="Red" Text="*" /></td>
            <td style="font-weight:bold;font-size:smaller">Cntr Type
                <asp:RequiredFieldValidator ID="rfvCntrType" runat="server" ControlToValidate="ddContainerType" InitialValue="0" ErrorMessage="Container Type" Font-Bold="true" ForeColor="Red" Text="*" /></td>
            <td style="font-weight:bold;font-size:smaller">Qty
                <asp:RequiredFieldValidator ID="rfvCntrQty" runat="server" ControlToValidate="InboundContainerQtyTextBox" ErrorMessage="Container Qty" Font-Bold="true" ForeColor="Red" Text="*" /></td>
            <td style="font-weight:bold;font-size:smaller">Location
                <asp:RequiredFieldValidator ID="rfvLocation" runat="server" ControlToValidate="ddLocation" InitialValue="" ErrorMessage="Location" Font-Bold="true" ForeColor="Red" Text="*" /></td>
            <td style="font-weight:bold;font-size:smaller">ProcessPlan
                <asp:RequiredFieldValidator ID="rfvProcessPlan" runat="server" ControlToValidate="ddProcessPlan" InitialValue="Select..." ErrorMessage="Process Plan" Font-Bold="true" ForeColor="Red" Text="*" /></td>
            <asp:RegularExpressionValidator ID="revCntrID" ControlToValidate="InboundContainerIDTextBox" runat="server" ForeColor="Red" Font-Bold="true" 
                ErrorMessage="This is not a Valid Container ID" ValidationExpression="^[IiOo][UuNn][Tt]?[-](\d{6})*$" SetFocusOnError="True" /></tr>
        <tr>
  <td><asp:TextBox ID="InboundDocNoTextBox" runat="server" Text='<%# Bind("InboundDocNo") %>' Width="75px" Font-Size="Smaller" /></td>
            <td><asp:TextBox ID="InboundContainerIDTextBox" runat="server" Text='<%# Bind("InboundContainerID") %>' Width="50px"  Font-Size="Smaller"/></td>
            <td><asp:TextBox ID="txbBrandCodes" runat="server" Text='<%# Bind("BrandCodeName") %>' OnTextChanged="txbBrandCodes_SelectedIndexChanged" AutoPostBack="true" Width="200px" Font-Size="Smaller"></asp:TextBox>
                <ajaxToolkit:AutoCompleteExtender
                    ID="txbBrandCodes_AutoCompleteExtender" runat="server" Enabled="True" CompletionInterval="50"
                    TargetControlID="txbBrandCodes" ServicePath="myAutoComplete.asmx" ServiceMethod="GetBrandCodes"
                    MinimumPrefixLength="4" EnableCaching="true" CompletionSetCount="20" CompletionListCssClass="autocomplete_completionListElement" 
                    CompletionListItemCssClass="autocomplete_listItem" CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                    DelimiterCharacters="," ShowOnlyCurrentWordInCompletionListItem="false">
                </ajaxToolkit:AutoCompleteExtender>
                <asp:Label ID="lblBrandCodeID" runat="server" Text='<%# Bind("BrandCode") %>' Visible="false" /></td>
            <td><asp:TextBox ID="ManLineTextBox" runat="server" Text='<%# Bind("ManLine") %>' Width="20px" Font-Size="Smaller" /></td>
            <td><asp:DropDownList ID="ddProfile" runat="server" DataSourceID="sdsGetProfile"  DataTextField="Name" Font-Size="Smaller"
                    DataValueField="ID" SelectedValue='<%# bind("InboundProfileID") %>' Width="150px" AppendDataBoundItems="True">
                    <asp:ListItem Text="Select..." Value = "" />
                </asp:DropDownList></td>
            <td><asp:DropDownList ID="ddRcvdAs" runat="server"  width="50px" SelectedValue='<%# bind("RcvdAs") %>' Font-Size="Smaller">
                    <asp:ListItem>Select...</asp:ListItem>
                    <asp:ListItem>Product</asp:ListItem>
                    <asp:ListItem>ShippedNH</asp:ListItem>
                    <asp:ListItem>Waste</asp:ListItem>
                    <asp:ListItem>Other</asp:ListItem>
                </asp:DropDownList></td>
            <td><asp:DropDownList ID="ddPalletType" runat="server" SelectedValue='<%# bind("InboundPalletType") %>' Width="50px" Font-Size="Smaller">
                    <asp:ListItem Value="0">Select...</asp:ListItem>
                    <asp:ListItem>CHEP</asp:ListItem>
                    <asp:ListItem>GMA</asp:ListItem>
                    <asp:ListItem>Other</asp:ListItem>
                    <asp:ListItem></asp:ListItem>
                </asp:DropDownList></td>
            <td><asp:TextBox ID="InboundPalletWeightTextBox" runat="server" Text='<%# Bind("InboundPalletWeight") %>' Width="30px" Font-Size="Smaller" /></td>
            <td><asp:DropDownList ID="ddContainerType" runat="server" SelectedValue='<%# bind("InboundContainerType") %>' Width="50px" Font-Size="Smaller">
                    <asp:ListItem Value="0">Select...</asp:ListItem>
                    <asp:ListItem>DM</asp:ListItem>
                    <asp:ListItem>CW</asp:ListItem>
                    <asp:ListItem>CS</asp:ListItem>
                    <asp:ListItem>CF</asp:ListItem>
                    <asp:ListItem>DF</asp:ListItem>
                </asp:DropDownList></td>
            <td><asp:TextBox ID="InboundContainerQtyTextBox" runat="server" Text='<%# Bind("InboundContainerQty") %>' Width="25px" Font-Size="Smaller" /></td>
            <td><asp:DropDownList ID="ddLocation" runat="server" Width="75px" SelectedValue='<%# bind("InventoryLocation") %>' 
                    DataSourceID="sdsGetLocation" DataTextField="LocationName" DataValueField="LocationName" AppendDataBoundItems="True" Font-Size="Smaller">
                    <asp:ListItem Text="Select..." Value = "" />
                </asp:DropDownList>
            </td>
            <td><asp:DropDownList ID="ddProcessPlan" runat="server" DataSourceID="sdsGetProcPlan"  DataTextField="ProcessPlan" Font-Size="Smaller"
                    DataValueField="ProcessPlan" Width="100px" SelectedValue='<%# bind("ProcessPlan") %>' AppendDataBoundItems="true">
                    <asp:ListItem>Select...</asp:ListItem>
                </asp:DropDownList></td>
            <td nowrap="nowrap"><asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" onClick="fvContainerDetailsUpd_Click" Text="Update" Font-Size="Smaller" />&nbsp;
            <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" OnClick="UpdCancel_Click" CommandName="Cancel" Text="Cancel" Font-Size="Smaller" /></td>
        </tr>
        </table>                       
        </EditItemTemplate>
        <InsertItemTemplate>
        <table>
        <tr>
        <td colspan="12">
        <asp:ValidationSummary ID="vsCntrInsert" runat="server" DisplayMode="BulletList" ShowMessageBox="true" ShowSummary="false"
            HeaderText="You must enter a value in the following fields:" EnableClientScript="true" />
        </td>
        </tr>
        <tr>
            <td style="font-weight:bold;font-size:smaller">DocNo
                <asp:RequiredFieldValidator ID="rfvDocNo" runat="server" ControlToValidate="InboundDocNoTextBox" ErrorMessage="Document Number" Font-Bold="true" ForeColor="Red" Text="*" /></td>
            <td style="font-weight:bold;font-size:smaller">CntrID
                <asp:RequiredFieldValidator ID="rfvCntrID" runat="server" ControlToValidate="InboundContainerIDTextBox" ErrorMessage="ContainerID" Font-Bold="true" ForeColor="Red" Text="*" /></td>
            <td style="font-weight:bold;font-size:smaller">BrandCode
                <asp:RequiredFieldValidator ID="rfvBrandCode" runat="server" ControlToValidate="txbBrandCodes" ErrorMessage="BrandCode" Font-Bold="true" ForeColor="Red" Text="*" /></td>  
            <td style="font-weight:bold;font-size:smaller">Line
                <asp:RequiredFieldValidator ID="rfvManLine" runat="server" ControlToValidate="ManLineTextBox" ErrorMessage="Manifest Line" Font-Bold="true" ForeColor="Red" Text="*" /></td>
            <td style="font-weight:bold;font-size:smaller">Profile
                <asp:RequiredFieldValidator ID="rfvProfile" runat="server" ControlToValidate="ddProfile" InitialValue="" ErrorMessage="Profile" Font-Bold="true" ForeColor="Red" Text="*" /></td>
            <td style="font-weight:bold;font-size:smaller">RcvdAs
                <asp:RequiredFieldValidator ID="rfvRcvdAs" runat="server" ControlToValidate="ddRcvdAs" InitialValue="Select..." ErrorMessage="RcvdAs" Font-Bold="true" ForeColor="Red" Text="*" /></td>
            <td style="font-weight:bold;font-size:smaller">Pallet Type
                <asp:RequiredFieldValidator ID="rfvPalletType" runat="server" ControlToValidate="ddPalletType" InitialValue="0" ErrorMessage="PalletType" Font-Bold="true" ForeColor="Red" Text="*" /></td>
            <td style="font-weight:bold;font-size:smaller">PalletWt
                <asp:RequiredFieldValidator ID="rfvPalletWt" runat="server" ControlToValidate="InboundPalletWeightTextBox" ErrorMessage="Pallet Weight" Font-Bold="true" ForeColor="Red" Text="*" /></td>
            <td style="font-weight:bold;font-size:smaller">Cntr Type
                <asp:RequiredFieldValidator ID="rfvCntrType" runat="server" ControlToValidate="ddContainerType" InitialValue="0" ErrorMessage="Container Type" Font-Bold="true" ForeColor="Red" Text="*" /></td>
            <td style="font-weight:bold;font-size:smaller">Qty
                <asp:RequiredFieldValidator ID="rfvCntrQty" runat="server" ControlToValidate="InboundContainerQtyTextBox" ErrorMessage="Container Qty" Font-Bold="true" ForeColor="Red" Text="*" /></td>
            <td style="font-weight:bold;font-size:smaller">Location
                <asp:RequiredFieldValidator ID="rfvLocation" runat="server" ControlToValidate="ddLocation" InitialValue="" ErrorMessage="Location" Font-Bold="true" ForeColor="Red" Text="*" /></td>
            <td style="font-weight:bold;font-size:smaller">ProcessPlan
                <asp:RequiredFieldValidator ID="rfvProcessPlan" runat="server" ControlToValidate="ddProcessPlan" InitialValue="Select..." ErrorMessage="Process Plan" Font-Bold="true" ForeColor="Red" Text="*" /></td>
            <asp:RegularExpressionValidator ID="revCntrID" ControlToValidate="InboundContainerIDTextBox" runat="server" ForeColor="Red" Font-Bold="true" 
                ErrorMessage="This is not a Valid Container ID" ValidationExpression="^[IiOo][UuNn][Tt]?[-](\d{6})*$" SetFocusOnError="True" /></tr>
        <tr>
            <td><asp:TextBox ID="InboundDocNoTextBox" runat="server" Text='<%# Bind("InboundDocNo") %>' Width="75px" Font-Size="Smaller" /></td>
            <td><asp:TextBox ID="InboundContainerIDTextBox" runat="server" Text='<%# Bind("InboundContainerID") %>' Width="50px"  Font-Size="Smaller"/></td>
            <td><asp:TextBox ID="txbBrandCodes" runat="server" OnTextChanged="txbBrandCodes_SelectedIndexChanged" AutoPostBack="true" Width="200px" Font-Size="Smaller"></asp:TextBox>
                <ajaxToolkit:AutoCompleteExtender
                    ID="txbBrandCodes_AutoCompleteExtender" runat="server" Enabled="True" CompletionInterval="50"
                    TargetControlID="txbBrandCodes" ServicePath="myAutoComplete.asmx" ServiceMethod="GetBrandCodes"
                    MinimumPrefixLength="4" EnableCaching="true" CompletionSetCount="20" CompletionListCssClass="autocomplete_completionListElement" 
                    CompletionListItemCssClass="autocomplete_listItem" CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                    DelimiterCharacters="," ShowOnlyCurrentWordInCompletionListItem="false">
                </ajaxToolkit:AutoCompleteExtender>
                <asp:Label ID="lblBrandCodeID" runat="server" Text='<%# Bind("BrandCode") %>' Visible="false" /></td>
            <td><asp:TextBox ID="ManLineTextBox" runat="server" Text='<%# Bind("ManLine") %>' Width="20px" Font-Size="Smaller" /></td>
            <td><asp:DropDownList ID="ddProfile" runat="server" DataSourceID="sdsGetProfile"  DataTextField="Name" Font-Size="Smaller"
                    DataValueField="ID" SelectedValue='<%# bind("InboundProfileID") %>' Width="150px" AppendDataBoundItems="True">
                    <asp:ListItem Text="Select..." Value = "" />
                </asp:DropDownList></td>
            <td><asp:DropDownList ID="ddRcvdAs" runat="server"  width="50px" SelectedValue='<%# bind("RcvdAs") %>' Font-Size="Smaller">
                    <asp:ListItem>Select...</asp:ListItem>
                    <asp:ListItem>Product</asp:ListItem>
                    <asp:ListItem>ShippedNH</asp:ListItem>
                    <asp:ListItem>Waste</asp:ListItem>
                    <asp:ListItem>Other</asp:ListItem>
                </asp:DropDownList></td>
            <td><asp:DropDownList ID="ddPalletType" runat="server" SelectedValue='<%# bind("InboundPalletType") %>' Width="50px" Font-Size="Smaller">
                    <asp:ListItem Value="0">Select...</asp:ListItem>
                    <asp:ListItem>CHEP</asp:ListItem>
                    <asp:ListItem>GMA</asp:ListItem>
                    <asp:ListItem>Other</asp:ListItem>
                    <asp:ListItem></asp:ListItem>
                </asp:DropDownList></td>
            <td><asp:TextBox ID="InboundPalletWeightTextBox" runat="server" Text='<%# Bind("InboundPalletWeight") %>' Width="30px" Font-Size="Smaller" /></td>
            <td><asp:DropDownList ID="ddContainerType" runat="server" SelectedValue='<%# bind("InboundContainerType") %>' Width="50px" Font-Size="Smaller">
                    <asp:ListItem Value="0">Select...</asp:ListItem>
                    <asp:ListItem>DM</asp:ListItem>
                    <asp:ListItem>CW</asp:ListItem>
                    <asp:ListItem>CS</asp:ListItem>
                    <asp:ListItem>CF</asp:ListItem>
                    <asp:ListItem>DF</asp:ListItem>
                </asp:DropDownList></td>
            <td><asp:TextBox ID="InboundContainerQtyTextBox" runat="server" Text='<%# Bind("InboundContainerQty") %>' Width="25px" Font-Size="Smaller" /></td>
            <td><asp:DropDownList ID="ddLocation" runat="server" Width="75px" SelectedValue='<%# bind("InventoryLocation") %>' 
                    DataSourceID="sdsGetLocation" DataTextField="LocationName" DataValueField="LocationName" AppendDataBoundItems="True" Font-Size="Smaller">
                    <asp:ListItem Text="Select..." Value = "" />
                </asp:DropDownList>
            </td>
            <td><asp:DropDownList ID="ddProcessPlan" runat="server" DataSourceID="sdsGetProcPlan"  DataTextField="ProcessPlan" Font-Size="Smaller"
                    DataValueField="ProcessPlan" Width="100px" SelectedValue='<%# bind("ProcessPlan") %>' AppendDataBoundItems="true">
                    <asp:ListItem>Select...</asp:ListItem>
                </asp:DropDownList></td>
            <td nowrap="nowrap"><asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" onClick="fvContainerDetailsIns_Click" Text="Insert" Font-Size="Smaller" />&nbsp;
            <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" OnClick="InsCancel_Click" CommandName="Cancel" Text="Cancel" Font-Size="Smaller" /></td>
        </tr>
        </table>
        </InsertItemTemplate>
        <ItemTemplate>
       <table style="font-size:smaller">
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
    <asp:GridView ID="gvContainers" runat="server" AutoGenerateColumns="False" 
            DataKeyNames="RcvDetailID" DataSourceID="sdsContainer" AllowSorting="True" 
            CellPadding="4"  ForeColor="#333333" Font-Size="Smaller" 
            OnRowCommand="gvContainers_RowCommand">
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
        <asp:TemplateField>
            <ItemTemplate>
                <asp:LinkButton ID="lnkDeleteBtn" runat="server" CommandName="DeleteDetail" CommandArgument='<%# Eval("RcvDetailID") %>'>Delete</asp:LinkButton>
            </ItemTemplate>
        </asp:TemplateField>
        </Columns>
    </asp:GridView></td></tr></table>
<asp:SqlDataSource ID="sdsClient" runat="server" 
    ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
    SelectCommand="IMDB_Receive_Client_Sel" SelectCommandType="StoredProcedure">
</asp:SqlDataSource>  
<asp:SqlDataSource ID="sdsTSDF" runat="server" 
    ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
    SelectCommand="IMDB_Receive_TSDF_Sel" SelectCommandType="StoredProcedure">
</asp:SqlDataSource>
<asp:SqlDataSource ID="sdsCarrier" runat="server" 
    ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
    SelectCommand="IMDB_Receive_Carrier_Sel" SelectCommandType="StoredProcedure">
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
<asp:SqlDataSource ID="sdsContainer_Edit" runat="server" 
    ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
    SelectCommand="IMDB_Receive_Container_Sel" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:SessionParameter Name="RcvDetailID" SessionField="CurDetailID" Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="sdsRcvHdr" runat="server"
    ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>"
    SelectCommand="IMDB_Receive_Hdr_Sel" SelectCommandType="StoredProcedure"
    UpdateCommand="IMDB_Receive_Hdr_Upd" UpdateCommandType="StoredProcedure"
    OnUpdating="sdsRcvHdr_Updating">
    <SelectParameters>
        <asp:ControlParameter ControlID="txbOrderNumber" Name="ordernumber" PropertyName="Text" Type="String" />
        <asp:ControlParameter ControlID="ddClient" Name="clientID" PropertyName="SelectedValue" Type="String" DefaultValue="0"/>
        <asp:SessionParameter Name="RcvHdrID"  SessionField="CurRcvHdrID" DefaultValue="0" Type="Int32" />
        <asp:ControlParameter ControlID="txbBegDate" Name="BegDate" PropertyName="Text" Type="String" DefaultValue="01/01/1900" />
        <asp:ControlParameter ControlID="txbEndDate" Name="EndDate" PropertyName="Text" Type="String" DefaultValue="01/01/2200" />
    </SelectParameters>
    <UpdateParameters>
        <asp:Parameter Name="RcvHdrID" Type="Int32" />
        <asp:Parameter Name="OrderNumber" Type="String" />
        <asp:Parameter Name="ClientID" Type="Int32" />
        <asp:Parameter Name="WorkOrder" Type="Int32" />
        <asp:Parameter Name="TSDFID" Type="Int32" />
        <asp:Parameter Name="ReceivedBy" Type="String" />
        <asp:Parameter Name="ReceiveDate" Type="DateTime" />
        <asp:Parameter Name="ReceiveDock" Type="String" />
        <asp:Parameter Name="CarrierID" Type="Int32" />
        <asp:Parameter Name="Trailer_Number" Type="String" />
        <asp:Parameter Name="ShipDate" Type="DateTime" />
        <asp:Parameter Name="Memo" Type="String" />
        <asp:Parameter Name="UserName" Type="String" />
    </UpdateParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="sdsGetProfile" runat="server" ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
    SelectCommand="IMDB_Receive_GetProfile_Sel" SelectCommandType="StoredProcedure">
</asp:SqlDataSource>
<asp:SqlDataSource ID="sdsGetProcPlan" runat="server" ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
    SelectCommand="IMDB_Receive_ProcessPlan_Sel" SelectCommandType="StoredProcedure">
</asp:SqlDataSource>
<asp:SqlDataSource ID="sdsGetLocation" runat="server" ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
    SelectCommand="IMDB_Receive_Location_Sel" SelectCommandType="StoredProcedure">
</asp:SqlDataSource>
<asp:SqlDataSource ID="sdsNewTruck" runat="server" 
    ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
    InsertCommand="IMDB_Receive_Hdr_Ins" InsertCommandtype="StoredProcedure"
    OnInserting="sdsNewTruck_Inserting" OnInserted="sdsNewTruck_Inserted">
    <InsertParameters>
        <asp:Parameter Name="OrderNumber" Type="String" />
        <asp:Parameter Name="WorkOrder" Type="Int32" />
        <asp:Parameter Name="ClientName" Type="Int32" />
        <asp:Parameter Name="TSDF" Type="Int32" />
        <asp:Parameter Name="ReceivedBy" Type="String" />
        <asp:Parameter Name="ReceiveDate" Type="DateTime" />
        <asp:Parameter Name="ReceiveDock" Type="String" />
        <asp:Parameter Name="Carrier" Type="Int32" />
        <asp:Parameter Name="Trailer_Number" Type="String" />
        <asp:Parameter Name="ShipDate" Type="DateTime" />
        <asp:Parameter Name="Memo" Type="String" />
        <asp:Parameter Name="UserName" Type="String" />
        <asp:Parameter Name="ID" Type="Int32" Direction="Output" />
    </InsertParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="sdsGetUsers" runat="server" ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
    SelectCommand="IMDB_Receive_User_Sel" SelectCommandType="StoredProcedure">
</asp:SqlDataSource>
<asp:SqlDataSource ID="sdsRcvSummary" runat="server" ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
    SelectCommand="IMDB_Receive_Summary_Sel" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:SessionParameter Name="RcvHdrID" SessionField="CurRcvHdrID" Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Clear" runat="server"></asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Footer" runat="server"></asp:Content>
