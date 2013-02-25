<%@ Page Title="Register" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="BEFOnTheWeb.Account.Register" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <h2>Use the form below to create a new account.</h2><br />
    <table>
        <tr>
            <td style="font-weight:600;font-size:1.2em"><asp:Label ID="lblUserType" runat="server" Text="Select a user role" />&nbsp;&nbsp;</td>
            <td><asp:DropDownList ID="ddUserType" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddUserType_SelectedIndexChanged">
                    <asp:ListItem Text="Select from List" Value="NoneSelected" />
                    <asp:ListItem Text="Volunteer / Guest" Value="Guest" />
                    <asp:ListItem Text="Teacher" Value="Teacher" />
<%--                    <asp:ListItem Text="School Administrator" Value="GrantApprover" />
                    <asp:ListItem Text="BEF Director" Value="BEF" />--%>
                </asp:DropDownList></td>
        </tr>
    </table>

    <asp:Label ID="lblUserTypeNote" runat="server" Text="" />
    <p>
        <asp:CreateUserWizard ID="RegisterUser" runat="server" visible="false"
            CancelDestinationPageUrl="~/Default.aspx" 
            ContinueDestinationPageUrl="~/Default.aspx" DisplayCancelButton="True"
            oncreatinguser="RegisterUser_CreatingUser" OnCreatedUser="RegisterUser_CreatedUser">
            <WizardSteps>
                <asp:CreateUserWizardStep ID="CreateUserWizardStep1" runat="server" >
                    <ContentTemplate>
                        <table>
                            <tr>
                                <td style="text-align:center" colspan="2">Sign Up for Your New Account</td>
                            </tr>
                            <tr>
                                <td style="text-align:right;padding-right:4px">
                                    <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">User Name:</asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="UserName" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" ErrorMessage="User Name is required." ToolTip="User Name is required." ValidationGroup="RegisterUser">*</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align:right;padding-right:4px">
                                    <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">Password:</asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="Password" runat="server" TextMode="Password"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" ErrorMessage="Password is required." ToolTip="Password is required." ValidationGroup="RegisterUser">*</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align:right;padding-right:4px">
                                    <asp:Label ID="ConfirmPasswordLabel" runat="server" AssociatedControlID="ConfirmPassword">Confirm Password:</asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="ConfirmPassword" runat="server" TextMode="Password"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="ConfirmPasswordRequired" runat="server" ControlToValidate="ConfirmPassword" ErrorMessage="Confirm Password is required." ToolTip="Confirm Password is required." ValidationGroup="RegisterUser">*</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align:right;padding-right:4px">
                                    <asp:Label ID="EmailLabel" runat="server" AssociatedControlID="Email">E-mail:</asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="Email" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="EmailRequired" runat="server" ControlToValidate="Email" ErrorMessage="E-mail is required." ToolTip="E-mail is required." ValidationGroup="RegisterUser">*</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align:right;vertical-align:top;padding-right:4px">
                                    <asp:Label ID="QuestionLabel" runat="server" AssociatedControlID="Question">Security Question:</asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="Question" runat="server"> 
                                       <asp:ListItem>What is your mother's maiden name?</asp:ListItem> 
                                       <asp:ListItem>In what city were you born?</asp:ListItem> 
                                       <asp:ListItem>What is your favorite sport?</asp:ListItem> 
                                       <asp:ListItem>How much wood could a woodchuck chuck if a woodchuck could chuck wood?</asp:ListItem> 
                                    </asp:DropDownList> 
                                    <br /> 
                                    <i>If you forget your password you will be asked the security question <br /> 
                                        you choose here and prompted to enter the answer you specify below.</i> 
                                    <asp:RequiredFieldValidator ID="QuestionRequired" runat="server" ControlToValidate="Question" ErrorMessage="Security question is required." ToolTip="Security question is required." ValidationGroup="RegisterUser">*</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align:right;padding-right:4px">
                                    <asp:Label ID="AnswerLabel" runat="server" AssociatedControlID="Answer">Security Answer:</asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="Answer" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="AnswerRequired" runat="server" ControlToValidate="Answer" ErrorMessage="Security answer is required." ToolTip="Security answer is required." ValidationGroup="RegisterUser">*</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align:center" colspan="2">
                                    <asp:CompareValidator ID="PasswordCompare" runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword" Display="Dynamic" ErrorMessage="The Password and Confirmation Password must match." ValidationGroup="RegisterUser"></asp:CompareValidator>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align:center;color:Red" colspan="2" >
                                    <asp:Literal ID="ErrorMessage" runat="server" EnableViewState="False"></asp:Literal>
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:CreateUserWizardStep>
                <asp:CompleteWizardStep ID="CompleteWizardStep1" runat="server" />
            </WizardSteps>
        </asp:CreateUserWizard>
    </p>
    <p>
        <asp:Label runat="server" id="InvalidUserNameOrPasswordMessage" Visible="false" EnableViewState="false" ForeColor="Red"></asp:Label>
    </p>
</asp:Content>