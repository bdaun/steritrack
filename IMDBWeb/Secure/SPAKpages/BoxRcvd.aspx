<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BoxRcvd.aspx.cs" Inherits="IMDBWeb.Secure.SPAKpages.BoxRcvd" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<ajaxToolkit:ToolkitScriptManager ID="SM1" runat="server" EnablePageMethods="true" />
<script type="text/javascript">
    function CommentChanged_Changed() {
        document.all('ctl00$MainContent$txbPalletCntrID').focus();
        return false;
    }
</script>
<h3>Box Receiving</h3><hr />
<asp:Label ID="lblErrMsg" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" />
<table border="0" cellpadding="0" cellspacing="10">
    <tr align="center">
        <td><asp:Label ID="lblTruckCntrID" runat="server" Text="TruckCntrID" style="font-size:xx-large;font-weight:bold" /></td>
        <td> <asp:Label ID="lblBoxCntrID" runat="server" Text="BoxCntrID" style="font-size:xx-large;font-weight:bold" /></td>
        <td><asp:Label ID="lblPalletCntrID" runat="server" Text="PalletCntrID" style="font-size:xx-large;font-weight:bold" /></td>
    </tr>
    <tr>
        <td><asp:TextBox ID="txbTruckCntrID" runat="server" Font-Size="XX-Large" AutoPostBack="true" ontextchanged="txbTruckCntrID_TextChanged" /></td>
        <td><asp:TextBox ID="txbBoxCntrID" runat="server" Font-Size="XX-Large" AutoPostBack="true" ontextchanged="txbBoxCntrID_TextChanged" /></td>
        <td><asp:TextBox ID="txbPalletCntrID" runat="server" Font-Size="XX-Large" AutoPostBack="true" ontextchanged="txbPalletCntrID_TextChanged" /></td>
    </tr>
    <tr>
        <td colspan="3">
            <table>
                <tr style="padding-bottom:10px">
                    <td align="right"><asp:Label ID="lblFacility" runat="server" Text="Facility:" Font-Size="XX-Large" Font-Bold="true" />&nbsp;&nbsp;</td>
                    <td style="width:100%; border-color:gray; border-style:solid; border-width:1px"><asp:Label ID="lblFacilityName" runat="server" Font-Size="XX-Large" /></td>
                </tr>
                <tr style="padding-top:10px">
                    <td align="right"><asp:Label ID="lblProfile" runat="server" Text="Profile:" Font-Size="XX-Large" Font-Bold="true" />&nbsp;&nbsp;</td>
                    <td style="width:100%; border-color:gray; border-style:solid; border-width:1px"><asp:Label ID="lblProfileName" runat="server" Font-Size="XX-Large" /></td>
                </tr>
            </table>
        </td>
    </tr>
    <tr id="trBoxNotFound" runat="server">
        <td colspan="3">
        <table id="tblBoxNotFound" runat="server" border="0" cellpadding="0" cellspacing="5" >
            <tr><td colspan="4">&nbsp;</td></tr>
            <tr style="font-size:larger; color:Black">
                <td align="center">Possibly Controlled</td>
                <td align="center">Suggested Profile Name</td>
                <td align="center">Manifest/DocNumber</td>
                <td align="center">Store</td>
            </tr>
            <tr>
                <td align="center"><asp:CheckBox ID="chkCntrl" runat="server" /></td>
                <td><asp:DropDownList ID="ddProfile" runat="server" DataSourceID="sdsProfile" 
                        DataTextField="ProfileName" DataValueField="ProfileName" AppendDataBoundItems="true">
                        <asp:ListItem Text="Select a Profile" Value="" />
                    </asp:DropDownList>
                </td>
                <td><asp:TextBox ID="txbManifest" runat="server" /></td>
                <td><asp:DropDownList ID="ddStore" runat="server" DataSourceID="sdsStore" 
                        DataTextField="Site" DataValueField="Site" AppendDataBoundItems="true">
                        <asp:ListItem Text="Select a Store" Value=" :" />
                        <asp:ListItem Text="No Information Available" Value="NA : NA" />
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td style="font-size:larger; color:Black; text-align:right">Comment:&nbsp;</td>
                <td colspan="3"><asp:textbox ID="txbComments" runat="server" TextMode="MultiLine" Width="100%" Onblur="return CommentChanged_Changed()" /></td>
            </tr>
            <tr><td colspan="4">&nbsp;</td></tr>
        </table>
        </td>
        <td style="text-align:right"></td>
    </tr>
    <tr><td colspan="2"></td>
        <td align="right">
            <asp:Button ID="btnSubmit" runat="server" Text="Submit" 
                onclick="btnSubmit_Click" />&nbsp;&nbsp;
            <asp:Button ID="btnReset" runat="server" Text="Reset" CausesValidation="false" onclick="btnReset_Click" />&nbsp;&nbsp;
            <asp:Button ID="btnClose" runat="server" Text="Done" onclick="btnClose_Click" CausesValidation="false" />&nbsp;</td></tr>
</table>
<br />
    <asp:GridView ID="gvBoxData" runat="server" AutoGenerateColumns="False" CellPadding="4"
        DataKeyNames="id" DataSourceID="sdsBoxRcvd" 
        AllowSorting="True">
        <Columns>
            <asp:CommandField ShowDeleteButton="True" />
            <asp:BoundField DataField="id" HeaderText="id" InsertVisible="False" ReadOnly="True" SortExpression="id" />
            <asp:BoundField DataField="TruckCntrID" HeaderText="TruckCntrID" SortExpression="TruckCntrID" />
            <asp:BoundField DataField="BoxCntrID" HeaderText="BoxCntrID" SortExpression="BoxCntrID" />
            <asp:BoundField DataField="Facility_Name" HeaderText="Facility_Name" SortExpression="Facility_Name" />
            <asp:BoundField DataField="Profile_Name" HeaderText="Profile_Name" SortExpression="Profile_Name" />
            <asp:BoundField DataField="PalletCntrID" HeaderText="PalletCntrID" SortExpression="PalletCntrID" />
            <asp:BoundField DataField="ModDate" HeaderText="ModDate" SortExpression="ModDate" />
            <asp:BoundField DataField="UserName" HeaderText="UserName" SortExpression="UserName" />
        </Columns>
            <EditRowStyle BackColor="White" />
            <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#333333" HorizontalAlign="Center" />
            <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
            <SelectedRowStyle BackColor="#FFFF99"></SelectedRowStyle>
    </asp:GridView>
            <asp:SqlDataSource ID="sdsProfile" runat="server" 
                ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
                SelectCommand="SPAK_BoxRcvd_Profile_Sel" SelectCommandType="StoredProcedure">
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="sdsStore" runat="server" 
                ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
                SelectCommand="SPAK_BoxRcvd_Store_Sel" SelectCommandType="StoredProcedure">
            </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsBoxRcvd" runat="server" 
        ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
        SelectCommand="SPAK_BoxRcvd_Sel" SelectCommandType="StoredProcedure"
        DeleteCommand="SPAK_BoxRcvd_Del" DeleteCommandType="StoredProcedure">
    </asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Clear" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Footer" runat="server">
</asp:Content>
