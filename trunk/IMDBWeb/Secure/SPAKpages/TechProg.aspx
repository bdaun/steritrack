<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TechProg.aspx.cs" 
        Inherits="IMDBWeb.Secure.SPAKpages.TechProg" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<script type="text/javascript">function setHeight(txtdesc) {txtdesc.style.height = txtdesc.scrollHeight + "px";}</script>
<table style="width: 65%;">
    <tr align="center">
        <td>Customer Rep</td>
        <td>Technician</td>
        <td>Customer</td>
        <td>Beginning Date</td>
        <td>Ending Date</td>
        <td></td>
    </tr>
    <tr align="center">
        <td>
            <asp:DropDownList ID="ddCustRepList" runat="server" AutoPostBack="True" 
                DataSourceID="sdsCustomerReps" DataTextField="CustServRepID" 
                DataValueField="CustServRepID" AppendDataBoundItems="true"
                onselectedindexchanged="ddCustRepList_SelectedIndexChanged">
            <asp:ListItem Text="Select From" Value="0" Selected="True">Select a CS Rep</asp:ListItem>
            <asp:ListItem Text="(All)" Value="All" />
            </asp:DropDownList>
        </td>
        <td>
            <asp:DropDownList ID="ddTechName_CSRep" runat="server" 
                DataSourceID="sdsTechName_CSRep" DataTextField="TechName" 
                DataValueField="TechnicianID" AutoPostBack="True" 
                onselectedindexchanged="ddTechName_CSRep_SelectedIndexChanged" EnableViewState="False" AppendDataBoundItems="True">
                <asp:ListItem Text="Select a Technician" Value = "" />
                <asp:ListItem Text="(All)" Value="All" />
            </asp:DropDownList><br />
        </td>
        <td>
            <asp:DropDownList ID="ddCustomer" runat="server"  
                AutoPostBack="True">
                <asp:ListItem Text="Select a Customer" Value = "" />
                <asp:ListItem Text="(All)" Value="All" />
                <asp:ListItem Text="WalMart" Value="A20050062" />
                <asp:ListItem Text="Rite Aid" Value="AL559592" />
                <asp:ListItem Text="CVS" Value="AL20090641" />
                <asp:ListItem Text="Costco" Value="AL20080027" />
                <asp:ListItem Text="Walgreens" Value="AL20060112" />
                <asp:ListItem Text="Target" Value="A20080097" />
            </asp:DropDownList>
        </td>
        <td><asp:TextBox ID="txbBeginDate" runat="server" Width="100px"></asp:TextBox>
        <ajaxToolKit:CalendarExtender ID="calExtBegin" runat="server" TargetControlID="txbBeginDate" /></td>
        <td><asp:TextBox ID="txbEndDate" runat="server" Width="100px"></asp:TextBox>
        <ajaxToolKit:CalendarExtender ID="calExtEnd" runat="server" TargetControlID="txbEndDate" /></td>
        <td><asp:Button ID="btnGO" runat="server" onclick="btnGo_Click" Text="Go" /></td>
    </tr>
    <tr align="center"><td></td><td><asp:Label ID="lblPhone" runat="server" Font-Size="X-Small" Text="" />
    </td><td></td><td></td><td></td><td></td></tr>
</table>
<table>
<tr valign="top">
<td>
<ajaxToolkit:ToolkitScriptManager ID="sm" runat="server" EnablePartialRendering="true" />
<asp:UpdatePanel ID="udpGridView" runat="server">
    <Triggers>
        <asp:AsyncPostBackTrigger ControlID="btnGO" EventName="Click" />
        <asp:AsyncPostBackTrigger ControlID="gvTechName" EventName="SelectedIndexChanged" />
    </Triggers>
<ContentTemplate>
<asp:UpdateProgress ID="progGridView" runat="server" DisplayAfter="2000" DynamicLayout="true">
    <ProgressTemplate>
        <img src="../../images/progress.gif" alt="" />
    </ProgressTemplate>
</asp:UpdateProgress>
<asp:CheckBox ID="chkShipped" runat="server" Checked="false" OnCheckedChanged="chkShipped_Changed" AutoPostBack="true" /> Show "Shipped" Records
<asp:GridView ID="gvTechName" runat="server" AllowSorting="True" 
        AutoGenerateColumns="False" DataSourceID="sdsTechData" 
        EmptyDataText="Empty Data Set" ShowHeaderWhenEmpty="True" 
        OnRowDataBound="gvTechName_RowDataBound" DataKeyNames="SalesOrderNumber"
        OnSelectedIndexChanged="gvTechName_SelectedIndexChanged" CellPadding="4" 
        ForeColor="#333333" GridLines="Horizontal"
        SelectedRowStyle-BackColor = "#ffff99">
    <Columns>
        <asp:BoundField DataField="TechName" HeaderText="Technician" SortExpression="TechName" ItemStyle-Wrap="False" />
        <asp:BoundField DataField="DateRequired" HeaderText="Date Needed" HtmlEncode="False" DataFormatString = "{0:d}" SortExpression="DateRequired" />
        <asp:BoundField DataField="SalesOrderNumber" HeaderText="Order" SortExpression="SalesOrderNumber" />
        <asp:BoundField DataField="SiteName" HeaderText="Store" SortExpression="name" />
        <asp:BoundField DataField="SiteNumber" HeaderText="Store Number" SortExpression="SiteNumber" />
        <asp:BoundField DataField="Address1" HeaderText="Address" SortExpression="Address1" />
        <asp:BoundField DataField="City" HeaderText="City" SortExpression="City" />
        <asp:BoundField DataField="State" HeaderText="State" SortExpression="State" />
        <asp:BoundField DataField="PlannedVisitDate" HeaderText="Planned Date" SortExpression="PlannedVisitDate" DataFormatString="{0:d}" />
        <asp:BoundField DataField="SPAKStatus" HeaderText="SPAK Status" SortExpression="SPAKStatus" />
        <asp:BoundField DataField="CallStatus" HeaderText="Call Status" SortExpression="CallStatus" />
    </Columns>
    <EditRowStyle BackColor="#7C6F57" />
    <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
    <HeaderStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#333333" />
    <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
</asp:GridView>
        </ContentTemplate>
    </asp:UpdatePanel>
</td>
<td>
<asp:UpdatePanel ID="udpdvCallLog" runat="server">
<Triggers>
    <asp:AsyncPostBackTrigger ControlID="gvTechName" 
        EventName="SelectedIndexChanged" />
</Triggers>
<ContentTemplate>
    <asp:UpdateProgress ID="UpdateProgress1" runat="server" DisplayAfter="500" DynamicLayout="true">
        <ProgressTemplate>
            <img src="../../images/progress.gif" alt="" style="width: 300px; height: 22px" />
        </ProgressTemplate>
    </asp:UpdateProgress>
    <asp:DetailsView ID="dvCallLog" runat="server" AutoGenerateRows="False" 
        DataKeyNames="OrderNumber" DataSourceID="sdsCallDetail" 
        DefaultMode="Edit" AutoGenerateEditButton="true">
        <Fields>
            <asp:BoundField DataField="OrderNumber" Visible="false" />
            <asp:TemplateField>
                <EditItemTemplate>
                <table>
                    <tr>
                        <td align="right">Order Number:&nbsp</td>
                        <td align="left"><asp:Label ID="lblOrderNumber" runat="server" Text='<%# bind("OrderNumber") %>' Font-Bold="True" ForeColor="Black"></asp:Label></td></tr>
                    <tr>
                        <td align="right">Status:&nbsp</td>
                        <td align="left"><asp:DropDownList ID="ddStatus" runat="server" 
                            SelectedValue='<%# bind("Status") %>'>
                            <asp:ListItem Text="-" Value="-" />
                            <asp:ListItem Text="Will Not Visit Today" Value="WNV" />
                            <asp:ListItem Text="Will Visit Today" Value="WV"/>
                            <asp:ListItem Text="Shipped" Value="Shipped" />
                            </asp:DropDownList></td>
                    </tr>
                    <tr>
                        <td align="right">Planned Visit Date:&nbsp</td>
                        <td align="left"><asp:textbox ID="txbVisitDate" runat="server" Text='<%# bind("PlannedVisitDate","{0:MM/dd/yyyy}") %>'></asp:textbox>
                        <asp:RegularExpressionValidator ID="revDate" ControlToValidate="txbVisitDate" runat="server" Font-Bold="true" ForeColor="Red" Text="*" ErrorMessage="Please enter a date as mm/dd/yyyy" 
                            ValidationExpression="(((0?[1-9]|1[012])[/.](0?[1-9]|1\d|2[0-8])|(0?[13456789]|1[012])[/.](29|30)|(0?[13578]|1[02])/31)[/.](19|[2-9]\d)\d{2}|0?2[/.]29[/.]((19|[2-9]\d)(0[48]|[2468][048]|[13579][26])|(([2468][048]|[3579][26])00)))">
                        </asp:RegularExpressionValidator></td>
                    </tr>
                    <tr>
                        <td align="right">Miles Traveled:&nbsp</td>
                        <td align="left"><asp:textbox ID="txbMilesTrav" runat="server" Text='<%# bind("MilesTrav") %>'></asp:textbox>
                        <asp:RegularExpressionValidator ID="revMiles" ControlToValidate="txbMilesTrav" runat="server" Font-Bold="true" ForeColor="Red" Text="*" ErrorMessage="Please enter miles as a whole number" 
                            ValidationExpression="\b\d+\b"></asp:RegularExpressionValidator></td>
                    </tr>
                    <tr>
                        <td align="right">Time at Store (hrs):&nbsp</td>
                        <td align="left"><asp:textbox ID="txbTimeAtStore" runat="server" Text='<%# bind("TimeAtStore") %>'></asp:textbox>
                        <asp:RegularExpressionValidator ID="revTime" ControlToValidate="txbTimeAtStore" runat="server" Font-Bold="true" ForeColor="Red" Text="*" ErrorMessage="Please enter a value in hours.  Use 1.5 to designate 1 1/2 hours" 
                            ValidationExpression="((\b[0-9]+)?\.)?[0-9]+\b"></asp:RegularExpressionValidator></td>
                    </tr>
                    <tr>
                        <td align="right" >Move to Tech:&nbsp</td>
                        <td align="left"><asp:textbox ID="txbMovetoTech" runat="server" Text='<%# bind("MovetoTech") %>'></asp:textbox></td>
                    </tr>
                    <tr>
                        <td align="right">Comment:&nbsp</td>
                        <td align="left"><asp:textbox ID="txbComment" runat="server"  Text='<%# bind("Comment") %>' TextMode="MultiLine" 
                        onkeyup="setHeight(this);" onkeydown="setHeight(this);" onclick="setHeight(this);"></asp:textbox></td>
                    </tr>
                    </table>
                    <table>
                    <tr><td colspan="4" align="center" style="font-weight:bold">
                    <hr/> Issue items</td><td></td></tr>
                    <tr>
                        <td class="tblCheckbox"><asp:CheckBox ID="chkSupplies" runat="server" Checked='<%# bind("chkSupplies") %>' /></td>
                        <td class="tblCheckItem">Insufficient Supplies</td>
                        <td class="tblCheckbox"><asp:CheckBox ID="chkEquipment" runat="server" Checked='<%# bind("chkEquipment") %>' /></td>
                        <td class="tblCheckItem">Printer/ Hardware</td>
                    </tr>
                    <tr>
                        <td class="tblCheckbox"><asp:CheckBox ID="chkWeather" runat="server" Checked='<%# bind("chkWeather") %>' /></td>
                        <td class="tblCheckItem">Weather/ Accident</td>
                        <td class="tblCheckbox"><asp:CheckBox ID="chkSoftware" runat="server" Checked='<%# bind("chkSoftware") %>' /></td>
                        <td class="tblCheckItem">Comp/ Sync/ software</td>
                    </tr>
                    <tr>
                        <td class="tblCheckbox"><asp:CheckBox ID="chkTruck" runat="server" Checked='<%# bind("chkTruck") %>' /></td>
                        <td class="tblCheckItem">Truck Breakdown</td>
                        <td class="tblCheckbox"><asp:CheckBox ID="chkStop" runat="server" Checked='<%# bind("chkStop") %>' /></td>
                        <td class="tblCheckItem">Overweight/ Urgent drop</td>
                    </tr>
                    </table>
                    <table>
                    <tr><td colspan="4"><hr /></td><td></td></tr>
                    <tr style="font-size:x-small">
                        <td align="right">Modified By:&nbsp</td>
                        <td align="left"><asp:Label ID="lblUser" runat="server" Text='<%# bind("ModBy") %>'></asp:Label></td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr style="font-size:x-small">
                        <td align="right">Updated:&nbsp</td>
                        <td align="left"><asp:Label ID="Label1" runat="server" Text='<%# bind("ModDate") %>'></asp:Label></td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr align="left">
                        <td colspan="4"><br /><asp:ValidationSummary ID="ValidationSummary1" runat="server" HeaderText="The following error(s) occur:" ShowMessageBox="false" DisplayMode="BulletList" ShowSummary="true" ForeColor="Red" Font-Bold="true" />
                        </td>
                    </tr>
                </table>
                </EditItemTemplate>
            </asp:TemplateField>
        </Fields>
    </asp:DetailsView>
    </ContentTemplate>
</asp:UpdatePanel>
        </td>
   </tr>
  </table>
<asp:SqlDataSource ID="sdsCallDetail" runat="server" OnUpdating="sdsCallDetail_Updating" OnUpdated="sdsCallDetail_Updated"
    ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
    SelectCommand="SELECT * FROM [SPAK_CallInfo] WHERE ([OrderNumber] = @OrderNumber)"
    UpdateCommand="UPDATE Spak_CallInfo SET Status=@Status,MilesTrav=@MilesTrav,TimeAtStore=@TimeAtStore,Comment=@Comment,
                    MovetoTech=@MoveToTech,PlannedVisitDate=@PlannedVisitDate,ModDate=getdate(),ModBy=@Modby,
                    chkSupplies = @chkSupplies,chkEquipment = @chkEquipment,chkWeather = @chkWeather,
                    chkStop = @chkStop,chkSoftware = @chkSoftware,chkTruck = @chkTruck
                    WHERE OrderNumber = @OrderNumber">
    <SelectParameters>
        <asp:ControlParameter ControlID="gvTechName" Name="OrderNumber" PropertyName="SelectedValue" Type="String" />
    </SelectParameters>
    <UpdateParameters>
        <asp:Parameter Name="staus" Type="String" /> 
        <asp:Parameter Name="MilesTrav" Type="Int32" />
        <asp:Parameter Name="TimeAtStore" Type="Decimal" />
        <asp:Parameter Name="Comment" Type="String" />
        <asp:Parameter Name="MovetoTech" Type="String" />
        <asp:Parameter Name="PlannedVisitDate" Type="DateTime" />
        <asp:Parameter Name="ModDate" Type="DateTime" />
        <asp:Parameter Name="ModBy" Type="String"/>
        <asp:Parameter Name="chkSupplies" Type="Byte" />
        <asp:Parameter Name="chkEquipment" Type="Byte" />
        <asp:Parameter Name="chkWeather" Type="Byte" />
        <asp:Parameter Name="chkStop" Type="Byte" />
        <asp:Parameter Name="chkSoftware" Type="Byte" />
        <asp:Parameter Name="chkTruck" Type="Byte" />
        <asp:Parameter Name="OrderNumber" Type="String" />
    </UpdateParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="sdsCustomerReps" runat="server" ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
    SelectCommand="SELECT DISTINCT CustServRepID FROM SPAK_TechCSMap Order by CustServRepID">
</asp:SqlDataSource>
<asp:SqlDataSource ID="sdsTechData" runat="server" OnSelecting="sdsTechData_Selecting"
    ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
    SelectCommand="SPAK_TechProg_TechData_Sel" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:ControlParameter ControlID="ddCustRepList" Name="repname" PropertyName="SelectedValue" Type="String" />
        <asp:ControlParameter ControlID="ddCustomer" Name="Customer" PropertyName="SelectedValue" Type="String" />
        <asp:ControlParameter ControlID="ddTechName_CSRep" Name="technicianid" PropertyName="SelectedValue" Type="String" />
        <asp:ControlParameter ControlID="txbBeginDate" Name="date1" PropertyName="Text" Type="DateTime" />
        <asp:ControlParameter ControlID="txbEndDate" Name="date2" PropertyName="Text" Type="DateTime" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="sdsTechName_CSRep" runat="server" 
    ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
    SelectCommand="SPAK_TechProg_TechNamePerCS_Sel" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:ControlParameter ControlID="ddCustRepList" Name="CSrep" PropertyName="SelectedValue" Type="String" />
    </SelectParameters>
</asp:SqlDataSource>
</asp:Content>
