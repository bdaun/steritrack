<%@ Page Language="C#" MasterPageFile="~/Secure/Page.master" %>
<%@ Import Namespace="System.Web.Configuration" %>

<script runat="server">
	private const string VirtualImageRoot = "~/";
	string selectedFolderName;
	
	private void Page_Init()
	{
		UserRoles.DataSource = Roles.GetAllRoles();
		UserRoles.DataBind();

		UserList.DataSource = Membership.GetAllUsers();
		UserList.DataBind();

		if (IsPostBack)
		{
			selectedFolderName = "";
		}
		else
		{
			selectedFolderName = Request.QueryString["selectedFolderName"];
		}
	}
	
	private void Page_Load()
	{
		if (!IsPostBack)
		{
			PopulateTree();
		}
	}
	
	private void Page_PreRender()
	{

		if (FolderTree.SelectedNode != null)
		{
			DisplayAccessRules(FolderTree.SelectedValue);
			SecurityInfoSection.Visible = true;
		}
	}

	private void PopulateTree()
	{
		
		// Populate the tree based on the subfolders of the specified VirtualImageRoot
		DirectoryInfo rootFolder = new DirectoryInfo(Server.MapPath(VirtualImageRoot));
		TreeNode root = AddNodeAndDescendents(rootFolder, null);
		FolderTree.Nodes.Add(root);
		try
		{
			FolderTree.SelectedNode.ImageUrl = "../../images/target.gif";
		}
		catch { }
	}
	
	private TreeNode AddNodeAndDescendents(DirectoryInfo folder, TreeNode parentNode)
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
		
		TreeNode node = new TreeNode(folder.Name, virtualFolderPath);
		node.Selected = (folder.Name == selectedFolderName);
		
		// Recurse through this folder's subfolders
		DirectoryInfo[] subFolders = folder.GetDirectories();
		foreach(DirectoryInfo subFolder in subFolders)
		{
			if (subFolder.Name != "_controls" && subFolder.Name != "App_Data")
			{
				TreeNode child = AddNodeAndDescendents(subFolder, node);
				node.ChildNodes.Add(child);
			}
		}
		return node; // Return the new TreeNode
	}
	
	protected void FolderTree_SelectedNodeChanged(object sender, EventArgs e)
	{
		ActionDeny.Checked = true;
		ActionAllow.Checked = false;
		ApplyRole.Checked = true;
		ApplyUser.Checked = false;
		ApplyAllUsers.Checked = false;
		ApplyAnonUser.Checked = false;
		UserRoles.SelectedIndex = 0;
		UserList.SelectedIndex = 0;

		RuleCreationError.Visible = false;

		ResetFolderImageUrls(FolderTree.Nodes[0]); // Restore previously selected folder's ImageUrl.
		FolderTree.SelectedNode.ImageUrl = "../../images/target.gif"; // Set the newly selected folder's ImageUrl.
	}

	private void ResetFolderImageUrls(TreeNode parentNode)
	{

		parentNode.ImageUrl = "../../images/folder.gif";
		
		// Recurse through this node's child nodes.
		TreeNodeCollection nodes = parentNode.ChildNodes;
		foreach (TreeNode childNode in nodes)
		{
			ResetFolderImageUrls(childNode);
		}
	}

	private void DisplayAccessRules(string virtualFolderPath)
	{
		if (!virtualFolderPath.StartsWith(VirtualImageRoot) || virtualFolderPath.IndexOf("..") >= 0)
		{

			throw new ApplicationException("An attempt to access a folder outside of the website directory has been detected and blocked.");
		}
		Configuration config = WebConfigurationManager.OpenWebConfiguration(virtualFolderPath);
		SystemWebSectionGroup systemWeb = (SystemWebSectionGroup)config.GetSectionGroup("system.web");
		AuthorizationRuleCollection authorizationRules = systemWeb.Authorization.Rules;
		RulesGrid.DataSource = authorizationRules;
		RulesGrid.DataBind();

		TitleOne.InnerText = "Rules applied to " + virtualFolderPath;
		TitleTwo.InnerText = "Create new rule for " + virtualFolderPath;
	}

	private void RowDataBound(object sender, GridViewRowEventArgs e)
	{
		if (e.Row.RowType == DataControlRowType.DataRow)
		{
			AuthorizationRule rule = (AuthorizationRule)e.Row.DataItem;
			if (!rule.ElementInformation.IsPresent)
			{
				e.Row.Cells[3].Text = "Inherited from higher level";
				e.Row.Cells[4].Text = "Inherited from higher level";
				e.Row.CssClass = "odd";
			}
		}
	}

	private string GetAction(AuthorizationRule rule)
	{
		return rule.Action.ToString();
	}
	private string GetRole(AuthorizationRule rule)
	{
		return rule.Roles.ToString();
	}
	private string GetUser(AuthorizationRule rule)
	{
		return rule.Users.ToString();
	}
	private void DeleteRule(object sender, EventArgs e)
	{
		Button button = (Button)sender;
		GridViewRow item = (GridViewRow)button.Parent.Parent;
		string virtualFolderPath = FolderTree.SelectedValue;
		Configuration config = WebConfigurationManager.OpenWebConfiguration(virtualFolderPath);
		SystemWebSectionGroup systemWeb = (SystemWebSectionGroup)config.GetSectionGroup("system.web");
		AuthorizationSection section = (AuthorizationSection)systemWeb.Sections["authorization"];
		section.Rules.RemoveAt(item.RowIndex);
		config.Save();
	}
	private void MoveUp(object sender, EventArgs e)
	{
		MoveRule(sender, e, "up");
	}
	private void MoveDown(object sender, EventArgs e)
	{
		MoveRule(sender, e, "down");
	}
	
	private void MoveRule(object sender, EventArgs e, string upOrDown)
	{
		upOrDown = upOrDown.ToLower();

		if (upOrDown == "up" || upOrDown == "down")
		{
			Button button = (Button)sender;
			GridViewRow item = (GridViewRow)button.Parent.Parent;
			int selectedIndex = item.RowIndex;
			if ((selectedIndex > 0 && upOrDown == "up") || (upOrDown == "down"))
			{
				string virtualFolderPath = FolderTree.SelectedValue;
				Configuration config = WebConfigurationManager.OpenWebConfiguration(virtualFolderPath);
				SystemWebSectionGroup systemWeb = (SystemWebSectionGroup)config.GetSectionGroup("system.web");
				AuthorizationSection section = (AuthorizationSection)systemWeb.Sections["authorization"];

				// Pull the local rules out of the authorization section, deleting them from same:
				ArrayList rulesArray = PullLocalRulesOutOfAuthorizationSection(section);
				if (upOrDown == "up")
				{
					LoadRulesInNewOrder(section, rulesArray, selectedIndex, upOrDown);
				}
				else if (upOrDown == "down")
				{
					if (selectedIndex < rulesArray.Count - 1)
					{
						LoadRulesInNewOrder(section, rulesArray, selectedIndex, upOrDown);
					}
					else
					{
						// DOWN button in last row was pressed. Load the rules array back in without resorting.
						for (int x = 0; x < rulesArray.Count; x++)
						{
							section.Rules.Add((AuthorizationRule)rulesArray[x]);
						}
					}
				}
				config.Save();
			}
		}
	}
	private void LoadRulesInNewOrder(AuthorizationSection section,
		ArrayList rulesArray, int selectedIndex, string upOrDown)
	{		
		AddFirstGroupOfRules(section, rulesArray, selectedIndex, upOrDown);
		AddTheTwoSwappedRules(section, rulesArray, selectedIndex, upOrDown);
		AddFinalGroupOfRules(section, rulesArray, selectedIndex, upOrDown);
	}
	private void AddFirstGroupOfRules(AuthorizationSection section, 
		ArrayList rulesArray, int selectedIndex, string upOrDown)
	{
		int adj;
		if (upOrDown == "up") adj = 1;
		else adj = 0;
		for (int x = 0; x < selectedIndex - adj; x++)
		{
			section.Rules.Add((AuthorizationRule)rulesArray[x]);
		}
	}
	private void AddTheTwoSwappedRules(AuthorizationSection section,
		ArrayList rulesArray, int selectedIndex, string upOrDown)
	{
		if (upOrDown == "up")
		{
			section.Rules.Add((AuthorizationRule)rulesArray[selectedIndex]);
			section.Rules.Add((AuthorizationRule)rulesArray[selectedIndex - 1]);
		}
		else if (upOrDown == "down")
		{
			section.Rules.Add((AuthorizationRule)rulesArray[selectedIndex + 1]);
			section.Rules.Add((AuthorizationRule)rulesArray[selectedIndex]);
		}
	}
	private void AddFinalGroupOfRules(AuthorizationSection section,
		ArrayList rulesArray, int selectedIndex, string upOrDown)
	{
		int adj;
		if (upOrDown == "up") adj = 1;
		else adj = 2;
		for (int x = selectedIndex + adj; x < rulesArray.Count; x++)
		{
			section.Rules.Add((AuthorizationRule)rulesArray[x]);
		}
	}
	private ArrayList PullLocalRulesOutOfAuthorizationSection(AuthorizationSection section)
	{
		// First load the local rules into an ArrayList.

		ArrayList rulesArray = new ArrayList();
		foreach (AuthorizationRule rule in section.Rules)
		{
			if (rule.ElementInformation.IsPresent)
			{
				rulesArray.Add(rule);
			}
		}

		// Next delete the rules from the section.
		foreach (AuthorizationRule rule in rulesArray)
		{
			section.Rules.Remove(rule);
		}
		return rulesArray;
	}

	private void CreateRule(object sender, EventArgs e)
	{
		AuthorizationRule newRule;
		if (ActionAllow.Checked) newRule = new AuthorizationRule(AuthorizationRuleAction.Allow);
		else newRule = new AuthorizationRule(AuthorizationRuleAction.Deny);
		
		if (ApplyRole.Checked && UserRoles.SelectedIndex > 0)
		{
			newRule.Roles.Add(UserRoles.Text);
			AddRule(newRule);
		}
		else if (ApplyUser.Checked && UserList.SelectedIndex > 0)
		{
			newRule.Users.Add(UserList.Text);
			AddRule(newRule);
		}
		else if (ApplyAllUsers.Checked)
		{
			newRule.Users.Add("*");
			AddRule(newRule);
		}
		else if (ApplyAnonUser.Checked)
		{
			newRule.Users.Add("?");
			AddRule(newRule);
		}
	}
	
	private void AddRule(AuthorizationRule newRule)
	{
		string virtualFolderPath = FolderTree.SelectedValue;
		Configuration config = WebConfigurationManager.OpenWebConfiguration(virtualFolderPath);
		SystemWebSectionGroup systemWeb = (SystemWebSectionGroup)config.GetSectionGroup("system.web");
		AuthorizationSection section = (AuthorizationSection)systemWeb.Sections["authorization"];
		section.Rules.Add(newRule);
		try
		{
			config.Save();
			RuleCreationError.Visible = false;
		}
		catch (Exception ex)
		{
			RuleCreationError.Visible = true;
			RuleCreationError.Text = "<div class=\"alert\"><br />An error occurred and the rule was not added. I saw this happen during testing when I attempted to create a rule that the ASP.NET infrastructure realized was redundant. Specifically, I had the rule <i>DENY ALL USERS</i> in one folder, then attempted to add the same rule in a subfolder, which caused ASP.NET to throw an exception.<br /><br />Here's the error message that was thrown just now:<br /><br /><i>" + ex.Message + "</i></div>";
		}
	}
</script>



<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

<!-- #include file="_nav.aspx -->

<table class="webparts">
<tr>
	<th>Website Access Rules</th>
</tr>
<tr>
	<td class="details" style="vertical-align:top">
		<p>
		Use this page to manage access rules for your Web site. Rules are applied to folders, thus providing robust folder-level security enforced by the ASP.NET infrastructure. Rules are persisted as XML in each folder's Web.config file. <i>Page-level security and inner-page security are not handled using this tool &mdash; they are handled using specialized code that is available to the Web Developers.</i>
		</p>
		<table>
		<tr>
			<td style="padding-right: 30px;vertical-align:top">
				<div class="treeview">
				<asp:TreeView runat="server" ID="FolderTree"
					OnSelectedNodeChanged="FolderTree_SelectedNodeChanged">
					<RootNodeStyle ImageUrl="../../images/folder.gif" />
					<ParentNodeStyle ImageUrl="../../images/folder.gif" />
					<LeafNodeStyle ImageUrl="../../images/folder.gif" />
					<SelectedNodeStyle Font-Underline="true" ForeColor="#A21818" />
				</asp:TreeView>
				</div> 
			</td>

			<td valign="top" style="padding-left: 30px; border-left: 1px solid #999;">
			<asp:Panel runat="server" ID="SecurityInfoSection" Visible="false">
				<h2 runat="server" id="TitleOne" class="alert"></h2>
				
				<p>
				Rules are applied in order. The first rule that matches applies, and the permission in each rule overrides the permissions in all following rules. Use the Move Up and Move Down buttons to change the order of the selected rule. Rules that appear dimmed are inherited from the parent and cannot be changed at this level. 
				</p>
				
				<asp:GridView runat="server" ID="RulesGrid" AutoGenerateColumns="false"
				CssClass="list" GridLines="none"
				OnRowDataBound="RowDataBound"
				>
					<Columns>
						<asp:TemplateField HeaderText="Action">
							<ItemTemplate>
								<%# GetAction((AuthorizationRule)Container.DataItem) %>
							</ItemTemplate>
						</asp:TemplateField>
						<asp:TemplateField HeaderText="Roles">
							<ItemTemplate>
								<%# GetRole((AuthorizationRule)Container.DataItem) %>
							</ItemTemplate>
						</asp:TemplateField>
						<asp:TemplateField HeaderText="User">
							<ItemTemplate>
								<%# GetUser((AuthorizationRule)Container.DataItem) %>
							</ItemTemplate>
						</asp:TemplateField>
						<asp:TemplateField HeaderText="Delete Rule">
							<ItemTemplate>
								<asp:Button ID="Button1" runat="server" Text="Delete Rule" CommandArgument="<%# (AuthorizationRule)Container.DataItem %>" OnClick="DeleteRule" OnClientClick="return confirm('Click OK to delete this rule.')" />
							</ItemTemplate>
						</asp:TemplateField>
						<asp:TemplateField HeaderText="Move Rule">
							<ItemTemplate>
								<asp:Button ID="Button2" runat="server" Text="  Up  " CommandArgument="<%# (AuthorizationRule)Container.DataItem %>" OnClick="MoveUp" />
								<asp:Button ID="Button3" runat="server" Text="Down" CommandArgument="<%# (AuthorizationRule)Container.DataItem %>" OnClick="MoveDown" />
							</ItemTemplate>
						</asp:TemplateField>
					</Columns>
				</asp:GridView>

				<br />
				<hr />
				<h2 runat="server" id="TitleTwo" class="alert"></h2>
				<b>Action:</b>
				<asp:RadioButton runat="server" ID="ActionDeny" GroupName="action" 
					Text="Deny" Checked="true" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<asp:RadioButton runat="server" ID="ActionAllow" GroupName="action" 
					Text="Allow" />
				
				<br /><br />
				<b>Rule applies to:</b>
				<br />
				<asp:RadioButton runat="server" ID="ApplyRole" GroupName="applyto"
					Text="This Role:" Checked="true" />
				<asp:DropDownList ID="UserRoles" runat="server" AppendDataBoundItems="true">
				<asp:ListItem>Select Role</asp:ListItem>
				</asp:DropDownList>
				<br />
					
				<asp:RadioButton runat="server" ID="ApplyUser" GroupName="applyto"
					Text="This User:" />
				<asp:DropDownList ID="UserList" runat="server" AppendDataBoundItems="true">
				<asp:ListItem>Select User</asp:ListItem>
				</asp:DropDownList>	
				<br />
				
				
				<asp:RadioButton runat="server" ID="ApplyAllUsers" GroupName="applyto"
					Text="All Users (*)"  />
				<br />
				
				
				<asp:RadioButton runat="server" ID="ApplyAnonUser" GroupName="applyto"
					Text="Anonymous Users (?)"  />
				<br /><br />
				
				<asp:Button ID="Button4" runat="server" Text="Create Rule" OnClick="CreateRule"
					OnClientClick="return confirm('Click OK to create this rule.');" />
					
				<asp:Literal runat="server" ID="RuleCreationError"></asp:Literal>
			</asp:Panel>
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>


</asp:Content>

