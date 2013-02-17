<%@ Page Language="C#" MasterPageFile="~/Secure/Page.master" %>

<script runat="server">
	private bool createRoleSuccess = true;
	
	private void Page_PreRender()
	{
        // Create a DataTable and define its columns
		DataTable RoleList = new DataTable();
		RoleList.Columns.Add("Role Name");
		RoleList.Columns.Add("User Count");
		
        string[] allRoles = Roles.GetAllRoles();

        // Get the list of roles in the system and how many users belong to each role
        foreach (string roleName in allRoles)
		{
            int numberOfUsersInRole = Roles.GetUsersInRole(roleName).Length;
            string[] roleRow = { roleName, numberOfUsersInRole.ToString() };
			RoleList.Rows.Add(roleRow);
		}

        // Bind the DataTable to the GridView
		UserRoles.DataSource = RoleList;
		UserRoles.DataBind();

		if (createRoleSuccess)
		{
			// Clears form field after a role was successfully added. Alternative to redirect technique I often use.
			NewRole.Text = "";
		}
	}

	private void AddRole(object sender, EventArgs e)
	{
		try
		{
			Roles.CreateRole(NewRole.Text);
			ConfirmationMessage.InnerText = "The new role was added.";
			createRoleSuccess = true;
		}
		catch (Exception ex)
		{
			ConfirmationMessage.InnerText = ex.Message;
			createRoleSuccess = false;
		}
	}

	private void DeleteRole(object sender, CommandEventArgs e)
	{
		try
		{
			Roles.DeleteRole(e.CommandArgument.ToString());
			ConfirmationMessage.InnerText = "Role '" + e.CommandArgument.ToString() + "' was deleted.";
		}
		catch (Exception ex)
		{
			ConfirmationMessage.InnerText = ex.Message;
		}
	}

	protected void DisableRoleManager(object sender, EventArgs e)
	{

	}
</script>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

<!-- #include file="_nav.aspx -->

<table class="webparts">
<tr>
	<th>Roles</th>
</tr>
<tr>
<td class="details" style="width: 450px;vertical-align:top">

<br />

<asp:GridView runat="server" ID="UserRoles" AutoGenerateColumns="false"
	CssClass="list" AlternatingRowStyle-CssClass="odd" GridLines="none">
	<Columns>
		<asp:TemplateField>
			<HeaderTemplate>Role Name</HeaderTemplate>
			<ItemTemplate>
				<%# Eval("Role Name") %>
			</ItemTemplate>
		</asp:TemplateField>
		<asp:TemplateField>
			<HeaderTemplate>User Count</HeaderTemplate>
			<ItemTemplate>
				<%# Eval("User Count") %>
			</ItemTemplate>
		</asp:TemplateField>
		<asp:TemplateField>
			<HeaderTemplate>Delete Role</HeaderTemplate>
			<ItemTemplate>
				<asp:Button ID="Button1" runat="server" OnCommand="DeleteRole" CommandName="DeleteRole" CommandArgument='<%# Eval("Role Name") %>' Text="Delete" OnClientClick="return confirm('Are you sure?')" />
			</ItemTemplate>
		</asp:TemplateField>
	</Columns>
</asp:GridView>
<p>
New Role:
<asp:TextBox runat="server" ID="NewRole"></asp:TextBox>
<asp:Button ID="Button2" runat="server" OnClick="AddRole" Text="Add Role" />
</p>
<div runat="server" id="ConfirmationMessage" class="alert">
</div>
</td>
</tr></table>
</asp:Content>