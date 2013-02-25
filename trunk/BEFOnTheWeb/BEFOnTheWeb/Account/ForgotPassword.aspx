<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="BEFOnTheWeb.Account.ForgotPassword" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Use the form below to reset your password.</h2>
    <asp:PasswordRecovery ID="PasswordRecovery1" runat="server">
        <MailDefinition BodyFileName="~/Account/email.txt" IsBodyHtml="True">
        </MailDefinition>
        <QuestionTemplate>
            <table style="padding:4px;border-collapse:collapse;">
                <tr>
                    <td>
                        <table style="padding:4px;border-collapse:collapse;">
                            <tr>
                                <td style="text-align:center" colspan="2">Identity Confirmation</td>
                            </tr>
                            <tr>
                                <td style="text-align:center" colspan="2">Answer the following question to receive your password.</td>
                            </tr>
                            <tr>
                                <td style="text-align:right">User Name:&nbsp;</td>
                                <td>
                                    <asp:Literal ID="UserName" runat="server"></asp:Literal>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align:right">Question:&nbsp;</td>
                                <td>
                                    <asp:Literal ID="Question" runat="server"></asp:Literal>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align:right">
                                    <asp:Label ID="AnswerLabel" runat="server" AssociatedControlID="Answer">Answer:&nbsp;</asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="Answer" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="AnswerRequired" runat="server" ControlToValidate="Answer" ErrorMessage="Answer is required." ToolTip="Answer is required." ValidationGroup="PasswordRecovery1">*</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="color:Red;text-align:center">
                                    <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align:right" colspan="2">
                                    <asp:Button ID="SubmitButton" runat="server" CommandName="Submit" Text="Submit" ValidationGroup="PasswordRecovery1" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </QuestionTemplate>
        <SuccessTemplate>
            <table style="border-collapse:collapse;padding:4px">
                <tr>
                    <td>
                        <table style="border-collapse:collapse;padding:4px">
                            <tr>
                                <td>Your password has been sent to you.</td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </SuccessTemplate>
        <UserNameTemplate>
            <table Style="padding:4px;border-collapse:collapse;">
                <tr>
                    <td>
                        <table Style="padding:4px;border-collapse:collapse;">
                            <tr>
                                <td Style="text-align:center" colspan="2">Forgot Your Password?</td>
                            </tr>
                            <tr>
                                <td Style="text-align:center" colspan="2">Enter your User Name to receive your password.</td>
                            </tr>
                            <tr>
                                <td Style="text-align:center">
                                    <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">User Name:&nbsp;</asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="UserName" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" ErrorMessage="User Name is required." ToolTip="User Name is required." ValidationGroup="PasswordRecovery1">*</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td Style="text-align:center;color:red" colspan="2" >
                                    <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                                </td>
                            </tr>
                            <tr>
                                <td Style="text-align:right" colspan="2">
                                    <asp:Button ID="SubmitButton" runat="server" CommandName="Submit" Text="Submit" ValidationGroup="PasswordRecovery1" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </UserNameTemplate>
    </asp:PasswordRecovery>
</asp:Content>

