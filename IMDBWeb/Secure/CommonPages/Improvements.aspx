<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Improvements.aspx.cs" Inherits="IMDBWeb.Secure.CommonPages.Improvements" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>SteriTrack Improvement Ideas and Problem Reporting</h2><br />
<table>
<tr>
    <td colspan="3" style="font-style:italic">Showing all Open Comments<br />Find Comment by Submitter and/or Status</td>
</tr>
<tr>
<td>        
    <asp:DropDownList ID="ddSubmitterName" runat="server" DataSourceID="sdsSubmitterName" 
        DataTextField="SubmitterName" DataValueField="SubmitterName" 
        AppendDataBoundItems="true" AutoPostBack="True" 
        onselectedindexchanged="ddSubmitterName_SelectedIndexChanged">
        <asp:ListItem Text="Select a Submitter" Value="All" />
        <asp:ListItem Text="All" Value="All" />
    </asp:DropDownList>
</td>
<td>
    <asp:DropDownList ID="ddStatus" runat="server" onselectedindexchanged="ddStatus_SelectedIndexChanged" AutoPostBack="True">
        <asp:ListItem Text="Select a Status" Value="Submitted" />
        <asp:ListItem Text="All" Value="All" />
        <asp:ListItem Text="Submitted" Value="Submitted" />
        <asp:ListItem Text="Project Created" Value="Project" />
        <asp:ListItem Text="Resolved/Closed" Value="Closed" />
    </asp:DropDownList>
</td>
<td> <asp:Button ID="btnSubmit" runat="server" Text="Go" onclick="btnSubmit_Click" />&nbsp;
    <asp:Button ID="btnClear" runat="server" Text="Clear" 
        onclick="btnClear_Click" /></td></tr>
</table><br />
<asp:Button ID="btnInsert" runat="server" Text="Insert New" onclick="btnInsert_Click" />
<asp:FormView ID="fvInsertComment" runat="server" DataSourceID="sdscomments" DefaultMode="Insert" Visible="False" Width="95%" >
<InsertItemTemplate>
    <table>
    <tr>
    <td valign="top">Comment:&nbsp</td>
    <td><asp:TextBox ID="CommentTextBox" runat="server" TextMode="MultiLine" Rows="10" Text='<%# Bind("Comment") %>' Columns="100" /></td>
    </tr>
    </table>
    <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
    <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" OnClick="InsertCancelButton_OnClick" Text="Cancel" />
</InsertItemTemplate>
</asp:FormView>
<asp:GridView ID="gvComments" runat="server" AutoGenerateColumns="False" DataSourceID="sdsComments" Width="90%">
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
        <asp:TemplateField HeaderText="Status" SortExpression="Status">
            <EditItemTemplate>
                <asp:DropDownList ID="ddStatus" runat="server" SelectedValue='<%# Bind("Status") %>' >
                    <asp:ListItem Text="Submitted" Value="Submitted" />
                    <asp:ListItem Text="Project Created" Value="Project" />
                    <asp:ListItem Text="Resolved/Closed" Value="Closed" />
                </asp:DropDownList>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="lblStatus" runat="server" Text='<%# Bind("Status") %>' ></asp:Label>
            </ItemTemplate>
            <ItemStyle Width="35px" />
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Submitter" SortExpression="Submitter">
            <EditItemTemplate>
                <asp:Label ID="lblSubmitter" runat="server" Text='<%# Bind("Submitter") %>' ></asp:Label>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="lblSubmitter" runat="server" Text='<%# Bind("Submitter") %>' ></asp:Label>
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
        <asp:TemplateField HeaderText="ModDate" SortExpression="ModDate">
            <EditItemTemplate>
                <asp:Label ID="lblModDate" runat="server" Text='<%# Bind("ModDate", "{0:d}") %>' ></asp:Label>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="lblModDate" runat="server" Text='<%# Bind("ModDate", "{0:d}") %>' ></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="ModBy" SortExpression="ModBy">
            <EditItemTemplate>
                <asp:Label ID="lblModBy" runat="server" Text='<%# Bind("UserName") %>' ></asp:Label>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="lblModBy" runat="server" Text='<%# Bind("UserName") %>' ></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>
<asp:SqlDataSource ID="sdsComments" runat="server" 
    ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
    SelectCommand="IMDB_Improvements_Comments_Sel" SelectCommandType="StoredProcedure"
    InsertCommand="IMDB_Improvements_Comments_Ins" InsertCommandType="StoredProcedure"
    UpdateCommand="UPDATE Improvements SET Comment=@Comment,ModDate=GetDate(),UserName=@ModBy,[Status]=@Status WHERE ID=@ID" 
    UpdateCommandType="Text" OnInserting="sdsComments_Inserting" OnInserted="sdsComments_Inserted"
    OnUpdating="sdsComments_Updating" OnUpdated="sdsComments_Updated">
    <SelectParameters>
        <asp:ControlParameter ControlID="ddSubmitterName" Name="SubmitterName" PropertyName="SelectedValue" Type="String" />
        <asp:ControlParameter ControlID="ddStatus" Name="Status" PropertyName="SelectedValue" DefaultValue="All" Type="String" />
    </SelectParameters>
    <InsertParameters>
        <asp:Parameter Name="Comment" Type="String" />
        <asp:Parameter Name="ModBy" Type="String" />
    </InsertParameters>
    <UpdateParameters>
        <asp:Parameter Name="ID" Type="Int32" />
        <asp:Parameter Name="Comment" Type="String" />
        <asp:Parameter Name="ModBy" Type="String" />
        <asp:Parameter Name="Status" Type="String" />
    </UpdateParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="sdsSubmitterName" runat="server" 
    ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
    SelectCommand="IMDB_Improvements_SubmitterName_Sel" SelectCommandType="StoredProcedure">
</asp:SqlDataSource>
</asp:Content>
