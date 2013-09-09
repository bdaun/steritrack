<%@ Page Title="" Language="C#" MasterPageFile="~/mobile.Master" AutoEventWireup="true" CodeBehind="mLocationChange.aspx.cs" Inherits="IMDBWeb.Secure.LocationChange" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pagename" runat="server"><div class="pagename">Location Change</div></asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server"><hr />
<div>
<asp:Label ID="lblTitle" runat="server" style="font-size:x-small" Text="ContainerID"/><br />
<asp:TextBox ID="txbCntrID" runat="server" AutoPostBack="True" CssClass="style1" ontextchanged="txbCntrID_TextChanged"></asp:TextBox><br />
<asp:Button ID="BtnSubmit" runat="server" Text="Submit" onclick="BtnSubmit_Click" style="font-size: small" />
<asp:Button ID="btnClear" runat="server" Text="Clear" onclick="btnClear_Click" style="font-size: small" /><br />
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
<asp:Label ID="lblErrMsg" runat="server" Text="lblErrMsg" ForeColor="#FF3300" Visible="False" style="font-size: small; font-weight:bold" />   
</div>
<asp:formview ID="fvProcPlan" runat="server" DataSourceID="sdsProcPlanSelected" DefaultMode="Edit" >
    <EditItemTemplate>
        ProcessPlan:
        <asp:DropDownList ID="ddProcessPlan" runat="server" DataSourceID="sdsProcPlan" AutoPostBack="true" 
        DataTextField="ProcessPlan" DataValueField="ProcessPlan" SelectedValue='<%# Bind("ProcessPlan") %>' OnSelectedIndexChanged="ddProcessPlan_SelectedIndexChanged" />
    </EditItemTemplate>
    <InsertItemTemplate>
        ProcessPlan:
        <asp:TextBox ID="ProcessPlanTextBox" runat="server" Text='<%# Bind("ProcessPlan") %>' /><br />
        <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
        &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
    </InsertItemTemplate>
    <ItemTemplate>
        ProcessPlan:<asp:Label ID="ProcessPlanLabel" runat="server" Text='<%# Bind("ProcessPlan") %>' /><br />
    </ItemTemplate>
</asp:formview>
<table border="0" cellpadding="0" cellspacing="0">
<%--<tr><td><asp:Label ID="lblProcessPlan" runat="server" Text="Process Plan:" Font-Size="XX-Small" Visible="False" /></td></tr>
<tr><td><asp:DropDownList ID="ddProcessPlan" runat="server" DataSourceID="sdsProcPlan" DataTextField="ProcessPlan" DataValueField="ProcessPlan" /></td></tr>--%>
<tr><td>
    <asp:Label ID="lblNewLocation" runat="server" Text="Please enter a new location" Visible="False" />
</td></tr>
<tr><td>
    <asp:TextBox ID="txbNewLocation" runat="server" AutoPostBack="True" ontextchanged="txbNewLocation_TextChanged" />
</td></tr>
<tr><td>
    <asp:Label ID="lblOutCntr" runat="server" Text="Please scan the New Location ID" Font-Size="XX-Small" />
</td></tr>
<tr><td>
    <asp:TextBox ID="txbOutCntr" runat="server" AutoPostBack="True" ontextchanged="txbOutCntr_TextChanged" />
</td></tr>
</table>
<asp:SqlDataSource ID="sdsProcPlan" runat="server" ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
    SelectCommand="IMDB_LocChange_ProcPlan_Sel" SelectCommandType="StoredProcedure">
</asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsProcPlanSelected" runat="server" 
        ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
        SelectCommand="IMDB_LocChange_ProcPlanSelected_Sel" 
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="txbCntrID" DefaultValue="Null" Name="CntrID" 
                PropertyName="Text" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
<asp:SqlDataSource ID="RcvDetailSQL" runat="server"
        ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
        SelectCommand="IMDB_LocChange_Sel" SelectCommandType="StoredProcedure">
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
            <asp:ControlParameter ControlID="txbCntrID" DefaultValue="null" Name="OutboundContainerID" PropertyName="Text" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    </asp:Content>
