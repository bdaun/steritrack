<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CreatingUserAccounts.aspx.cs" Inherits="BEFWeb.Membership.CreatingUserAccounts" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h2>Create a New User Account</h2>
    <p>
        <asp:CreateUserWizard ID="RegisterUser" runat="server" 
            CancelDestinationPageUrl="~/Default.aspx" 
            ContinueDestinationPageUrl="~/Default.aspx" DisplayCancelButton="True"
            oncreatinguser="RegisterUser_CreatingUser">
            <WizardSteps>
                <asp:CreateUserWizardStep ID="CreateUserWizardStep1" runat="server" />
                <asp:CompleteWizardStep ID="CompleteWizardStep1" runat="server" />
            </WizardSteps>
        </asp:CreateUserWizard>
    </p>
    <p>
        <asp:Label runat="server" id="InvalidUserNameOrPasswordMessage" Visible="false" EnableViewState="false" ForeColor="Red"></asp:Label>
    </p>
    
    <p>
        <asp:Label ID="CreateAccountResults" runat="server"></asp:Label>
    </p>    
</asp:Content>

