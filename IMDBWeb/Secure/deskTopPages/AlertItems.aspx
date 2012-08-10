<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AlertItems.aspx.cs" Inherits="IMDBWeb.Secure.deskTopPages.AlertItems" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h3>Alert Items Management</h3><br />
<asp:Label ID="lblErrMsg" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" />
<table id="tblSearch" runat="server">
<tr><td>Alert Item</td><td></td><td></td></tr>
<tr><td><asp:TextBox ID="txbAlertItem" runat="server" AutoPostBack="false"></asp:TextBox></td>
    <td><asp:Button ID="btnSearch" runat="server" Text="Search" onclick="btnSearch_Click" /></td><td></td>
</tr>
<tr><td colspan="2"><asp:Button ID="btnInsertShow" runat="server" Text="InsertNew" onclick="btnInsertShow_Click" />&nbsp;&nbsp;
<asp:Button ID="btnShhowAll" runat="server" Text="ShowAllActive" onclick="btnShowActive_Click" /></td>
    <td></td><td></td>
</tr>
</table>
<table id="tblInsert" runat="server">
<tr>
    <td align="right">New Alert Item:&nbsp;</td>
    <td><asp:TextBox ID="txbAlertItem_New" runat="server" /></td>
</tr>
<tr>
    <td align="right">Comment:&nbsp;</td>
    <td><asp:TextBox ID="txbComment" runat="server" TextMode="MultiLine" Rows="4" Columns="75" /></td>
</tr>
<tr>
    <td align="right">&nbsp;</td>
    <td>
        <asp:Button ID="btnInsert" runat="server" Text="Insert" onclick="btnInsert_Click" />&nbsp;&nbsp;
        <asp:Button ID="btnCancel" runat="server" Text="Cancel" onclick="btnCancel_Click" />
    </td>
</tr>
</table>
<asp:GridView ID="gvAlertItems" runat="server" AutoGenerateColumns="False" DataKeyNames="ID" DataSourceID="sdsAlertItem">
    <Columns>
        <asp:CommandField ButtonType="Button" ShowEditButton="True" />
        <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ID" />
        <asp:BoundField DataField="AlertItem" HeaderText="AlertItem" InsertVisible="False" ReadOnly="True"  SortExpression="AlertItem" />
        <asp:BoundField DataField="Comment" HeaderText="Comment" SortExpression="Comment" />
        <asp:CheckBoxField DataField="Active" HeaderText="Active" SortExpression="Active" />
        <asp:BoundField DataField="ModDate" HeaderText="ModDate" SortExpression="ModDate" DataFormatString="{0:d}" />
        <asp:BoundField DataField="ModBy" HeaderText="ModBy" SortExpression="ModBy" />
    </Columns>
</asp:GridView>
<asp:SqlDataSource ID="sdsAlertItem" runat="server" 
    ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
    OnUpdating="sdsAlertItem_Updating"
    SelectCommand="SPAK_AlertItem_Sel" SelectCommandType="StoredProcedure" 
    UpdateCommand="UPDATE SPAK_AlertItems SET Comment = @Comment,Active = @Active,ModDate = getdate(),ModBy = @User WHERE ID = @ID" 
    UpdateCommandType="Text">
    <SelectParameters>
        <asp:ControlParameter ControlID="txbAlertItem" Name="AlertItem" PropertyName="Text" Type="String" />
    </SelectParameters>
    <UpdateParameters>
        <asp:Parameter Name="ID" Type="Int32" />
        <asp:Parameter Name="Comment" Type="String" />
        <asp:Parameter Name="Active" Type="Boolean" />
        <asp:Parameter Name="User" Type="String" />
    </UpdateParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="sdsAlertItem_Active" runat="server" 
    ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
    OnUpdating="sdsAlertItem_Updating"
    SelectCommand="SPAK_AlertItem_Sel_Active" SelectCommandType="StoredProcedure"
    UpdateCommand="UPDATE SPAK_AlertItems SET Comment = @Comment,Active = @Active,ModDate = getdate(),ModBy = @User WHERE ID = @ID" 
    UpdateCommandType="Text">
    <UpdateParameters>
        <asp:Parameter Name="ID" Type="Int32" />
        <asp:Parameter Name="Comment" Type="String" />
        <asp:Parameter Name="Active" Type="Boolean" />
        <asp:Parameter Name="User" Type="String" />
    </UpdateParameters>
</asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Clear" runat="server"></asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Footer" runat="server"></asp:Content>
