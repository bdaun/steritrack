<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TruckOut.aspx.cs" Inherits="IMDBWeb.Secure.deskTopPages.TruckOut" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server"> 
<h3>Truck Out Management</h3>
<table><tr><td align="left"><asp:DropDownList ID="ddDocList" runat="server" AppendDataBoundItems="true" 
        AutoPostBack="True" DataSourceID="sdsOutBoundDocNo" 
        DataTextField="OutboundDocNo" DataValueField="outboundDocNo" 
        onselectedindexchanged="ddDocList_SelectedIndexChanged">
<asp:ListItem Value="" Text="Select a Document"></asp:ListItem></asp:DropDownList>
    </td><td>
    <asp:RadioButtonList ID="rblFilter" runat="server" onselectedindexchanged="rblFilter_SelectedIndexChanged" AutoPostBack="True">
        <asp:ListItem Selected="True" Text="Show 'Not Completed' Outbound Documents only" Value="0" />
        <asp:ListItem Text="Show All" Value="1" />
    </asp:RadioButtonList>
    </td><td></td></tr>
    <tr id="trAddCntr" runat="server"><td colspan="2">Scan/Enter New Container:&nbsp&nbsp
    <asp:TextBox ID="txbNewCntr" runat="server" ontextchanged="txbNewCntr_TextChanged" AutoPostBack="True" />
    <asp:RegularExpressionValidator ID="valCheck" ControlToValidate="txbNewCntr" runat="server" ForeColor="Red" Font-Bold="true" 
        ErrorMessage="This is not a Valid Container ID" ValidationExpression="^[IiOo][UuNn][Tt]?[-](\d{6})*$" SetFocusOnError="True" />
    </td><td></td><td></td></tr>
    <tr id="trErrMsg" runat="server"><td colspan="3"><asp:Label ID="lblErrMsg" runat="server" Font-Bold="True" Font-Size="Large" 
            ForeColor="Red" /></td><td></td><td></td></tr>
</table>
<table><tr valign="top">
<td><asp:gridview ID="gvContainers" runat="server" AutoGenerateColumns="False" DataSourceID="sdsTruckOut" 
onDataBound="gvContainers_onDataBound" OnRowCommand="gvContainers_onRowCommand" OnRowDataBound="gvContainers_RowDatabound" 
        CellPadding="3" DataKeyNames="outboundcontainerid" >
    <Columns>
    <asp:TemplateField> 
        <ItemTemplate> 
                <asp:LinkButton id="btnEdit" runat="server" commandname="Edit" text="Edit" /> 
        </ItemTemplate> 
        <EditItemTemplate> 
                <asp:LinkButton id="btnUpdate" runat="server" commandname="Update" text="Update" /> 
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
<%--    <asp:TemplateField HeaderText="Haz?"> 
    <ItemTemplate> 
            <asp:Label id="hazardous" runat="server" Text='<%# Eval("hazardous") %>' /> 
    </ItemTemplate> 
    <EditItemTemplate> 
            <asp:Label id="hazardous" runat="server" Text='<%# Eval("hazardous") %>' /> 
    </EditItemTemplate> 
    </asp:TemplateField>--%>
    <asp:BoundField DataField="Hazardous" HeaderText="Haz?" SortExpression="Hazardous" />
    </Columns>
    <HeaderStyle HorizontalAlign="Center" />
</asp:gridview></td>
<td>
<asp:GridView ID="gvTally" runat="server" DataSourceID="sdsTally" AutoGenerateColumns="false"
cellpadding="3" >
    <Columns>
        <asp:BoundField DataField="Name" HeaderText="Profile" SortExpression="Name" />
        <asp:BoundField DataField="NumberofCntrs" HeaderText="Cntr Count" SortExpression="NumberofCntrs" />
        <asp:BoundField DataField="outboundcontainertype" HeaderText="Cntr Type" SortExpression="outboundcontainertype" />
        <asp:BoundField DataField="TotalWeight" HeaderText="Total Act Weight" SortExpression="TotalWeight" />
    </Columns>
    <HeaderStyle ForeColor="Green" Font-Bold="true" BackColor="White" />
</asp:GridView>
</td>
</tr></table> 
<asp:SqlDataSource ID="sdsOutBoundDocNo" runat="server" DataSourceMode="DataSet" EnableCaching="false"
    ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
    SelectCommand="SP_IMDB_OutBoundDoc_Sel" SelectCommandType="StoredProcedure" FilterExpression="Completed = '0'" >
    <FilterParameters>
        <asp:ControlParameter ControlID="rblFilter" PropertyName="SelectedValue" />
    </FilterParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="sdsTally" runat="server" ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
    SelectCommand="SP_IMDB_TruckOut_Tally" SelectCommandType="StoredProcedure" >
    <SelectParameters>
        <asp:ControlParameter ControlID="ddDocList" PropertyName="SelectedValue" 
            Name="outbounddocno" Type="String" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="sdsTruckOut" runat="server" DataSourceMode="DataSet" EnableCaching="false"
    ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" OnDataBinding="sdsTruckOut_OnDataBinding"
    OnUpdating="sdsTruckOut_Updating" OnDeleting="sdsTruckOut_Deleting"
    SelectCommand="SP_IMDB_TruckOut_Sel" SelectCommandType="StoredProcedure" 
    UpdateCommand="SP_IMDB_TruckOut_AggrWt_upd" UpdateCommandType="StoredProcedure"
    DeleteCommand="SP_IMDB_TruckOut_RemoveCntr" DeleteCommandType="StoredProcedure" >
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
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Clear" runat="server"></asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Footer" runat="server"></asp:Content>
