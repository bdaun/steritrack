<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManifestMailing.aspx.cs" Inherits="IMDBWeb.Secure.deskTopPages.ManifestMailing" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<script type="text/javascript">    function setHeight(txtdesc) { txtdesc.style.height = txtdesc.scrollHeight + "px"; }</script>
<asp:UpdatePanel ID="udpMailGV" runat="server">
<ContentTemplate>
<asp:ScriptManager ID="sm1" runat="server" />
<table>
<tr><td>I would like to:</td><td></td></tr>
<tr><td><asp:RadioButtonList ID="rbList1" runat="server" AutoPostBack="True" onselectedindexchanged="rbList1_SelectedIndexChanged">
<asp:ListItem>See all overdue manifests for mailing</asp:ListItem>
<asp:ListItem>Manage manifest mailing by Truck Tag</asp:ListItem>
<asp:ListItem>Manage manifest mailing by Manifest Number</asp:ListItem>
</asp:RadioButtonList></td><td></td></tr>
</table>
<asp:UpdateProgress ID="progGridView" runat="server" DisplayAfter="2000" DynamicLayout="true">
    <ProgressTemplate>
        <img src="../../images/progress.gif" alt="" style="width: 350px; height: 25px" />
    </ProgressTemplate>
</asp:UpdateProgress>
<asp:Label ID="lblErrMsg" runat="server" Text="" /><br />
<asp:Label ID="lblSelParam" runat="server" Text="" />&nbsp;&nbsp;<asp:TextBox 
    ID="txbSelParam" runat="server" AutoPostBack="True" 
    ontextchanged="txbSelParam_TextChanged" />
<asp:RegularExpressionValidator ID="revSelParam" runat="server" ControlToValidate="txbSelParam"></asp:RegularExpressionValidator>
<table><tr id="trUpdateAll" runat="server">
<td style="font-size:large; color: #0000FF;">
Set all rows to &quot;Mailed&quot; with a Mailed Date of
<asp:TextBox ID="txbMailDate" runat="server"  />&nbsp;&nbsp;
<asp:Button ID="btnGo" runat="server" Text="Go" onclick="btnGo_Click" /></td>
<td></td></tr></table>
<asp:GridView ID="gvManifestStatus" runat="server" AutoGenerateColumns="False" 
    DataSourceID="sdsManifestMail_Date" CellPadding="2" DataKeyNames="InboundDocNo">
    <Columns>
        <asp:CommandField ShowEditButton="True" />
        <asp:TemplateField HeaderText="TruckID" HeaderStyle-HorizontalAlign="Center">
        <EditItemTemplate>
        <asp:Label ID="lblTruckID" runat="server" Text='<%# Eval("TruckID") %>' />
        </EditItemTemplate>
        <ItemTemplate>
        <asp:Label ID="lblTruckID" runat="server" Text='<%# Eval("TruckID") %>' />
        </ItemTemplate>
        <HeaderStyle HorizontalAlign="Center" />
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Manifest">
        <EditItemTemplate>
        <asp:Label ID="lblManifest" runat="server" Text='<%# Eval("InboundDocNo") %>' />
        </EditItemTemplate>
        <ItemTemplate>
        <asp:Label ID="lblManifest" runat="server" Text='<%# Eval("InboundDocNo") %>' />
        </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Date Needed">
        <EditItemTemplate>
        <asp:Label ID="lblDateNeeded" runat="server" Text='<%# Eval("DateNeeded","{0:MM/dd/yyyy}") %>' />
        </EditItemTemplate>
        <ItemTemplate>
        <asp:Label ID="lblDateNeeded" runat="server" Text='<%# Eval("DateNeeded","{0:MM/dd/yyyy}") %>' />
        </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Age">
        <EditItemTemplate>
        <asp:Label ID="lblAge" runat="server" Text='<%# Eval("Age") %>'  />
        </EditItemTemplate>
        <ItemTemplate>
        <asp:Label ID="lblAge" runat="server" Text='<%# Eval("Age") %>' />
        </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Mailed">
        <EditItemTemplate>
        <asp:CheckBox ID="chkMailed" runat="server" Checked='<%# Bind("Mailed") %>' Enabled="true" />
        </EditItemTemplate>
        <ItemTemplate>
        <asp:CheckBox ID="chkMailed" runat="server" Checked='<%# Eval("Mailed") %>' Enabled="false" />
        </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Date Mailed">
        <EditItemTemplate>
        <asp:TextBox ID="txbDateMailed" runat="server" Text='<%# Bind("DateMailed","{0:MM/dd/yyyy}") %>' Width="100px" />
        </EditItemTemplate>
        <ItemTemplate>
        <asp:Label ID="lblDateMailed" runat="server" Text='<%# Eval("DateMailed","{0:MM/dd/yyyy}") %>' Width="100px" />
        </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Discrepancy">
        <EditItemTemplate>
        <asp:CheckBox ID="chkDiscrepancy" runat="server" Checked='<%# Bind("Discrepancy") %>' Enabled="true" />
        </EditItemTemplate>
        <ItemTemplate>
        <asp:CheckBox ID="chkDiscrepancy" runat="server" Checked='<%# Eval("Discrepancy") %>' Enabled="false" />
        </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Date Failed">
        <EditItemTemplate>
        <asp:TextBox ID="txbDateFailed" runat="server" Text='<%# Bind("DateFailed","{0:MM/dd/yyyy}") %>' Width="100px" />
        </EditItemTemplate>
        <ItemTemplate>
        <asp:Label ID="lblDateFailed" runat="server" Text='<%# Eval("DateFailed","{0:MM/dd/yyyy}") %>' Width="100px" />
        </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Comment">
        <EditItemTemplate>
        <asp:TextBox ID="txbComment" runat="server" Text='<%# Bind("Comment") %>' Width="400px" TextMode="MultiLine" 
                        onkeyup="setHeight(this);" onkeydown="setHeight(this);" onclick="setHeight(this);" CssClass="gridcomment" />
        </EditItemTemplate>
        <ItemTemplate>
        <asp:Label ID="lblComment" runat="server" Text='<%# Eval("Comment") %>' Width="400px" CssClass="gridcomment" />
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
    SelectCommand="SP_ManifestMail_Date" SelectCommandType="StoredProcedure"
    UpdateCommand="Update SpakManifestRcvd Set Mailed=@Mailed,DateMailed=@DateMailed,Discrepancy=@Discrepancy,DateFailed=@DateFailed,
    Comment=@Comment,UserName=@User WHERE InboundDocNo=@InboundDocNo" OnUpdating="sdsManifestMail_Date_Updating" >
    <UpdateParameters>
    <asp:Parameter Name="Mailed" Type="Byte" />
    <asp:Parameter Name="DateMailed" Type="DateTime" />
    <asp:Parameter Name="Discrepancy" Type="Byte" />
    <asp:Parameter Name="DateFailed" Type="DateTime" />
    <asp:Parameter Name="Comment" Type="String" />
    <asp:Parameter Name="InboundDocNo" Type="String" />
    <asp:Parameter Name="User" Type="String" />
    </UpdateParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="sdsManifestMail_TruckID" runat="server" 
    ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
    SelectCommand="SP_ManifestMail_TruckID" SelectCommandType="StoredProcedure"
    UpdateCommand="Update SpakManifestRcvd Set Mailed=@Mailed,DateMailed=@DateMailed,Discrepancy=@Discrepancy,DateFailed=@DateFailed,
    Comment=@Comment,UserName=@User WHERE InboundDocNo=@InboundDocNo" OnUpdating="sdsManifestMail_Date_Updating" >
    <UpdateParameters>
    <asp:Parameter Name="Mailed" Type="Byte" />
    <asp:Parameter Name="DateMailed" Type="DateTime" />
    <asp:Parameter Name="Discrepancy" Type="Byte" />
    <asp:Parameter Name="DateFailed" Type="DateTime" />
    <asp:Parameter Name="Comment" Type="String" />
    <asp:Parameter Name="InboundDocNo" Type="String" />
    <asp:Parameter Name="User" Type="String" />
    </UpdateParameters>
    <SelectParameters>
    <asp:ControlParameter ControlID="txbSelParam" DefaultValue="NULL" Name="TruckID" PropertyName="Text" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="sdsManifestMail_Manifest" runat="server" 
    ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
    SelectCommand="SP_ManifestMail_Manifest" SelectCommandType="StoredProcedure"
    UpdateCommand="Update SpakManifestRcvd Set Mailed=@Mailed,DateMailed=@DateMailed,Discrepancy=@Discrepancy,DateFailed=@DateFailed,
    Comment=@Comment,UserName=@User WHERE InboundDocNo=@InboundDocNo" OnUpdating="sdsManifestMail_Date_Updating" >
    <UpdateParameters>
    <asp:Parameter Name="Mailed" Type="Byte" />
    <asp:Parameter Name="DateMailed" Type="DateTime" />
    <asp:Parameter Name="Discrepancy" Type="Byte" />
    <asp:Parameter Name="DateFailed" Type="DateTime" />
    <asp:Parameter Name="Comment" Type="String" />
    <asp:Parameter Name="InboundDocNo" Type="String" />
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
