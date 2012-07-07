<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TechCSMap.aspx.cs" Inherits="IMDBWeb.Secure.SPAKpages.TechCSMap" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .style1
        {
            height: 47px;
        }
    </style>
    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table cellpadding="8">
        <tr align="center">
            <td colspan="2">
    Customer Service Rep<br />
                &nbsp;
    <asp:DropDownList ID="ddCSRep" runat="server" DataSourceID="sdsCSReps" 
        DataTextField="CustServRepID" DataValueField="CustServRepID" 
        AppendDataBoundItems="true" AutoPostBack="True">
        <asp:ListItem Text="Default" Value="0">Select a CS Rep</asp:ListItem>
    </asp:DropDownList>
            </td>
            <td class="style1" colspan="2">
            SPAK Technician<br />
    <asp:DropDownList ID="ddTech" runat="server" DataSourceID="sdsTechs" 
        DataTextField="TechName" DataValueField="TechnicianID" AppendDataBoundItems="true" 
                    AutoPostBack="True">
        <asp:ListItem Text="Default" Value="0">Select a Technician</asp:ListItem>
    </asp:DropDownList>
            </td>
        </tr>
        <tr align="center" valign="top">
            <td colspan="2">
    <asp:GridView ID="gvCSRep" runat="server" AutoGenerateColumns="False" 
                    DataSourceID="sdsRep2Tech" Width="150px" CellPadding="4" ForeColor="#333333" GridLines="Horizontal">
        <HeaderStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#333333" />
        <Columns>
            <asp:BoundField DataField="TechName" HeaderText="TechName" SortExpression="TechName" />
        </Columns>
    </asp:GridView>
            </td>
            <td class="style1" colspan="2">
    <asp:GridView ID="gvTech" runat="server" AutoGenerateColumns="False" 
                    DataSourceID="sdsTech2Rep" CellPadding="4" ForeColor="#333333" GridLines="Horizontal">
        <HeaderStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#333333" />
        <Columns>
            <asp:CommandField ShowEditButton="True" />
            <asp:TemplateField HeaderText="CustServRepID" SortExpression="CustServRepID">
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("CustServRepID") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:DropDownList ID="ddNewRepID" runat="server" DataSourceID="sdsCSReps" 
                        SelectedValue='<%# Bind("CustServRepID") %>' DataTextField="CustServRepID" 
                        DataValueField="CustServRepID" AppendDataBoundItems="true" >
                        <asp:ListItem Text="Unassigned" Value="Unassigned" />
                    </asp:DropDownList>
                </EditItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
            </td>
        </tr>
        <tr align="center" valign="top">
            <td colspan="2"><asp:Button ID="btnAddCM" runat="server" Text="Add New" /></td>
            <td colspan="2"><asp:Button ID="btnAddTech" runat="server" Text="Add New" 
                    onclick="btnAddTech_Click" /></td>
        </tr>
        <tr align="center" valign="top">
            <td align="right">
                <asp:Label ID="lblCMNameID" runat="server" Text="NameID:"></asp:Label>&nbsp   
            </td>
            <td align="left">
                <asp:TextBox ID="txbCMNameID" runat="server"></asp:TextBox></td>
            <td align="right">
                <asp:Label ID="lblTechNameID" runat="server" Text="NameID:"></asp:Label>&nbsp
                </td>
            <td align="left">
                <asp:TextBox ID="txbTechNameID" runat="server" ></asp:TextBox>
            </td>
        </tr>
        <tr align="center" valign="top">
            <td align="right">
                <asp:Label ID="lblCMName" runat="server" Text="Name:"></asp:Label>&nbsp
            </td>
            <td align="left">
                <asp:TextBox ID="txbCMName" runat="server"></asp:TextBox>  
            </td>
            <td align="right">
                <asp:Label ID="lblTechName" runat="server" Text="Name:"></asp:Label>&nbsp
            </td>
            <td align="left">
                <asp:TextBox ID="txbTEchName" runat="server" ></asp:TextBox>
            </td>
        </tr>
        <tr align="center" valign="top">
            <td></td>
            <td></td>
            <td align="right">
                <asp:Label ID="lblTechPhone" runat="server" Text="Phone:"></asp:Label>&nbsp;
            </td>
            <td align="left">
                <asp:TextBox ID="txbTechPhone" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr align="center" valign="top">
            <td colspan="2">
                <asp:Button ID="btnSubmitCM" runat="server" Text="Submit" />
            </td>
            <td colspan="2">
                <asp:Button ID="btnSubmitTech" runat="server" Text="Submit" 
                    onclick="btnSubmitTech_Click" />
            </td>
        </tr>
    </table>
    <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>
    <br />
    <br />
    <asp:SqlDataSource ID="sdsTechs" runat="server" 
        ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
        SelectCommand="SELECT DISTINCT TechName, TechnicianID
                        FROM SPAK_TechCSMap ORDER BY TechName">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsCSReps" runat="server" 
        ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
        SelectCommand="SELECT DISTINCT CustServRepID FROM SPAK_TechCSMap ORDER BY CustServRepID">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsRep2Tech" runat="server" 
        ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
        
        SelectCommand="SELECT DISTINCT [TechName] FROM [SPAK_TechCSMap] WHERE ([CustServRepID] = @CustServRepID)">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddCSRep" Name="CustServRepID" 
                PropertyName="SelectedValue" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsTech2Rep" runat="server" 
        ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
        SelectCommand="SELECT DISTINCT CustServRepID FROM SPAK_TechCSMap WHERE (TechnicianID = @TechnicianID)" 
        UpdateCommand="UPDATE spak_techcsmap SET CustServRepID = @CustServRepID WHERE TechnicianID = @TechnicianID">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddTech" Name="TechnicianID" PropertyName="SelectedValue" Type="String" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="CustServRepID" Type="String" />
            <asp:ControlParameter ControlID="ddTech" Name="TechnicianID" PropertyName="SelectedValue" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
