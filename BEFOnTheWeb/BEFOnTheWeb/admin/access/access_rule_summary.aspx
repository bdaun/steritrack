<%@ Page Language="C#" MasterPageFile="~/Secure/Page.master" %>
<%@ Import Namespace="System.Web.Configuration" %>

<script runat="server">
	private const string VirtualImageRoot = "~/";
	private string selectedRole, selectedUser;
	
	private void Page_Init()
	{
		UserRoles.DataSource = Roles.GetAllRoles();
		UserRoles.DataBind();

		UserList.DataSource = Membership.GetAllUsers();
		UserList.DataBind();

		FolderTree.Nodes.Clear();
	}
	
	private void Page_Load()
	{
		selectedRole = UserRoles.SelectedValue;
		selectedUser = UserList.SelectedValue;
	}
	
	private void Page_PreRender()
	{
	}
	
	private void PopulateTree(string byUserOrRole)
	{
		
		// Populate the tree based on the subfolders of the specified VirtualImageRoot
		DirectoryInfo rootFolder = new DirectoryInfo(Server.MapPath(VirtualImageRoot));
		TreeNode root = AddNodeAndDescendents(byUserOrRole, rootFolder, null);
		FolderTree.Nodes.Add(root);
	}
	
	private TreeNode AddNodeAndDescendents(string byUserOrRole, DirectoryInfo folder, TreeNode parentNode)
	{
		
		// Add the TreeNode, displaying the folder's name and storing the full path to the folder as the value...
		string virtualFolderPath;
		if (parentNode == null)
		{
			virtualFolderPath = VirtualImageRoot;
		}
		else
		{
			virtualFolderPath = parentNode.Value + folder.Name + "/";
		}
		
		// Instantiate the objects that we'll use to check folder security on each tree node.
		Configuration config = WebConfigurationManager.OpenWebConfiguration(virtualFolderPath);
		SystemWebSectionGroup systemWeb = (SystemWebSectionGroup)config.GetSectionGroup("system.web");
		AuthorizationSection section = (AuthorizationSection)systemWeb.Sections["authorization"];

		string action;
		if (byUserOrRole == "ByRole")
		{
			action = GetTheRuleForThisRole(section, virtualFolderPath);
		}
		else if (byUserOrRole == "ByUser")
		{
			action = GetTheRuleForThisUser(section, virtualFolderPath);
		}
		else
		{
			action = "";
		}
		
		//  This is where I wanna adjust the folder name.
		TreeNode node = new TreeNode(folder.Name + " (" + action + ")", virtualFolderPath);
		node.ImageUrl = (action.Substring(0, 5) == "ALLOW") ? "../../images/greenlight.gif" : "../../images/redlight.gif";
		node.NavigateUrl = "access_rules.aspx?selectedFolderName=" + folder.Name;
		
		// Recurse through this folder's subfolders
		DirectoryInfo[] subFolders = folder.GetDirectories();
		foreach(DirectoryInfo subFolder in subFolders)
		{
			// You could use this filter out certain folders.
			if (subFolder.Name != "_controls" && subFolder.Name != "App_Data")
			{
				TreeNode child = AddNodeAndDescendents(byUserOrRole, subFolder, node);
				node.ChildNodes.Add(child);
			}
		}
		return node; // Return the new TreeNode
	}
    
    private string GetTheRuleForThisRole(AuthorizationSection section, string folder)
	{
        
		foreach (AuthorizationRule rule in section.Rules)
		{

			foreach (string user in rule.Users)
			{
				if (user == "*")
				{
					return rule.Action.ToString().ToUpper() + ": All Users";
				}
			}
			foreach (string role in rule.Roles)
			{
				if (role == selectedRole)
				{
					return rule.Action.ToString().ToUpper() + ": Role=" + role;
				}
			}
		}

		return "Allow";
	}

	private string GetTheRuleForThisUser(AuthorizationSection section, string folder)
	{
		foreach (AuthorizationRule rule in section.Rules)
		{
			foreach (string user in rule.Users)
			{
				if (user == "*")
				{
					return rule.Action.ToString().ToUpper() + ": All Users";
				}
				else if (user == selectedUser)
				{
					return rule.Action.ToString().ToUpper() + ": User=" + user;
				}
			}

			// Don't forget that users might belong to some roles!
			foreach (string role in rule.Roles)
			{
				if (Roles.IsUserInRole(selectedUser, role))
				{
					return rule.Action.ToString().ToUpper() + ": Role=" + role;
				}
			}
		}
		return "ALLOW";
	}

	private void DisplayRoleSummary(object sender, EventArgs e)
	{
		FolderTree.Nodes.Clear();
		UserList.SelectedIndex = 0;
		if (UserRoles.SelectedIndex > 0)
		{
			PopulateTree("ByRole");
			FolderTree.ExpandAll();
		}
	}

	private void DisplayUserSummary(object sender, EventArgs e)
	{
		FolderTree.Nodes.Clear();
		UserRoles.SelectedIndex = 0;
		if (UserList.SelectedIndex > 0)
		{
			PopulateTree("ByUser");
			FolderTree.ExpandAll();
		}
	}

	private void DisplaySecuritySummary(object sender, TreeNodeEventArgs e)
	{
		e.Node.ShowCheckBox = true;
	}
	
	protected void FolderTree_SelectedNodeChanged(object sender, EventArgs e)
	{
	}
</script>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

<!-- #include file="_nav.aspx -->

<table class="webparts">
<tr>
	<th>Website Access Security Summary</th>
</tr>
<tr>
	<td class="details" style="vertical-align:top">
		<table>
		<tr>
			<td style="padding-right: 30px;vertical-align:top">

				<asp:DropDownList ID="UserRoles" runat="server" AppendDataBoundItems="true"
					AutoPostBack="true" OnSelectedIndexChanged="DisplayRoleSummary">
				<asp:ListItem>Select Role</asp:ListItem>
				</asp:DropDownList>
				
				&nbsp;&nbsp;&nbsp;&nbsp;<b>&mdash;&nbsp;&nbsp;OR&nbsp;&nbsp;&mdash;</b>
				&nbsp;&nbsp;&nbsp;				
				
				<asp:DropDownList ID="UserList" runat="server" AppendDataBoundItems="true"
					AutoPostBack="true" OnSelectedIndexChanged="DisplayUserSummary">
				<asp:ListItem>Select User</asp:ListItem>
				<asp:ListItem Text="Anonymous users (?)" Value="?"></asp:ListItem>
				<asp:ListItem Text="Authenticated users not in a role (*)" Value="*"></asp:ListItem>
				</asp:DropDownList>	
				
				<br />
				
				<div class="treeview">
				<asp:TreeView runat="server" ID="FolderTree"
					OnSelectedNodeChanged="FolderTree_SelectedNodeChanged"
					>
					<RootNodeStyle ImageUrl="../../images/folder.gif" />
					<ParentNodeStyle ImageUrl="../../images/folder.gif" />
					<LeafNodeStyle ImageUrl="../../images/folder.gif" />
					<SelectedNodeStyle Font-Underline="true" ForeColor="#A21818" />
				</asp:TreeView>
				</div>
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>

</asp:Content>

