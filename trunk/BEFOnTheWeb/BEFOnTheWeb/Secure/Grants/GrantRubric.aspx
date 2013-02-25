<%@ Page Title="" Language="C#" MasterPageFile="~/Secure/Page.Master" AutoEventWireup="true" CodeBehind="GrantRubric.aspx.cs" Inherits="BEFOnTheWeb.Secure.GrantRubric" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Grant Application Rubric</h2>
<br />
    <asp:DropDownList ID="ddGrant" runat="server" DataTextField="Title" DataValueField="ID" DataSourceID="sdsGrant" ></asp:DropDownList>
<asp:FormView ID="fvRubric" runat="server" DataSourceID="sdsRubricInfo" >
    <EditItemTemplate>
        ID:
        <asp:Label ID="IDLabel1" runat="server" Text='<%# Eval("ID") %>' />
        <br />
        GrantID:
        <asp:TextBox ID="GrantIDTextBox" runat="server" Text='<%# Bind("GrantID") %>' />
        <br />
        Score_ActDesc:
        <asp:TextBox ID="Score_ActDescTextBox" runat="server" Text='<%# Bind("Score_ActDesc") %>' />
        <br />
        Score_NeedAssess:
        <asp:TextBox ID="Score_NeedAssessTextBox" runat="server" Text='<%# Bind("Score_NeedAssess") %>' />
        <br />
        Score_Goals:
        <asp:TextBox ID="Score_GoalsTextBox" runat="server" Text='<%# Bind("Score_Goals") %>' />
        <br />
        Score_AssessEval:
        <asp:TextBox ID="Score_AssessEvalTextBox" runat="server" Text='<%# Bind("Score_AssessEval") %>' />
        <br />
        Score_Budget:
        <asp:TextBox ID="Score_BudgetTextBox" runat="server" Text='<%# Bind("Score_Budget") %>' />
        <br />
        Score_Bonus:
        <asp:TextBox ID="Score_BonusTextBox" runat="server" Text='<%# Bind("Score_Bonus") %>' />
        <br />
        Status:
        <asp:TextBox ID="StatusTextBox" runat="server" Text='<%# Bind("Status") %>' />
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
        GrantID:
        <asp:TextBox ID="GrantIDTextBox" runat="server" Text='<%# Bind("GrantID") %>' />
        <br />
        Score_ActDesc:
        <asp:TextBox ID="Score_ActDescTextBox" runat="server" Text='<%# Bind("Score_ActDesc") %>' />
        <br />
        Score_NeedAssess:
        <asp:TextBox ID="Score_NeedAssessTextBox" runat="server" Text='<%# Bind("Score_NeedAssess") %>' />
        <br />
        Score_Goals:
        <asp:TextBox ID="Score_GoalsTextBox" runat="server" Text='<%# Bind("Score_Goals") %>' />
        <br />
        Score_AssessEval:
        <asp:TextBox ID="Score_AssessEvalTextBox" runat="server" Text='<%# Bind("Score_AssessEval") %>' />
        <br />
        Score_Budget:
        <asp:TextBox ID="Score_BudgetTextBox" runat="server" Text='<%# Bind("Score_Budget") %>' />
        <br />
        Score_Bonus:
        <asp:TextBox ID="Score_BonusTextBox" runat="server" Text='<%# Bind("Score_Bonus") %>' />
        <br />
        Status:
        <asp:TextBox ID="StatusTextBox" runat="server" Text='<%# Bind("Status") %>' />
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
        ID:
        <asp:Label ID="IDLabel" runat="server" Text='<%# Eval("ID") %>' />
        <br />
        GrantID:
        <asp:Label ID="GrantIDLabel" runat="server" Text='<%# Bind("GrantID") %>' />
        <br />
        Score_ActDesc:
        <asp:Label ID="Score_ActDescLabel" runat="server" Text='<%# Bind("Score_ActDesc") %>' />
        <br />
        Score_NeedAssess:
        <asp:Label ID="Score_NeedAssessLabel" runat="server" Text='<%# Bind("Score_NeedAssess") %>' />
        <br />
        Score_Goals:
        <asp:Label ID="Score_GoalsLabel" runat="server" Text='<%# Bind("Score_Goals") %>' />
        <br />
        Score_AssessEval:
        <asp:Label ID="Score_AssessEvalLabel" runat="server" Text='<%# Bind("Score_AssessEval") %>' />
        <br />
        Score_Budget:
        <asp:Label ID="Score_BudgetLabel" runat="server" Text='<%# Bind("Score_Budget") %>' />
        <br />
        Score_Bonus:
        <asp:Label ID="Score_BonusLabel" runat="server" Text='<%# Bind("Score_Bonus") %>' />
        <br />
        Status:
        <asp:Label ID="StatusLabel" runat="server" Text='<%# Bind("Status") %>' />
        <br />
        CreateDate:
        <asp:Label ID="CreateDateLabel" runat="server" Text='<%# Bind("CreateDate") %>' />
        <br />
        ModDate:
        <asp:Label ID="ModDateLabel" runat="server" Text='<%# Bind("ModDate") %>' />
        <br />
        ModBy:
        <asp:Label ID="ModByLabel" runat="server" Text='<%# Bind("ModBy") %>' />
        <br />
        <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
        &nbsp;<asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New" Text="New" />
    </ItemTemplate>

</asp:FormView>

<table>
    <tr><td></td><td></td><td></td><td></td></tr>
</table>
<asp:LinkButton ID="lnkDownLoadRubric" runat="server" OnClick="lnkDownLoadRubric_Click">Download Blank Rubric Form</asp:LinkButton>
<asp:SqlDataSource ID="sdsRubricInfo" runat="server" 
    ConnectionString="<%$ ConnectionStrings:BEF %>" 
    OnUpdating="sdsRubricInfo_OnUpdating"
    OnInserting="sdsRubricInfo_OnInserting"
    OnInserted="sdsRubricInfo_Inserted"
    SelectCommand="Rubric_RubricInfo_Sel" SelectCommandType="StoredProcedure"
    UpdateCommand="Rubric_RubricInfo_upd" UpdateCommandType="StoredProcedure"
    InsertCommand="Rubric_RubricInfo_ins" InsertCommandType="StoredProcedure">
    <SelectParameters>
        <asp:ControlParameter ControlID="ddGrant" Name="GrantID" Type="Int32" DefaultValue="1" />
    </SelectParameters>
    <UpdateParameters>
        <asp:Parameter Name="UserName" />
    </UpdateParameters>
    <InsertParameters>
        <asp:Parameter Name="UserName" />
    </InsertParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="sdsGrant" runat="server" ConnectionString="<%$ ConnectionStrings:BEF %>" 
    SelectCommand="Rubric_GrantInfo_sel" SelectCommandType="StoredProcedure"
     OnSelecting="sdsGrant_OnSelecting">
    <SelectParameters>
        <asp:Parameter Name="UserName" />
    </SelectParameters>
</asp:SqlDataSource>
</asp:Content>
