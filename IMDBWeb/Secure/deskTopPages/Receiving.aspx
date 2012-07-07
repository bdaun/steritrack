<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Receiving.aspx.cs" Inherits="IMDBWeb.Secure.SPAKpages.Receiving" EnableEventValidation="false"%>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" tagprefix="ajaxToolkit"%>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <table class="ui-accordion">
        <tr>
            <td width="100px">
                Order Number:
            </td>
            <td>
                <asp:TextBox ID="txbOrderNum" runat="server" OnTextChanged="txbOrderNum_OnTextChanged" AutoPostBack="true" Width="250px"></asp:TextBox>
                    <ajaxToolkit:AutoCompleteExtender
                        ID="txbOrderNum_AutoCompleteExtender" 
                        runat="server"
                        Enabled="True"
                        CompletionInterval="250"
                        TargetControlID="txbOrderNum"
                        ServicePath="myAutoComplete.asmx"
                        ServiceMethod="GetOrderNums"
                        MinimumPrefixLength="4"
                        EnableCaching="true"
                        CompletionSetCount="20"
                        CompletionListCssClass="autocomplete_completionListElement" 
                        CompletionListItemCssClass="autocomplete_listItem" 
                        CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                        DelimiterCharacters=","
                        ShowOnlyCurrentWordInCompletionListItem="false"
                        BehaviorID="AutoCompleteEx1">
                            <Animations>
                            <OnShow>
                                <Sequence>
                                    <%-- Make the completion list transparent and then show it --%>
                                    <OpacityAction Opacity="0" />
                                    <HideAction Visible="true" />
                            
                                    <%--Cache the original size of the completion list the first time
                                        the animation is played and then set it to zero --%>
                                    <ScriptAction Script="
                                        // Cache the size and setup the initial size
                                        var behavior = $find('AutoCompleteEx1');
                                        if (!behavior._height) {
                                            var target = behavior.get_completionList();
                                            behavior._height = target.offsetHeight - 2;
                                            target.style.height = '0px';
                                        }" />
                            
                                    <%-- Expand from 0px to the appropriate size while fading in --%>
                                    <Parallel Duration=".4">
                                        <FadeIn />
                                        <Length PropertyKey="height" StartValue="0" EndValueScript="$find('AutoCompleteEx1')._height" />
                                    </Parallel>
                                </Sequence>
                            </OnShow>
                            <OnHide>
                                <%-- Collapse down to 0px and fade out --%>
                                <Parallel Duration="0">
                                    <FadeOut />
                                    <Length PropertyKey="height" StartValueScript="$find('AutoCompleteEx1')._height" EndValue="0" />
                                </Parallel>
                            </OnHide>
                        </Animations>
                     </ajaxToolkit:AutoCompleteExtender>
            </td>
        </tr>
        <tr>
            <td width="100px">
                Client:
            </td>
            <td>
                <asp:TextBox ID="txbClientName" runat="server"  
                        OnTextChanged="txbClientName_OnTextChanged" AutoPostBack="true" Width="250px"></asp:TextBox>
                    <ajaxToolkit:AutoCompleteExtender
                        ID="txbClientName_AutoCompleteExtender" 
                        runat="server"
                        Enabled="True"
                        CompletionInterval="250"
                        TargetControlID="txbClientName"
                        ServicePath="myAutoComplete.asmx"
                        ServiceMethod="GetClientName"
                        MinimumPrefixLength="1"
                        EnableCaching="true"
                        CompletionSetCount="5"
                        CompletionListCssClass="autocomplete_completionListElement" 
                        CompletionListItemCssClass="autocomplete_listItem" 
                        CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                        DelimiterCharacters=";, :"
                        ShowOnlyCurrentWordInCompletionListItem="true"
                        BehaviorID="AutoCompleteEx">
                            <Animations>
                            <OnShow>
                                <Sequence>
                                    <%-- Make the completion list transparent and then show it --%>
                                    <OpacityAction Opacity="0" />
                                    <HideAction Visible="true" />
                            
                                    <%--Cache the original size of the completion list the first time
                                        the animation is played and then set it to zero --%>
                                    <ScriptAction Script="
                                        // Cache the size and setup the initial size
                                        var behavior = $find('AutoCompleteEx');
                                        if (!behavior._height) {
                                            var target = behavior.get_completionList();
                                            behavior._height = target.offsetHeight - 2;
                                            target.style.height = '0px';
                                        }" />
                            
                                    <%-- Expand from 0px to the appropriate size while fading in --%>
                                    <Parallel Duration=".4">
                                        <FadeIn />
                                        <Length PropertyKey="height" StartValue="0" EndValueScript="$find('AutoCompleteEx')._height" />
                                    </Parallel>
                                </Sequence>
                            </OnShow>
                            <OnHide>
                                <%-- Collapse down to 0px and fade out --%>
                                <Parallel Duration="0">
                                    <FadeOut />
                                    <Length PropertyKey="height" StartValueScript="$find('AutoCompleteEx')._height" EndValue="0" />
                                </Parallel>
                            </OnHide>
                        </Animations>
                    </ajaxToolkit:AutoCompleteExtender>
            </td>
        </tr>
    </table>
    <table class="ui-accordion">
        <tr>
            <td>
                <asp:UpdatePanel ID="udp_gvSearchResults" runat="server" UpdateMode="always">
                    <ContentTemplate>
                        <asp:Label ID="Label1" runat="server" Visible="true"></asp:Label>&nbsp;
                        <asp:GridView
                            ID="gvSearchResults"
                            runat="server"
                            AutoGenerateColumns="False" 
                            OnSelectedIndexChanged="gvSearchResults_SelectedIndexChanged"
                            DataKeyNames="id"
                            DataSourceID="sdsHdrList"
                            AllowPaging="True"  
                            AllowSorting="True"
                            OnRowDataBound="gvSearchResults_RowDataBound"
                            CellPadding="4"
                            ForeColor="#333333"
                            GridLines="Horizontal"
                            SelectedRowStyle-BackColor = "#ffff99"
                            OnRowCommand="gvSearchResults_RowCommand">
                            <Columns>
                                <asp:BoundField DataField="Trailer Number" HeaderText="Trailer Number" 
                                    SortExpression="Trailer Number" />
                                <asp:BoundField DataField="OrderNumber" HeaderText="Order Number" 
                                    SortExpression="OrderNumber" />
                                <asp:BoundField DataField="WorkOrder" HeaderText="Work Order" 
                                    SortExpression="WorkOrder" />
                                <asp:BoundField DataField="name" HeaderText="Client" 
                                    SortExpression="name" />
                                <asp:BoundField DataField="vendorname1" HeaderText="TSDF" 
                                    SortExpression="vendorname1" />
                                <asp:BoundField DataField="vendorname" HeaderText="Carrier" 
                                    SortExpression="vendorname" />
                                <asp:BoundField DataField="ShipDate" DataFormatString="{0:MM/d/yyyy}" 
                                    HeaderText="ShipDate" SortExpression="ShipDate" />
                                <asp:BoundField DataField="ReceivedBy" HeaderText="Received By" 
                                    SortExpression="ReceivedBy" />
                                <asp:BoundField DataField="ReceiveDate" HeaderText="Receive Date" 
                                    SortExpression="ReceiveDate" DataFormatString="{0:MM/d/yyyy}" />
                                <asp:BoundField DataField="ReceiveDock" HeaderText="Receive Dock" 
                                    SortExpression="ReceiveDock" />
                            </Columns>
                            <SelectedRowStyle BackColor="#FFFF99" />
                        </asp:GridView>
                        <br />
                        <asp:Label ID="Label3" runat="server" Visible="true" Font-Bold="True" ForeColor="Red"></asp:Label>
                        <asp:Label ID="label2" runat="server" Visible="true" Font-Bold="True" ForeColor="Red"></asp:Label>
                        <br />
                        <asp:GridView
                            ID="gvRcvDetail"
                            runat="server"
                            DataSourceID="sdsRcvDetail_Sel"  
                            AutoGenerateColumns="False"
                            DataKeyNames="ID" HorizontalAlign="Center">
                            <Columns>
                                <asp:BoundField DataField="InboundDocNo" HeaderText="Doc No" 
                                    SortExpression="InboundDocNo" />
                                <asp:BoundField DataField="ManifestLineNumber" HeaderText="Line Number" 
                                    SortExpression="ManifestLineNumber" />
                                <asp:BoundField DataField="InboundProfileID" HeaderText="Profile ID" 
                                    SortExpression="InboundProfileID" />
                                <asp:BoundField DataField="InboundContainerType" HeaderText="Container Type"
                                     SortExpression="InboundContainerType" />
                                <asp:BoundField DataField="InboundPalletType" HeaderText="Pallet Type" 
                                    SortExpression="InboundPalletType" />
                                <asp:BoundField DataField="InboundPalletWeight" HeaderText="Pallet Weight"
                                     SortExpression="InboundPalletWeight" />
                                <asp:BoundField DataField="InboundContainerQty" HeaderText="Container Qty"
                                     SortExpression="InboundContainerQty" />
                                <asp:BoundField DataField="InboundContainerID" HeaderText="Container ID" 
                                    SortExpression="InboundContainerID" />
                                <asp:BoundField DataField="InventoryLocation" HeaderText="Inventory Location" 
                                    SortExpression="InventoryLocation" />
                                <asp:BoundField DataField="BrandCode" HeaderText="Brand Code" 
                                    SortExpression="BrandCode" />
                                <asp:CheckBoxField DataField="Process?" HeaderText="Process?" 
                                    SortExpression="Process?" />
                                <asp:BoundField DataField="ProcessPlan" HeaderText="Process Plan" 
                                    SortExpression="ProcessPlan" />
                                <asp:BoundField DataField="RcvdAs" HeaderText="Rcvd As" 
                                    SortExpression="RcvdAs" />
                                <asp:BoundField DataField="CreateDate" HeaderText="Create Date" 
                                    SortExpression="CreateDate" DataFormatString="{0:MM/d/yyyy}"/>
                                <asp:BoundField DataField="ModDate" HeaderText="Mod Date" 
                                    SortExpression="ModDate" DataFormatString="{0:MM/d/yyyy}"/>
                                <asp:BoundField DataField="UserName" HeaderText="User Name" 
                                    SortExpression="UserName" />
                            </Columns>
                            <HeaderStyle HorizontalAlign="Center" />
                        </asp:GridView>
                     </ContentTemplate>
                </asp:UpdatePanel>
                <asp:Panel runat="Server" ID="pnlPopUp" CssClass="PopupPanel" style="display:none">
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            Select Inbound <br /> Document Number(s) <br />
                            <asp:CheckBoxList ID="CheckBoxList1" runat="server" DataSourceID="sdsRcvInboundDocs_Sel" DataTextField="InboundDocNo" >
                            </asp:CheckBoxList>
                            <br />
                            <asp:Button runat="server" Id="btnOk" Text="Ok" onclick="btnOk_Click" /> 
                            <asp:Button runat="server" Id="Edit" Text="Edit" onclick="btnEdit_Click" />          
                        </ContentTemplate>
                     </asp:UpdatePanel>
                </asp:Panel>
                <ajaxToolkit:ModalPopupExtender ID="mdlPopup" 
                                runat="server"
                                TargetControlID="btnModalPopUp"
                                OkControlID="btnOk"
                                PopupControlID="pnlPopUp"
                                BackgroundCssClass="modalBackground">
                </ajaxToolkit:ModalPopupExtender>
                <asp:Button runat="server" ID="btnModalPopUp" Style="display:none"/>                  
            </td>
        </tr>
        <tr>
            <td>
                <asp:Button ID="btnNewTruck" runat="server" Text="New Truck" 
                    onclick="btnNewTruck_Click" />
                <asp:Button ID="btnClear" runat="server" onclick="btnClear_Click" Text="Clear" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False"
                        DataKeyNames="id" DataSourceID="SqlDataSource1" Height="50px" Width="400px"
                        OnItemCommand="DetailsView1_ItemCommand" Visible="False" DefaultMode="Insert">
                            <EmptyDataTemplate>
                                No Data
                            </EmptyDataTemplate>
                    <Fields>
                        <asp:TemplateField>
                            <InsertItemTemplate>
                                <table class="ui-accordion">
                                    <tr>
                                        <td>
                                            
                                            Order Number</td>
                                        <td>
                                            <asp:TextBox ID="txbOrderNumber" Width="250px" runat="server" Text='<%# bind("OrderNumber") %>'></asp:TextBox>
                                        </td>
                                        <td>
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Work Order</td>
                                        <td>
                                            <asp:TextBox ID="txbWorkOrder" Width="250px" runat="server" Text='<%# bind("WorkOrder") %>'></asp:TextBox>
                                        </td>
                                        <td>
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Client</td>
                                        <td>
                                            <asp:TextBox ID="txbClientName2" Width="250px" runat="server" OnTextChanged="txbClientName2_OnTextChanged"  AutoPostBack="true"></asp:TextBox>
                                                <ajaxToolkit:AutoCompleteExtender
                                                    ID="txbClientName_AutoCompleteExtender" 
                                                    runat="server"
                                                    Enabled="True"
                                                    CompletionInterval="250"
                                                    TargetControlID="txbClientName2"
                                                    ServicePath="myAutoComplete.asmx"
                                                    ServiceMethod="GetClientName"
                                                    MinimumPrefixLength="1"
                                                    EnableCaching="true"
                                                    CompletionSetCount="5"
                                                    CompletionListCssClass="autocomplete_completionListElement" 
                                                    CompletionListItemCssClass="autocomplete_listItem" 
                                                    CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                                                    DelimiterCharacters=";, :"
                                                    ShowOnlyCurrentWordInCompletionListItem="true"
                                                    BehaviorID="AutoCompleteEx3">
                                                        <Animations>
                                                        <OnShow>
                                                            <Sequence>
                                                                <%-- Make the completion list transparent and then show it --%>
                                                                <OpacityAction Opacity="0" />
                                                                <HideAction Visible="true" />
                            
                                                                <%--Cache the original size of the completion list the first time
                                                                    the animation is played and then set it to zero --%>
                                                                <ScriptAction Script="
                                                                    // Cache the size and setup the initial size
                                                                    var behavior = $find('AutoCompleteEx');
                                                                    if (!behavior._height) {
                                                                        var target = behavior.get_completionList();
                                                                        behavior._height = target.offsetHeight - 2;
                                                                        target.style.height = '0px';
                                                                    }" />
                            
                                                                <%-- Expand from 0px to the appropriate size while fading in --%>
                                                                <Parallel Duration=".4">
                                                                    <FadeIn />
                                                                    <Length PropertyKey="height" StartValue="0" EndValueScript="$find('AutoCompleteEx3')._height" />
                                                                </Parallel>
                                                            </Sequence>
                                                        </OnShow>
                                                        <OnHide>
                                                            <%-- Collapse down to 0px and fade out --%>
                                                            <Parallel Duration="0">
                                                                <FadeOut />
                                                                <Length PropertyKey="height" StartValueScript="$find('AutoCompleteEx3')._height" EndValue="0" />
                                                            </Parallel>
                                                        </OnHide>
                                                    </Animations>
                                        </ajaxToolkit:AutoCompleteExtender>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblClientID" runat="server" Text='<%# bind("ClientName") %>'></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            TSDF</td>
                                        <td>
                                            <asp:TextBox ID="txbTSDFName" Width="250px" runat="server" OnTextChanged="txbTSDFName_OnTextChanged"  AutoPostBack="true"></asp:TextBox>
                                                <ajaxToolkit:AutoCompleteExtender
                                                    ID="txbTSDFName_AutoCompleteExtender" 
                                                    runat="server"
                                                    Enabled="True"
                                                    CompletionInterval="250"
                                                    TargetControlID="txbTSDFName"
                                                    ServicePath="myAutoComplete.asmx"
                                                    ServiceMethod="GetTSDFName"
                                                    MinimumPrefixLength="1"
                                                    EnableCaching="true"
                                                    CompletionSetCount="5"
                                                    CompletionListCssClass="autocomplete_completionListElement" 
                                                    CompletionListItemCssClass="autocomplete_listItem" 
                                                    CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                                                    DelimiterCharacters=";, :"
                                                    ShowOnlyCurrentWordInCompletionListItem="true"
                                                    BehaviorID="AutoCompleteEx4">
                                                        <Animations>
                                                        <OnShow>
                                                            <Sequence>
                                                                <%-- Make the completion list transparent and then show it --%>
                                                                <OpacityAction Opacity="0" />
                                                                <HideAction Visible="true" />
                            
                                                                <%--Cache the original size of the completion list the first time
                                                                    the animation is played and then set it to zero --%>
                                                                <ScriptAction Script="
                                                                    // Cache the size and setup the initial size
                                                                    var behavior = $find('AutoCompleteEx');
                                                                    if (!behavior._height) {
                                                                        var target = behavior.get_completionList();
                                                                        behavior._height = target.offsetHeight - 2;
                                                                        target.style.height = '0px';
                                                                    }" />
                            
                                                                <%-- Expand from 0px to the appropriate size while fading in --%>
                                                                <Parallel Duration=".4">
                                                                    <FadeIn />
                                                                    <Length PropertyKey="height" StartValue="0" EndValueScript="$find('AutoCompleteEx4')._height" />
                                                                </Parallel>
                                                            </Sequence>
                                                        </OnShow>
                                                        <OnHide>
                                                            <%-- Collapse down to 0px and fade out --%>
                                                            <Parallel Duration="0">
                                                                <FadeOut />
                                                                <Length PropertyKey="height" StartValueScript="$find('AutoCompleteEx4')._height" EndValue="0" />
                                                            </Parallel>
                                                        </OnHide>
                                                    </Animations>
                                        </ajaxToolkit:AutoCompleteExtender>
                                        </td>
                                        <td>
                                        <asp:Label ID="lblTSDFid" runat="server" Text='<%# bind("TSDF") %>'></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Ship Date</td>
                                        <td>
                                            <asp:TextBox ID="txbShipDate" Width="250px" runat="server" Text='<%# bind("ShipDate") %>'></asp:TextBox>
                                            <ajaxToolKit:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txbShipDate" />

                                        </td>
                                        <td>
                                        
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Carrier</td>
                                        <td>
                                                <asp:TextBox ID="txbCarrierName" Width="250px" runat="server" OnTextChanged="txbCarrierName_OnTextChanged"  AutoPostBack="true"></asp:TextBox>
                                                <ajaxToolkit:AutoCompleteExtender
                                                    ID="txbCarrierName_AutoCompleteExtender" 
                                                    runat="server"
                                                    Enabled="True"
                                                    CompletionInterval="250"
                                                    TargetControlID="txbCarrierName"
                                                    ServicePath="myAutoComplete.asmx"
                                                    ServiceMethod="GetCarrierName"
                                                    MinimumPrefixLength="1"
                                                    EnableCaching="true"
                                                    CompletionSetCount="5"
                                                    CompletionListCssClass="autocomplete_completionListElement" 
                                                    CompletionListItemCssClass="autocomplete_listItem" 
                                                    CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                                                    DelimiterCharacters=";, :"
                                                    ShowOnlyCurrentWordInCompletionListItem="true"
                                                    BehaviorID="AutoCompleteEx5">
                                                        <Animations>
                                                        <OnShow>
                                                            <Sequence>
                                                                <%-- Make the completion list transparent and then show it --%>
                                                                <OpacityAction Opacity="0" />
                                                                <HideAction Visible="true" />
                            
                                                                <%--Cache the original size of the completion list the first time
                                                                    the animation is played and then set it to zero --%>
                                                                <ScriptAction Script="
                                                                    // Cache the size and setup the initial size
                                                                    var behavior = $find('AutoCompleteEx');
                                                                    if (!behavior._height) {
                                                                        var target = behavior.get_completionList();
                                                                        behavior._height = target.offsetHeight - 2;
                                                                        target.style.height = '0px';
                                                                    }" />
                            
                                                                <%-- Expand from 0px to the appropriate size while fading in --%>
                                                                <Parallel Duration=".4">
                                                                    <FadeIn />
                                                                    <Length PropertyKey="height" StartValue="0" EndValueScript="$find('AutoCompleteEx5')._height" />
                                                                </Parallel>
                                                            </Sequence>
                                                        </OnShow>
                                                        <OnHide>
                                                            <%-- Collapse down to 0px and fade out --%>
                                                            <Parallel Duration="0">
                                                                <FadeOut />
                                                                <Length PropertyKey="height" StartValueScript="$find('AutoCompleteEx5')._height" EndValue="0" />
                                                            </Parallel>
                                                        </OnHide>
                                                    </Animations>
                                        </ajaxToolkit:AutoCompleteExtender>
                                        </td>
                                        <td>
                                        <asp:Label ID="lblCarrierID" runat="server" Text='<%# bind("carrier") %>'></asp:Label> 
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Trailer Number</td>
                                        <td>
                                            <asp:TextBox ID="txbTrailerNum" Width="250px" runat="server" Text='<%# bind("Trailer_Number") %>'></asp:TextBox>
                                        </td>
                                        <td>
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Receive Dock</td>
                                        <td>
                                            <asp:DropDownList ID="DropDownList4" Width="250px" runat="server" Text='<%# bind("ReceiveDock") %>'>
                                                <asp:ListItem Text="Select..." Value="" />
                                                <asp:ListItem>33</asp:ListItem>
                                                <asp:ListItem>34</asp:ListItem>
                                                <asp:ListItem>35</asp:ListItem>
                                                <asp:ListItem>36</asp:ListItem>
                                                <asp:ListItem>37</asp:ListItem>
                                                <asp:ListItem>SuiteA</asp:ListItem>
                                                <asp:ListItem>Other</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td>
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Receive Date</td>
                                        <td>
                                            <asp:TextBox ID="txbRcvDate" Width="250px" runat="server" Text='<%# bind("ReceiveDate") %>'></asp:TextBox>
                                            <ajaxToolKit:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txbRcvDate" />
                                        </td>
                                        <td>
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Received By</td>
                                        <td>
                                            <asp:DropDownList ID="DropDownList5" Width="250px" runat="server" DataSourceID="sdsGetUsers" 
                                                 SelectedValue='<%# bind("ReceivedBy") %>' DataTextField="Name" 
                                                DataValueField="Name" AppendDataBoundItems="True">
                                                    <asp:ListItem Text="Select..." Value = "" />
                                            </asp:DropDownList>
                                            <asp:SqlDataSource ID="sdsGetUsers" runat="server" 
                                                ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
                                                SelectCommand="IMDB_Rcv_User_Sel" SelectCommandType="StoredProcedure">
                                            </asp:SqlDataSource>
                                        </td>
                                        <td>
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;</td>
                                        <td>
                                            &nbsp;</td>
                                        <td>
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;</td>
                                        <td>
                                            &nbsp;</td>
                                        <td>
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;</td>
                                        <td>
                                            &nbsp;</td>
                                        <td>
                                            &nbsp;</td>
                                    </tr>
                                </table>
                            </InsertItemTemplate>
                            <EditItemTemplate>
                                <table class="ui-accordion">
                                    <tr>
                                        <td>
                                            
                                            Order Number</td>
                                        <td>
                                            <asp:TextBox ID="txbOrderNumber" Width="250px" runat="server" Text='<%# bind("OrderNumber") %>'></asp:TextBox>
                                        </td>
                                        <td>
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Work Order</td>
                                        <td>
                                            <asp:TextBox ID="txbWorkOrder" Width="250px" runat="server" Text='<%# bind("WorkOrder") %>'></asp:TextBox>
                                        </td>
                                        <td>
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Client</td>
                                        <td>
                                            <asp:TextBox ID="txbClientName2" Width="250px" runat="server" Text='<%# bind("name") %>' OnTextChanged="txbClientName2_OnTextChanged"  AutoPostBack="true"></asp:TextBox>
                                                <ajaxToolkit:AutoCompleteExtender
                                                    ID="txbClientName_AutoCompleteExtender" 
                                                    runat="server"
                                                    Enabled="True"
                                                    CompletionInterval="250"
                                                    TargetControlID="txbClientName2"
                                                    ServicePath="myAutoComplete.asmx"
                                                    ServiceMethod="GetClientName"
                                                    MinimumPrefixLength="1"
                                                    EnableCaching="true"
                                                    CompletionSetCount="5"
                                                    CompletionListCssClass="autocomplete_completionListElement" 
                                                    CompletionListItemCssClass="autocomplete_listItem" 
                                                    CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                                                    DelimiterCharacters=";, :"
                                                    ShowOnlyCurrentWordInCompletionListItem="true"
                                                    BehaviorID="AutoCompleteEx3">
                                                        <Animations>
                                                        <OnShow>
                                                            <Sequence>
                                                                <%-- Make the completion list transparent and then show it --%>
                                                                <OpacityAction Opacity="0" />
                                                                <HideAction Visible="true" />
                            
                                                                <%--Cache the original size of the completion list the first time
                                                                    the animation is played and then set it to zero --%>
                                                                <ScriptAction Script="
                                                                    // Cache the size and setup the initial size
                                                                    var behavior = $find('AutoCompleteEx');
                                                                    if (!behavior._height) {
                                                                        var target = behavior.get_completionList();
                                                                        behavior._height = target.offsetHeight - 2;
                                                                        target.style.height = '0px';
                                                                    }" />
                            
                                                                <%-- Expand from 0px to the appropriate size while fading in --%>
                                                                <Parallel Duration=".4">
                                                                    <FadeIn />
                                                                    <Length PropertyKey="height" StartValue="0" EndValueScript="$find('AutoCompleteEx3')._height" />
                                                                </Parallel>
                                                            </Sequence>
                                                        </OnShow>
                                                        <OnHide>
                                                            <%-- Collapse down to 0px and fade out --%>
                                                            <Parallel Duration="0">
                                                                <FadeOut />
                                                                <Length PropertyKey="height" StartValueScript="$find('AutoCompleteEx3')._height" EndValue="0" />
                                                            </Parallel>
                                                        </OnHide>
                                                    </Animations>
                                        </ajaxToolkit:AutoCompleteExtender>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblClientID" runat="server" Text='<%# bind("ClientName") %>'></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            TSDF</td>
                                        <td>
                                            <asp:TextBox ID="txbTSDFName" Width="250px" runat="server" Text='<%# bind("TSDFName") %>' OnTextChanged="txbTSDFName_OnTextChanged"  AutoPostBack="true"></asp:TextBox>
                                                <ajaxToolkit:AutoCompleteExtender
                                                    ID="txbTSDFName_AutoCompleteExtender" 
                                                    runat="server"
                                                    Enabled="True"
                                                    CompletionInterval="250"
                                                    TargetControlID="txbTSDFName"
                                                    ServicePath="myAutoComplete.asmx"
                                                    ServiceMethod="GetTSDFName"
                                                    MinimumPrefixLength="1"
                                                    EnableCaching="true"
                                                    CompletionSetCount="5"
                                                    CompletionListCssClass="autocomplete_completionListElement" 
                                                    CompletionListItemCssClass="autocomplete_listItem" 
                                                    CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                                                    DelimiterCharacters=";, :"
                                                    ShowOnlyCurrentWordInCompletionListItem="true"
                                                    BehaviorID="AutoCompleteEx4">
                                                        <Animations>
                                                        <OnShow>
                                                            <Sequence>
                                                                <%-- Make the completion list transparent and then show it --%>
                                                                <OpacityAction Opacity="0" />
                                                                <HideAction Visible="true" />
                            
                                                                <%--Cache the original size of the completion list the first time
                                                                    the animation is played and then set it to zero --%>
                                                                <ScriptAction Script="
                                                                    // Cache the size and setup the initial size
                                                                    var behavior = $find('AutoCompleteEx');
                                                                    if (!behavior._height) {
                                                                        var target = behavior.get_completionList();
                                                                        behavior._height = target.offsetHeight - 2;
                                                                        target.style.height = '0px';
                                                                    }" />
                            
                                                                <%-- Expand from 0px to the appropriate size while fading in --%>
                                                                <Parallel Duration=".4">
                                                                    <FadeIn />
                                                                    <Length PropertyKey="height" StartValue="0" EndValueScript="$find('AutoCompleteEx4')._height" />
                                                                </Parallel>
                                                            </Sequence>
                                                        </OnShow>
                                                        <OnHide>
                                                            <%-- Collapse down to 0px and fade out --%>
                                                            <Parallel Duration="0">
                                                                <FadeOut />
                                                                <Length PropertyKey="height" StartValueScript="$find('AutoCompleteEx4')._height" EndValue="0" />
                                                            </Parallel>
                                                        </OnHide>
                                                    </Animations>
                                        </ajaxToolkit:AutoCompleteExtender>
                                        </td>
                                        <td>
                                        <asp:Label ID="lblTSDFid" runat="server" Text='<%# bind("TSDF") %>'></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Ship Date</td>
                                        <td>
                                            <asp:TextBox ID="txbShipDate" Width="250px" runat="server" Text='<%# bind("ShipDate") %>'></asp:TextBox>
                                            <ajaxToolKit:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txbShipDate" />

                                        </td>
                                        <td>
                                        
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Carrier</td>
                                        <td>
                                                <asp:TextBox ID="txbCarrierName" Width="250px" runat="server" Text='<%# bind("CarrierName") %>' OnTextChanged="txbCarrierName_OnTextChanged"  AutoPostBack="true"></asp:TextBox>
                                                <ajaxToolkit:AutoCompleteExtender
                                                    ID="txbCarrierName_AutoCompleteExtender" 
                                                    runat="server"
                                                    Enabled="True"
                                                    CompletionInterval="250"
                                                    TargetControlID="txbCarrierName"
                                                    ServicePath="myAutoComplete.asmx"
                                                    ServiceMethod="GetCarrierName"
                                                    MinimumPrefixLength="1"
                                                    EnableCaching="true"
                                                    CompletionSetCount="5"
                                                    CompletionListCssClass="autocomplete_completionListElement" 
                                                    CompletionListItemCssClass="autocomplete_listItem" 
                                                    CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                                                    DelimiterCharacters=";, :"
                                                    ShowOnlyCurrentWordInCompletionListItem="true"
                                                    BehaviorID="AutoCompleteEx5">
                                                        <Animations>
                                                        <OnShow>
                                                            <Sequence>
                                                                <%-- Make the completion list transparent and then show it --%>
                                                                <OpacityAction Opacity="0" />
                                                                <HideAction Visible="true" />
                            
                                                                <%--Cache the original size of the completion list the first time
                                                                    the animation is played and then set it to zero --%>
                                                                <ScriptAction Script="
                                                                    // Cache the size and setup the initial size
                                                                    var behavior = $find('AutoCompleteEx');
                                                                    if (!behavior._height) {
                                                                        var target = behavior.get_completionList();
                                                                        behavior._height = target.offsetHeight - 2;
                                                                        target.style.height = '0px';
                                                                    }" />
                            
                                                                <%-- Expand from 0px to the appropriate size while fading in --%>
                                                                <Parallel Duration=".4">
                                                                    <FadeIn />
                                                                    <Length PropertyKey="height" StartValue="0" EndValueScript="$find('AutoCompleteEx5')._height" />
                                                                </Parallel>
                                                            </Sequence>
                                                        </OnShow>
                                                        <OnHide>
                                                            <%-- Collapse down to 0px and fade out --%>
                                                            <Parallel Duration="0">
                                                                <FadeOut />
                                                                <Length PropertyKey="height" StartValueScript="$find('AutoCompleteEx5')._height" EndValue="0" />
                                                            </Parallel>
                                                        </OnHide>
                                                    </Animations>
                                        </ajaxToolkit:AutoCompleteExtender>
                                        </td>
                                        <td>
                                        <asp:Label ID="lblCarrierID" runat="server" Text='<%# bind("carrier") %>'></asp:Label> 
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Trailer Number</td>
                                        <td>
                                            <asp:TextBox ID="txbTrailerNum" Width="250px" runat="server" Text='<%# bind("Trailer_Number") %>'></asp:TextBox>
                                        </td>
                                        <td>
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Receive Dock</td>
                                        <td>
                                            <asp:DropDownList ID="DropDownList4" Width="250px" runat="server" Text='<%# bind("ReceiveDock") %>'>
                                                <asp:ListItem Text="Select..." Value="" />
                                                <asp:ListItem>33</asp:ListItem>
                                                <asp:ListItem>34</asp:ListItem>
                                                <asp:ListItem>35</asp:ListItem>
                                                <asp:ListItem>36</asp:ListItem>
                                                <asp:ListItem>37</asp:ListItem>
                                                <asp:ListItem>SuiteA</asp:ListItem>
                                                <asp:ListItem>Other</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td>
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Receive Date</td>
                                        <td>
                                            <asp:TextBox ID="txbRcvDate" Width="250px" runat="server" Text='<%# bind("ReceiveDate") %>'></asp:TextBox>
                                            <ajaxToolKit:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txbRcvDate" />
                                        </td>
                                        <td>
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Received By</td>
                                        <td>
                                            <asp:DropDownList ID="DropDownList5" Width="250px" runat="server" DataSourceID="sdsGetUsers" 
                                                 SelectedValue='<%# bind("ReceivedBy") %>' DataTextField="Name" 
                                                DataValueField="Name" AppendDataBoundItems="True">
                                                    <asp:ListItem Text="Select..." Value = "" />
                                            </asp:DropDownList>
                                            <asp:SqlDataSource ID="sdsGetUsers" runat="server" 
                                                ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
                                                SelectCommand="IMDB_Rcv_User_Sel" SelectCommandType="StoredProcedure">
                                            </asp:SqlDataSource>
                                        </td>
                                        <td>
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;</td>
                                        <td>
                                            &nbsp;</td>
                                        <td>
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;</td>
                                        <td>
                                            &nbsp;</td>
                                        <td>
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;</td>
                                        <td>
                                            &nbsp;</td>
                                        <td>
                                            &nbsp;</td>
                                    </tr>
                                </table>                            
                            
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:CommandField ShowInsertButton="True" ShowEditButton="True" />
                   </Fields>
                 </asp:DetailsView>
                    </ContentTemplate>
               </asp:UpdatePanel>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="sdsHdrList" runat="server" 
        ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
        SelectCommand="IMDB_Rcv_Hdr_Sel" SelectCommandType="StoredProcedure"
        OnSelecting ="sdsHdrList_OnSelecting">
        <SelectParameters>
            <asp:sessionparameter Name = "OrderNum" SessionField="CurOrderNum" DefaultValue = "null" Type="String" />
            <asp:SessionParameter Name="RcvHdrID"  SessionField="CurRcvHrdID" DefaultValue="0" Type="Int32" />
            <asp:SessionParameter Name="ClientName"  SessionField="CurClientName" DefaultValue="null" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsRcvDetail_Sel" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
                    SelectCommand="IMDB_Rcv_Detail_Sel" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="label2" 
                            Name="InboundDocNo" PropertyName="Text" Type="string" />
                    </SelectParameters>
                </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsRcvInboundDocs_Sel" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
                    SelectCommand="IMDB_Rcv_InboundDoc_Sel" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="gvSearchResults" Name="RcvHdrID" 
                            PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsAddTruck" runat="server" 
        ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" SelectCommand="IMDB_test" 
        SelectCommandType="StoredProcedure" InsertCommand="IMDB_Rcv_Hdr_Ins" InsertCommandType="StoredProcedure"> 
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
        OldValuesParameterFormatString="original_{0}" 
        SelectCommand="Select c.name,v.vendorname as TSDFname,v2.vendorname as CarrierName,r.id,r.OrderNumber,r.WorkOrder,r.ClientName,r.TSDF,r.ReceivedBy,r.ReceiveDate,r.ReceiveDock,r.Carrier,r.[Trailer Number] as Trailer_Number,r.ShipDate,r.Memo,r.ModDate,r.Username From dbo.RcvHdr r left join dbo.client c on c.id = r.ClientName	left join dbo.vendorlist v on v.id = r.carrier left join dbo.vendorlist v2 on v2.id = r.TSDF Where (r.id = @RcvHdrID)"
        ConflictDetection="CompareAllValues" 
        DeleteCommand="DELETE FROM [RcvHdr] WHERE [ID] = @original_ID AND [OrderNumber] = @original_OrderNumber AND (([WorkOrder] = @original_WorkOrder) OR ([WorkOrder] IS NULL AND @original_WorkOrder IS NULL)) AND (([ClientName] = @original_ClientName) OR ([ClientName] IS NULL AND @original_ClientName IS NULL)) AND (([TSDF] = @original_TSDF) OR ([TSDF] IS NULL AND @original_TSDF IS NULL)) AND (([ReceivedBy] = @original_ReceivedBy) OR ([ReceivedBy] IS NULL AND @original_ReceivedBy IS NULL)) AND (([ReceiveDate] = @original_ReceiveDate) OR ([ReceiveDate] IS NULL AND @original_ReceiveDate IS NULL)) AND (([ReceiveDock] = @original_ReceiveDock) OR ([ReceiveDock] IS NULL AND @original_ReceiveDock IS NULL)) AND (([Carrier] = @original_Carrier) OR ([Carrier] IS NULL AND @original_Carrier IS NULL)) AND (([Trailer Number] = @original_Trailer_Number) OR ([Trailer Number] IS NULL AND @original_Trailer_Number IS NULL)) AND (([ShipDate] = @original_ShipDate) OR ([ShipDate] IS NULL AND @original_ShipDate IS NULL)) AND (([Memo] = @original_Memo) OR ([Memo] IS NULL AND @original_Memo IS NULL)) AND (([ModDate] = @original_ModDate) OR ([ModDate] IS NULL AND @original_ModDate IS NULL)) AND (([UserName] = @original_UserName) OR ([UserName] IS NULL AND @original_UserName IS NULL))" 
        InsertCommand="INSERT INTO [RcvHdr] ([OrderNumber], [WorkOrder], [ClientName], [TSDF], [ReceivedBy], [ReceiveDate], [ReceiveDock], [Carrier], [Trailer Number], [ShipDate], [Memo], [ModDate], [UserName]) VALUES (@OrderNumber, @WorkOrder, @ClientName, @TSDF, @ReceivedBy, @ReceiveDate, @ReceiveDock, @Carrier, @Trailer_Number, @ShipDate, @Memo, @ModDate, @UserName); Select @ID=Scope_Identity();" 
        oninserted="SqlDataSource1_Inserted"
        UpdateCommand="UPDATE [RcvHdr] SET [OrderNumber] = @OrderNumber, [WorkOrder] = @WorkOrder, [ClientName] = @ClientName, [TSDF] = @TSDF, [ReceivedBy] = @ReceivedBy, [ReceiveDate] = @ReceiveDate, [ReceiveDock] = @ReceiveDock, [Carrier] = @Carrier, [Trailer Number] = @Trailer_Number, [ShipDate] = @ShipDate, [Memo] = @Memo, [ModDate] = @ModDate, [UserName] = @UserName WHERE [ID] = @Original_id"
        onupdated="SqlDataSource1_Updated">
        <SelectParameters>
            <asp:SessionParameter Name="RcvHdrID"  SessionField="CurRcvHrdID" DefaultValue="0" Type="Int32" />
        </SelectParameters>
        
        <DeleteParameters>
            <asp:Parameter Name="original_ID" Type="Int32" />
            <asp:Parameter Name="original_OrderNumber" Type="String" />
            <asp:Parameter Name="original_WorkOrder" Type="Int32" />
            <asp:Parameter Name="original_ClientName" Type="Int32" />
            <asp:Parameter Name="original_TSDF" Type="Int32" />
            <asp:Parameter Name="original_ReceivedBy" Type="String" />
            <asp:Parameter Name="original_ReceiveDate" Type="DateTime" />
            <asp:Parameter Name="original_ReceiveDock" Type="String" />
            <asp:Parameter Name="original_Carrier" Type="Int32" />
            <asp:Parameter Name="original_Trailer_Number" Type="String" />
            <asp:Parameter Name="original_ShipDate" Type="DateTime" />
            <asp:Parameter Name="original_Memo" Type="String" />
            <asp:Parameter Name="original_ModDate" Type="DateTime" />
            <asp:Parameter Name="original_UserName" Type="String" />
        </DeleteParameters>
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
            <asp:Parameter Name="ModDate" Type="DateTime" />
            <asp:Parameter Name="UserName" Type="String" />
            <asp:parameter direction="Output" name="ID" type="Int32" />
        </InsertParameters>
        <UpdateParameters>
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
            <asp:Parameter Name="ModDate" Type="DateTime" />
            <asp:Parameter Name="UserName" Type="String" />
            <asp:Parameter Name="original_ID" Type="Int32" />
        </UpdateParameters>

    </asp:SqlDataSource>
</asp:Content>    

<asp:Content ID="Content3" ContentPlaceHolderID="Clear" runat="server"> 
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="Footer" runat="server">
</asp:Content>
