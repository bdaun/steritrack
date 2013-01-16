<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManualDataAdd.aspx.cs" Inherits="MWP.Secure.MailData.ManualDataAdd" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <ajaxToolkit:ToolkitScriptManager ID="AjaxSM" runat="server" EnablePageMethods="true" />
    <h2>Data Entry Page</h2>
    <asp:Label ID="lblErrMsg" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" />
<table>
<tr>
    <td style="font-style:italic">Select a type of add:</td><td></td><td></td><td></td>
</tr>
<tr>
    <td><asp:DropDownList ID="DropDownList1" runat="server">
        <asp:ListItem Text="Mistake Mail" Value="MistakeMail" />

        </asp:DropDownList></td><td></td><td></td><td></td>
</tr>
<tr>
    <td></td><td></td><td></td><td></td>
</tr>
</table>
</asp:Content>
