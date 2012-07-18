<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Receiving.aspx.cs" Inherits="IMDBWeb.Secure.SPAKpages.Receiving" EnableEventValidation="false"%>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" tagprefix="ajaxToolkit"%>


<asp:Content
    ID="Content1"
    ContentPlaceHolderID="HeadContent"
    runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <table class="ui-accordion">
        <tr runat="server" id="trOrder">
            <td width="100px">
                Order Number:
            </td>
            <td width="300px">
                <asp:TextBox
                    ID="txbOrderNum"
                    runat="server"  
                    OnTextChanged="txbOrderNum_OnTextChanged"
                    AutoPostBack="true"
                    Width="250px"></asp:TextBox>
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
            <td>
                <asp:Button ID="btnNewTruck" runat="server" Text="New Truck" onclick="btnNewTruck_Click" />
            </td>
        </tr>
        <tr runat="server" id="trClient">
            <td width="100px">
                Client:
            </td>
            <td width="300px">
                <asp:TextBox
                    ID="txbClientName"
                    runat="server"  
                    OnTextChanged="txbClientName_OnTextChanged"
                    AutoPostBack="true"
                    Width="250px"></asp:TextBox>
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
            <td>
                <asp:Button ID="btnClear" runat="server" Text="Clear" onclick="btnClear_Click"/>            
            </td>
        </tr>
    </table>
    <table class="ui-accordion">
        <tr>
            <td>
                <asp:UpdatePanel ID="upHdrList" runat="server" UpdateMode="always">
                    <ContentTemplate>
                        <asp:GridView
                            ID="gvHdrList"
                            DataSourceID="sdsHdrList"
                            DataKeyNames="id"
                            OnSelectedIndexChanged="gvHdrList_SelectedIndexChanged"
                            OnRowDataBound="gvHdrList_RowDataBound"
                            AutoGenerateColumns="False" 
                            AllowPaging="True"  
                            AllowSorting="True"
                            CellPadding="4"
                            ForeColor="#333333"
                            GridLines="Horizontal"
                            SelectedRowStyle-BackColor = "#ffff99"
                            runat="server">
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
                            <asp:SqlDataSource
                                ID="sdsHdrList"
                                runat="server" 
                                ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
                                SelectCommand="IMDB_Rcv_Hdr_Sel" SelectCommandType="StoredProcedure"
                                OnSelecting ="sdsHdrList_OnSelecting">
                                    <SelectParameters>
                                        <asp:sessionparameter Name = "OrderNum" SessionField="CurOrderNum" DefaultValue = "null" Type="String" />
                                        <asp:SessionParameter Name="RcvHdrID"  SessionField="CurRcvHrdID" DefaultValue="0" Type="Int32" />
                                        <asp:SessionParameter Name="ClientName"  SessionField="CurClientName" DefaultValue="null" Type="String" />
                                    </SelectParameters>
                            </asp:SqlDataSource>

                        <asp:Label ID="Label1" runat="server" Visible="true"></asp:Label>
                    <asp:Label ID="Label3" runat="server" Visible="true" Font-Bold="True" ForeColor="Red"></asp:Label>
                        <asp:Label ID="label2" runat="server" Visible="true" Font-Bold="True" ForeColor="Red"></asp:Label>
                    
                    </ContentTemplate>
                </asp:UpdatePanel>
                
                <asp:UpdatePanel ID="upDocList" runat="server">
                    <ContentTemplate>
                    <asp:Button ID="btnAddDoc" Visible="false" runat="server" Text="New Inbound Doc" onclick="btnAddDoc_Click" />
                        <asp:GridView
                            Width="45%"
                            AllowPaging="True"
                            ID="gvSubCatDocs"
                            AutoGenerateColumns="False"
                            GridLines="None"
                            DataSourceID="sdsSubCatDocs"
                            runat="server"
                            ShowHeader="False"
                            OnRowCreated="gvSubCatDocs_RowCreated"
                            DataKeyNames="InboundDocNo">
                            <Columns>
                                <asp:TemplateField>
                                    <ItemStyle Width="200px" />
                                    <ItemTemplate>
                                        <asp:Panel ID="pnlSubCatDocs" runat="server">
                                            <asp:Image ID="imgCollapsible" Style="margin-right: 5px;" runat="server" />
                                            <span style="font-weight:bold">Inbound Doc Number: <%#Eval("InboundDocNo")%></span>
                                            Click <asp:LinkButton ID='lbAddContainer' runat="server" onclick="btnAddContainer_Click" Text='<%#Eval("InboundDocNo")%>'></asp:LinkButton> to Add New Container
                                         </asp:Panel>
                                        <asp:Panel ID="pnlContainerList" runat="server" Width="75%">
                                            <asp:GridView
                                                ID="gvContainerList"
                                                DataSourceID="sdsContainerList"  
                                                DataKeyNames="ID" 
                                                Onrowcommand="gvContainerList_RowCommand"
                                                AutoGenerateColumns="False"
                                                HorizontalAlign="Center"
                                                runat="server">
                                                <Columns>
                                                    <asp:templatefield>
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lbEditDetail" runat="server" CommandName="EditDetail" CommandArgument='<%# Eval("id") %>'>Edit</asp:LinkButton>
                                                        <asp:LinkButton ID="lblDupeDetail" runat="server" CommandName="DupeDetail" CommandArgument='<%# Eval("id") %>'>Duplicate</asp:LinkButton>
                                                    </ItemTemplate>
                                                        <ItemStyle Font-Size="XX-Small" HorizontalAlign="Center" VerticalAlign="Middle" />
                                                    </asp:templatefield>
                                                    <asp:BoundField DataField="InboundDocNo" HeaderText="Doc No" SortExpression="InboundDocNo" />
                                                    <asp:BoundField DataField="ManifestLineNumber" HeaderText="Line Number" SortExpression="ManifestLineNumber" />
                                                    <asp:BoundField DataField="name" HeaderText="Profile" SortExpression="name" />
                                                    <asp:BoundField DataField="InboundContainerType" HeaderText="Container Type" SortExpression="InboundContainerType" />
                                                    <asp:BoundField DataField="InboundPalletType" HeaderText="Pallet Type" SortExpression="InboundPalletType" />
                                                    <asp:BoundField DataField="InboundPalletWeight" HeaderText="Pallet Weight" SortExpression="InboundPalletWeight" />
                                                    <asp:BoundField DataField="InboundContainerQty" HeaderText="Container Qty" SortExpression="InboundContainerQty" />
                                                    <asp:BoundField DataField="InboundContainerID" HeaderText="Container ID" SortExpression="InboundContainerID" />
                                                    <asp:BoundField DataField="InventoryLocation" HeaderText="Inventory Location" SortExpression="InventoryLocation" />
                                                    <asp:BoundField DataField="BCName" HeaderText="Brand Code" SortExpression="BCName" />
                                                    <asp:CheckBoxField DataField="Process?" HeaderText="Process?" SortExpression="Process?" />
                                                    <asp:BoundField DataField="ProcessPlan" HeaderText="Process Plan" SortExpression="ProcessPlan" />
                                                    <asp:BoundField DataField="RcvdAs" HeaderText="Rcvd As" SortExpression="RcvdAs" />
                                                    <asp:CommandField ShowDeleteButton="True" >
                                                        <ItemStyle Font-Size="XX-Small" />
                                                    </asp:CommandField>
                                                </Columns>
                                             </asp:GridView>
                                            <asp:SqlDataSource
                                                ID="sdsContainerList"
                                                runat="server" 
                                                ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
                                                SelectCommand="IMDB_Rcv_Detail_Sel"
                                                SelectCommandType="StoredProcedure"
                                                DeleteCommand="DELETE FROM [RcvDetail] WHERE [ID] = @ID"
                                                OnDeleted="sdsContainerList_Ondeleted">
                                                <SelectParameters>
                                                    <asp:Parameter Name="InboundDocNo" Type="String" DefaultValue="" />
                                                    <asp:SessionParameter Name="RcvHdrID" SessionField="CurRcvHrdID" Type="Int32" />
                                                </SelectParameters>
                                                <DeleteParameters>
                                                    <asp:SessionParameter DefaultValue="0" Name="ID" SessionField="CurDetailID" Type="Int32" />
                                                 </DeleteParameters>
                                            </asp:SqlDataSource>
                                        </asp:Panel>
                                            <ajaxtoolkit:CollapsiblePanelExtender
                                                ID="ctlCollapsiblePanel"
                                                runat="Server"
                                                TargetControlID="pnlContainerList"
                                                CollapsedSize="0" Collapsed="True"
                                                ExpandControlID="pnlSubCatDocs"
                                                CollapseControlID="pnlSubCatDocs"
                                                AutoCollapse="false"
                                                AutoExpand="false"
                                                ScrollContents="false"
                                                ImageControlID="imgCollapsible"
                                                ExpandedImage="~/images/collapse.gif"
                                                CollapsedImage="~/images/expand.gif"
                                                ExpandDirection="Vertical"
                                                SuppressPostBack="false"/>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource
                            ID="sdsSubCatDocs"
                            runat="server"
                            ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>"
                            SelectCommand="Select Distinct InboundDocNo from RcvDetail where RcvHdrID = @RcvHdrID">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="gvHdrList" Name="RcvHdrID" PropertyName="SelectedValue" Type="Int32" />
                                </SelectParameters>
                        </asp:SqlDataSource>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr>
            <td>
                <asp:UpdatePanel ID="upHdrDetail" runat="server">
                    <ContentTemplate>
                        <asp:DetailsView
                            ID="dvHdrDetail"
                            DataSourceID="sdsHdrDetail"
                            DataKeyNames="id"
                            OnItemCommand="dvHdrDetail_ItemCommand"
                            Defaultmode="Insert"
                            Visible="false"
                            AutoGenerateRows="False"
                            Height="50px"
                            Width="400px"
                            runat="server">
                            <EmptyDataTemplate>
                                No Data
                            </EmptyDataTemplate>
                                <Fields>
                                    <asp:TemplateField>
                                        <InsertItemTemplate>
                                            <table class="ui-accordion">
                                                <tr>
                                                    <td>Order Number</td>
                                                    <td>
                                                        <asp:TextBox
                                                            ID="txbOrderNumber"
                                                            Width="250px"
                                                            runat="server"
                                                            Text='<%# bind("OrderNumber") %>'></asp:TextBox>
                                                    </td>
                                                    <td>&nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td>Work Order</td>
                                                    <td>
                                                        <asp:TextBox
                                                            ID="txbWorkOrder"
                                                            Width="250px"
                                                            runat="server"
                                                            Text='<%# bind("WorkOrder") %>'></asp:TextBox>
                                                    </td>
                                                    <td>&nbsp;</td>
                                                </tr>
                                                            <tr>
                                                    <td>Client</td>
                                                    <td>
                                                        <asp:TextBox
                                                            ID="txbClientName2"
                                                            Width="250px"
                                                            runat="server"
                                                            OnTextChanged="txbClientName2_OnTextChanged" 
                                                            AutoPostBack="true"></asp:TextBox>
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
                                                        <asp:Label
                                                            ID="lblClientID"
                                                            runat="server"
                                                            Text='<%# bind("ClientName") %>'
                                                            Visible="false"></asp:Label>
                                                    </td>
                                                </tr>
                                                            <tr>
                                                    <td>TSDF</td>
                                                    <td>
                                                        <asp:TextBox
                                                            ID="txbTSDFName"
                                                            Width="250px"
                                                            runat="server"
                                                            OnTextChanged="txbTSDFName_OnTextChanged" 
                                                            AutoPostBack="true"></asp:TextBox>
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
                                                        <asp:Label
                                                            ID="lblTSDFid"
                                                            runat="server"
                                                            Text='<%# bind("TSDF") %>'
                                                            Visible="false"></asp:Label>
                                                    </td>
                                                </tr>
                                                            <tr>
                                                    <td>Ship Date</td>
                                                    <td>
                                                        <asp:TextBox
                                                            ID="txbShipDate"
                                                            Width="250px"
                                                            runat="server"
                                                            Text='<%# bind("ShipDate") %>'></asp:TextBox>
                                                            <ajaxToolKit:CalendarExtender
                                                            ID="CalendarExtender1"
                                                            runat="server"
                                                            TargetControlID="txbShipDate" />
                                                    </td>
                                                    <td>&nbsp;</td>
                                                </tr>
                                                            <tr>
                                                    <td>Carrier</td>
                                                    <td>
                                                         <asp:TextBox
                                                            ID="txbCarrierName"
                                                            Width="250px"
                                                            runat="server"
                                                            OnTextChanged="txbCarrierName_OnTextChanged"
                                                            AutoPostBack="true"></asp:TextBox>
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
                                                        <asp:Label
                                                            ID="lblCarrierID"
                                                            runat="server"
                                                            Text='<%# bind("carrier") %>'
                                                            Visible="false"></asp:Label> 
                                                    </td>
                                                </tr>
                                                            <tr>
                                                    <td>Trailer Number</td>
                                                    <td>
                                                        <asp:TextBox
                                                            ID="txbTrailerNum"
                                                            Width="250px"
                                                            runat="server"
                                                            Text='<%# bind("Trailer_Number") %>'></asp:TextBox>
                                                    </td>
                                                    <td>&nbsp;</td>
                                                </tr>
                                                            <tr>
                                                    <td>Receive Dock</td>
                                                    <td>
                                                        <asp:DropDownList
                                                            ID="DropDownList4"
                                                            Width="250px"
                                                            runat="server"
                                                            Text='<%# bind("ReceiveDock") %>'>
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
                                                    <td>&nbsp;</td>
                                                </tr>
                                                            <tr>
                                                    <td>Receive Date</td>
                                                    <td>
                                                        <asp:TextBox
                                                            ID="txbRcvDate"
                                                            Width="250px"
                                                            runat="server"
                                                            Text='<%# bind("ReceiveDate") %>'></asp:TextBox>
                                                            <ajaxToolKit:CalendarExtender
                                                                ID="CalendarExtender2"
                                                                runat="server"
                                                                TargetControlID="txbRcvDate" />
                                                    </td>
                                                    <td>&nbsp;</td>
                                                </tr>
                                                            <tr>
                                                    <td>Received By</td>
                                                    <td>
                                                        <asp:DropDownList
                                                            ID="DropDownList5"
                                                            Width="250px"
                                                            runat="server"
                                                            DataSourceID="sdsGetUsers" 
                                                            SelectedValue='<%# bind("ReceivedBy") %>'
                                                            DataTextField="Name" 
                                                            DataValueField="Name"
                                                            AppendDataBoundItems="True">
                                                                <asp:ListItem Text="Select..." Value = "" />
                                                        </asp:DropDownList>
                                                        <asp:SqlDataSource
                                                            ID="sdsGetUsers"
                                                            runat="server" 
                                                            ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
                                                            SelectCommand="IMDB_Rcv_User_Sel"
                                                            SelectCommandType="StoredProcedure">
                                                        </asp:SqlDataSource>
                                                    </td>
                                                    <td>&nbsp;</td>
                                                </tr>
                                                            <tr>
                                                    <td>&nbsp;</td>
                                                    <td>&nbsp;</td>
                                                    <td>&nbsp;</td>
                                                </tr>
                                                        </table>
                                        </InsertItemTemplate>
                                        <EditItemTemplate>
                                            <table class="ui-accordion">
                                    <tr>
                                        <td>Order Number</td>
                                        <td>
                                            <asp:TextBox
                                                ID="txbOrderNumber"
                                                Width="250px"
                                                runat="server"
                                                Text='<%# bind("OrderNumber") %>'></asp:TextBox>
                                        </td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>Work Order</td>
                                        <td>
                                            <asp:TextBox
                                                ID="txbWorkOrder"
                                                Width="250px"
                                                runat="server"
                                                Text='<%# bind("WorkOrder") %>'></asp:TextBox>
                                        </td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>Client</td>
                                        <td>
                                            <asp:TextBox
                                                ID="txbClientName2"
                                                Width="250px"
                                                runat="server"
                                                OnTextChanged="txbClientName2_OnTextChanged" 
                                                AutoPostBack="true"
                                                Text='<%# bind("name") %>'></asp:TextBox>
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
                                            <asp:Label
                                                ID="lblClientID"
                                                runat="server"
                                                Text='<%# bind("ClientName") %>'
                                                Visible="false"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>TSDF</td>
                                        <td>
                                            <asp:TextBox
                                                ID="txbTSDFName"
                                                Width="250px"
                                                runat="server"
                                                OnTextChanged="txbTSDFName_OnTextChanged" 
                                                AutoPostBack="true"
                                                Text='<%# bind("TSDFName") %>'></asp:TextBox>
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
                                            <asp:Label
                                                ID="lblTSDFid"
                                                runat="server"
                                                Text='<%# bind("TSDF") %>'
                                                Visible="false"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Ship Date</td>
                                        <td>
                                            <asp:TextBox
                                                ID="txbShipDate"
                                                Width="250px"
                                                runat="server"
                                                Text='<%# bind("ShipDate") %>'></asp:TextBox>
                                                <ajaxToolKit:CalendarExtender
                                                    ID="CalendarExtender1"
                                                    runat="server"
                                                    TargetControlID="txbShipDate" />
                                        </td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>Carrier</td>
                                        <td>
                                             <asp:TextBox
                                                ID="txbCarrierName"
                                                Width="250px"
                                                runat="server"
                                                OnTextChanged="txbCarrierName_OnTextChanged"
                                                AutoPostBack="true"
                                                Text='<%# bind("CarrierName") %>'></asp:TextBox>
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
                                            <asp:Label
                                                ID="lblCarrierID"
                                                runat="server"
                                                Text='<%# bind("carrier") %>'
                                                Visible="false"></asp:Label> 
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Trailer Number</td>
                                        <td>
                                            <asp:TextBox
                                                ID="txbTrailerNum"
                                                Width="250px"
                                                runat="server"
                                                Text='<%# bind("Trailer_Number") %>'></asp:TextBox>
                                        </td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>Receive Dock</td>
                                        <td>
                                            <asp:DropDownList
                                                ID="DropDownList4"
                                                Width="250px"
                                                runat="server"
                                                Text='<%# bind("ReceiveDock") %>'>
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
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>Receive Date</td>
                                        <td>
                                            <asp:TextBox
                                                ID="txbRcvDate"
                                                Width="250px"
                                                runat="server"
                                                Text='<%# bind("ReceiveDate") %>'></asp:TextBox>
                                                <ajaxToolKit:CalendarExtender
                                                    ID="CalendarExtender2"
                                                    runat="server"
                                                    TargetControlID="txbRcvDate" />
                                        </td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>Received By</td>
                                        <td>
                                            <asp:DropDownList
                                                ID="DropDownList5"
                                                Width="250px"
                                                runat="server"
                                                DataSourceID="sdsGetUsers" 
                                                SelectedValue='<%# bind("ReceivedBy") %>'
                                                DataTextField="Name" 
                                                DataValueField="Name"
                                                AppendDataBoundItems="True">
                                                    <asp:ListItem Text="Select..." Value = "" />
                                            </asp:DropDownList>
                                            <asp:SqlDataSource
                                                ID="sdsGetUsers"
                                                runat="server" 
                                                ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
                                                SelectCommand="IMDB_Rcv_User_Sel"
                                                SelectCommandType="StoredProcedure">
                                            </asp:SqlDataSource>
                                        </td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                </table>                           
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <table class="ui-accordion">
                                    <tr>
                                        <td>Order Number</td>
                                        <td>
                                            <asp:TextBox
                                                ID="txbOrderNumber"
                                                Width="250px"
                                                runat="server"
                                                Text='<%# bind("OrderNumber") %>'></asp:TextBox>
                                        </td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>Work Order</td>
                                        <td>
                                            <asp:TextBox
                                                ID="txbWorkOrder"
                                                Width="250px"
                                                runat="server"
                                                Text='<%# bind("WorkOrder") %>'></asp:TextBox>
                                        </td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>Client</td>
                                        <td>
                                            <asp:TextBox
                                                ID="txbClientName2"
                                                Width="250px"
                                                runat="server"
                                                OnTextChanged="txbClientName2_OnTextChanged" 
                                                AutoPostBack="true"
                                                Text='<%# bind("name") %>'></asp:TextBox>
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
                                            <asp:Label
                                                ID="lblClientID"
                                                runat="server"
                                                Text='<%# bind("ClientName") %>'
                                                Visible="false"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>TSDF</td>
                                        <td>
                                            <asp:TextBox
                                                ID="txbTSDFName"
                                                Width="250px"
                                                runat="server"
                                                OnTextChanged="txbTSDFName_OnTextChanged" 
                                                AutoPostBack="true"
                                                Text='<%# bind("TSDFName") %>'></asp:TextBox>
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
                                            <asp:Label
                                                ID="lblTSDFid"
                                                runat="server"
                                                Text='<%# bind("TSDF") %>'
                                                Visible="false"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Ship Date</td>
                                        <td>
                                            <asp:TextBox
                                                ID="txbShipDate"
                                                Width="250px"
                                                runat="server"
                                                Text='<%# bind("ShipDate") %>'></asp:TextBox>
                                                <ajaxToolKit:CalendarExtender
                                                    ID="CalendarExtender1"
                                                    runat="server"
                                                    TargetControlID="txbShipDate" />
                                        </td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>Carrier</td>
                                        <td>
                                             <asp:TextBox
                                                ID="txbCarrierName"
                                                Width="250px"
                                                runat="server"
                                                OnTextChanged="txbCarrierName_OnTextChanged"
                                                AutoPostBack="true"
                                                Text='<%# bind("CarrierName") %>'></asp:TextBox>
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
                                            <asp:Label
                                                ID="lblCarrierID"
                                                runat="server"
                                                Text='<%# bind("carrier") %>'
                                                Visible="false"></asp:Label> 
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Trailer Number</td>
                                        <td>
                                            <asp:TextBox
                                                ID="txbTrailerNum"
                                                Width="250px"
                                                runat="server"
                                                Text='<%# bind("Trailer_Number") %>'></asp:TextBox>
                                        </td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>Receive Dock</td>
                                        <td>
                                            <asp:DropDownList
                                                ID="DropDownList4"
                                                Width="250px"
                                                runat="server"
                                                Text='<%# bind("ReceiveDock") %>'>
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
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>Receive Date</td>
                                        <td>
                                            <asp:TextBox
                                                ID="txbRcvDate"
                                                Width="250px"
                                                runat="server"
                                                Text='<%# bind("ReceiveDate") %>'></asp:TextBox>
                                                <ajaxToolKit:CalendarExtender
                                                    ID="CalendarExtender2"
                                                    runat="server"
                                                    TargetControlID="txbRcvDate" />
                                        </td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>Received By</td>
                                        <td>
                                            <asp:DropDownList
                                                ID="DropDownList5"
                                                Width="250px"
                                                runat="server"
                                                DataSourceID="sdsGetUsers" 
                                                SelectedValue='<%# bind("ReceivedBy") %>'
                                                DataTextField="Name" 
                                                DataValueField="Name"
                                                AppendDataBoundItems="True">
                                                    <asp:ListItem Text="Select..." Value = "" />
                                            </asp:DropDownList>
                                            <asp:SqlDataSource
                                                ID="sdsGetUsers"
                                                runat="server" 
                                                ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
                                                SelectCommand="IMDB_Rcv_User_Sel"
                                                SelectCommandType="StoredProcedure">
                                            </asp:SqlDataSource>
                                        </td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                </table>                             
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:CommandField ShowInsertButton="True" ShowEditButton="True"/>
                                </Fields>
                            <HeaderTemplate>
                                <asp:Label ID="Label4" runat="server" Text="Enter Truck Information" 
                                    CssClass="detailheader" Font-Bold="True"></asp:Label>
                            </HeaderTemplate>
                        </asp:DetailsView>
                            <asp:SqlDataSource
                                ID="sdsHdrDetail"
                                runat="server" 
                                ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
                                OldValuesParameterFormatString="original_{0}" 
                                SelectCommand="Select c.name,v.vendorname as TSDFname,v2.vendorname as CarrierName,r.id,r.OrderNumber,r.WorkOrder,r.ClientName,r.TSDF,r.ReceivedBy,r.ReceiveDate,r.ReceiveDock,r.Carrier,r.[Trailer Number] as Trailer_Number,r.ShipDate,r.Memo,r.ModDate,r.Username From dbo.RcvHdr r left join dbo.client c on c.id = r.ClientName	left join dbo.vendorlist v on v.id = r.carrier left join dbo.vendorlist v2 on v2.id = r.TSDF Where (r.id = @RcvHdrID)"
                                ConflictDetection="CompareAllValues" 
                                DeleteCommand="DELETE FROM [RcvHdr] WHERE [ID] = @Original_id" 
                                InsertCommand="INSERT INTO [RcvHdr] ([OrderNumber], [WorkOrder], [ClientName], [TSDF], [ReceivedBy], [ReceiveDate], [ReceiveDock], [Carrier], [Trailer Number], [ShipDate], [Memo], [ModDate], [UserName]) VALUES (@OrderNumber, @WorkOrder, @ClientName, @TSDF, @ReceivedBy, @ReceiveDate, @ReceiveDock, @Carrier, @Trailer_Number, @ShipDate, @Memo, getdate(), @UserName); Select @ID=Scope_Identity();" 
                                oninserted="sdsHdrDetail_Inserted"
                                UpdateCommand="UPDATE [RcvHdr] SET [OrderNumber] = @OrderNumber, [WorkOrder] = @WorkOrder, [ClientName] = @ClientName, [TSDF] = @TSDF, [ReceivedBy] = @ReceivedBy, [ReceiveDate] = @ReceiveDate, [ReceiveDock] = @ReceiveDock, [Carrier] = @Carrier, [Trailer Number] = @Trailer_Number, [ShipDate] = @ShipDate, [Memo] = @Memo, [ModDate] = getdate(), [UserName] = @UserName WHERE [ID] = @Original_id"
                                onupdated="sdsHdrDetail_Updated"
                                onupdating="sdsHdrDetail_Updating">
                                <SelectParameters>
                                    <asp:SessionParameter Name="RcvHdrID"  SessionField="CurRcvHrdID" DefaultValue="0" Type="Int32" />
                                </SelectParameters>
                                <DeleteParameters>
                                    <asp:Parameter Name="original_ID" Type="Int32" />
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
                                    <asp:Parameter Name="UserName" Type="String" />
                                    <asp:Parameter Name="original_ID" Type="Int32" />
                                </UpdateParameters>
                            </asp:SqlDataSource>
                    </ContentTemplate>
               </asp:UpdatePanel>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Panel runat="Server" ID="pnlContainerDetail" CssClass="PopupPanel" style="display:none">
                    <asp:UpdatePanel ID="upContainerDetail" runat="server">
                    <ContentTemplate>
                         <asp:DetailsView
                                    ID="dvContainerDetail"
                                    runat="server"
                                    AutoGenerateRows="False" 
                                    DataKeyNames="ID"
                                    DataSourceID="sdsContainerDetail"
                                    Height="50px"
                                    Width="400px"
                                    OnItemCommand="dvContainerDetail_ItemCommand"
                                    OnDataBound="dvContainerDetail_OnDataBound">
                                        <Fields>
                                            <asp:TemplateField>
                                                <InsertItemTemplate>
                                                    <table class="ui-accordion">
                                            <tr>
                                                <td>Inbound Doc No.</td>
                                                <td>
                                                    <asp:TextBox
                                                        ID="txbInboundDoc"
                                                        runat="server" 
                                                        Text='<%# bind("InboundDocNo") %>'
                                                        Width="250px"></asp:TextBox>
                                                </td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>Container ID</td>
                                                <td>
                                                    <asp:TextBox
                                                        ID="txbContainerID"
                                                        runat="server" 
                                                        Text='<%# bind("InboundContainerID") %>'
                                                        Width="250px"></asp:TextBox>
                                                </td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>Brand Code</td>
                                                <td>
                                                    <asp:TextBox
                                                        ID="txbBrandCodes"
                                                        runat="server"  
                                                        OnTextChanged="txbBrandCodes_OnTextChanged"
                                                        AutoPostBack="true"
                                                        Width="250px"></asp:TextBox>
                                                        <ajaxToolkit:AutoCompleteExtender
                                                            ID="txbBrandCodes_AutoCompleteExtender" 
                                                            runat="server"
                                                            Enabled="True"
                                                            CompletionInterval="250"
                                                            TargetControlID="txbBrandCodes"
                                                            ServicePath="myAutoComplete.asmx"
                                                            ServiceMethod="GetBrandCodes"
                                                            MinimumPrefixLength="2"
                                                            EnableCaching="true"
                                                            CompletionSetCount="20"
                                                            CompletionListCssClass="autocomplete_completionListElement" 
                                                            CompletionListItemCssClass="autocomplete_listItem" 
                                                            CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                                                            DelimiterCharacters=","
                                                            ShowOnlyCurrentWordInCompletionListItem="false"
                                                            BehaviorID="txbBrandCodes_Behavior">
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
                                                                                <Length PropertyKey="height" StartValue="0" EndValueScript="$find('txbBrandCodes_Behavior')._height" />
                                                                            </Parallel>
                                                                        </Sequence>
                                                                    </OnShow>
                                                                    <OnHide>
                                                                        <%-- Collapse down to 0px and fade out --%>
                                                                        <Parallel Duration="0">
                                                                            <FadeOut />
                                                                            <Length PropertyKey="height" StartValueScript="$find('txbBrandCodes_Behavior')._height" EndValue="0" />
                                                                        </Parallel>
                                                                    </OnHide>
                                                                </Animations>
                                                         </ajaxToolkit:AutoCompleteExtender>
                                                </td>
                                                <td>
                                                        <asp:Label
                                                            ID="lblBrandCodeID"
                                                            runat="server"
                                                            Text='<%# bind("BrandCode") %>'
                                                            Visible="false"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Line No</td>
                                                <td>
                                                    <asp:TextBox
                                                        ID="txbLineNo"
                                                        runat="server" 
                                                        Text='<%# bind("ManifestLineNumber") %>'
                                                        Width="250px"></asp:TextBox>
                                                </td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>Profile</td>
                                                <td>
                                                    <asp:DropDownList
                                                        ID="ddProfile"
                                                        runat="server"
                                                        DataSourceID="sdsGetProfile" 
                                                        DataTextField="Name"
                                                        DataValueField="ID" 
                                                        SelectedValue='<%# bind("InboundProfileID") %>'
                                                        Width="250px" AppendDataBoundItems="True">
                                                            <asp:ListItem Text="Select..." Value = "" />
                                                    </asp:DropDownList>
                                                    <asp:SqlDataSource
                                                        ID="sdsGetProfile"
                                                        runat="server" 
                                                        ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
                                                        SelectCommand="SELECT [ID], [Name] FROM [Profiles] ORDER BY [Name]">
                                                    </asp:SqlDataSource>
                                                </td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>Received As</td>
                                                <td>
                                                    <asp:DropDownList
                                                        ID="ddRecAs"
                                                        runat="server"  width="250px" 
                                                        SelectedValue='<%# bind("RcvdAs") %>'>
                                                            <asp:ListItem>Select...</asp:ListItem>
                                                            <asp:ListItem>Product</asp:ListItem>
                                                            <asp:ListItem>ShippedNH</asp:ListItem>
                                                            <asp:ListItem>Waste</asp:ListItem>
                                                            <asp:ListItem>Other</asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>Pallet Type</td>
                                                <td>
                                                    <asp:DropDownList
                                                        ID="ddPalletType"
                                                        runat="server" 
                                                        SelectedValue='<%# bind("InboundPalletType") %>'
                                                        Width="250px">
                                                            <asp:ListItem Value="0">Select...</asp:ListItem>
                                                            <asp:ListItem>CHEP</asp:ListItem>
                                                            <asp:ListItem>GMA</asp:ListItem>
                                                            <asp:ListItem>OTHER</asp:ListItem>
                                                            <asp:ListItem></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>Pallet Weight</td>
                                                <td>
                                                    <asp:TextBox
                                                        ID="txbPalletWeight"
                                                        runat="server" 
                                                        Text='<%# bind("InboundPalletWeight") %>'
                                                        Width="250px"></asp:TextBox>
                                                </td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>Container Type</td>
                                                <td>
                                                    <asp:DropDownList
                                                        ID="ddContainerTyper"
                                                        runat="server" 
                                                        SelectedValue='<%# bind("InboundContainerType") %>'
                                                        Width="250px">
                                                            <asp:ListItem Value="0">Select...</asp:ListItem>
                                                            <asp:ListItem>DM</asp:ListItem>
                                                            <asp:ListItem>CW</asp:ListItem>
                                                            <asp:ListItem>CS</asp:ListItem>
                                                            <asp:ListItem>CF</asp:ListItem>
                                                            <asp:ListItem>DF</asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>Container Qty</td>
                                                <td>
                                                    <asp:TextBox
                                                         ID="txbContainerQty"
                                                         runat="server" 
                                                         Text='<%# bind("InboundContainerQty") %>'
                                                         Width="250px"></asp:TextBox>
                                                </td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>Inventory Location</td>
                                                <td>
                                                    <asp:DropDownList
                                                        ID="ddLocation"
                                                        runat="server"
                                                        Width="250px"
                                                        SelectedValue='<%# bind("InventoryLocation") %>' 
                                                        DataSourceID="sdsGetLocation"
                                                        DataTextField="LocationName" 
                                                        DataValueField="LocationName"
                                                        AppendDataBoundItems="True">
                                                            <asp:ListItem Text="Select..." Value = "" />
                                                    </asp:DropDownList>
                                                    <asp:SqlDataSource
                                                        ID="sdsGetLocation"
                                                        runat="server" 
                                                        ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
                                                        SelectCommand="SELECT [ID], [LocationName] FROM [Locations] ORDER BY [ID]">
                                                    </asp:SqlDataSource>
                                                </td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>Process</td>
                                                <td>
                                                    <asp:CheckBox
                                                        ID="cbProcess"
                                                        runat="server"
                                                        width="250px"
                                                        Checked='<%# bind("column1") %>' />
                                                </td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>Process Plan As</td>
                                                <td>
                                                    <asp:DropDownList
                                                        ID="ddProcessPlan"
                                                        runat="server"
                                                        Width="250px"
                                                        SelectedValue='<%# bind("ProcessPlan") %>'>
                                                            <asp:ListItem>Select...</asp:ListItem>
                                                            <asp:ListItem>Bale</asp:ListItem>
                                                            <asp:ListItem>Decant</asp:ListItem>
                                                            <asp:ListItem>Depack</asp:ListItem>
                                                            <asp:ListItem>Compact</asp:ListItem>
                                                            <asp:ListItem>Disassemble</asp:ListItem>
                                                            <asp:ListItem>Recycle</asp:ListItem>
                                                            <asp:ListItem>Shred</asp:ListItem>
                                                            <asp:ListItem>Sort&amp;Seg</asp:ListItem>
                                                            <asp:ListItem>Truck</asp:ListItem>
                                                            <asp:ListItem>Truck Covanta</asp:ListItem>
                                                            <asp:ListItem>Truck CH</asp:ListItem>
                                                            <asp:ListItem>Truck GRR</asp:ListItem>
                                                            <asp:ListItem>Truck Niagra</asp:ListItem>
                                                            <asp:ListItem>Truck PP</asp:ListItem>
                                                            <asp:ListItem>Truck USA</asp:ListItem>
                                                            <asp:ListItem>Truck Vex</asp:ListItem>
                                                            <asp:ListItem>Truck WM</asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>&nbsp;</td>
                                                <td>&nbsp;</td>
                                                <td>&nbsp;</td>
                                            </tr>
                                        </table>
                                                    <asp:LinkButton ID="Insert" runat="server" CommandName="Insert" Text="Insert" />
                                                    <asp:LinkButton ID="Cancel" runat="server" CommandName="Cancel" Text="Cancel" />
                                                </InsertItemTemplate>
                                                <EditItemTemplate>
                                                    <table class="ui-accordion">
                                            <tr>
                                                <td>Inbound Doc No.</td>
                                                <td>
                                                    <asp:TextBox
                                                        ID="txbInboundDoc"
                                                        runat="server" 
                                                        Text='<%# bind("InboundDocNo") %>'
                                                        Width="250px"></asp:TextBox>
                                                </td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>Container ID</td>
                                                <td>
                                                    <asp:TextBox
                                                        ID="txbContainerID"
                                                        runat="server" 
                                                        Text='<%# bind("InboundContainerID") %>'
                                                        Width="250px"></asp:TextBox>
                                                </td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>Brand Code</td>
                                                <td>
                                                    <asp:TextBox
                                                        ID="txbBrandCodes"
                                                        runat="server"  
                                                        OnTextChanged="txbBrandCodes_OnTextChanged"
                                                        AutoPostBack="true"
                                                        Width="250px"
                                                        Text='<%# bind("BrandCodeName") %>'></asp:TextBox>
                                                        <ajaxToolkit:AutoCompleteExtender
                                                            ID="txbBrandCodes_AutoCompleteExtender" 
                                                            runat="server"
                                                            Enabled="True"
                                                            CompletionInterval="250"
                                                            TargetControlID="txbBrandCodes"
                                                            ServicePath="myAutoComplete.asmx"
                                                            ServiceMethod="GetBrandCodes"
                                                            MinimumPrefixLength="2"
                                                            EnableCaching="true"
                                                            CompletionSetCount="20"
                                                            CompletionListCssClass="autocomplete_completionListElement" 
                                                            CompletionListItemCssClass="autocomplete_listItem" 
                                                            CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                                                            DelimiterCharacters=","
                                                            ShowOnlyCurrentWordInCompletionListItem="false"
                                                            BehaviorID="txbBrandCodes_Behavior">
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
                                                                                <Length PropertyKey="height" StartValue="0" EndValueScript="$find('txbBrandCodes_Behavior')._height" />
                                                                            </Parallel>
                                                                        </Sequence>
                                                                    </OnShow>
                                                                    <OnHide>
                                                                        <%-- Collapse down to 0px and fade out --%>
                                                                        <Parallel Duration="0">
                                                                            <FadeOut />
                                                                            <Length PropertyKey="height" StartValueScript="$find('txbBrandCodes_Behavior')._height" EndValue="0" />
                                                                        </Parallel>
                                                                    </OnHide>
                                                                </Animations>
                                                         </ajaxToolkit:AutoCompleteExtender>
                                                </td>
                                                <td>
                                                        <asp:Label
                                                            ID="lblBrandCodeID"
                                                            runat="server"
                                                            Text='<%# bind("BrandCode") %>'
                                                            Visible="false"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td>Line No</td>
                                                <td>
                                                    <asp:TextBox
                                                        ID="txbLineNo"
                                                        runat="server" 
                                                        Text='<%# bind("ManifestLineNumber") %>'
                                                        Width="250px"></asp:TextBox>
                                                </td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>Profile</td>
                                                <td>
                                                    <asp:DropDownList
                                                        ID="ddProfile"
                                                        runat="server"
                                                        DataSourceID="sdsGetProfile" 
                                                        DataTextField="Name"
                                                        DataValueField="ID" 
                                                        SelectedValue='<%# bind("InboundProfileID") %>'
                                                        Width="250px" AppendDataBoundItems="True">
                                                            <asp:ListItem Text="Select..." Value = "" />
                                                    </asp:DropDownList>
                                                    <asp:SqlDataSource
                                                        ID="sdsGetProfile"
                                                        runat="server" 
                                                        ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
                                                        SelectCommand="SELECT [ID], [Name] FROM [Profiles] ORDER BY [Name]">
                                                    </asp:SqlDataSource>
                                                </td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>Received As</td>
                                                <td>
                                                    <asp:DropDownList
                                                        ID="ddRecAs"
                                                        runat="server"  width="250px" 
                                                        SelectedValue='<%# bind("RcvdAs") %>'>
                                                            <asp:ListItem>Select...</asp:ListItem>
                                                            <asp:ListItem>Product</asp:ListItem>
                                                            <asp:ListItem>ShippedNH</asp:ListItem>
                                                            <asp:ListItem>Waste</asp:ListItem>
                                                            <asp:ListItem>Other</asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>Pallet Type</td>
                                                <td>
                                                    <asp:DropDownList
                                                        ID="ddPalletType"
                                                        runat="server" 
                                                        SelectedValue='<%# bind("InboundPalletType") %>'
                                                        Width="250px">
                                                            <asp:ListItem Value="0">Select...</asp:ListItem>
                                                            <asp:ListItem>CHEP</asp:ListItem>
                                                            <asp:ListItem>GMA</asp:ListItem>
                                                            <asp:ListItem>OTHER</asp:ListItem>
                                                            <asp:ListItem></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>Pallet Weight</td>
                                                <td>
                                                    <asp:TextBox
                                                        ID="txbPalletWeight"
                                                        runat="server" 
                                                        Text='<%# bind("InboundPalletWeight") %>'
                                                        Width="250px"></asp:TextBox>
                                                </td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>Container Type</td>
                                                <td>
                                                    <asp:DropDownList
                                                        ID="ddContainerTyper"
                                                        runat="server" 
                                                        SelectedValue='<%# bind("InboundContainerType") %>'
                                                        Width="250px">
                                                            <asp:ListItem Value="0">Select...</asp:ListItem>
                                                            <asp:ListItem>DM</asp:ListItem>
                                                            <asp:ListItem>CW</asp:ListItem>
                                                            <asp:ListItem>CS</asp:ListItem>
                                                            <asp:ListItem>CF</asp:ListItem>
                                                            <asp:ListItem>DF</asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>Container Qty</td>
                                                <td>
                                                    <asp:TextBox
                                                         ID="txbContainerQty"
                                                         runat="server" 
                                                         Text='<%# bind("InboundContainerQty") %>'
                                                         Width="250px"></asp:TextBox>
                                                </td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>Inventory Location</td>
                                                <td>
                                                    <asp:DropDownList
                                                        ID="ddLocation"
                                                        runat="server"
                                                        Width="250px"
                                                        SelectedValue='<%# bind("InventoryLocation") %>' 
                                                        DataSourceID="sdsGetLocation"
                                                        DataTextField="LocationName" 
                                                        DataValueField="LocationName"
                                                        AppendDataBoundItems="True">
                                                            <asp:ListItem Text="Select..." Value = "" />
                                                    </asp:DropDownList>
                                                    <asp:SqlDataSource
                                                        ID="sdsGetLocation"
                                                        runat="server" 
                                                        ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
                                                        SelectCommand="SELECT [ID], [LocationName] FROM [Locations] ORDER BY [ID]">
                                                    </asp:SqlDataSource>
                                                </td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>Process</td>
                                                <td>
                                                    <asp:CheckBox
                                                        ID="cbProcess"
                                                        runat="server"
                                                        width="250px"
                                                        Checked='<%# bind("column1") %>' />
                                                </td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>Process Plan As</td>
                                                <td>
                                                    <asp:DropDownList
                                                        ID="ddProcessPlan"
                                                        runat="server"
                                                        Width="250px"
                                                        SelectedValue='<%# bind("ProcessPlan") %>'>
                                                            <asp:ListItem>Select...</asp:ListItem>
                                                            <asp:ListItem>Bale</asp:ListItem>
                                                            <asp:ListItem>Decant</asp:ListItem>
                                                            <asp:ListItem>Depack</asp:ListItem>
                                                            <asp:ListItem>Compact</asp:ListItem>
                                                            <asp:ListItem>Disassemble</asp:ListItem>
                                                            <asp:ListItem>Recycle</asp:ListItem>
                                                            <asp:ListItem>Shred</asp:ListItem>
                                                            <asp:ListItem>Sort&amp;Seg</asp:ListItem>
                                                            <asp:ListItem>Truck</asp:ListItem>
                                                            <asp:ListItem>Truck Covanta</asp:ListItem>
                                                            <asp:ListItem>Truck CH</asp:ListItem>
                                                            <asp:ListItem>Truck GRR</asp:ListItem>
                                                            <asp:ListItem>Truck Niagra</asp:ListItem>
                                                            <asp:ListItem>Truck PP</asp:ListItem>
                                                            <asp:ListItem>Truck USA</asp:ListItem>
                                                            <asp:ListItem>Truck Vex</asp:ListItem>
                                                            <asp:ListItem>Truck WM</asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>&nbsp;</td>
                                                <td>&nbsp;</td>
                                                <td>&nbsp;</td>
                                            </tr>
                                        </table>
                                                    <asp:LinkButton ID="Update" runat="server" CommandName="Update" Text="Update" />
                                                    <asp:LinkButton ID="Cancel" runat="server" CommandName="Cancel" Text="Cancel" />
                                                </EditItemTemplate>
                                                <ItemTemplate>
                                                    <table class="ui-accordion">
                                            <tr>
                                                <td>Inbound Doc No.</td>
                                                <td>
                                                    <asp:TextBox
                                                        ID="txbInboundDoc"
                                                        runat="server" 
                                                        Width="250px"
                                                        Text='<%# bind("InboundDocNo") %>'>
                                                        </asp:TextBox>
                                                </td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>Container ID</td>
                                                <td>
                                                    <asp:TextBox
                                                        ID="txbContainerID"
                                                        runat="server" 
                                                        Text=""
                                                        Width="250px"
                                                        tabindex="0"></asp:TextBox>
                                                </td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>Brand Code</td>
                                                <td>
                                                    <asp:TextBox
                                                        ID="txbBrandCodes"
                                                        runat="server"  
                                                        OnTextChanged="txbBrandCodes_OnTextChanged"
                                                        AutoPostBack="true"
                                                        Width="250px"
                                                        Text='<%# bind("BrandCodeName") %>'></asp:TextBox>
                                                        <ajaxToolkit:AutoCompleteExtender
                                                            ID="txbBrandCodes_AutoCompleteExtender" 
                                                            runat="server"
                                                            Enabled="True"
                                                            CompletionInterval="250"
                                                            TargetControlID="txbBrandCodes"
                                                            ServicePath="myAutoComplete.asmx"
                                                            ServiceMethod="GetBrandCodes"
                                                            MinimumPrefixLength="2"
                                                            EnableCaching="true"
                                                            CompletionSetCount="20"
                                                            CompletionListCssClass="autocomplete_completionListElement" 
                                                            CompletionListItemCssClass="autocomplete_listItem" 
                                                            CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                                                            DelimiterCharacters=","
                                                            ShowOnlyCurrentWordInCompletionListItem="false"
                                                            BehaviorID="txbBrandCodes_Behavior">
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
                                                                                <Length PropertyKey="height" StartValue="0" EndValueScript="$find('txbBrandCodes_Behavior')._height" />
                                                                            </Parallel>
                                                                        </Sequence>
                                                                    </OnShow>
                                                                    <OnHide>
                                                                        <%-- Collapse down to 0px and fade out --%>
                                                                        <Parallel Duration="0">
                                                                            <FadeOut />
                                                                            <Length PropertyKey="height" StartValueScript="$find('txbBrandCodes_Behavior')._height" EndValue="0" />
                                                                        </Parallel>
                                                                    </OnHide>
                                                                </Animations>
                                                         </ajaxToolkit:AutoCompleteExtender>
                                                </td>
                                                <td>
                                                        <asp:Label
                                                            ID="lblBrandCodeID"
                                                            runat="server"
                                                            Text='<%# bind("BrandCode") %>'
                                                            Visible="false"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td>Line No</td>
                                                <td>
                                                    <asp:TextBox
                                                        ID="txbLineNo"
                                                        runat="server" 
                                                        Text='<%# bind("ManifestLineNumber") %>'
                                                        Width="250px"></asp:TextBox>
                                                </td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>Profile</td>
                                                <td>
                                                    <asp:DropDownList
                                                        ID="ddProfile"
                                                        runat="server"
                                                        DataSourceID="sdsGetProfile" 
                                                        DataTextField="Name"
                                                        DataValueField="ID" 
                                                        SelectedValue='<%# bind("InboundProfileID") %>'
                                                        Width="250px" AppendDataBoundItems="True">
                                                            <asp:ListItem Text="Select..." Value = "" />
                                                    </asp:DropDownList>
                                                    <asp:SqlDataSource
                                                        ID="sdsGetProfile"
                                                        runat="server" 
                                                        ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
                                                        SelectCommand="SELECT [ID], [Name] FROM [Profiles] ORDER BY [Name]">
                                                    </asp:SqlDataSource>
                                                </td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>Received As</td>
                                                <td>
                                                    <asp:DropDownList
                                                        ID="ddRecAs"
                                                        runat="server"  width="250px" 
                                                        SelectedValue='<%# bind("RcvdAs") %>'>
                                                            <asp:ListItem>Select...</asp:ListItem>
                                                            <asp:ListItem>Product</asp:ListItem>
                                                            <asp:ListItem>ShippedNH</asp:ListItem>
                                                            <asp:ListItem>Waste</asp:ListItem>
                                                            <asp:ListItem>Other</asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>Pallet Type</td>
                                                <td>
                                                    <asp:DropDownList
                                                        ID="ddPalletType"
                                                        runat="server" 
                                                        SelectedValue='<%# bind("InboundPalletType") %>'
                                                        Width="250px">
                                                            <asp:ListItem Value="0">Select...</asp:ListItem>
                                                            <asp:ListItem>CHEP</asp:ListItem>
                                                            <asp:ListItem>GMA</asp:ListItem>
                                                            <asp:ListItem>OTHER</asp:ListItem>
                                                            <asp:ListItem></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>Pallet Weight</td>
                                                <td>
                                                    <asp:TextBox
                                                        ID="txbPalletWeight"
                                                        runat="server" 
                                                        Text='<%# bind("InboundPalletWeight") %>'
                                                        Width="250px"></asp:TextBox>
                                                </td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>Container Type</td>
                                                <td>
                                                    <asp:DropDownList
                                                        ID="ddContainerTyper"
                                                        runat="server" 
                                                        SelectedValue='<%# bind("InboundContainerType") %>'
                                                        Width="250px">
                                                            <asp:ListItem Value="0">Select...</asp:ListItem>
                                                            <asp:ListItem>DM</asp:ListItem>
                                                            <asp:ListItem>CW</asp:ListItem>
                                                            <asp:ListItem>CS</asp:ListItem>
                                                            <asp:ListItem>CF</asp:ListItem>
                                                            <asp:ListItem>DF</asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>Container Qty</td>
                                                <td>
                                                    <asp:TextBox
                                                         ID="txbContainerQty"
                                                         runat="server" 
                                                         Text='<%# bind("InboundContainerQty") %>'
                                                         Width="250px"></asp:TextBox>
                                                </td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>Inventory Location</td>
                                                <td>
                                                    <asp:DropDownList
                                                        ID="ddLocation"
                                                        runat="server"
                                                        Width="250px"
                                                        SelectedValue='<%# bind("InventoryLocation") %>' 
                                                        DataSourceID="sdsGetLocation"
                                                        DataTextField="LocationName" 
                                                        DataValueField="LocationName"
                                                        AppendDataBoundItems="True">
                                                            <asp:ListItem Text="Select..." Value = "" />
                                                    </asp:DropDownList>
                                                    <asp:SqlDataSource
                                                        ID="sdsGetLocation"
                                                        runat="server" 
                                                        ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
                                                        SelectCommand="SELECT [ID], [LocationName] FROM [Locations] ORDER BY [ID]">
                                                    </asp:SqlDataSource>
                                                </td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>Process</td>
                                                <td>
                                                    <asp:CheckBox
                                                        ID="cbProcess"
                                                        runat="server"
                                                        width="250px"
                                                        Checked='<%# bind("column1") %>' />
                                                </td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>Process Plan As</td>
                                                <td>
                                                    <asp:DropDownList
                                                        ID="ddProcessPlan"
                                                        runat="server"
                                                        Width="250px"
                                                        SelectedValue='<%# bind("ProcessPlan") %>'>
                                                            <asp:ListItem>Select...</asp:ListItem>
                                                            <asp:ListItem>Bale</asp:ListItem>
                                                            <asp:ListItem>Decant</asp:ListItem>
                                                            <asp:ListItem>Depack</asp:ListItem>
                                                            <asp:ListItem>Compact</asp:ListItem>
                                                            <asp:ListItem>Disassemble</asp:ListItem>
                                                            <asp:ListItem>Recycle</asp:ListItem>
                                                            <asp:ListItem>Shred</asp:ListItem>
                                                            <asp:ListItem>Sort&amp;Seg</asp:ListItem>
                                                            <asp:ListItem>Truck</asp:ListItem>
                                                            <asp:ListItem>Truck Covanta</asp:ListItem>
                                                            <asp:ListItem>Truck CH</asp:ListItem>
                                                            <asp:ListItem>Truck GRR</asp:ListItem>
                                                            <asp:ListItem>Truck Niagra</asp:ListItem>
                                                            <asp:ListItem>Truck PP</asp:ListItem>
                                                            <asp:ListItem>Truck USA</asp:ListItem>
                                                            <asp:ListItem>Truck Vex</asp:ListItem>
                                                            <asp:ListItem>Truck WM</asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>&nbsp;</td>
                                                <td>&nbsp;</td>
                                                <td>&nbsp;</td>
                                            </tr>
                                        </table>
                                                    <asp:LinkButton ID="Dupe" runat="server" CommandName="Duplicate" Text="Insert" />
                                                    <asp:LinkButton ID="Cancel" runat="server" CommandName="Cancel" Text="Cancel" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Fields>
                                </asp:DetailsView>
                             <asp:SqlDataSource
                                ID="sdsContainerDetail"
                                runat="server" 
                                ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
                                DeleteCommand="DELETE FROM [RcvDetail] WHERE [ID] = @ID" 
                                InsertCommand="INSERT INTO [RcvDetail] ([InboundDocNo], [ManifestLineNumber], [RcvHdrID], [InboundProfileID], [InboundContainerType], [InboundPalletType], [InboundPalletWeight], [InboundContainerQty], [InboundContainerID], [InventoryLocation], [BrandCode], [Process?], [ProcessPlan], [RcvdAs], [ModDate], [UserName]) VALUES (@InboundDocNo, @ManifestLineNumber, @RcvHdrID, @InboundProfileID, @InboundContainerType, @InboundPalletType, @InboundPalletWeight, @InboundContainerQty, @InboundContainerID, @InventoryLocation, @BrandCode, @column1, @ProcessPlan, @RcvdAs, @ModDate, @UserName)" 
                                SelectCommand="SELECT c.[US_Brand_Code] + ' ' + c.[name] as BrandCodeName, r.[ID], r.[InboundDocNo], r.[ManifestLineNumber], r.[RcvHdrID], r.[InboundProfileID], r.[InboundContainerType], r.[InboundPalletType], r.[InboundPalletWeight], r.[InboundContainerQty], r.[InboundContainerID], r.[InventoryLocation], r.[BrandCode], r.[Process?] AS column1, r.[ProcessPlan], r.[RcvdAs], r.[ModDate], r.[UserName] FROM [RcvDetail] r LEFT JOIN Components c on r.BrandCode = c.ID WHERE (r.[id] = @id)" 
                                UpdateCommand="UPDATE [RcvDetail] SET [InboundDocNo] = @InboundDocNo, [ManifestLineNumber] = @ManifestLineNumber, [RcvHdrID] = @RcvHdrID, [InboundProfileID] = @InboundProfileID, [InboundContainerType] = @InboundContainerType, [InboundPalletType] = @InboundPalletType, [InboundPalletWeight] = @InboundPalletWeight, [InboundContainerQty] = @InboundContainerQty, [InboundContainerID] = @InboundContainerID, [InventoryLocation] = @InventoryLocation, [BrandCode] = @BrandCode, [Process?] = @column1, [ProcessPlan] = @ProcessPlan, [RcvdAs] = @RcvdAs, [ModDate] = @ModDate, [UserName] = @UserName WHERE [ID] = @ID"
                                onupdated="sdsContainerDetail_Updated"
                                oninserted="sdsContainerDetail_Inserted">
                                <DeleteParameters>
                                    <asp:SessionParameter DefaultValue="0" Name="ID" SessionField="CurDetailID" Type="Int32" />
                                </DeleteParameters>
                                <InsertParameters>
                                    <asp:SessionParameter Name="InboundDocNo" SessionField="CurInboundDocNo" Type="String" />
                                    <asp:Parameter Name="ManifestLineNumber" Type="Int32" />
                                    <asp:SessionParameter Name="RcvHdrID" SessionField="CurRcvHrdID" Type="Int32" />
                                    <asp:Parameter Name="InboundProfileID" Type="Int32" />
                                    <asp:Parameter Name="InboundContainerType" Type="String" />
                                    <asp:Parameter Name="InboundPalletType" Type="String" />
                                    <asp:Parameter Name="InboundPalletWeight" Type="Int32" />
                                    <asp:Parameter Name="InboundContainerQty" Type="Int32" />
                                    <asp:Parameter Name="InboundContainerID" Type="String" />
                                    <asp:Parameter Name="InventoryLocation" Type="String" />
                                    <asp:Parameter Name="BrandCode" Type="Int64" />
                                    <asp:Parameter Name="column1" Type="Boolean" />
                                    <asp:Parameter Name="ProcessPlan" Type="String" />
                                    <asp:Parameter Name="RcvdAs" Type="String" />
                                    <asp:Parameter Name="ModDate" Type="DateTime" />
                                    <asp:Parameter Name="UserName" Type="String" />
                                </InsertParameters>
                                <SelectParameters>
                                    <asp:SessionParameter DefaultValue="0" Name="ID" SessionField="CurDetailID" Type="Int32" />
                                </SelectParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="InboundDocNo" Type="String" />
                                    <asp:Parameter Name="ManifestLineNumber" Type="Int32" />
                                    <asp:SessionParameter Name="RcvHdrID" SessionField="CurRcvHrdID" Type="Int32" />
                                    <asp:Parameter Name="InboundProfileID" Type="Int32" />
                                    <asp:Parameter Name="InboundContainerType" Type="String" />
                                    <asp:Parameter Name="InboundPalletType" Type="String" />
                                    <asp:Parameter Name="InboundPalletWeight" Type="Int32" />
                                    <asp:Parameter Name="InboundContainerQty" Type="Int32" />
                                    <asp:Parameter Name="InboundContainerID" Type="String" />
                                    <asp:Parameter Name="InventoryLocation" Type="String" />
                                    <asp:Parameter Name="BrandCode" Type="Int64" />
                                    <asp:Parameter Name="column1" Type="Boolean" />
                                    <asp:Parameter Name="ProcessPlan" Type="String" />
                                    <asp:Parameter Name="RcvdAs" Type="String" />
                                    <asp:Parameter Name="ModDate" Type="DateTime" />
                                    <asp:Parameter Name="UserName" Type="String" />
                                    <asp:Parameter Name="ID" Type="Int32" />
                                </UpdateParameters>
                            </asp:SqlDataSource>
                    </ContentTemplate>
                    </asp:UpdatePanel>
                </asp:Panel>
                    <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtender1" 
                                runat="server"
                                TargetControlID="Button1"
                                PopupControlID="pnlContainerDetail"
                                BackgroundCssClass="modalBackground">
                    </ajaxToolkit:ModalPopupExtender>
                        <asp:Button runat="server" ID="Button1" Style="display:none"/>
            </td>
        </tr>
    </table>
</asp:Content>    

<asp:Content
    ID="Content3"
    ContentPlaceHolderID="Clear"
    runat="server"> 
</asp:Content>
<asp:Content
    ID="Content4"
    ContentPlaceHolderID="Footer"
    runat="server">
</asp:Content>
