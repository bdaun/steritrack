﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="home.aspx.cs" Inherits="MWP.Home" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
<style type="text/css">

p.MsoTitleCxSpFirst
	{border: none;
            border-color: inherit;
            border-width: medium;
            margin:.0001pt;
	        padding:0in;
	        font-size:26.0pt;
	        font-family:"Cambria","serif";
	        color:#17365D;
	        letter-spacing:.25pt;
	        margin-left: 0in;
            margin-right: 0in;
            margin-top: 0in;
        }
p.MsoTitleCxSpLast
	{border: none;
            border-color: inherit;
            border-width: medium;
            margin:0in;
	        margin-right:0in;
	        margin-bottom:15.0pt;
	        margin-left:0in;
	        padding:0in;
	        font-size:26.0pt;
	        font-family:"Cambria","serif";
	        color:#17365D;
	        letter-spacing:.25pt;
	}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div style="border:none;border-bottom:solid #4F81BD 1.0pt;padding:0in 0in 4.0pt 0in">
        <p class="MsoTitleCxSpFirst">
            &nbsp;</p>
        <p class="MsoTitleCxSpFirst">
            <span class="style2" style=" font-size:32pt; color: #4b6c9e">Welcome To </span>
            <span class="style1" style=" font-size:larger; color: #4b6c9e"><em>MPS Business Management!</em></span></p>
        <p class="MsoTitleCxSpLast" style="font-size: medium; color: #4b6c9e">
            A SYSTEM FOR DATA MANAGEMENT, BILLING, AND REPORTING</p>
    </div>
    <asp:Label ID="Label1" runat="server" Text="v001001" Font-Size="X-Small"></asp:Label>
    <div class="footer"></div>
</asp:Content>
