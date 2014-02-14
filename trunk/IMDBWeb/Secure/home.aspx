<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="home.aspx.cs" Inherits="IMDBWeb.home" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
<style type="text/css">

p.MsoTitleCxSpFirst
	{border-style: none;
            border-color: inherit;
            border-width: medium;
	        font-size:26.0pt;
	        font-family:"Cambria","serif";
	        color:#17365D;
	        letter-spacing:.25pt;
        }
p.MsoTitleCxSpLast
	{border-style: none;
            border-color: inherit;
            border-width: medium;
	        margin-bottom:15.0pt;
	        font-size:26.0pt;
	        font-family:"Cambria","serif";
	        color:#17365D;
	        letter-spacing:.25pt;
	}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div style="border:none;border-bottom:solid #4F81BD 1.0pt;padding:0in 0in 4.0pt 0in">
        <p class="MsoTitleCxSpFirst">&nbsp;</p>
        <p class="MsoTitleCxSpFirst">
            <span class="style2" style=" font-size:32pt; color: #215E1C">Welcome To </span>
            <span class="style1" style=" font-size:larger; color: #215E1C"><em>SteriTrack!</em></span></p>
        <p class="MsoTitleCxSpLast" style="font-size: medium; color: #215E1C">
            A SYSTEM FOR INVENTORY MANAGEMENT, PROCESSING, AND REPORTING</p>
    </div>
    <asp:Label ID="Label1" runat="server" Text="v002026_01" Font-Size="X-Small"></asp:Label>
    <div class="footer"></div>
</asp:Content>
