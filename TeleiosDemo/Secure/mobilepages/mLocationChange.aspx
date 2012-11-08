<%@ Page Title="" Language="C#" MasterPageFile="~/mobile.Master" AutoEventWireup="true" CodeBehind="mLocationChange.aspx.cs" Inherits="TeleiosDemo.Secure.LocationChange" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pagename" runat="server"><div class="pagename">Location Change</div></asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server"><hr /><div>
<p style="font-size:x-small">Container ID: </p>
<asp:TextBox ID="txbCntrID" runat="server" AutoPostBack="True" CssClass="style1" ontextchanged="txbCntrID_TextChanged"></asp:TextBox><br />
<asp:Button ID="BtnSubmit" runat="server" Text="Submit" onclick="BtnSubmit_Click" style="font-size: small" />
<asp:Button ID="btnClear" runat="server" Text="Clear" onclick="btnClear_Click" style="font-size: small" /><br /><br />
<asp:Label ID="lblCntrErr" runat="server" Text="CntrErrMsg" ForeColor="#FF3300" Visible="False" style="font-size: medium" Font-Size="XX-Small" Font-Bold="true"></asp:Label>
<asp:FormView ID="FormView1" runat="server" CellPadding="4" DataSourceID="RcvDetailSQL" ForeColor="#333333" Width="237px">
<EditItemTemplate>
    US_Brand_Code:
    <asp:TextBox ID="US_Brand_CodeTextBox" runat="server" Text='<%# Bind("US_Brand_Code") %>' /><br />
    ProductName:
    <asp:TextBox ID="ProductNameTextBox" runat="server" Text='<%# Bind("ProductName") %>' /><br />
    ProfileName:
    <asp:TextBox ID="ProfileNameTextBox" runat="server" Text='<%# Bind("ProfileName") %>' /><br />
    LocationName:
    <asp:TextBox ID="LocationNameTextBox" runat="server" Text='<%# Bind("LocationName") %>' /><br />
    <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />&nbsp;
    <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
</EditItemTemplate>
    <EditRowStyle BackColor="#7C6F57" />
    <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
    <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
    <ItemTemplate>
    <table cellpadding="5">
    <tr><td align="right" style="font-size: x-small; font-weight: bold">Product:  </td>
        <td><asp:Label ID="ProductNameLabel" runat="server" Text='<%# Bind("ProductName") %>' /></td>
    </tr>    
    <tr><td align="right" style="font-size: x-small; font-weight: bold">Profile:  </td>
        <td><asp:Label ID="ProfileNameLabel" runat="server" Text='<%# Bind("ProfileName") %>' /></td>
    </tr>
    <tr><td align="right" style="font-size: x-small; font-weight: bold">Location:  </td>
        <td><asp:Label ID="Label1" runat="server" Text='<%# Bind("LocationName") %>' /></td>
    </tr>
    </table>
    </ItemTemplate>
    <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
    <RowStyle BackColor="#E3EAEB" />
</asp:FormView>
<asp:FormView ID="fvOUTCntr" runat="server" DataSourceID="sdsProcLoc" 
    Width="237px" Font-Size="X-Small" ForeColor="#333333">
    <EditItemTemplate>
        OutboundLocation:
        <asp:TextBox ID="OutboundLocationTextBox" runat="server" 
            Text='<%# Bind("OutboundLocation") %>' />
        <br />
        <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" 
            CommandName="Update" Text="Update" />
        &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" 
            CausesValidation="False" CommandName="Cancel" Text="Cancel" />
    </EditItemTemplate>
    <EditRowStyle BackColor="#E3EAEB" />
    <InsertItemTemplate>
        OutboundLocation:
        <asp:TextBox ID="OutboundLocationTextBox" runat="server" 
            Text='<%# Bind("OutboundLocation") %>' />
        <br />
        <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" 
            CommandName="Insert" Text="Insert" />
        &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" 
            CausesValidation="False" CommandName="Cancel" Text="Cancel" />
    </InsertItemTemplate>
    <InsertRowStyle BackColor="#E3EAEB" />
    <ItemTemplate>
        <strong>OutboundLocation:</strong>
        <asp:Label ID="OutboundLocationLabel" runat="server" 
            Text='<%# Bind("OutboundLocation") %>' />
        <br />

    </ItemTemplate>
    <RowStyle BackColor="#E3EAEB" />
</asp:FormView>        
<asp:Label ID="lblErrMsg" runat="server" Text="lblErrMsg" ForeColor="#FF3300" 
    Visible="False" style="font-size: small; font-weight:bold"></asp:Label>
        
<asp:Label ID="lblNewLocation" runat="server" 
    Text="Please enter a new location" Visible="False"></asp:Label>
<br />
<asp:TextBox ID="txbNewLocation" runat="server" AutoPostBack="True" 
    ontextchanged="txbNewLocation_TextChanged"></asp:TextBox>
<asp:Label ID="lblOutCntr" runat="server" 
    Text="Please scan the New Location ID" Font-Size="XX-Small"></asp:Label>
<asp:TextBox ID="txbOutCntr" runat="server" AutoPostBack="True" 
    ontextchanged="txbOutCntr_TextChanged"></asp:TextBox><br />
</div>
<asp:SqlDataSource ID="RcvDetailSQL" runat="server"
        ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
        SelectCommand="Select US_Brand_Code,b.Name AS ProductName, 
        c.Name AS ProfileName,LocationName
        FROM RcvDetail a
        INNER JOIN Components b
        ON a.brandcode = b.ID
        INNER JOIN Profiles c
        ON a.InboundprofileID = c.id
        INNER JOIN Locations d
        ON a.InventoryLocation = d.LocationName
        WHERE a.inboundcontainerid = @param">
        <SelectParameters>
            <asp:ControlParameter ControlID="txbCntrID" DefaultValue="NULL" Name="param" 
                PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="LocationsSQL" runat="server" 
        ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
        SelectCommand="SELECT DISTINCT [LocationName] FROM [Locations]">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsProcLoc" runat="server"
        ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
        SelectCommand="SELECT DISTINCT [OutboundLocation] FROM [ProcDetail] WHERE ([OutboundContainerID] = @OutboundContainerID)">
        <SelectParameters>
            <asp:ControlParameter ControlID="txbCntrID" DefaultValue="null" 
                Name="OutboundContainerID" PropertyName="Text" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    </asp:Content>
