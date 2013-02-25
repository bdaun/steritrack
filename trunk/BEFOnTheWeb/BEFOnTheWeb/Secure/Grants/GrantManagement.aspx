<%@ Page Title="" Language="C#" MasterPageFile="~/Secure/Page.Master" AutoEventWireup="true" CodeBehind="GrantManagement.aspx.cs" Inherits="BEFOnTheWeb.Secure.GrantManagement" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">                  
    <h1>Grant Application Form</h1>
<asp:Label ID="lblErrMsg" runat="server" />
<table>
    <tr>
        <td><asp:GridView ID="gvGrantInfo" runat="server" DataSourceID="sdsGrant" AutoGenerateColumns="False"  
                GridLines="Horizontal" AllowSorting="True" CssClass="mGrid" ForeColor="White"
                OnRowEditing="gvGrantInfo_RowEditing" SelectedRowStyle-BackColor="#ffff99" OnRowDataBound="gvGrantInfo_RowDataBound"
                DataKeyNames="ID" ShowHeaderWhenEmpty="True" HeaderStyle-HorizontalAlign="Center">
                <Columns>
                    <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ID" />
                    <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
                    <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
                </Columns>
            </asp:GridView></td>
        <td style="padding-left:50px;vertical-align:top">
            <asp:Button ID="btnNewGrant" runat="server" Text="Start New Grant" ForeColor="white" Font-Size="Small" BackColor="#a695d1"   /><br />
            <asp:Button ID="btnPrint" runat="server" Text="Print" onclick="btnPrint_Click" ForeColor="white" Font-Size="Small" BackColor="#a695d1" />
            <ajaxToolkit:RoundedCornersExtender ID="rcNewGrant" runat="server" TargetControlID="btnnewGrant" BorderColor="#a695d1"  />
            <ajaxToolkit:RoundedCornersExtender ID="rcPrint" runat="server" TargetControlID="btnPrint" BorderColor="#a695d1"  />
        </td>
    </tr>
</table>
<asp:FormView ID="fvGrantInfo" runat="server" DataSourceID="sdsGrant" RenderOuterTable="true" Width="100%">
    <EditItemTemplate>
        ID:
        <asp:Label ID="IDLabel1" runat="server" Text='<%# Eval("ID") %>' />
        <br />
        username:
        <asp:TextBox ID="usernameTextBox" runat="server" Text='<%# Bind("username") %>' />
        <br />
        Status:
        <asp:TextBox ID="StatusTextBox" runat="server" Text='<%# Bind("Status") %>' />
        <br />
        Title:
        <asp:TextBox ID="TitleTextBox" runat="server" Text='<%# Bind("Title") %>' />
        <br />
        Applicant_1:
        <asp:TextBox ID="Applicant_1TextBox" runat="server" Text='<%# Bind("Applicant_1") %>' />
        <br />
        Applicant_2:
        <asp:TextBox ID="Applicant_2TextBox" runat="server" Text='<%# Bind("Applicant_2") %>' />
        <br />
        Applicant_3:
        <asp:TextBox ID="Applicant_3TextBox" runat="server" Text='<%# Bind("Applicant_3") %>' />
        <br />
        School:
        <asp:TextBox ID="SchoolTextBox" runat="server" Text='<%# Bind("School") %>' />
        <br />
        Grade:
        <asp:TextBox ID="GradeTextBox" runat="server" Text='<%# Bind("Grade") %>' />
        <br />
        Subject:
        <asp:TextBox ID="SubjectTextBox" runat="server" Text='<%# Bind("Subject") %>' />
        <br />
        StudentImpact:
        <asp:TextBox ID="StudentImpactTextBox" runat="server" Text='<%# Bind("StudentImpact") %>' />
        <br />
        PhoneNumber:
        <asp:TextBox ID="PhoneNumberTextBox" runat="server" Text='<%# Bind("PhoneNumber") %>' />
        <br />
        PhoneExt:
        <asp:TextBox ID="PhoneExtTextBox" runat="server" Text='<%# Bind("PhoneExt") %>' />
        <br />
        Email:
        <asp:TextBox ID="EmailTextBox" runat="server" Text='<%# Bind("Email") %>' />
        <br />
        AmountRequested:
        <asp:TextBox ID="AmountRequestedTextBox" runat="server" Text='<%# Bind("AmountRequested") %>' />
        <br />
        ShortDescription:
        <asp:TextBox ID="ShortDescriptionTextBox" runat="server" Text='<%# Bind("ShortDescription") %>' />
        <br />
        ActivityDescription:
        <asp:TextBox ID="ActivityDescriptionTextBox" runat="server" Text='<%# Bind("ActivityDescription") %>' />
        <br />
        NeedsAssessment:
        <asp:TextBox ID="NeedsAssessmentTextBox" runat="server" Text='<%# Bind("NeedsAssessment") %>' />
        <br />
        GoalsObjectives:
        <asp:TextBox ID="GoalsObjectivesTextBox" runat="server" Text='<%# Bind("GoalsObjectives") %>' />
        <br />
        AssessEvaluation:
        <asp:TextBox ID="AssessEvaluationTextBox" runat="server" Text='<%# Bind("AssessEvaluation") %>' />
        <br />
        ExpenseID:
        <asp:TextBox ID="ExpenseIDTextBox" runat="server" Text='<%# Bind("ExpenseID") %>' />
        <br />
        AltFunding:
        <asp:TextBox ID="AltFundingTextBox" runat="server" Text='<%# Bind("AltFunding") %>' />
        <br />
        CreateDate:
        <asp:TextBox ID="CreateDateTextBox" runat="server" Text='<%# Bind("CreateDate") %>' />
        <br />
        ModDate:
        <asp:TextBox ID="ModDateTextBox" runat="server" Text='<%# Bind("ModDate") %>' />
        <br />
        ModBy:
        <asp:TextBox ID="ModByTextBox" runat="server" Text='<%# Bind("ModBy") %>' />
        <br />
        <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
        &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
    </EditItemTemplate>
    <InsertItemTemplate>
        username:
        <asp:TextBox ID="usernameTextBox" runat="server" Text='<%# Bind("username") %>' />
        <br />
        Status:
        <asp:TextBox ID="StatusTextBox" runat="server" Text='<%# Bind("Status") %>' />
        <br />
        Title:
        <asp:TextBox ID="TitleTextBox" runat="server" Text='<%# Bind("Title") %>' />
        <br />
        Applicant_1:
        <asp:TextBox ID="Applicant_1TextBox" runat="server" Text='<%# Bind("Applicant_1") %>' />
        <br />
        Applicant_2:
        <asp:TextBox ID="Applicant_2TextBox" runat="server" Text='<%# Bind("Applicant_2") %>' />
        <br />
        Applicant_3:
        <asp:TextBox ID="Applicant_3TextBox" runat="server" Text='<%# Bind("Applicant_3") %>' />
        <br />
        School:
        <asp:TextBox ID="SchoolTextBox" runat="server" Text='<%# Bind("School") %>' />
        <br />
        Grade:
        <asp:TextBox ID="GradeTextBox" runat="server" Text='<%# Bind("Grade") %>' />
        <br />
        Subject:
        <asp:TextBox ID="SubjectTextBox" runat="server" Text='<%# Bind("Subject") %>' />
        <br />
        StudentImpact:
        <asp:TextBox ID="StudentImpactTextBox" runat="server" Text='<%# Bind("StudentImpact") %>' />
        <br />
        PhoneNumber:
        <asp:TextBox ID="PhoneNumberTextBox" runat="server" Text='<%# Bind("PhoneNumber") %>' />
        <br />
        PhoneExt:
        <asp:TextBox ID="PhoneExtTextBox" runat="server" Text='<%# Bind("PhoneExt") %>' />
        <br />
        Email:
        <asp:TextBox ID="EmailTextBox" runat="server" Text='<%# Bind("Email") %>' />
        <br />
        AmountRequested:
        <asp:TextBox ID="AmountRequestedTextBox" runat="server" Text='<%# Bind("AmountRequested") %>' />
        <br />
        ShortDescription:
        <asp:TextBox ID="ShortDescriptionTextBox" runat="server" Text='<%# Bind("ShortDescription") %>' />
        <br />
        ActivityDescription:
        <asp:TextBox ID="ActivityDescriptionTextBox" runat="server" Text='<%# Bind("ActivityDescription") %>' />
        <br />
        NeedsAssessment:
        <asp:TextBox ID="NeedsAssessmentTextBox" runat="server" Text='<%# Bind("NeedsAssessment") %>' />
        <br />
        GoalsObjectives:
        <asp:TextBox ID="GoalsObjectivesTextBox" runat="server" Text='<%# Bind("GoalsObjectives") %>' />
        <br />
        AssessEvaluation:
        <asp:TextBox ID="AssessEvaluationTextBox" runat="server" Text='<%# Bind("AssessEvaluation") %>' />
        <br />
        ExpenseID:
        <asp:TextBox ID="ExpenseIDTextBox" runat="server" Text='<%# Bind("ExpenseID") %>' />
        <br />
        AltFunding:
        <asp:TextBox ID="AltFundingTextBox" runat="server" Text='<%# Bind("AltFunding") %>' />
        <br />
        CreateDate:
        <asp:TextBox ID="CreateDateTextBox" runat="server" Text='<%# Bind("CreateDate") %>' />
        <br />
        ModDate:
        <asp:TextBox ID="ModDateTextBox" runat="server" Text='<%# Bind("ModDate") %>' />
        <br />
        ModBy:
        <asp:TextBox ID="ModByTextBox" runat="server" Text='<%# Bind("ModBy") %>' />
        <br />
        <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
        &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
    </InsertItemTemplate>
    <ItemTemplate>
        <table class="formtable">
            <tr><th colspan="2" style="font-weight:bold;text-align:center">Basic Information</th></tr>
            <div id="Step1" runat="server">
            <tr><td class="form1sttd">ID:</td>
                <td><asp:Label ID="IDLabel" runat="server" Width="20px" Text='<%# Eval("ID") %>' />&nbsp;&nbsp;
                    <asp:Label ID="usernameLabel" runat="server" Text='<%# Bind("username") %>' />
                </td></tr>
            <tr><td class="form1sttd">Status:</td>
                <td><asp:Label ID="StatusLabel" runat="server" Text='<%# Bind("Status") %>' /></td>
            </tr>
            <tr><td class="form1sttd">Title:</td>
                <td><asp:Label ID="TitleLabel" runat="server" Text='<%# Bind("Title") %>' /></td>
            </tr>
            <tr><td class="form1sttd">Grant Owner:</td>
                <td><asp:Label ID="Applicant_1Label" runat="server" Text='<%# Bind("Applicant_1") %>' /></td></tr>
            <tr><td class="form1sttd"></td><td style="font-size:small"><b>Phone/Ext:&nbsp;&nbsp;</b><asp:Label ID="PhoneNumberLabel" runat="server" Text='<%# Bind("PhoneNumber") %>' />&nbsp/&nbsp;
                <asp:Label ID="PhoneExtLabel" runat="server" Text='<%# Bind("PhoneExt") %>' />&nbsp;&nbsp;
                <b>Grade:&nbsp&nbsp;</b><asp:Label ID="GradeLabel" runat="server" Text='<%# Bind("Grade") %>' />
                </td></tr>
            <tr><td class="form1sttd"></td><td style="font-size:small"><b>School:&nbsp;&nbsp;</b><asp:Label ID="SchoolLabel" runat="server" Text='<%# Bind("School") %>' />&nbsp;&nbsp;
                <b>Subject:&nbsp&nbsp;</b><asp:Label ID="SubjectLabel" runat="server" Text='<%# Bind("Subject") %>' />
                </td></tr>
            <tr><td class="form1sttd"></td><td style="font-size:small"><b>Email:&nbsp;&nbsp;</b><asp:Label ID="EmailLabel" runat="server" Text='<%# Bind("Email") %>' /></td></tr>
            <tr><td class="form1sttd">Grant Applicant2:</td>
                <td><asp:Label ID="Applicant_2Label" runat="server" Text='<%# Bind("Applicant_2") %>' /></td></tr>
            <tr><td class="form1sttd">Grant Applicant3:</td>
                <td><asp:Label ID="Applicant_3Label" runat="server" Text='<%# Bind("Applicant_3") %>' /></td></tr>
            <tr><td class="form1sttd">Short Description</td>
                <td><asp:Label ID="ShortDescriptionLabel" runat="server" Text='<%# Bind("ShortDescription") %>' /></td>
            </tr></div>                
        </table>
        <asp:Button ID="btnStep1ShowHide" runat="server" Text="Hide Basic Information" OnClick="btnStep1ShowHide_Click" />
        <br />
        <table class="formtable">
            <tr><th colspan="2" style="font-weight:bold;text-align:center">Activity Description</th></tr>
            <div id="Step2" runat="server">
            <tr><td class="form1sttd">ActivityDescription:</td>
                <td><asp:TextBox ID="ActivityDescriptionTextBox" runat="server" Text='<%# Bind("ActivityDescription") %>' Enabled="false" TextMode="MultiLine" 
                     Width="98%" />
                    <ajaxToolkit:TextBoxWatermarkExtender ID="wmActDesc" runat="server" TargetControlID="ActivityDescriptionTextBox" 
                        WatermarkText="Describe the strategies and/or activities you will use to implement this project and how those strategies and/or activities meet student needs and/or Indiana State Standards." WatermarkCssClass="watermarked" />
                </td></tr>
                </div>
        </table>
        <asp:Button ID="btnStep2ShowHide" runat="server" Text="Hide Activity Description" OnClick="btnStep2ShowHide_Click" />

        StudentImpact:
        <asp:Label ID="StudentImpactLabel" runat="server" Text='<%# Bind("StudentImpact") %>' />

        AmountRequested:
        <asp:Label ID="AmountRequestedLabel" runat="server" Text='<%# Bind("AmountRequested") %>' />

        
        <br />
        NeedsAssessment:
        <asp:Label ID="NeedsAssessmentLabel" runat="server" Text='<%# Bind("NeedsAssessment") %>' />
        <br />
        GoalsObjectives:
        <asp:Label ID="GoalsObjectivesLabel" runat="server" Text='<%# Bind("GoalsObjectives") %>' />
        <br />
        AssessEvaluation:
        <asp:Label ID="AssessEvaluationLabel" runat="server" Text='<%# Bind("AssessEvaluation") %>' />
        <br />
        ExpenseID:
        <asp:Label ID="ExpenseIDLabel" runat="server" Text='<%# Bind("ExpenseID") %>' />
        <br />
        AltFunding:
        <asp:Label ID="AltFundingLabel" runat="server" Text='<%# Bind("AltFunding") %>' />
    </ItemTemplate>
</asp:FormView>



<asp:Panel ID="Panel1" runat="server" >
<%--<asp:FormView ID="fvLabel" runat="server" BorderColor="Black" BorderStyle="Double" DataSourceID="sdsCntrDetails" Width="4.5in"
    OnDataBound="fvLabel_OnDataBound" >
    <ItemTemplate>
        <div style="text-align:center">
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
        }  //-->
        </script>
    </ItemTemplate>
</asp:FormView>--%>
</asp:Panel>




<asp:SqlDataSource ID="sdsGrant" runat="server" ConnectionString="<%$ ConnectionStrings:Teleios2013ConnectionString %>" 
    SelectCommand="Grant_GrantInfo_Sel" SelectCommandType="StoredProcedure" OnSelecting="sdsGrant_OnSelecting">
    <SelectParameters>
        <asp:Parameter Name="UserName" />
        <asp:Parameter Name="Role" />
    </SelectParameters></asp:SqlDataSource>
</asp:Content>
