<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManifestRcvd.aspx.cs" Inherits="IMDBWeb.Secure.SPAKPages.ManifestRcvd" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ScriptManager ID="SM1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
<h3>Manifest Receiving</h3><hr />
<asp:Label ID="lblErrMsg" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" />
<table border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td style="font-size:large;font-weight:bold;text-align:center" >TruckID</td>
        <td></td>
        <td style="font-size:large;font-weight:bold;text-align:center">Manifest / Document Number</td><td></td>
    </tr>
    <tr>
        <td><asp:TextBox ID="txbTruckID" runat="server" Width="400" Font-Size="XX-Large" 
                TabIndex="1" ontextchanged="txbTruckID_TextChanged" autopostback="true" 
                ToolTip="Use format of ##-mm/dd/yy-###" CausesValidation="true" /></td>
        <td>&nbsp;</td>
        <td>
            <asp:TextBox ID="txbInboundDocNo" runat="server" Width="400" Font-Size="XX-Large" TabIndex="2"
            ontextchanged="txbInboundDocNo_TextChanged" autopostback="true" CausesValidation="true" /></td>
        <td style="padding-left:4px">
            <asp:Button ID="btnOverride" runat="server" Text="Override" Visible="false" Font-Size="Large" onclick="btnOverride_Click" />
        </td>
    </tr>
    <tr>
        <td colspan="2">
            <asp:RequiredFieldValidator ID="rfvTxbTruckID" runat="server" ControlToValidate="txbTruckID" CssClass="failureNotification" Font-Bold="true"
                ErrorMessage="TruckID is required." /><br />
            <asp:RegularExpressionValidator ID="revTxbTruckID" runat="server" ControlToValidate="txbTruckID" SetFocusOnError="true"
                ValidationExpression="(\d\d[-]0[1-9]|1[012])[/](0[1-9]|[12][0-9]|3[01])[/][01]\d[-]\d\d\d" 
                ErrorMessage="Please use a TruckID format of XX-mm/dd/yy-##X" Font-Bold="true" ForeColor="Red" CssClass="failureNotification" /></td>
                <td style="vertical-align:top; text-align:right"><asp:Button ID="btnClose" 
                        runat="server" Text="Done" onclick="btnClose_Click" CausesValidation="false" /></td>
        <td>&nbsp;</td>
    </tr>
    <tr><td colspan="4"><h5>Recent Manifests Received</h5></td></tr>
</table>
    <asp:GridView ID="gvManifestData" runat="server" AllowPaging="True" CellPadding="4"
        AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="id" 
        DataSourceID="sdsManifestRcvd">
        <Columns>
            <asp:CommandField ShowDeleteButton="True" />
            <asp:BoundField DataField="id" HeaderText="id" InsertVisible="False" ReadOnly="True" SortExpression="id" />
            <asp:BoundField DataField="TruckID" HeaderText="TruckID" SortExpression="TruckID" />
            <asp:BoundField DataField="inboundDocNo" HeaderText="inboundDocNo" SortExpression="inboundDocNo" />
            <asp:BoundField DataField="ModDate" HeaderText="ModDate" SortExpression="ModDate" />
            <asp:BoundField DataField="UserName" HeaderText="UserName" SortExpression="UserName" />
        </Columns>
            <EditRowStyle BackColor="White" />
            <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#333333" HorizontalAlign="Center" />
            <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
            <SelectedRowStyle BackColor="#FFFF99"></SelectedRowStyle>
    </asp:GridView>
<asp:SqlDataSource ID="sdsManifestRcvd" runat="server" 
    ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
    SelectCommand="SPAK_ManifestRcvd_Sel" SelectCommandType="StoredProcedure"
    DeleteCommand="SPAK_ManifestRcvd_Del" DeleteCommandType="StoredProcedure">
</asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Clear" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Footer" runat="server">
</asp:Content>
