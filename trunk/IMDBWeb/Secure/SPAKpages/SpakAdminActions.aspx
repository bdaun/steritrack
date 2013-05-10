<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SpakAdminActions.aspx.cs" Inherits="IMDBWeb.Secure.SPAKpages.SpakAdminActions" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<h3>SPAK Data Admin Actions</h3>
<hr />
<asp:Label ID="lblErrMsg" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" />
    <table border="2" cellpadding="10" style="background-color:#f9f9f9">
        <tr style="text-align:center;font-size:x-large;font-weight:bold;color:#003300">
            <td>Admin Operations</td>
        </tr>
        <tr valign="top">
            <td>
                <ul>
                    <li><asp:LinkButton ID="lnkUpdateBoxes" runat="server" Text="Update Boxes" onclick="lnkUpdateBoxes_Click" Font-Size="Large" ForeColor="#008000" /></li>
                    <li><asp:LinkButton ID="lnkUpdateManifests" runat="server" Text="Update Manifests" onclick="lnkUpdateManifests_Click" Font-Size="Large" ForeColor="#008000" /></li>
                    <li><asp:LinkButton ID="lnkUpdateUnknowns" runat="server" Text="Update Unknowns" onclick="lnkUpdateUnknowns_Click" Font-Size="Large" ForeColor="#008000" /></li>
                </ul>
            </td>
        </tr>
    </table>
    <asp:Label ID="lblResult" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="DarkGreen" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Clear" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Footer" runat="server">
</asp:Content>
