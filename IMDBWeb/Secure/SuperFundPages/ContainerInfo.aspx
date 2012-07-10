<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ContainerInfo.aspx.cs" 
Inherits="IMDBWeb.Secure.SuperFundPages.ContainerInfo" EnableEventValidation="false" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<script type="text/javascript">    function setHeight(txtdesc) {
        txtdesc.style.height = txtdesc.scrollHeight + "px"; 
}
</script>
<script type="text/javascript"> function SampleCheck() {
    var n = document.getElementById('MainContent_dvContainerDetails_SampleNeeded');
    var c = document.getElementById('MainContent_dvContainerDetails_SampleCompleted');
    var i = document.getElementById('MainContent_dvContainerDetails_SampleID');
    var e = document.getElementById('MainContent_dvContainerDetails_ddProfile');
    var a = document.getElementById('MainContent_dvContainerDetails_ApprovedforRemoval');
    var dd = e.options[e.selectedIndex].index;
    if (c.checked == true && i.value == '') {
        alert("You must check 'Sample Needed' and enter a SampleID in order to mark this complete!");
        n.checked = false;
        c.checked = false;
        a.checked = false;
    }
    if((c.checked==true && dd != 0) || (n.checked==false && dd != 0)) {
        a.checked = true;
    }
    else {
        a.checked = false;
    }
}
</script>
<script type="text/javascript">    function SetApproved() {
    var e = document.getElementById('MainContent_dvContainerDetails_ddProfile');
    var dd = e.options[e.selectedIndex].index;
    var n = document.getElementById('MainContent_dvContainerDetails_SampleNeeded');
    var c = document.getElementById('MainContent_dvContainerDetails_SampleCompleted');
    var a = document.getElementById('MainContent_dvContainerDetails_ApprovedforRemoval');
    if ((dd==0) || (n.checked == true && c.checked == false)) {
        a.checked = false;
        }
    else {
        a.checked = true;
        }
}
</script>
<table style="width: 253px">
    <tr align="center">
        <td>Grid Area</td>
        <td>Container ID</td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>
            <asp:DropDownList ID="ddGridLoc" runat="server" DataSourceID="sds_SFGridLoc" 
                DataTextField="GridLocation" DataValueField="ID" 
                AppendDataBoundItems="true" AutoPostBack="True" 
                onselectedindexchanged="ddGridLoc_SelectedIndexChanged">
                <asp:ListItem Text="Select a Grid Location" Value="" />
                <asp:ListItem Text="All" Value="0" />
            </asp:DropDownList>
        </td>
        <td>
            <asp:TextBox ID="txbCntrID" runat="server" ontextchanged="txbCntrID_TextChanged" AutoPostBack="true"></asp:TextBox>
        </td>
        <td>
            <asp:Button ID="btnReset" runat="server" Text="Reset" 
                onclick="btnReset_Click" />
        </td>
    </tr>
    <tr>
        <td>
            <asp:Button ID="btnAddCntr" runat="server" Text="Add Container" Visible="false" 
                onclick="btnAddCntr_Click"/>
        </td>
        <td>
            <asp:DropDownList ID="ddCompany" runat="server" DataSourceID="sdsCompany" AppendDataBoundItems="true"
                DataTextField="CompanyName" DataValueField="ID" AutoPostBack="true" 
                Visible="false" onselectedindexchanged="ddCompany_SelectedIndexChanged">
                <asp:ListItem Text="Select a Company" Value="0" />
            </asp:DropDownList>
        </td>
        <td>
            <asp:Button ID="btnGo" runat="server" Text="Go" Visible="false" 
                onclick="btnGo_Click"/>
        </td>
    </tr>
</table>
<table width="85%">
<tr><td>
    <asp:Label ID="lblCntrCnt" runat="server" Text="Container Count in Grid Area: " />
    <asp:Label ID="lblCntrCntNo" runat="server" Font-Bold="true" ForeColor="Black" />
    </td><td></td></tr>
<tr valign="top">
    <td>
    <asp:Label ID="lblErrMsg" runat="server" Text="" Font-Bold="true" ForeColor="Red"/>
<asp:GridView ID="gvGridLoc" runat="server" AutoGenerateColumns="False" DataSourceID="sdsGridLoc"
CellPadding="4" ForeColor="#333333" GridLines="Horizontal" AllowSorting="True" OnRowEditing="gvGridLoc_Editing"
SelectedRowStyle-BackColor = "#ffff99" OnRowDataBound="gvGridLoc_RowDataBound" DataKeyNames="ContainerID" 
EmptyDataText="Empty Date Set" onselectedindexchanged="gvGridLoc_SelectedIndexChanged" 
ShowHeaderWhenEmpty="True" HeaderStyle-HorizontalAlign="Center" AllowPaging="True">
<Columns>
    <asp:CommandField ShowEditButton="True" />
    <asp:TemplateField HeaderText="Grid">
        <EditItemTemplate>
            <asp:DropDownList ID="ddgvGrid" runat="server" SelectedValue='<%# Bind("GridID") %>'
             DataTextField="GridLocation" DataValueField="ID" DataSourceID="sds_SFGridLoc"></asp:DropDownList>
        </EditItemTemplate>
        <ItemTemplate>
            <asp:Label ID="lblGridLoc" runat="server" Text='<%# Bind("GridLocation") %>'></asp:Label>
        </ItemTemplate>
    </asp:TemplateField>
    <asp:BoundField DataField="ContainerID" HeaderText="Cntr ID" ReadOnly="true" />
    <asp:TemplateField HeaderText="Company">
        <EditItemTemplate>
            <asp:DropDownList ID="ddgvCompany" runat="server" SelectedValue='<%# Bind("CompanyID") %>'
            DataTextField="CompanyName" DataValueField="ID" DataSourceID="sdsCompany"></asp:DropDownList>
        </EditItemTemplate>
        <ItemTemplate>
            <asp:Label ID="lblCompanyName" runat="server" Text='<%# Bind("CompanyName") %>'></asp:Label>
        </ItemTemplate>
    </asp:TemplateField>
</Columns>
    <EditRowStyle BackColor="White" />
    <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
    <HeaderStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#333333" HorizontalAlign="Center" />
    <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
    <SelectedRowStyle BackColor="#FFFF99"></SelectedRowStyle>
    </asp:GridView>
    </td>
    <td>
<asp:DetailsView ID="dvContainerDetails" runat="server" DefaultMode="Edit" 
        AutoGenerateRows="False" DataKeyNames="ID" DataSourceID="sdsCntrDetails" 
        AutoGenerateEditButton="True">
    <Fields>
    <asp:TemplateField>
    <EditItemTemplate>
    <script type="text/javascript"> function UpdateSampleID() {
        var sn = document.getElementById('MainContent_dvContainerDetails_SampleNeeded');
        if (sn.checked == true) {
            document.getElementById('MainContent_dvContainerDetails_SampleID').value = '<%# Eval("ContainerID") %>';
            }
            else {
                document.getElementById('MainContent_dvContainerDetails_SampleID').value = '';
            }
        }
    </script>
    <table>
    <tr><td align="right">ContainerID:&nbsp</td>
    <td align="justify"><asp:Label ID="lblContainerID" runat="server" Text='<%# bind("ContainerID") %>' Font-Bold="True" ForeColor="Black" />
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ApprovedforRemoval:&nbsp<asp:CheckBox ID="ApprovedforRemoval" runat="server" Checked='<%# bind("ApprovedforRemoval") %>' />
    </td></tr>
    <tr><td align="right">UnknownType:&nbsp</td>
    <td align="left"><asp:DropDownList ID="ddUOI" runat="server" SelectedValue='<%# bind("ContainerUOI") %>' Enabled="false" >
        <asp:ListItem Text="Select" Value="0" />
        <asp:ListItem Text="Co‐mingled materials" Value="Co‐mingled materials" />
        <asp:ListItem Text="Phase 2 Respondent Material" Value="Phase 2 Respondent Material" />
        <asp:ListItem Text="Investigation Debris Waste" Value="Investigation Debris Waste" />
    </asp:DropDownList>    
    <script type="text/javascript">
        if ('<%# Eval("CompanyName") %>' == 'Unknown Owner')
        { document.getElementById('MainContent_dvContainerDetails_ddUOI').disabled = false }
        else
        { document.getElementById('MainContent_dvContainerDetails_ddUOI').disabled = true }
    </script>
    </td></tr>
    <tr><td align="right">ContainerType:&nbsp</td>
    <td align="left"><asp:DropDownList ID="ddContainerType" runat="server" SelectedValue='<%# bind("ContainerType") %>' >
        <asp:ListItem Text="Select" Value="0" />
        <asp:ListItem Text="Tote" Value="TP" />
        <asp:ListItem Text="Poly/Fiber Drum" Value="DF" />
        <asp:ListItem Text="Metal Drum" Value="DM" />
        <asp:ListItem Text="Mixing Vat" Value="MV" />
        <asp:ListItem Text="Fiber Container" Value="CF" />
        <asp:ListItem Text="Lab Pack" Value="LP" />
    </asp:DropDownList></td></tr>
    <tr><td align="center" colspan="2">Cntr Size:&nbsp
    <asp:TextBox ID="ContainerSize" runat="server" Text='<%# bind("ContainerSize") %>' Font-Bold="true" ForeColor="Black" Width="75px" />
    &nbsp;&nbsp;&nbsp;&nbsp;UOM:&nbsp<asp:DropDownList ID="ddContainerUOM" runat="server" SelectedValue='<%# bind("ContainerUOM") %>'>
        <asp:ListItem Text="Select" Value="0" />
        <asp:ListItem Text="Gallon" Value="Gal" />
        <asp:ListItem Text="Pounds" Value="Pounds" />
        <asp:ListItem Text="Each" Value="ea" />
    </asp:DropDownList></td>
    <td align="left"></td></tr>
    <tr style="border-bottom:thin solid #000000;"><td align="right">Matrix:&nbsp</td>
    <td align="left"><asp:DropDownList ID="ddMatrix" runat="server" SelectedValue='<%# bind("Matrix") %>'>
        <asp:ListItem Text="Select" Value="0" />
        <asp:ListItem Text="Solid" Value="Solid" />
        <asp:ListItem Text="Liquid" Value="Liquid" />
        <asp:ListItem Text="Mixture" Value="Mixture" />
    </asp:DropDownList>&nbsp;&nbsp;Overpack?:&nbsp&nbsp<asp:CheckBox ID="Overpack" runat="server" Checked='<%# bind("Overpack") %>' /></td></tr>
    <tr align="center"><td colspan="2" style="font-weight:bold;font-size:large">Hazcat Information</td><td></td></tr>
    <tr><td align="right"></td>
    <td align="left"></td></tr>
    <tr><td align="right">Flammability:&nbsp</td>
    <td align="left"><asp:CheckBox ID="Flammability" runat="server" Checked='<%# bind("Flammability") %>' />
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;WaterReactivity:&nbsp
    <asp:CheckBox ID="WaterReactivity" runat="server" Checked='<%# bind("WaterReactivity") %>' /></td></tr>
    <tr><td align="right">WaterSolubility:&nbsp</td>
    <td align="left"><asp:CheckBox ID="WaterSolubility" runat="server" Checked='<%# bind("WaterSolubility") %>' />
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Oxidizer:&nbsp<asp:CheckBox ID="Oxidizer" runat="server" Checked='<%# bind("Oxidizer") %>' /></td></tr>
    <tr><td align="right">HazcatDuplicated:&nbsp</td>
    <td align="left"><asp:CheckBox ID="HazcatDuplicated" runat="server" Checked='<%# bind("HazcatDuplicated") %>' />
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;pH:&nbsp;<asp:DropDownList ID="pH" runat="server" SelectedValue='<%# bind("pH") %>'>
        <asp:ListItem Text="Select" Value="0" />
        <asp:ListItem Text="< 4" Value="<4" />
        <asp:ListItem Text="4-10" Value="4-10" />
        <asp:ListItem Text="> 10" Value=">10" />
    </asp:DropDownList></td></tr>
    <tr style="border-bottom:thin solid #000000;"><td align="center" colspan="2">
    Profile:&nbsp<asp:DropDownList ID="ddProfile" runat="server" SelectedValue='<%# bind("ProfileID") %>' onClick="javascript:SetApproved(this);" 
    AppendDataBoundItems="True" DataSourceID="sdsSFundProfile" DataTextField="ProfileName" DataValueField="ID" OnSelectedIndexChanged="ddProfile_SelectedIndexChanged" >
        <asp:ListItem Text="Select" Value="0"   />
    </asp:DropDownList>
        </td>
    <td align="left"></td></tr>
    <tr align="center"><td colspan="2" style="font-weight:bold;font-size:large">Sampling Information</td><td></td></tr>
    <tr><td align="right">SampleNeeded:&nbsp;</td>
    <td align="left"><asp:CheckBox ID="SampleNeeded" runat="server" Checked='<%# bind("SampleNeeded") %>' 
        onClick="javascript:UpdateSampleID(this);javascript:SampleCheck(this);javascript:UpdateLabel(this);" />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    SampleCompleted:&nbsp<asp:CheckBox ID="SampleCompleted" runat="server" Checked='<%# bind("SampleCompleted") %>' 
        onClick="javascript:UpdateSampleID(this);javascript:SampleCheck(this);javascript:UpdateLabel(this);" /></td></tr>
    <tr><td align="right">SampleID:&nbsp</td>
    <td align="left"><asp:TextBox ID="SampleID" runat="server" Text='<%# bind("SampleID") %>' Font-Bold="true" ForeColor="Black" /></td></tr>
    <tr><td align="right">COCNumber:&nbsp</td>
    <td align="left"><asp:TextBox ID="COCNumber" runat="server" Text='<%# bind("COCNumber") %>' Font-Bold="true" ForeColor="Black" /></td></tr>
    <tr style="border-bottom:thin solid #000000;"><td align="center" colspan="2">Comments:&nbsp&nbsp;
    <asp:TextBox ID="lblComments" runat="server" Text='<%# bind("ContainerComment") %>' TextMode="MultiLine" 
        onkeyup="setHeight(this);" onkeydown="setHeight(this);" onclick="setHeight(this);" Width="75%" /></td>
    <td align="left"></td></tr>
    <tr><td align="right">Moddate:&nbsp</td>
    <td align="left"><asp:Label ID="Moddate" runat="server" Text='<%# bind("Moddate") %>' Font-Bold="true" ForeColor="Black" /></td></tr>
    <tr><td align="right">Modby:&nbsp</td>
    <td align="left"><asp:Label ID="Modby" runat="server" Text='<%# bind("Modby") %>' Font-Bold="true" ForeColor="Black" /></td></tr>
    </table>
    </EditItemTemplate>
    </asp:TemplateField>
    </Fields>
    </asp:DetailsView>
    </td>
    <td><asp:Button ID="btnPrint" runat="server" Text="Print" onclick="btnPrint_Click" />
        <asp:Panel ID="Panel1" runat="server" >
            <asp:FormView ID="fvLabel" runat="server" BorderColor="Black" BorderStyle="Double" DataSourceID="sdsCntrDetails" Width="4.5in"
             OnDataBound="fvLabel_OnDataBound" >
                <ItemTemplate>
                    <div align="center">
                    <asp:Label ID="lblPRP" runat="server" Font-Bold="true" Font-Size="54px" Text='<%# String.Format("{0}{1}",Eval("CompanyPRP"),"-") %>' />
                    <asp:Label ID="lblGridLoc" runat="server" Font-Bold="true" Font-Size="54px" Text='<%# String.Format("{0}{1}",Eval("GridLocation"),"-") %>' />
                    <asp:Label ID="lblcntrid" runat="server" Font-Bold="true" Font-Size="54px" Text='<%# Eval("ContainerID") %>' /><br />
                    <asp:Label ID="lblBarcode" runat="server" Text='<%# String.Format("{0}{1}{2}","*", Eval("ContainerID"),"*") %>' style="font-family: 'Free 3 of 9'; font-size: 72px;" /></div><br /> 
                    Profile:&nbsp;&nbsp;<asp:Label ID="lblProfile" runat="server" Font-Bold="true" Font-Size="Medium" Text='<%# Eval("ProfileName") %>' /><br />
                    Matrix:&nbsp;&nbsp<asp:Label ID="lblMatrix" runat="server" Font-Bold="true" Font-Size="Medium" Text='<%# Eval("Matrix") %>' /><br /><br />
                    <asp:Label ID="lblSampleID" runat="server" Font-Bold="true" Font-Size="32px" Text="" /><br />
                    Date: 
                    <script type="text/javascript"><!--
                        {
                            var currentTime = new Date()
                            var month = currentTime.getMonth() + 1
                            var day = currentTime.getDate()
                            var year = currentTime.getFullYear()
                            document.write(month + "/" + day + "/" + year)
                        }
                    //-->
                    </script>
                </ItemTemplate>
            </asp:FormView>
            </asp:Panel>
    </td>
</tr>
</table>
<asp:SqlDataSource ID="sds_SFGridLoc" runat="server" ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
    SelectCommand="SP_SFund_GridLoc_Sel" SelectCommandType="StoredProcedure">
</asp:SqlDataSource>
<asp:SqlDataSource ID="sdsCompany" runat="server" ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
    SelectCommand="SP_SFund_Company_Sel" SelectCommandType="StoredProcedure">
</asp:SqlDataSource>
<asp:SqlDataSource ID="sdsGridLoc" runat="server" ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
    SelectCommand="SP_SFund_gvGridLoc" SelectCommandType="StoredProcedure" 
    OnSelected="sdsGridLoc_Selected" OnUpdating="sdsGridLoc_Updating"
    UpdateCommand="SP_SFund_gvGridLoc_upd" UpdateCommandType="StoredProcedure">
    <SelectParameters>
        <asp:ControlParameter ControlID="ddGridLoc" Name="gridLocation" PropertyName="SelectedValue" Type="Int32" />
        <asp:ControlParameter ControlID="txbCntrID" Name="ContainerID" PropertyName="Text" Type="Int32" DefaultValue="0" />
    </SelectParameters>
    <UpdateParameters>
        <asp:Parameter Name="GridID" Type="Int32" />
        <asp:Parameter Name="ContainerID" Type="Int32" />
        <asp:Parameter Name="CompanyID" Type="Int32" />
        <asp:Parameter Name="Modby" Type="String" />
    </UpdateParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="sdsCntrDetails" runat="server" ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
    onUpdating="sdsCntrDetails_Updating" OnUpdated="sdsCntrDetails_Updated" 
    SelectCommand="SP_SFund_ContainerDetails_Sel" SelectCommandType="StoredProcedure"
    UpdateCommand="UPDATE SFund_ContainerDetails SET ContainerUOI=@ContainerUOI,ContainerType=@ContainerType,ContainerSize=@ContainerSize,
    ContainerUOM=@ContainerUOM,Matrix=@Matrix,OverPack=@Overpack,ph=@ph,Flammability=@Flammability,WaterReactivity=@WaterReactivity,WaterSolubility=@WaterSolubility,
    Oxidizer=@Oxidizer,HazcatDuplicated=@HazcatDuplicated,ProfileID=@ProfileID,SampleNeeded=@SampleNeeded,SampleID=@SampleID,
    SampleCompleted=@SampleCompleted,COCNumber=@COCNumber,FTWorksheet=@FTWorksheet,
    ApprovedforRemoval=@ApprovedforRemoval,Moddate=getdate(),Modby=@Modby,ContainerComment=@ContainerComment WHERE ContainerID = @containerID">
    <SelectParameters>
        <asp:ControlParameter ControlID="gvGridLoc" Name="ContainerID" PropertyName="SelectedValue" Type="Int32" />
    </SelectParameters>
    <UpdateParameters>
        <asp:Parameter Name="ContainerUOI" Type="String" />
        <asp:Parameter Name="ContainerType" Type="String" />
        <asp:Parameter Name="ContainerSize" Type="String" />
        <asp:Parameter Name="ContainerUOM" Type="String" />
        <asp:Parameter Name="Matrix" Type="String" />
        <asp:Parameter Name="Overpack" Type="Byte" />
        <asp:Parameter Name="ph" Type="String" />
        <asp:Parameter Name="Flammability" Type="Byte" />
        <asp:Parameter Name="WaterReactivity" Type="Byte" />
        <asp:Parameter Name="WaterSolubility" />
        <asp:Parameter Name="Oxidizer" Type="Byte" />
        <asp:Parameter Name="HazcatDuplicated" Type="Byte" />
        <asp:Parameter Name="ProfileID" Type="Int32" />
        <asp:Parameter Name="SampleNeeded" Type="Byte" />
        <asp:Parameter Name="SampleID" Type="String" />
        <asp:Parameter Name="SampleCompleted" Type="Byte" />
        <asp:Parameter Name="COCNumber" Type="String" />
        <asp:Parameter Name="FTWorksheet" Type="String" />
        <asp:Parameter Name="ApprovedforRemoval" Type="Byte" />
        <asp:Parameter Name="Modby" Type="String" />
        <asp:Parameter Name="ContainerComment" Type="String" />
        <asp:Parameter name="ContainerID" Type="Int32" />
    </UpdateParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="sdsSFundProfile" runat="server" 
    ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
    SelectCommand="SP_SFund_Profile_Sel" SelectCommandType="StoredProcedure">
</asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Clear" runat="server">
    <div class="instructions"><asp:Label ID="lblInstructionHeader" runat="server" Text="Instructions/Options" Font-Underline="true"></asp:Label><br />
    <asp:Label ID="lblInstructions" runat="server" Text="" /></div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Footer" runat="server" >
</asp:Content>
