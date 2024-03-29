﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TruckOut.aspx.cs" Inherits="IMDBWeb.Secure.IndustrialPages.TruckOut" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server"> 
<h3>Truck Out Management</h3><hr />
<ajaxToolkit:ToolkitScriptManager ID="SM" runat="server" />
<table><tr>
<td>
<table><tr><td align="left"><asp:DropDownList ID="ddDocList" runat="server" AppendDataBoundItems="true" 
        AutoPostBack="True" DataSourceID="sdsOutBoundDocNo" 
        DataTextField="OutboundDocNo" DataValueField="outboundDocNo" 
        onselectedindexchanged="ddDocList_SelectedIndexChanged">
<asp:ListItem Value="" Text="Select a Document"></asp:ListItem></asp:DropDownList>
    </td><td>
    <asp:RadioButtonList ID="rblFilter" runat="server" onselectedindexchanged="rblFilter_SelectedIndexChanged" AutoPostBack="True">
        <asp:ListItem Selected="True" Text="Show 'Not Completed' Outbound Documents only" Value="0" />
        <asp:ListItem Text="Show Completed" Value="1" />
    </asp:RadioButtonList>
    </td></tr>
    <tr id="trAddCntr" runat="server"><td colspan="2">Scan/Enter New Container:&nbsp&nbsp
    <asp:TextBox ID="txbNewCntr" runat="server" ontextchanged="txbNewCntr_TextChanged" AutoPostBack="True" />
    <asp:RegularExpressionValidator ID="valCheck" ControlToValidate="txbNewCntr" runat="server" ForeColor="Red" Font-Bold="true" 
        ErrorMessage="This is not a Valid Container ID" ValidationExpression="^[IiOo][UuNn][Tt]?[-](\d{6})*$" SetFocusOnError="True" />
    </td></tr>
    <tr id="trErrMsg" runat="server"><td colspan="2"><asp:Label ID="lblErrMsg" runat="server" Font-Bold="True" Font-Size="Large" 
            ForeColor="Red" /></td></tr>
</table>
</td>
<td>
</td></tr></table>
<asp:Button ID="btnPrint" runat="server" Text="Print" OnClientClick="javascript:window.print();" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<asp:Button ID="btnExport" runat="server" onclick="btnExport_Click" Text="Export to Excel" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<asp:Button ID="btnCompleteTruck" runat="server" Text="Close Out Truck" onclick="btnCompleteTruck_Click" /><br /><br />
<asp:Panel ID="Panel1" runat="server">
<table>
<tr><td colspan="2">
    <i>Shipment Info</i>
    <asp:GridView ID="gvShipHdr" runat="server" AutoGenerateColumns="False" 
        DataSourceID="sdsShipHdr" CellPadding="3" DataKeyNames="ID">
        <Columns>
            <asp:CommandField ShowEditButton="True" />
            <asp:BoundField DataField="ID" Visible="false" />
            <asp:BoundField DataField="TrailerNumber" HeaderText="Trailer Number" />
            <asp:BoundField DataField="Shippingdock" HeaderText="Dock" />
            <asp:BoundField DataField="Destination" HeaderText="Destination" ReadOnly="true" ItemStyle-ForeColor="Black" ItemStyle-Font-Italic="true" ItemStyle-BackColor="LightGray" />
            <asp:BoundField DataField="ShipDate" HeaderText="ShipDate"  DataFormatString="{0:d}" ReadOnly="true" ItemStyle-ForeColor="Black" ItemStyle-Font-Italic="true" ItemStyle-BackColor="LightGray" />
            <asp:BoundField DataField="Carrier" HeaderText="Carrier" ReadOnly="true" ItemStyle-ForeColor="Black" ItemStyle-Font-Italic="true" ItemStyle-BackColor="LightGray" />
        </Columns>
    </asp:GridView>  
</td>
</tr>
<tr valign="top">
<td><br /><i>Outbound Container Info</i><asp:gridview ID="gvContainers" runat="server" AutoGenerateColumns="False" DataSourceID="sdsTruckOut" 
        onDataBound="gvContainers_onDataBound" OnRowCommand="gvContainers_onRowCommand" 
        OnRowDataBound="gvContainers_RowDatabound" CellPadding="3" DataKeyNames="outboundcontainerid" >
    <Columns>
    <asp:TemplateField> 
        <ItemTemplate> 
                <asp:LinkButton id="btnEdit" runat="server" commandname="Edit" text="Edit" /> 
        </ItemTemplate> 
        <EditItemTemplate> 
                <asp:LinkButton id="btnUpdate" runat="server" commandname="Update" text="Update" />
                <asp:LinkButton id="btnCancel" runat="server" commandname="Cancel" text="Cancel" /> 
        </EditItemTemplate> 
    </asp:TemplateField>
    <asp:TemplateField HeaderText="CntrID"> 
        <ItemTemplate> 
                <asp:Label id="outboundcontainerid" runat="server" Text='<%# Eval("outboundcontainerid") %>' /> 
        </ItemTemplate> 
        <EditItemTemplate> 
                <asp:Label id="outboundcontainerid" runat="server" Text='<%# Eval("outboundcontainerid") %>' /> 
        </EditItemTemplate> 
    </asp:TemplateField>  
    <asp:TemplateField HeaderText="Est CntrWt"> 
    <ItemTemplate> 
            <asp:Label id="AggrWt" runat="server" Text='<%# Eval("AggrWt") %>' /> 
    </ItemTemplate> 
    <EditItemTemplate> 
            <asp:Label id="AggrWt" runat="server" Text='<%# Eval("AggrWt") %>' /> 
    </EditItemTemplate> 
    </asp:TemplateField> 
    <asp:TemplateField HeaderText="Act ShipWt">
        <EditItemTemplate>
            <asp:TextBox ID="ActAggrWt" runat="server" Text='<%# Bind("ActAggrWt") %>' />
        </EditItemTemplate>
        <ItemTemplate>
            <asp:Label ID="ActAggrWt" runat="server" Text='<%# Eval("ActAggrWt") %>'></asp:Label>
        </ItemTemplate>
    </asp:TemplateField>
    <asp:TemplateField HeaderText="Profile"> 
    <ItemTemplate> 
            <asp:Label id="Profile" runat="server" Text='<%# Eval("Name") %>' /> 
    </ItemTemplate> 
    <EditItemTemplate> 
            <asp:Label id="Profile" runat="server" Text='<%# Eval("Name") %>' /> 
    </EditItemTemplate> 
    </asp:TemplateField>
    <asp:TemplateField HeaderText="Stream"> 
    <ItemTemplate> 
            <asp:Label id="outboundstreamtype" runat="server" Text='<%# Eval("outboundstreamtype") %>' /> 
    </ItemTemplate> 
    <EditItemTemplate> 
            <asp:Label id="outboundstreamtype" runat="server" Text='<%# Eval("outboundstreamtype") %>' /> 
    </EditItemTemplate> 
    </asp:TemplateField>
    <asp:TemplateField HeaderText="Cntr Qty"> 
    <ItemTemplate> 
            <asp:Label id="AggrQty" runat="server" Text='<%# Eval("AggrQty") %>' /> 
    </ItemTemplate> 
    <EditItemTemplate> 
            <asp:Label id="AggrQty" runat="server" Text='<%# Eval("AggrQty") %>' /> 
    </EditItemTemplate> 
    </asp:TemplateField>
    <asp:TemplateField HeaderText="Cntr Type"> 
    <ItemTemplate> 
            <asp:Label id="outboundcontainertype" runat="server" Text='<%# Eval("outboundcontainertype") %>' /> 
    </ItemTemplate> 
    <EditItemTemplate> 
            <asp:Label id="outboundcontainertype" runat="server" Text='<%# Eval("outboundcontainertype") %>' /> 
    </EditItemTemplate> 
    </asp:TemplateField>
    <asp:TemplateField HeaderText="Document"> 
    <ItemTemplate> 
            <asp:Label id="OutboundDocNo" runat="server" Text='<%# Eval("OutboundDocNo") %>' /> 
    </ItemTemplate> 
    <EditItemTemplate> 
            <asp:Label id="OutboundDocNo" runat="server" Text='<%# Eval("OutboundDocNo") %>' /> 
    </EditItemTemplate> 
    </asp:TemplateField>
    <asp:TemplateField HeaderText="Ship Cmplt"> 
    <ItemTemplate> 
            <asp:Label id="completed" runat="server" Text='<%# Eval("completed") %>' /> 
    </ItemTemplate> 
    <EditItemTemplate> 
            <asp:Label id="completed" runat="server" Text='<%# Eval("completed") %>' /> 
    </EditItemTemplate> 
    </asp:TemplateField>
    <asp:ButtonField ButtonType="Link"  CommandName="Delete" Text="Remove" Visible="true" />
    <asp:TemplateField HeaderText="Haz?"> 
    <ItemTemplate> 
            <asp:Label id="hazardous" runat="server" Text='<%# Eval("hazardous") %>' /> 
    </ItemTemplate> 
    <EditItemTemplate> 
            <asp:Label id="hazardous" runat="server" Text='<%# Eval("hazardous") %>' /> 
    </EditItemTemplate> 
    </asp:TemplateField>
    </Columns>
    <HeaderStyle HorizontalAlign="Center" />
</asp:gridview></td>
<td><br /><i>Outbound Summary Info</i>
<asp:GridView ID="gvTally" runat="server" DataSourceID="sdsTally" AutoGenerateColumns="false" cellpadding="3" EnableViewState="False">
    <Columns>
        <asp:BoundField DataField="Name" HeaderText="Profile" SortExpression="Name" />
        <asp:BoundField DataField="NumberofCntrs" HeaderText="Cntr Count" SortExpression="NumberofCntrs" />
        <asp:BoundField DataField="outboundcontainertype" HeaderText="Cntr Type" SortExpression="outboundcontainertype" />
        <asp:BoundField DataField="TotalWeight" HeaderText="Total Act Weight" SortExpression="TotalWeight" DataFormatString="{0:n0}" />
    </Columns>
    <HeaderStyle ForeColor="Green" Font-Bold="true" BackColor="White" />
</asp:GridView>
</td>
</tr></table> 
</asp:Panel>
<asp:HiddenField ID="hdnOUTPlaceHolder" runat="server" />
<asp:HiddenField ID="hdnINPlaceHolder" runat="server" />
<asp:HiddenField ID="hdnINChangePlaceHolder" runat="server" />
<ajaxToolkit:ModalPopupExtender ID="mpeOUTCHEP" runat="server"  
	targetcontrolid="hdnOUTPlaceHolder" popupcontrolid="pnlOUTCHEPPopup" popupdraghandlecontrolid="PopupHeaderOUT" drag="true" backgroundcssclass="ModalPopupBG">
</ajaxToolkit:ModalPopupExtender>
<ajaxToolkit:ModalPopupExtender ID="mpeINCHEP" runat="server" 
	targetcontrolid="hdnINPlaceHolder" popupcontrolid="pnlINCHEPPopup" popupdraghandlecontrolid="PopupHeaderIN" drag="true" backgroundcssclass="ModalPopupBG">
</ajaxToolkit:ModalPopupExtender>
<ajaxToolkit:ModalPopupExtender ID="mpeINChange" runat="server"  
	targetcontrolid="hdnINChangePlaceHolder" popupcontrolid="pnlINNoChange" popupdraghandlecontrolid="PopupHeaderInChange" drag="true" backgroundcssclass="ModalPopupBG">
</ajaxToolkit:ModalPopupExtender>
<asp:panel id="pnlINCHEPPopup" style="display: none" runat="server">
	<div class="ChepCheckdPopup">
                <div class="PopupHeader" id="PopupHeaderIN">Warning!</div>
                <div class="PopupBody">
                    <p>This container was originally shipped on a CHEP pallet. Has the pallet been changed to GMA?</p>
                </div>
                <div class="Controls">
                    <asp:Button ID="btnINChanged" runat="server" Text="Yes" onclick="INYesChanged" CausesValidation="false" />
                    <asp:Button ID="btnINNotChanged" runat="server" Text="No" onclick="INNotChanged" CausesValidation="false" />
		</div>
        </div>
</asp:panel>
<asp:panel id="pnlINNoChange" style="display: none" runat="server">
	<div class="ChepCheckdPopup">
                <div class="PopupHeader" id="PopupHeaderInChange">Warning!</div>
                <div class="PopupBody">
                    <p>This container is on a CHEP pallet.  Do not add to the truck wihtout Supervisor approval</p>
                </div>
                <div class="Controls">
                    <asp:Button ID="btnINOK" runat="server" Text="I have approval" OnClick="INwApproval" CausesValidation="false" />
                    <asp:Button ID="btnINCancel" runat="server" Text="Cancel" OnClick="INCancel" CausesValidation="false" />
		        </div>
        </div>
</asp:panel>
<asp:panel id="pnlOUTCHEPPopup" style="display: none" runat="server">
	<div class="ChepCheckdPopup">
                <div class="PopupHeader" id="PopupHeaderOUT">Warning!</div>
                <div class="PopupBody">
                    <p>This container is on a CHEP pallet.  Do not add to the truck wihtout Supervisor approval</p>
                </div>
                <div class="Controls">
                    <asp:Button ID="btnOUTOk" runat="server" Text="I have approval" OnClick="OUTwApproval" CausesValidation="false" />
                    <asp:Button ID="btnOUTCancel" runat="server" Text="Cancel" OnClick="OUTCancel" CausesValidation="false" />
		        </div>
        </div>
</asp:panel>
<asp:SqlDataSource ID="sdsOutBoundDocNo" runat="server" DataSourceMode="DataSet" EnableCaching="false"
    ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
    SelectCommand="IMDB_TruckOut_OutBoundDoc_Sel" SelectCommandType="StoredProcedure" FilterExpression="Completed = '0'" >
    <FilterParameters>
        <asp:ControlParameter ControlID="rblFilter" PropertyName="SelectedValue" />
    </FilterParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="sdsTally" runat="server" ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
    SelectCommand="IMDB_TruckOut_Tally" SelectCommandType="StoredProcedure" >
    <SelectParameters>
        <asp:ControlParameter ControlID="ddDocList" PropertyName="SelectedValue" 
            Name="outbounddocno" Type="String" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="sdsTruckOut" runat="server" DataSourceMode="DataSet" EnableCaching="false"
    ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" OnDataBinding="sdsTruckOut_OnDataBinding"
    OnUpdating="sdsTruckOut_Updating" OnDeleting="sdsTruckOut_Deleting"
    SelectCommand="IMDB_TruckOut_Sel" SelectCommandType="StoredProcedure" 
    UpdateCommand="IMDB_TruckOut_AggrWt_upd" UpdateCommandType="StoredProcedure"
    DeleteCommand="IMDB_TruckOut_RemoveCntr" DeleteCommandType="StoredProcedure" >
    <SelectParameters>
        <asp:ControlParameter ControlID="ddDocList" Name="outbounddocno" PropertyName="SelectedValue" Type="String" />
    </SelectParameters>
    <UpdateParameters>
       <asp:Parameter Name="ActAggrWt" Type="Int32" />
       <asp:Parameter Name="outboundcontainerID" Type="String" />
       <asp:Parameter Name="user" Type="String" />
    </UpdateParameters>
    <DeleteParameters>
       <asp:Parameter Name="outboundcontainerID" Type="String" />
       <asp:Parameter Name="user" Type="String" />
    </DeleteParameters>
    <FilterParameters>
    <asp:ControlParameter ControlID="rblFilter" PropertyName="SelectedValue" />
</FilterParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="sdsShipHdr" runat="server" 
    ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" OnUpdating="sdsShipHdr_OnUpdating"
    SelectCommand="IMDB_TruckOut_ShipHdr_Sel" SelectCommandType="StoredProcedure"
    UpdateCommand="IMDB_TruckOut_ShipHdr_Upd" UpdateCommandType="StoredProcedure">
    <SelectParameters>
        <asp:ControlParameter ControlID="ddDocList" Name="outbounddocno" PropertyName="SelectedValue" Type="String" />
    </SelectParameters>
    <UpdateParameters>
        <asp:Parameter Name="UserName" Type="String" />
        <asp:Parameter Name="Completed" Type="Int32" />
    </UpdateParameters>
</asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Clear" runat="server"></asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Footer" runat="server"></asp:Content>
