<%@ Page Title="" Language="C#" MasterPageFile="~/mobile.Master" AutoEventWireup="true" CodeBehind="mProcessing.aspx.cs" Inherits="TeleiosDemo.Secure.Processing" %>
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
    SelectCommand="IMDB_Processing_ProcDetail_Sel" SelectCommandType="StoredProcedure" >
    <SelectParameters>
        <asp:ControlParameter ControlID="txbCntrID" DefaultValue="NULL" Name="CntrID" PropertyName="Text" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="sdsProcHdr" runat="server" 
    ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
    SelectCommand="IMDB_Processing_ProcHdr_Sel" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:ControlParameter ControlID="txbCntrID" DefaultValue="Null" Name="InboundContainerID" PropertyName="Text" Type="String" />
    </SelectParameters>
</asp:SqlDataSource>
</asp:Content>
