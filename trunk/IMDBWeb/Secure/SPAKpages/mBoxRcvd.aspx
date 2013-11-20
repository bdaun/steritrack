<%@ Page Title="" Language="C#" MasterPageFile="~/Mobile.Master" AutoEventWireup="true" CodeBehind="mBoxRcvd.aspx.cs" Inherits="IMDBWeb.Secure.SPAKpages.mBoxRcvd" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headcontent" runat="server">
    <style type="text/css">
        .style1
        {
            width: 57px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pagename" runat="server"><div class="pagename">Mobile Box Received</div></asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
<asp:ScriptManager ID="SM1" runat="server" EnablePageMethods="true" />
<script type="text/javascript">
    function CommentChanged_Changed() {
        document.all('ctl00$MainContent$txbPalletCntrID').focus();
        return false;
    }
</script>
<asp:Label ID="lblErrMsg" runat="server" Font-Bold="True" Font-Size="Small" ForeColor="Red" />
<table width="100%">
<tr><td class="style1"><asp:Label ID="lblTruckCntrID" runat="server" Text="TrkID:" 
                style="font-size:small; font-weight:bold" /></td><td><asp:TextBox ID="txbTruckCntrID" runat="server" Font-Size="XX-Large" 
                AutoPostBack="true" ontextchanged="txbTruckCntrID_TextChanged" 
                style="font-size:small;width:95%" /></td></tr>
<tr><td class="style1"> <asp:Label ID="lblBoxCntrID" runat="server" Text="BoxID:" 
                style="font-size:small; font-weight:bold" /></td><td><asp:TextBox ID="txbBoxCntrID" runat="server" Font-Size="XX-Large" 
                AutoPostBack="true" ontextchanged="txbBoxCntrID_TextChanged" 
                style="font-size: small;width:95%" /></td></tr>
<tr><td class="style1"><asp:Label ID="lblPalletCntrID" runat="server" Text="PalletID:" 
                style="font-size:small; font-weight:bold" /></td><td><asp:TextBox ID="txbPalletCntrID" runat="server" Font-Size="XX-Large" 
                AutoPostBack="true" ontextchanged="txbPalletCntrID_TextChanged" 
                style="font-size: small;width:95%" /></td></tr>
<tr><td class="style1"><asp:Label ID="lblFacility" runat="server" Text="Facility:" 
                            Font-Size="XX-Large" Font-Bold="true" style="font-size: small" /></td><td>
                        <asp:Label ID="lblFacilityName" runat="server" Font-Size="XX-Large" 
                            style="font-size: small" /></td></tr>
<tr><td class="style1"><asp:Label ID="lblProfile" runat="server" Text="Profile:" 
                            Font-Size="XX-Large" Font-Bold="true" style="font-size: small" /></td><td>
                        <asp:Label ID="lblProfileName" runat="server" Font-Size="XX-Large" 
                            style="font-size: small" /></td></tr>
</table>
<table border="0" cellpadding="0" cellspacing="10" width="100%">
    <tr id="trBoxNotFound" runat="server">
        <td colspan="2">
        <table id="tblBoxNotFound" runat="server" border="0" cellpadding="0" cellspacing="5" width="100%" >
            <tr><td colspan="2">&nbsp;</td></tr>
            <tr style="font-size:larger; color:Black"><td>&nbsp;Cntrl?</td><td align="left"><asp:CheckBox ID="chkCntrl" runat="server" /></td></tr>
            <tr style="font-size:larger; color:Black"><td>Profile</td><td><asp:DropDownList ID="ddProfile" runat="server" DataSourceID="sdsProfile" 
                        DataTextField="ProfileName" DataValueField="ProfileName" AppendDataBoundItems="true">
                        <asp:ListItem Text="Select a Profile" Value="" />
                    </asp:DropDownList>
                </td></tr>
            <tr style="font-size:larger; color:Black"><td>Manifest</td><td><asp:TextBox ID="txbManifest" runat="server" /></td></tr>
            <tr style="font-size:larger; color:Black"><td>Store</td><td><asp:DropDownList ID="ddStore" runat="server" DataSourceID="sdsStore" 
                        DataTextField="Site" DataValueField="Site" AppendDataBoundItems="true">
                        <asp:ListItem Text="Select a Store" Value=" :" />
                        <asp:ListItem Text="No Information Available" Value="NA : NA" />
                    </asp:DropDownList>
                </td></tr>
            <tr style="font-size:larger; color:Black"><td style="font-size:larger; color:Black; text-align:right">Comment:&nbsp;</td> <td colspan="3"><asp:textbox ID="txbComments" runat="server" TextMode="MultiLine" Width="100%" Onblur="return CommentChanged_Changed()" /></td></tr>
            <tr><td colspan="2">&nbsp;</td></tr>
        </table>
        </td>
    </tr>
    <tr>
        <td align="right">
            <asp:Button ID="btnSubmit" runat="server" Text="Submit" 
                onclick="btnSubmit_Click" />&nbsp;&nbsp;
            <asp:Button ID="btnReset" runat="server" Text="Reset" CausesValidation="false" onclick="btnReset_Click" />&nbsp;&nbsp;
            <asp:Button ID="btnClose" runat="server" Text="Done" onclick="btnClose_Click" CausesValidation="false" />&nbsp;</td></tr>
</table>
<br />
<asp:SqlDataSource ID="sdsProfile" runat="server" 
    ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
    SelectCommand="SPAK_BoxRcvd_Profile_Sel" SelectCommandType="StoredProcedure">
</asp:SqlDataSource>
<asp:SqlDataSource ID="sdsStore" runat="server" 
    ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
    SelectCommand="SPAK_BoxRcvd_Store_Sel" SelectCommandType="StoredProcedure">
</asp:SqlDataSource>
</asp:Content>
