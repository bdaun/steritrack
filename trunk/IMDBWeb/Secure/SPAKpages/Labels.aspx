<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Labels.aspx.cs" Inherits="IMDBWeb.Secure.SPAKpages.Labels" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<asp:ScriptManager ID="SM1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
<h3>Lables</h3><hr />
<asp:Label ID="lblErrMsg" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" />
<table border="2" cellpadding="10" style="background-color:#f9f9f9" width="70%" >
    <tr style="text-align:center;font-size:large;font-weight:bold;color:#003300">
        <td colspan="2">Create/Print Labels</td><td colspan="2">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="2" align="center">Select Type of Label to Create&nbsp;
            <asp:DropDownList ID="ddCreateItems" runat="server" AutoPostBack="True" Font-Size="Large" 
                onselectedindexchanged="ddCreateItems_SelectedIndexChanged">
                <asp:ListItem Text="Select an Option" Value="None" />
                <asp:ListItem Text="Truck Tag" Value="TruckTag" />
                <asp:ListItem Text="Process Tag" Value="ProcessTag" />
                <asp:ListItem Text="PassThru Tag" Value="PassThruTag" />
            </asp:DropDownList>
        </td>
        <td colspan="2" align="center">
        </td>
    </tr>
    <tr  style="vertical-align:top">
        <td colspan="2">
            <table id="tblCreateLabels" runat="server" border="0" cellpadding="10" cellspacing="0" width="98%">
                <tr><td align="right">Number of Pallet Container ID&#39;s to create</td><td>
                    <asp:TextBox ID="txbNumberContainers" runat="server" Width="50px" AutoPostBack="true" style="text-align:right" 
                        ontextchanged="txbNumberContainers_TextChanged" Font-Size="Large" />
                    </td></tr>
                <tr id="truckrow1" runat="server"><td align="right">Truck Receiving Site</td><td>
                    <asp:DropDownList ID="ddSiteSelect" runat="server" AppendDataBoundItems="True" 
                        AutoPostBack="True" DataSourceID="sdsSiteSelect" DataTextField="SiteName" Font-Size="Large" DataValueField="SiteCode">
                        <asp:ListItem Text="Select a Site" />
                    </asp:DropDownList>
                    </td></tr>
                <tr id="truckrow2" runat="server"><td align="right" style="border-top-width:1; border-right:1">Date Truck arrived at Site (mm/dd/yy)</td><td>
                    <asp:TextBox ID="txbTruckDate" runat="server" autopostback="true" Width="100px" style="text-align:right"
                        ontextchanged="txbTruckDate_TextChanged" Font-Size="Large"/>
                    </td></tr>
                <tr id="truckrow3" runat="server"><td align="right" style="border-top-width:1; border-right:1">Truck Sequence Number</td><td>
                    <asp:TextBox ID="txbTruckSeqNumber" runat="server" Width="50px" Text="001" Font-Size="large" style="text-align:right"
                        ontextchanged="txbTruckSeqNumber_TextChanged"></asp:TextBox>
                    </td></tr>
                <tr>
                    <td colspan="2" align="right">
                    <asp:Label ID="lblCreateMsg" runat="server" Visible="false" Text="Labels Created!" 
                        ForeColor="Green" Font-Bold="true" Font-Size="Large" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:Button ID="btnCreateLabel" runat="server" Text="Create Labels" 
                            onclick="btnCreateLabel_Click" />
                    <asp:Button ID="btnPrintLabel" runat="server" Text="Print Labels" 
                            onclick="btnPrintLabel_Click" Visible="false" /></td></tr>
            </table>
        </td>
        <td colspan="2">
        </td>
    </tr>
</table>
<asp:Panel ID="pnlLblPreview" runat="server" Visible="false"> 
Test 
</asp:Panel>
<asp:SqlDataSource ID="sdsSiteSelect" runat="server" 
    ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
    SelectCommand="SPAK_Labels_Site_Sel" SelectCommandType="StoredProcedure">
</asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Clear" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Footer" runat="server">
</asp:Content>
