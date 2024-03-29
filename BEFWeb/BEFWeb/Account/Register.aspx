﻿<%@ Page Title="Register" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="BEFWeb.Account.Register" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <h2>Use the form below to create a new account.</h2>

    <p>
        <asp:CreateUserWizard ID="RegisterUser" runat="server" 
            CancelDestinationPageUrl="~/Default.aspx" 
            ContinueDestinationPageUrl="~/Default.aspx" DisplayCancelButton="True"
            oncreatinguser="RegisterUser_CreatingUser" OnCreatedUser="RegisterUser_CreatedUser">
            <WizardSteps>
                <asp:CreateUserWizardStep ID="CreateUserWizardStep1" runat="server" />
                <asp:CompleteWizardStep ID="CompleteWizardStep1" runat="server" />
            </WizardSteps>
        </asp:CreateUserWizard>
    </p>
    <p>
        <asp:Label runat="server" id="InvalidUserNameOrPasswordMessage" Visible="false" EnableViewState="false" ForeColor="Red"></asp:Label>
    </p>
</asp:Content>