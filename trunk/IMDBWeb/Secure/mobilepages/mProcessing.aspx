<%@ Page Title="" Language="C#" MasterPageFile="~/mobile.Master" AutoEventWireup="true" CodeBehind="mProcessing.aspx.cs" Inherits="IMDBWeb.Secure.Processing" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server"></asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="pagename" runat="server"><div class="pagename">Processing</div></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server"><hr />
    <asp:Label ID="lblScan" runat="server" Font-Size="X-Small" Text="Scan/Enter an IN Cntr to process: "></asp:Label>    
    <asp:TextBox ID="txbCntrID" runat="server" AutoPostBack="True" ontextchanged="txbCntrID_TextChanged"></asp:TextBox>&nbsp;<br />
    <asp:Button ID="btnSubmit" runat="server" Font-Size="x-Small" Text="Submit" onclick="btnSubmit_Click" />&nbsp;
    <asp:Button ID="btnClear" runat="server" Font-Size="x-Small" onclick="btnClear_Click" Text="Clear" /><br />
    <asp:Label ID="lblErrMsg" runat="server" Text="ErrMsg" ForeColor="Red"></asp:Label>
    <asp:Button ID="btnInsCntr" runat="server" Font-Size="x-Small" onclick="btnInsCntr_Click" Text="Cntr" />&nbsp&nbsp
    <asp:Button ID="btnInsCompact" runat="server" Font-Size="x-Small" onclick="btnIns_Compact_Click" Text="Cmpct" />&nbsp&nbsp
    <asp:Button ID="btnInsBale" runat="server" Font-Size="x-Small" onclick="btnIns_Bale_Click" Text="Bale" />&nbsp&nbsp
    <asp:Button ID="btnDone" runat="server" Font-Size="X-Small" onclick="btnDone_Click" Text="Done" /><br />
    <asp:Label ID="lblOutCntr" runat="server" Font-Size="X-Small" CssClass="bold" Text="New CntrID: "></asp:Label>
    <asp:TextBox ID="txbOutCntr" runat="server" ontextchanged="txbOutCntr_TextChanged" AutoPostBack="True"></asp:TextBox><br />
    <asp:Label ID="lblDots" runat="server" Text="..........................................................." /><br />
    <asp:Label ID="lblHeader" runat="server" Font-Size="X-Small" CssClass="bold" Text="Process Header Results"></asp:Label>
    <asp:FormView ID="fvProcHdr" runat="server" DataSourceID="sdsProcHdr" Font-Size="X-Small">
        <ItemTemplate>
            ID:<asp:Label ID="lblID" runat="server" Text='<%# Bind("ID") %>'></asp:Label>&nbsp;&nbsp;
            Process Date:<asp:Label ID="lblProcDate" runat="server" Text='<%# bind("ProcessDate") %>'></asp:Label><br />
        </ItemTemplate>
    </asp:FormView>
    
    <asp:Label ID="lblProcDetails" runat="server" Font-Size="X-Small" CssClass="bold" Text="Process Details"></asp:Label>&nbsp;&nbsp;
    <asp:GridView ID="gvProcDetails" runat="server" AutoGenerateColumns="False" 
        DataKeyNames="ID" DataSourceID="sdsProcDetail" Font-Size="X-Small">
        <Columns>
            <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ID" />
            <asp:BoundField DataField="OutboundContainerID" HeaderText="CntrID" SortExpression="OutboundContainerID" />
            <asp:BoundField DataField="OutboundLocation" HeaderText="Location" SortExpression="OutboundLocation" />
        </Columns>
    </asp:GridView>
<asp:SqlDataSource ID="sdsProcDetail" runat="server" 
    ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
    DeleteCommand="DELETE FROM [ProcDetail] WHERE [ID] = @ID" 
    InsertCommand="INSERT INTO [ProcDetail] ([ProcHdrID], [OutboundStreamType], [OutboundStreamWeight], [ActShipWt], [OutboundStreamProfile], [OutboundContainerType], [OutboundContainerID], [OutboundPalletType], [OutboundLocation], [OutboundDocNo], [ProcessMethod], [Shipped], [OutboundCntrQty]) VALUES (@ProcHdrID, @OutboundStreamType, @OutboundStreamWeight,@OutboundStreamWeight, @OutboundStreamProfile, @OutboundContainerType, @OutboundContainerID, @OutboundPalletType, @OutboundLocation, @OutboundDocNo, @ProcessMethod, @Shipped, @OutboundCntrQty)" 
    SelectCommand="SELECT a.[ID], a.[ProcHdrID], a.[OutboundStreamType], a.[OutboundStreamWeight], a.[OutboundStreamProfile], a.[OutboundContainerType], a.[OutboundContainerID], a.[OutboundPalletType], a.[OutboundLocation], a.[OutboundDocNo], a.[ProcessMethod], a.[Shipped], a.[OutboundCntrQty] FROM [ProcDetail] a INNER JOIN [Prochdr] b ON b.[ID] = a.[ProcHdrID] WHERE (b.[InboundContainerID]= @CntrID)" 
    UpdateCommand="UPDATE [ProcDetail] SET [ProcHdrID] = @ProcHdrID, [OutboundStreamType] = @OutboundStreamType, [OutboundStreamWeight] = @OutboundStreamWeight, [OutboundStreamProfile] = @OutboundStreamProfile, [OutboundContainerType] = @OutboundContainerType, [OutboundContainerID] = @OutboundContainerID, [OutboundPalletType] = @OutboundPalletType, [OutboundLocation] = @OutboundLocation, [OutboundDocNo] = @OutboundDocNo, [ProcessMethod] = @ProcessMethod, [Shipped] = @Shipped, [OutboundCntrQty] = @OutboundCntrQty WHERE [ID] = @ID">
    <DeleteParameters>
        <asp:Parameter Name="ID" Type="Int32" />
    </DeleteParameters>
    <InsertParameters>
        <asp:Parameter Name="ProcHdrID" Type="Int32" />
        <asp:Parameter Name="OutboundStreamType" Type="String" />
        <asp:Parameter Name="OutboundStreamWeight" Type="Int32" />
        <asp:Parameter Name="OutboundStreamProfile" Type="Int32" />
        <asp:Parameter Name="OutboundContainerType" Type="String" />
        <asp:Parameter Name="OutboundContainerID" Type="String" />
        <asp:Parameter Name="OutboundPalletType" Type="String" />
        <asp:Parameter Name="OutboundLocation" Type="String" />
        <asp:Parameter Name="OutboundDocNo" Type="String" />
        <asp:Parameter Name="ProcessMethod" Type="String" />
        <asp:Parameter Name="Shipped" Type="Boolean" />
        <asp:Parameter Name="OutboundCntrQty" Type="Int32" />
    </InsertParameters>
    <SelectParameters>
        <asp:ControlParameter ControlID="txbCntrID" DefaultValue="NULL" Name="CntrID" PropertyName="Text" />
    </SelectParameters>
    <UpdateParameters>
        <asp:Parameter Name="ProcHdrID" Type="Int32" />
        <asp:Parameter Name="OutboundStreamType" Type="String" />
        <asp:Parameter Name="OutboundStreamWeight" Type="Int32" />
        <asp:Parameter Name="OutboundStreamProfile" Type="Int32" />
        <asp:Parameter Name="OutboundContainerType" Type="String" />
        <asp:Parameter Name="OutboundContainerID" Type="String" />
        <asp:Parameter Name="OutboundPalletType" Type="String" />
        <asp:Parameter Name="OutboundLocation" Type="String" />
        <asp:Parameter Name="OutboundDocNo" Type="String" />
        <asp:Parameter Name="ProcessMethod" Type="String" />
        <asp:Parameter Name="Shipped" Type="Boolean" />
        <asp:Parameter Name="OutboundCntrQty" Type="Int32" />
        <asp:Parameter Name="ID" Type="Int32" />
    </UpdateParameters>
</asp:SqlDataSource>

<asp:SqlDataSource ID="sdsProcHdr" runat="server" 
    ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
    SelectCommand="SELECT * FROM [ProcHdr] WHERE ([InboundContainerID] = @InboundContainerID)">
    <SelectParameters>
        <asp:ControlParameter ControlID="txbCntrID" DefaultValue="Null" 
            Name="InboundContainerID" PropertyName="Text" Type="String" />
    </SelectParameters>
</asp:SqlDataSource>
</asp:Content>
