<%@ Control Language="C#" ClassName="Alphalinks" %>

<script runat="server">
	string[] letters = { "All", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K",
					"L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V",
					"W", "X", "Y", "Z"};
	
	private string selectedLetter;
	private int selectedIndex;
	
	private void Page_Load()
	{

		if (ViewState["selectedLetter"] == null)
		{
			selectedLetter = "All";
			ViewState["selectedLetter"] = "All";
		}
	}

	public void Page_PreRender()
	{
		__theAlphalink.DataSource = letters;
		__theAlphalink.DataBind();
	}
	
	public string Letter
	{
		get
		{
			return ViewState["selectedLetter"].ToString();
		}
		set
		{
			ViewState["selectedLetter"] = value;
		}
	}

	private void Select(object sender, CommandEventArgs e)
	{
		selectedLetter = e.CommandArgument.ToString();
		ViewState["selectedLetter"] = e.CommandArgument.ToString();
	}

	private void DisableSelectedLink(object sender, RepeaterItemEventArgs e)
	{
		LinkButton lb = (LinkButton)e.Item.Controls[1];
		if (lb.Text == Letter)
			lb.Enabled = false;
	}
</script>

<asp:Repeater runat="server" ID="__theAlphalink" OnItemDataBound="DisableSelectedLink">
<ItemTemplate>
	<asp:LinkButton runat="server" ID="link" 
		text="<%# Container.DataItem %>"
		CommandName="Filter"
		CommandArgument='<%# DataBinder.Eval(Container, "DataItem")%>'
		OnCommand="Select"
		 />&nbsp;
</ItemTemplate>
</asp:Repeater>