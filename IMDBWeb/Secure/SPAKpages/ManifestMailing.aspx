<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManifestMailing.aspx.cs" Inherits="IMDBWeb.Secure.SPAKPages.ManifestMailing" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<script type="text/javascript">    function setHeight(txtdesc) { txtdesc.style.height = txtdesc.scrollHeight + "px"; }</script>
<asp:UpdatePanel ID="udpMailGV" runat="server" UpdateMode="Conditional">
<ContentTemplate>
<asp:ScriptManager ID="sm1" runat="server" />
<table>
<tr><td>I would like to:</td><td></td></tr>
<tr><td><asp:RadioButtonList ID="rbList1" runat="server" AutoPostBack="True" onselectedindexchanged="rbList1_SelectedIndexChanged">
<asp:ListItem>See all unmailed manifests by Age</asp:ListItem>
<asp:ListItem>Manage manifest mailing by Truck Tag</asp:ListItem>
<asp:ListItem>Manage manifest mailing by Manifest Number</asp:ListItem>
</asp:RadioButtonList></td><td></td></tr>
<tr><td><asp:Button ID="btnReset" runat="server" onclick="btnReset_Click" Font-Size="Small" Text="Reset" />
    </td></tr>
</table>
<asp:UpdateProgress ID="progGridView" runat="server" DisplayAfter="2000" DynamicLayout="true">
    <ProgressTemplate>
        <img src="../../images/progress.gif" alt="" style="width: 350px; height: 25px" />
    </ProgressTemplate>
</asp:UpdateProgress>
<asp:Label ID="lblErrMsg" runat="server" Text="" /><br />
<asp:Label ID="lblSelParam" runat="server" Text="" />&nbsp;&nbsp;
<asp:TextBox ID="txbSelParam" runat="server" AutoPostBack="True" ontextchanged="txbSelParam_TextChanged" />
<asp:RegularExpressionValidator ID="revSelParam" runat="server" ControlToValidate="txbSelParam"></asp:RegularExpressionValidator>
<table><tr id="trUpdateAll" runat="server">
<td style="font-size:large; color: #0000FF;">
Set all rows to &quot;Mailed&quot; with a Mailed Date of
<asp:TextBox ID="txbMailDate" runat="server"  />
<ajaxToolKit:CalendarExtender ID="txbMailDate_CalEx" runat="server" TargetControlID="txbMailDate" />&nbsp;&nbsp;
<asp:Button ID="btnGo" runat="server" Text="Go" onclick="btnGo_Click" /></td>
<td>
    <asp:Label ID="lblDateErr" runat="server" Font-Bold="True" ForeColor="Red" Text="Please Enter a Mailed Date" Visible="false"></asp:Label></td></tr></table>
<asp:GridView ID="gvManifestStatus" runat="server" AutoGenerateColumns="False" 
    DataSourceID="sdsManifestMail_Date" CellPadding="2" 
        DataKeyNames="InboundDocNo,TruckID" AllowSorting="True" >
    <Columns>
        <asp:CommandField ShowEditButton="True" CausesValidation="False" />
        <asp:TemplateField HeaderText="TruckID" HeaderStyle-HorizontalAlign="Center" SortExpression="TruckID">
        <EditItemTemplate>
        <asp:Label ID="TruckID" runat="server" Text='<%# Eval("TruckID") %>' />
        </EditItemTemplate>
        <ItemTemplate>
        <asp:Label ID="TruckID" runat="server" Text='<%# Eval("TruckID") %>' />
        </ItemTemplate>
        <HeaderStyle HorizontalAlign="Center" />
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Manifest" SortExpression="InboundDocNo">
        <EditItemTemplate>
        <asp:Label ID="InboundDocNo" runat="server" Text='<%# Eval("InboundDocNo") %>' />
        </EditItemTemplate>
        <ItemTemplate>
        <asp:Label ID="InboundDocNo" runat="server" Text='<%# Eval("InboundDocNo") %>' />
        </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Date Serviced" SortExpression="DateService">
        <EditItemTemplate>
        <asp:Label ID="DateService" runat="server" Text='<%# Eval("DateService","{0:MM/dd/yyyy}") %>' />
        </EditItemTemplate>
        <ItemTemplate>
        <asp:Label ID="DateService" runat="server" Text='<%# Eval("DateService","{0:MM/dd/yyyy}") %>' />
        </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Age" SortExpression="Age">
        <EditItemTemplate>
        <asp:Label ID="Age" runat="server" Text='<%# Eval("Age") %>'  />
        </EditItemTemplate>
        <ItemTemplate>
        <asp:Label ID="Age" runat="server" Text='<%# Eval("Age") %>' />
        </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Mailed" SortExpression="Mailed">
        <EditItemTemplate>
        <asp:CheckBox ID="Mailed" runat="server" Checked='<%# Bind("Mailed") %>' Enabled="true" />
        </EditItemTemplate>
        <ItemTemplate>
        <asp:CheckBox ID="Mailed" runat="server" Checked='<%# Eval("Mailed") %>' Enabled="false" />
        </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Date Mailed" SortExpression="Datemailed">
        <EditItemTemplate>
        <asp:TextBox ID="DateMailed" runat="server" Text='<%# Bind("DateMailed","{0:MM/dd/yyyy}") %>' Width="100px" />
        <ajaxToolKit:CalendarExtender ID="DateMailed_CalEx" runat="server" TargetControlID="DateMailed" />
        </EditItemTemplate>
        <ItemTemplate>
        <asp:Label ID="DateMailed" runat="server" Text='<%# Eval("DateMailed","{0:MM/dd/yyyy}") %>' Width="100px" />
        </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Discrepancy" SortExpression="Discrepancy">
        <EditItemTemplate>
        <asp:CheckBox ID="Discrepancy" runat="server" Checked='<%# Bind("Discrepancy") %>' Enabled="true" />
        </EditItemTemplate>
        <ItemTemplate>
        <asp:CheckBox ID="Discrepancy" runat="server" Checked='<%# Eval("Discrepancy") %>' Enabled="false" />
        </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Date Failed" SortExpression="DateFailed">
        <EditItemTemplate>
        <asp:TextBox ID="DateFailed" runat="server" Text='<%# Bind("DateFailed","{0:MM/dd/yyyy}") %>' Width="100px" />
        <ajaxToolKit:CalendarExtender ID="DateFailed_CalEx" runat="server" TargetControlID="DateFailed" />
        </EditItemTemplate>
        <ItemTemplate>
        <asp:Label ID="DateFailed" runat="server" Text='<%# Eval("DateFailed","{0:MM/dd/yyyy}") %>' Width="100px" />
        </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Comment" SortExpression="Comment">
        <EditItemTemplate>
        <asp:TextBox ID="Comment" runat="server" Text='<%# Bind("Comment") %>' Width="400px" TextMode="MultiLine" 
                        onkeyup="setHeight(this);" onkeydown="setHeight(this);" onclick="setHeight(this);" CssClass="gridcomment" />
        </EditItemTemplate>
        <ItemTemplate>
        <asp:Label ID="Comment" runat="server" Text='<%# Eval("Comment") %>' Width="400px" CssClass="gridcomment" />
        </ItemTemplate>
        </asp:TemplateField>
    </Columns>
    <EditRowStyle HorizontalAlign="Center" />
    <AlternatingRowStyle HorizontalAlign="Center" />
    <HeaderStyle HorizontalAlign="Center" />
    <RowStyle HorizontalAlign="Center" />
</asp:GridView>
<asp:SqlDataSource ID="sdsManifestMail_Date" runat="server" 
    ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
    SelectCommand="SPAK_ManifestMail_Date" SelectCommandType="StoredProcedure"
    UpdateCommand="Update SpakManifestRcvd Set Mailed=@Mailed,DateMailed=@DateMailed,Discrepancy=@Discrepancy,DateFailed=@DateFailed,
    Comment=@Comment,UserName=@User,moddate=GetDate() WHERE (InboundDocNo=@InboundDocNo AND TruckID=@TruckID)" OnUpdating="sdsManifestMail_Date_Updating" >
    <UpdateParameters>
    <asp:Parameter Name="Mailed" Type="Byte" />
    <asp:Parameter Name="DateMailed" Type="DateTime" />
    <asp:Parameter Name="Discrepancy" Type="Byte" />
    <asp:Parameter Name="DateFailed" Type="DateTime" />
    <asp:Parameter Name="Comment" Type="String" />
    <asp:Parameter Name="InboundDocNo" Type="String" />
    <asp:Parameter Name="User" Type="String" />
    <asp:Parameter Name="TruckID" Type="String" />
    </UpdateParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="sdsManifestMail_TruckID" runat="server" 
    ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
    SelectCommand="SPAK_ManifestMail_TruckID" SelectCommandType="StoredProcedure"
    UpdateCommand="Update SpakManifestRcvd Set Mailed=@Mailed,DateMailed=@DateMailed,Discrepancy=@Discrepancy,DateFailed=@DateFailed,
    Comment=@Comment,UserName=@User,moddate=GetDate() WHERE (InboundDocNo=@InboundDocNo AND TruckID=@TruckID)" OnUpdating="sdsManifestMail_Date_Updating" >
    <UpdateParameters>
    <asp:Parameter Name="Mailed" Type="Byte" />
    <asp:Parameter Name="DateMailed" Type="DateTime" />
    <asp:Parameter Name="Discrepancy" Type="Byte" />
    <asp:Parameter Name="DateFailed" Type="DateTime" />
    <asp:Parameter Name="Comment" Type="String" />
    <asp:Parameter Name="InboundDocNo" Type="String" />
    <asp:Parameter Name="User" Type="String" />
    <asp:Parameter Name="TruckID" Type="String" />
    </UpdateParameters>
    <SelectParameters>
    <asp:ControlParameter ControlID="txbSelParam" DefaultValue="NULL" Name="TruckID" PropertyName="Text" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="sdsManifestMail_Manifest" runat="server" 
    ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
    SelectCommand="SPAK_ManifestMail_Manifest" SelectCommandType="StoredProcedure"
    UpdateCommand="Update SpakManifestRcvd Set Mailed=@Mailed,DateMailed=@DateMailed,Discrepancy=@Discrepancy,DateFailed=@DateFailed,
    Comment=@Comment,UserName=@User,moddate=GetDate() WHERE (InboundDocNo=@InboundDocNo AND TruckID=@TruckID)" OnUpdating="sdsManifestMail_Date_Updating" >
    <UpdateParameters>
    <asp:Parameter Name="Mailed" Type="Byte" />
    <asp:Parameter Name="DateMailed" Type="DateTime" />
    <asp:Parameter Name="Discrepancy" Type="Byte" />
    <asp:Parameter Name="DateFailed" Type="DateTime" />
    <asp:Parameter Name="Comment" Type="String" />
    <asp:Parameter Name="InboundDocNo" Type="String" />
    <asp:Parameter Name="TruckID" Type="String" />
    <asp:Parameter Name="User" Type="String" />
    </UpdateParameters>
    <SelectParameters>
    <asp:ControlParameter ControlID="txbSelParam" DefaultValue="NULL" Name="InboundDocNo" PropertyName="Text" />
    </SelectParameters>
</asp:SqlDataSource>
</ContentTemplate>
</asp:UpdatePanel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Clear" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Footer" runat="server">
</asp:Content>
