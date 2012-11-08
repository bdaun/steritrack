<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TechComments.aspx.cs" Inherits="TeleiosDemo.Secure.SPAKpages.TechComments" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    SPAK Technician Comments<br /><br />
<table style="width: "50%">
    <tr align="center"><td>TechName</td><td>Begin Date</td>
        <td>End Date</td><td></td></tr>
    <tr>
    <td>        
        <asp:DropDownList ID="ddTechName" runat="server" DataSourceID="sdsTechName" 
            DataTextField="TechName" DataValueField="TechnicianID" 
            AppendDataBoundItems="true" AutoPostBack="True" 
            onselectedindexchanged="ddTechName_SelectedIndexChanged">
            <asp:ListItem Text="Select a Technician" Value="" />
        </asp:DropDownList>
    </td>
    <td>
        <asp:TextBox ID="txbBeginDate" runat="server" Width="100px"></asp:TextBox>
    </td>
    <td>
        <asp:TextBox ID="txbEndDate" runat="server" Width="100px"></asp:TextBox>
    </td>
    <td>
        <asp:Button ID="btnSubmit" runat="server" Text="Go" onclick="btnSubmit_Click" />
    </td></tr>
</table>
    <asp:FormView ID="fvInsertComment" runat="server" 
        DataSourceID="sdsTechcomments" DefaultMode="Insert" Visible="False" Width="95%" >
    <InsertItemTemplate>
    <table>
    <tr>
        <td>Technician:&nbsp</td>
        <td><asp:Label ID="lblTechName" runat="server" Text='<%# Eval("TechName") %>' />&nbsp&nbsp
        <asp:Label ID="lblTechnicianID" runat="server" Text='<%# Bind("TechnicianID") %>' ForeColor="White" /></td>
    </tr>
    <tr>
        <td>Date:&nbsp</td>
        <td><asp:Label ID="lblCommentDate" runat="server" Text='<%# Bind("CommentDate") %>' /></td>
    </tr>
    <tr>
        <td valign="top">Comment:&nbsp</td>
        <td><asp:TextBox ID="CommentTextBox" runat="server" TextMode="MultiLine" Rows="10" Text='<%# Bind("Comment") %>' Columns="100" /></td>
    </tr>
</table>
    <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
    <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" OnClick="InsertCancelButton_OnClick" Text="Cancel" />
    </InsertItemTemplate>
    </asp:FormView>
    <asp:GridView ID="gvTechComments" runat="server" AutoGenerateColumns="False" DataSourceID="sdsTechcomments" Width="90%">
        <HeaderStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#333333" />
        <Columns>
            <asp:CommandField ShowEditButton="True"><ItemStyle Width="25px"></ItemStyle></asp:CommandField>
            <asp:TemplateField HeaderText="ID" SortExpression="ID">
                <EditItemTemplate>
                    <asp:Label ID="lblID" runat="server" Text='<%# Bind("ID") %>' ></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblID" runat="server" Text='<%# Bind("ID") %>' ></asp:Label>
                </ItemTemplate>
                <ItemStyle Width="35px" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Date" SortExpression="CommentDate">
                <EditItemTemplate>
                    <asp:Label ID="lblCommentDate" runat="server"  ReadOnly="true" Text='<%# Eval("CommentDate","{0:d}") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblCommentDate" runat="server" Text='<%# Bind("CommentDate", "{0:d}") %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle Width="75px" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Comment" SortExpression="Comment">
                <EditItemTemplate>
                    <asp:TextBox ID="txbComment" runat="server" Text='<%# Bind("Comment") %>' Width="90%" Rows="10" TextMode="MultiLine"></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblComment" runat="server" Text='<%# Bind("Comment") %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle VerticalAlign="Top" Wrap="True" />
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:Button ID="btnInsert" runat="server" Text="Insert New" onclick="btnInsert_Click" />
    <asp:SqlDataSource ID="sdsTechcomments" runat="server" 
        ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
        SelectCommand="SPAK_TechComments_Sel" SelectCommandType="StoredProcedure"
        InsertCommand="SPAK_TechComments_Ins" InsertCommandType="StoredProcedure"
        UpdateCommand="SPAK_TechComments_upd" UpdateCommandType="StoredProcedure"
        OnInserting="sdsTechcomments_Inserting" OnInserted="sdsTechcomments_Inserted"
        OnUpdating="sdsTechcomments_Updating" OnUpdated="sdsTechcomments_Updated">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddTechName" Name="TechnicianID" PropertyName="SelectedValue" Type="String" />
            <asp:ControlParameter ControlID="txbBeginDate" Name="date1" PropertyName="Text" Type="DateTime" />
            <asp:ControlParameter ControlID="txbEndDate" Name="date2" PropertyName="Text" Type="DateTime" />
        </SelectParameters>
        <InsertParameters>
            <asp:Parameter Name="TechnicianID" Type="String" />
            <asp:Parameter Name="CommentDate" Type="DateTime" />
            <asp:Parameter Name="Comment" Type="String" />
            <asp:Parameter Name="ModBy" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="ID" Type="Int32" />
            <asp:Parameter Name="Comment" Type="String" />
            <asp:Parameter Name="ModBy" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsTechName" runat="server" 
        ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
        SelectCommand="SPAK_TechProg_TechName_Sel" SelectCommandType="StoredProcedure">
    </asp:SqlDataSource>
</asp:Content>
