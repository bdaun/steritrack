<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MgtSummary.aspx.cs" Inherits="IMDBWeb.Secure.SPAKpages.GridViewGrouping" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h3>Spak Tech Mgt Reporting</h3>
<hr />
<table width="75%">
<tr>
    <td align="right"><asp:Label ID="lblCustRep" runat="server" Text="Customer Rep:"></asp:Label>&nbsp</td>
    <td>
        <asp:DropDownList ID="ddCustomerRep" runat="server" AutoPostBack="True"
            DataSourceID="sdsCM" DataTextField="CustServRepID" 
            DataValueField="CustServRepID" AppendDataBoundItems="True"
            onselectedindexchanged="ddCustomerRep_SelectedIndexChanged" >
            <asp:ListItem Text="Select a CM" Value = "zzz" Selected="True" />
            <asp:ListItem Text="(All)" Value="All" />
        </asp:DropDownList>
    </td>
    <td>&nbsp;</td>
    <td><asp:Label ID="lblStore" runat="server" Text="Site Name:"></asp:Label></td>
    <td>
        <asp:TextBox ID="txbSiteName" runat="server" 
            ontextchanged="txbSiteName_TextChanged" AutoPostBack="true"></asp:TextBox>
    </td>
    <td>&nbsp;</td>
    <td align="right"><asp:Label ID="lblBeginDate" runat="server" Text="BeginDate:"></asp:Label>&nbsp</td>
    <td>
        <asp:TextBox ID="txbBegDate" runat="server" ontextchanged="txbBegDate_TextChanged" AutoPostBack="true"></asp:TextBox>
        <ajaxToolKit:CalendarExtender ID="calExtBegin" runat="server" TargetControlID="txbBegDate" />
    </td>
    <td>
        </td>
    <td align="center">
        
    </td>
    <td>
        &nbsp;</td>
</tr>
<tr>
    <td align="right"><asp:Label ID="lblTech" runat="server" Text="Technician:"></asp:Label>&nbsp</td>
    <td>
        <asp:DropDownList ID="ddTechName" runat="server" 
            DataSourceID="sdsTech" DataTextField="TechName" 
            DataValueField="TechnicianID" AutoPostBack="true"
            onselectedindexchanged="ddTechName_SelectedIndexChanged" EnableViewState="false" AppendDataBoundItems="true">
            <asp:ListItem Text="Select a Technician" Value = "ALL" />
            <asp:ListItem Text="(All)" Value="All" />
        </asp:DropDownList>
    </td>
    <td></td>
    <td><asp:Label ID="lblSiteCity" runat="server" Text="Site City:"></asp:Label></td>
    <td>
        <asp:TextBox ID="txbSiteCity" runat="server" ontextchanged="txb_TextChanged" AutoPostBack="true"></asp:TextBox>
    </td>
    <td>&nbsp;</td>
    <td align="right"><asp:Label ID="lblEndDate" runat="server" Text="EndDate:"></asp:Label>&nbsp</td>
    <td>
        <asp:TextBox ID="txbEndDate" runat="server" ontextchanged="txbEndDate_TextChanged" AutoPostBack="true"></asp:TextBox>
        <ajaxToolKit:CalendarExtender ID="calExtEnd" runat="server" TargetControlID="txbEndDate" />
    </td>
    <td>
        &nbsp;</td>
    <td align="center">
    </td>
    <td>
        &nbsp;</td>
</tr>
<tr>
    <td align="right"><asp:Label ID="lblCustomer" runat="server" Text="Customer:"></asp:Label>&nbsp</td>
    <td>
        <asp:DropDownList ID="ddCustomer" runat="server" 
            onselectedindexchanged="ddCustomer_SelectedIndexChanged" AutoPostBack="true">
            <asp:ListItem Text="Select a Customer" Value = "ALL" />
            <asp:ListItem Text="(All)" Value="All" />
            <asp:ListItem Text="WalMart" Value="A20050062" />
            <asp:ListItem Text="Rite Aid" Value="AL559592" />
            <asp:ListItem Text="CVS" Value="AL20090641" />
            <asp:ListItem Text="Costco" Value="AL20080027" />
            <asp:ListItem Text="Walgreens" Value="AL20060112" />
            <asp:ListItem Text="Target" Value="A20080097" />
        </asp:DropDownList>
    </td>
    <td></td>
    <td><asp:Label ID="lblSiteState" runat="server" Text="Site State:"></asp:Label></td>
    <td>
        <asp:TextBox ID="txbSiteState" runat="server" ontextchanged="txbSiteState_TextChanged" AutoPostBack="true"></asp:TextBox>
    </td>
    <td>&nbsp;</td>
    <td align="right"><asp:Label ID="lblSpakStatus" runat="server" Text="SpakStatus:"></asp:Label>&nbsp</td>
    <td>
        <asp:DropDownList ID="ddSSpakStatus" runat="server" onselectedindexchanged="ddSSpakStatus_SelectedIndexChanged" AutoPostBack="true">
            <asp:ListItem Text="Select a SPAK Status" Value = "ALL" />
            <asp:ListItem Text="(All)" Value="ALL" />
            <asp:ListItem Text="Account Manager" Value="Account Manager" />
            <asp:ListItem Text="Authorized" Value="Authorized" />
            <asp:ListItem Text="Cancel" Value="Cancel" />
            <asp:ListItem Text="Completed" Value="Completed" />
            <asp:ListItem Text="New" Value="New" />
            <asp:ListItem Text="Partial" Value="Partial" />
            <asp:ListItem Text="Review" Value="Review" />
            <asp:ListItem Text="Scheduled" Value="Scheduled" />
            <asp:ListItem Text="Shipped" Value="Shipped" />
        </asp:DropDownList>
    </td>
    <td>
        &nbsp;</td>
    <td>
        &nbsp</td>
    <td>
        &nbsp;</td>
</tr>
<tr>
    <td colspan ="2">
    Group By Rep<asp:CheckBox ID="chkGroupRep" runat="server" Checked="false" AutoPostBack="true" />
    Group By Tech<asp:CheckBox ID="chkGroupTech" runat="server" Checked="false" AutoPostBack="true" />
    </td>
    <td></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td align="right"><asp:Label ID="lblCallStatus" runat="server" Text="CallStatus:"></asp:Label>&nbsp</td>
    <td>
        <asp:DropDownList ID="ddCallStatus" runat="server" onselectedindexchanged="ddCallStatus_SelectedIndexChanged" AutoPostBack="true">
            <asp:ListItem Text="Select a Call Status" Value = "ALL" />
            <asp:ListItem Text="(All)" Value="All" />
            <asp:ListItem Text="-" Value="-" />
            <asp:ListItem Text="Will Not Visit Today" Value="WNV" />
            <asp:ListItem Text="Will Visit Today" Value="WV"/>
            <asp:ListItem Text="Shipped" Value="Shipped" />
        </asp:DropDownList>
    </td>
    <td>
        &nbsp;</td>
    <td>
        &nbsp;</td>
    <td>
        &nbsp;</td>
</tr>
</table>
<hr id="hr1" runat="server" />
<asp:Button ID="btnExport" runat="server" onclick="btnExport_Click" Text="Export to Excel" />
<asp:ScriptManager ID="sm" runat="server" EnablePartialRendering="True"></asp:ScriptManager>
<asp:UpdatePanel ID="udpGridView" runat="server">
<Triggers>
    <asp:PostBackTrigger ControlID="ddCustomerRep"  />
    <asp:AsyncPostBackTrigger ControlID="ddTechName" EventName="SelectedIndexChanged" />
    <asp:AsyncPostBackTrigger ControlID="ddCustomer" EventName="SelectedIndexChanged" />
    <asp:AsyncPostBackTrigger ControlID="txbSiteName" EventName="TextChanged" />
    <asp:AsyncPostBackTrigger ControlID="txbSiteCity" EventName="TextChanged" />
    <asp:AsyncPostBackTrigger ControlID="txbSiteState" EventName="TextChanged" />
    <asp:AsyncPostBackTrigger ControlID="txbBegDate" EventName="TextChanged" />
    <asp:AsyncPostBackTrigger ControlID="txbEndDate" EventName="TextChanged" />
    <asp:AsyncPostBackTrigger ControlID="ddSSpakStatus" EventName="SelectedIndexChanged" />
    <asp:AsyncPostBackTrigger ControlID="ddCallStatus" EventName="SelectedIndexChanged" />
    <asp:AsyncPostBackTrigger ControlID="chkGroupRep" EventName="CheckedChanged" />
    <asp:AsyncPostBackTrigger ControlID="chkGroupTech" EventName="CheckedChanged" />
</Triggers>
<ContentTemplate>
<asp:Label ID="lblRecordCount" runat="server" Text="Record Count:"></asp:Label>&nbsp
<asp:TextBox ID="txbRecordCount" runat="server" Width="30px" ReadOnly="true"></asp:TextBox>&nbsp&nbsp
<asp:UpdateProgress ID="progGridView" runat="server" DisplayAfter="2000" DynamicLayout="true">
    <ProgressTemplate>
        <img src="../../images/progress.gif" alt="" />
    </ProgressTemplate>
</asp:UpdateProgress>
<asp:GridView ID="gvSummaryData" runat="server" AutoGenerateColumns="false" DataSourceID="sdsSummaryData" 
    AllowSorting="True" OnRowDataBound="gvSummaryData_RowDataBound" OnPreRender="gvSummaryData_PreRender">
    <Columns>
        <asp:BoundField DataField="SPAKStatus" HeaderText="SPAK Status" SortExpression="SPAKStatus" ItemStyle-HorizontalAlign="Center" >
        <ItemStyle HorizontalAlign="Center" />
        </asp:BoundField>
        <asp:BoundField DataField="CallStatus" HeaderText="Call Status" SortExpression="CallStatus" ItemStyle-HorizontalAlign="Center" >
        <ItemStyle HorizontalAlign="Center" />
        </asp:BoundField>
        <asp:BoundField DataField="custservrepID" HeaderText="CM Name" SortExpression="custservrepID" />
        <asp:BoundField DataField="techname" HeaderText="Tech Name" SortExpression="techname" />
        <asp:BoundField DataField="OrderNumber" HeaderText="Order Number" SortExpression="OrderNumber" />
        <asp:BoundField DataField="DateNeeded" HeaderText="Date Needed" SortExpression="DateNeeded" DataFormatString="{0:d}" />
        <asp:BoundField DataField="PlannedVisitDate" HeaderText="Planned VisitDate" SortExpression="PlannedVisitDate" DataFormatString="{0:d}" />
        <asp:BoundField DataField="SiteName" HeaderText="Site Name" SortExpression="SiteName" />
        <asp:BoundField DataField="StoreNumber" HeaderText="Store Number" SortExpression="StoreNumber" />
        <asp:BoundField DataField="SiteCity" HeaderText="Site City" SortExpression="SiteCity" />
        <asp:BoundField DataField="SiteState" HeaderText="Site State" SortExpression="SiteState" />
        <asp:BoundField DataField="MilesTraveledtoStore" HeaderText="Mls2Store" SortExpression="MilesTraveledtoStore" ItemStyle-HorizontalAlign="Center" ><ItemStyle HorizontalAlign="Center"></ItemStyle></asp:BoundField>
        <asp:BoundField DataField="TimeAtStore" HeaderText="Time At Store" SortExpression="TimeAtStore" ItemStyle-HorizontalAlign="Center" ><ItemStyle HorizontalAlign="Center"></ItemStyle></asp:BoundField>
        <asp:BoundField DataField="OrderComments" HeaderText="Order Comments" SortExpression="OrderComments" />
        <asp:CheckBoxField DataField="SuppliesNeeded" HeaderText="Supplies Needed" SortExpression="SuppliesNeeded" ItemStyle-HorizontalAlign="Center" ><ItemStyle HorizontalAlign="Center"></ItemStyle></asp:CheckBoxField>
        <asp:CheckBoxField DataField="EquipmentIssues" HeaderText="Equipment Issues" SortExpression="EquipmentIssues" ItemStyle-HorizontalAlign="Center" ><ItemStyle HorizontalAlign="Center"></ItemStyle></asp:CheckBoxField>
        <asp:CheckBoxField DataField="WeatherIssues" HeaderText="Weather Issues" SortExpression="WeatherIssues" ItemStyle-HorizontalAlign="Center" ><ItemStyle HorizontalAlign="Center"></ItemStyle></asp:CheckBoxField>
        <asp:CheckBoxField DataField="TruckIssues" HeaderText="Truck Issues" SortExpression="TruckIssues" ItemStyle-HorizontalAlign="Center" ><ItemStyle HorizontalAlign="Center"></ItemStyle></asp:CheckBoxField>
        <asp:CheckBoxField DataField="SiteIssues" HeaderText="Site Issues" SortExpression="SiteIssues" ItemStyle-HorizontalAlign="Center" ><ItemStyle HorizontalAlign="Center"></ItemStyle></asp:CheckBoxField>
        <asp:CheckBoxField DataField="SoftwareIssues" HeaderText="Software Issues" SortExpression="SoftwareIssues" ItemStyle-HorizontalAlign="Center" ><ItemStyle HorizontalAlign="Center"></ItemStyle></asp:CheckBoxField>
    </Columns>
    <EmptyDataRowStyle Font-Size="X-Large" ForeColor="Red" />
    <HeaderStyle BackColor="#FFCC66" ForeColor="#333333" />
</asp:GridView>
</ContentTemplate>
</asp:UpdatePanel>
<asp:GridView ID="gvExport" runat="server" Visible="false" DataSourceID="sdsSummaryData">
</asp:GridView>
<asp:SqlDataSource ID="sdsSummaryData" runat="server" 
    ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
    SelectCommand="SPAK_MgtSummary_Sel" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:ControlParameter ControlID="ddCustomerRep" Name="repname" PropertyName="SelectedValue" Type="String" DefaultValue="ALL" />
        <asp:ControlParameter ControlID="ddCustomer" Name="Customer" PropertyName="SelectedValue" Type="String" DefaultValue="ALL" />
        <asp:ControlParameter ControlID="ddTechName" Name="technicianID" PropertyName="SelectedValue" Type="String" DefaultValue="ALL" />
        <asp:ControlParameter ControlID="txbBegDate" Name="date1" PropertyName="Text" Type="DateTime" DefaultValue="" />
        <asp:ControlParameter ControlID="txbEndDate" Name="date2" PropertyName="Text" Type="DateTime" DefaultValue="" />
        <asp:ControlParameter ControlID="txbSiteName" DefaultValue="ALL" Name="sitename" PropertyName="Text" Type="String" />
        <asp:ControlParameter ControlID="txbSiteState" DefaultValue="ALL" Name="sitestate" PropertyName="Text" Type="String" />
        <asp:ControlParameter ControlID="txbSiteCity" DefaultValue="ALL" Name="sitecity" PropertyName="Text" Type="String" />
        <asp:ControlParameter ControlID="ddSSpakStatus" DefaultValue="ALL" Name="spakstatus" PropertyName="SelectedValue" Type="String" />
        <asp:ControlParameter ControlID="ddCallStatus" DefaultValue="ALL" Name="callstatus" PropertyName="SelectedValue" Type="String" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="sdsCM" runat="server" 
    ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
    SelectCommand="SPAK_MgtSummary_CMName_Sel" SelectCommandType="StoredProcedure">
</asp:SqlDataSource>
<asp:SqlDataSource ID="sdsTech" runat="server" 
    ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
    SelectCommand="SPAK_TechProg_TechNamePerCS_Sel" SelectCommandType="StoredProcedure">
        <SelectParameters>
        <asp:ControlParameter ControlID="ddCustomerRep" Name="CSrep" PropertyName="SelectedValue" Type="String" />
    </SelectParameters>
</asp:SqlDataSource>
</asp:Content>
