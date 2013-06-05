<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CVSReconciliation.aspx.cs" Inherits="IMDBWeb.Secure.SPAKpages.CVSReconciliation" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<asp:ScriptManager ID="sm1" runat="server" />
<h3>CVS Reconciliation Page</h3><hr /><br />
<asp:Label ID="lblErrMsg" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" /><br />
<asp:Label ID="lblEnterTruckID" runat="server" Text="Please scan/Enter a TruckID to begin:" Font-Size="Large" />&nbsp;&nbsp;
<asp:TextBox ID="txbTruckID" runat="server" AutoPostBack="true" ontextchanged="txbTruckID_TextChanged" Font-Size="X-Large" />&nbsp;&nbsp;
<asp:Button ID="btnSubmit" runat="server" Text="Submit" onclick="btnSubmit_Click" />&nbsp;&nbsp;
<asp:Button ID="btnReset" runat="server" Text="Reset" onclick="btnReset_Click" /><br />
<table border="0" cellpadding="0" cellspacing="0">
    <tr id="trBoxFound" runat="server">
        <td>
            <asp:Label ID="lblBoxText1" runat="server" Font-Size="Large" />&nbsp;&nbsp;
            <asp:Label ID="lblBoxCount1" runat="server" Font-Size="X-Large" Font-Bold="true" Font-Italic="true" ForeColor="Green" />&nbsp;&nbsp;
            <asp:Label ID="lblBoxText2" runat="server" Font-Size="Large" />&nbsp;&nbsp;
            <asp:Label ID="lblBoxCount2" runat="server" Font-Size="X-Large" Font-Bold="true" Font-Italic="true" ForeColor="Green" />&nbsp;&nbsp;
            <asp:Label ID="lblBoxText3" runat="server" Font-Size="Large" />&nbsp;&nbsp;
            <asp:Label ID="lblTruckID" runat="server" Font-Size="X-Large" Font-Bold="true" Font-Italic="true" ForeColor="Green" />
        </td>
    </tr>
    <tr id="trBoxNotFound" runat="server">
        <td>
            <asp:Label ID="lblBoxNotFound" runat="server" Font-Size="X-Large" Font-Bold="true" Text="No Boxes found for this TruckID" />
        </td>
    </tr>
</table>
<br />
<table border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td>
            <asp:GridView ID="gvBoxRecon" runat="server" AutoGenerateColumns="False" 
                DataSourceID="sdsBoxesToReconcile" Visible="False"
             CellPadding="4" Font-Size="Large" AllowSorting="True">
                <Columns>
                    <asp:BoundField DataField="Manifest" HeaderText="Manifest" SortExpression="Manifest" HeaderStyle-ForeColor="DarkGreen" />
                    <asp:BoundField DataField="BoxCntrID" HeaderText="BoxCntrID" SortExpression="BoxCntrID" HeaderStyle-ForeColor="DarkGreen" />
                    <asp:TemplateField HeaderText="Reconciled" SortExpression="Reconciled">
                        <ItemTemplate>
                            <asp:Image runat="Server" ImageUrl='<%# Convert.ToBoolean(Eval("Reconciled")) ? "~/images/check_mark_green.png" : "~/images/x_mark_Red.jpg"%>' Height="28px" />
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                        <HeaderStyle ForeColor="DarkGreen" />
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </td>
        <td id="tdBoxRecon" runat="server" valign="top" style="padding-left:25px" >
            <asp:Label ID="lblReconBox" runat="server" Text="Scan/Enter a Box to be reconciled" Font-Size="Large" />&nbsp;&nbsp;
            <asp:TextBox ID="txbReconBox" runat="server" Font-Size="X-Large" AutoPostBack="true" OnTextChanged="txbReconBox_TextChanged" />&nbsp;&nbsp&nbsp;
            <asp:Button ID="btnReconBox" runat="server" Text="Submit" OnClick="btnReconBox_Click" /><br />
            <asp:Label ID="lblReconErrMsg" runat="server" Visible="false" Font-Bold="true" Font-Size="Large" ForeColor="Red" /><br />
            <asp:Label ID="lblReconMoreBoxes" runat="server" Font-Size="Large" Font-Italic="true" />
            <asp:Label ID="lblCurReconBox" runat="server" Visible="false" Font-Size="XX-small" />
            <asp:GridView ID="gvReconMoreBoxes" runat="server" AutoGenerateColumns="False" 
                DataSourceID="sdsReconMoreBoxes" OnDataBound="sdsReconMoreBoxes_DataBound">
                <Columns>
                    <asp:BoundField DataField="BoxCntrID" HeaderText="BoxCntrID" SortExpression="BoxCntrID" />
                     <asp:TemplateField HeaderText="Reconciled" SortExpression="Reconciled">
                        <ItemTemplate>
                            <asp:Image ID="Image1" runat="Server" ImageUrl='<%# Convert.ToBoolean(Eval("Reconciled")) ? "~/images/check_mark_green.png" : "~/images/x_mark_Red.jpg"%>' Height="28px" />
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        &nbsp;</td>
    </tr>
</table>
<asp:SqlDataSource ID="sdsBoxesToReconcile" runat="server" 
    ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
    SelectCommand="SPAK_CVSRecon_Boxes_Sel" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:ControlParameter ControlID="txbTruckID" Name="TruckCntrID" PropertyName="Text" Type="String" />
    </SelectParameters>
</asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsReconMoreBoxes" runat="server" 
        ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>"
        SelectCommand="SPAK_CVSRecon_MoreBoxes_Sel" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblCurReconBox" Name="BoxCntrID" PropertyName="Text" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Clear" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Footer" runat="server">
</asp:Content>
