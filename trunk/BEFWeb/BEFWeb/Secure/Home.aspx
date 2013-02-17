<%@ Page Title="" Language="C#" MasterPageFile="~/secure/Page.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="BEFWeb.Secure.Home" %>
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
            <span class="style2" style="font-size:36pt; color: #4b6c9e">Welcome To </span><br />
            <span class="style1" style="font-size:60pt; color: #4b6c9e;margin-left: 100pt"><em>BEF Online</em></span></p>
        <div><br /><img id="Img1" alt="BEF LOGO" src="~/Images/logo_top_left.png" runat="server" style="height: 200px; width: 200px;display: block;margin-left: 175pt;" /></div>
        <p class="MsoTitleCxSpLast" style="font-size: medium; color: #4b6c9e"></p>
    </div>
    <asp:Label ID="Label1" runat="server" Text="v001001" Font-Size="X-Small"></asp:Label>
    <div class="footer"></div>
</asp:Content>
