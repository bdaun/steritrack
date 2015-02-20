using System;
using System.IO;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Configuration;
using System.Collections.Generic;

namespace CSSFriendly
{
    public class MenuAdapter : System.Web.UI.WebControls.Adapters.MenuAdapter
    {
        private WebControlAdapterExtender _extender = null;
        private WebControlAdapterExtender Extender
        {
            get
            {
                if (((_extender == null) && (Control != null)) ||
                    ((_extender != null) && (Control != _extender.AdaptedControl)))
                {
                    _extender = new WebControlAdapterExtender(Control);
                }

                System.Diagnostics.Debug.Assert(_extender != null, "CSS Friendly adapters internal error", "Null extender instance");
                return _extender;
            }
        }

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);

            if (Extender.AdapterEnabled)
            {
                RegisterScripts();
            }
        }

        private void RegisterScripts()
        {
            Extender.RegisterScripts();

			/* 
			 * Modified for support of compiled CSSFriendly assembly
			 * 
			 * We will first search for embedded JavaScript files. If they are not
			 * found, we default to the standard approach.
			 */

			Type type = this.GetType();

			// TreeViewAdapter.js
			string resource = "CSSFriendly.JavaScript.MenuAdapter.js";
			string filePath = Page.ClientScript.GetWebResourceUrl(type, resource);
			
			// if filePath is empty, use the old approach
			if ( String.IsNullOrEmpty(filePath) )
			{
				string folderPath = WebConfigurationManager.AppSettings.Get("CSSFriendly-JavaScript-Path");
				if (String.IsNullOrEmpty(folderPath))
				{
					folderPath = "~/JavaScript";
				}
				filePath = folderPath.EndsWith("/") ? folderPath + "MenuAdapter.js" : folderPath + "/TreeViewAdapter.js";
			}

			if (!Page.ClientScript.IsClientScriptIncludeRegistered(type, resource))
				Page.ClientScript.RegisterClientScriptInclude(type, resource, Page.ResolveUrl(filePath));

			// Menu.css -- only add if it is embedded
			resource = "CSSFriendly.CSS.Menu.css";
			filePath = Page.ClientScript.GetWebResourceUrl(type, resource);
			
			// if filePath is not empty, embedded CSS exists -- register it
			if (!String.IsNullOrEmpty(filePath))
			{
				string cssTag = "<link href=\"" + Page.ResolveUrl(filePath) + "\" type=\"text/css\" rel=\"stylesheet\"></link>";
				if (!Page.ClientScript.IsClientScriptBlockRegistered(type, resource))
					Page.ClientScript.RegisterClientScriptBlock(type, resource, cssTag, false);
			}

			// IEMenu6.css -- only add if it is embedded
			resource = "CSSFriendly.CSS.BrowserSpecific.IEMenu6.css";
			filePath = Page.ClientScript.GetWebResourceUrl(type, resource);
			
			// if filePath is not empty, embedded CSS exists -- register it
			if (!String.IsNullOrEmpty(filePath))
			{
				string cssTag = "<link href=\"" + Page.ResolveUrl(filePath) + "\" type=\"text/css\" rel=\"stylesheet\"></link>";
				if (!Page.ClientScript.IsClientScriptBlockRegistered(type, resource))
					Page.ClientScript.RegisterClientScriptBlock(type, resource, cssTag, false);
			}
		}

        protected override void RenderBeginTag(HtmlTextWriter writer)
        {
            if (Extender.AdapterEnabled)
            {
                Extender.RenderBeginTag(writer, "AspNet-Menu-" + Control.Orientation.ToString());
            }
            else
            {
                base.RenderBeginTag(writer);
            }
        }

        protected override void RenderEndTag(HtmlTextWriter writer)
        {
            if (Extender.AdapterEnabled)
            {
                Extender.RenderEndTag(writer);
            }
            else
            {
                base.RenderEndTag(writer);
            }
        }

        protected override void RenderContents(HtmlTextWriter writer)
        {
            if (Extender.AdapterEnabled)
            {
                writer.Indent++;
                BuildItems(Control.Items, true, writer);
                writer.Indent--;
                writer.WriteLine();
            }
            else
            {
                base.RenderContents(writer);
            }
        }

        /// <summary>
        /// Builds the current menu (at whatever level it is at)
        /// </summary>
        /// <param name="items"></param>
        /// <param name="isRoot"></param>
        /// <param name="writer"></param>
        private void BuildItems(MenuItemCollection items, bool isRoot, HtmlTextWriter writer)
        {

            // build a List of top level menu names.  This because those top level names
            // have the nice rainbow background colors for when they are selected.
            List<String> listTopLevelMenuNames = new List<string>();
            if (ConfigurationManager.AppSettings["TopLevelMenuTextList"] != null)
            {
                string str = ConfigurationManager.AppSettings["TopLevelMenuTextList"].ToString().ToLower();
                 string[] topLevelMenuNames = str.Split(new char[2] { ',', ';' });
                foreach (string menuName in topLevelMenuNames)
                {
                    listTopLevelMenuNames.Add(menuName.ToLower());
                }
            }
            
            // Now, we need to figure out if any items are selected at this level
            bool itemSelectedAtThisLevel = false;
            if (items.Count > 0)
            {
                foreach (MenuItem item in items)
                {
                    if (item.Selected)
                    {
                        itemSelectedAtThisLevel = true;
                        break;
                    }
                }
            }

            // if nothing is selected at this level, that means there must
            // be items selected an next level.  We can query the SiteMapProvider
            // to tell us which item is currently selected, get it's parent and that
            // is the one we need to apply special tag to
            string menuItemToHighlight = string.Empty;
            if (!itemSelectedAtThisLevel)
            {
                SiteMapNode siteMapNodeCurrent = SiteMap.CurrentNode;
                if (siteMapNodeCurrent != null)
                {
                    if (siteMapNodeCurrent.ParentNode != null)
                    {
                        menuItemToHighlight = siteMapNodeCurrent.ParentNode.Title;
                    }
                }
            }

            // Finally, build the menu out with the correct tags, no matter
            // which level we are on.
            if (items.Count > 0)
            {
                writer.WriteLine();
                writer.WriteBeginTag("table");
                if (isRoot)
                {
                    writer.WriteAttribute("class", "AspNet-Menu");
                }
                writer.Write(HtmlTextWriter.TagRightChar);
                writer.Indent++;


                writer.WriteLine();
                writer.WriteBeginTag("tr");
                writer.Write(HtmlTextWriter.TagRightChar);
                writer.Indent++;

                               
                foreach (MenuItem item in items)
                {
                    // figure out if this is top level (Register,...)
                    // If so, then
                    if (listTopLevelMenuNames.Contains(item.Text.ToLower()))
                    {
                        // this means we are on the top level so need to display rainbow fore and back
                        BuildItem(item, writer, menuItemToHighlight, true);
                    }
                    else
                    {
                        BuildItem(item, writer, menuItemToHighlight,false);
                    }
                }
                writer.Indent--;
                writer.WriteLine();
                writer.WriteEndTag("tr");
                writer.WriteEndTag("table");
            }
        }

        private void BuildItem(MenuItem item, HtmlTextWriter writer, string menuItemToHighlight,bool onTopLevel)
        {
            Menu menu = Control as Menu;
            if ((menu != null) && (item != null) && (writer != null))
            {
                writer.WriteLine();
                writer.WriteBeginTag("td");

                if (onTopLevel)
                {
                    string theClass = "AspNet-Menu-TopLevel-" + item.Text.ToLower().Trim();
                    if (item.Selected || item.Text.ToLower().Equals(menuItemToHighlight.ToLower()))
                    {
                        theClass += "-Selected";
                    }
                    writer.WriteAttribute("class", theClass);

                    writer.Write(HtmlTextWriter.TagRightChar);
                    writer.Indent++;
                    writer.WriteLine();
                }
                else
                {
                    string theClass = GetSelectStatusClass(item);
                    // check for empty string.  GetSelectedStatusClass returns empty when not selected.
                    if (String.IsNullOrEmpty(theClass))
                    {
                        theClass = "AspNet-Menu-Item";
                    }

                    writer.WriteAttribute("class", theClass);

                    writer.Write(HtmlTextWriter.TagRightChar);
                    writer.Indent++;
                    writer.WriteLine();
                }

                if (((item.Depth < menu.StaticDisplayLevels) && (menu.StaticItemTemplate != null)) ||
                    ((item.Depth >= menu.StaticDisplayLevels) && (menu.DynamicItemTemplate != null)))
                {
                    writer.WriteBeginTag("div");
                    writer.WriteAttribute("class", GetItemClass(menu, item));
                    writer.Write(HtmlTextWriter.TagRightChar);
                    writer.Indent++;
                    writer.WriteLine();

                    MenuItemTemplateContainer container = new MenuItemTemplateContainer(menu.Items.IndexOf(item), item);
                    if ((item.Depth < menu.StaticDisplayLevels) && (menu.StaticItemTemplate != null))
                    {
                        menu.StaticItemTemplate.InstantiateIn(container);
                    }
                    else
                    {
                        menu.DynamicItemTemplate.InstantiateIn(container);
                    }
                    container.DataBind();
                    container.RenderControl(writer);

                    writer.Indent--;
                    writer.WriteLine();
                    writer.WriteEndTag("div");
                }
                else
                {
                    if (IsLink(item))
                    {
                        writer.WriteBeginTag("a");
                        if (!String.IsNullOrEmpty(item.NavigateUrl))
                        {
                            writer.WriteAttribute("href", Page.Server.HtmlEncode(menu.ResolveClientUrl(item.NavigateUrl)));
                        }
                        else
                        {
                            writer.WriteAttribute("href", Page.ClientScript.GetPostBackClientHyperlink(menu, "b" +  item.ValuePath.Replace(menu.PathSeparator.ToString(), "\\"), true));
                        }

                        // THIS PUTS THE CLASS NAME INTO THE HREF, NOT SURE WHY WE NEED IT SINCE IT IS IN THE DIV ABOVE
                        //writer.WriteAttribute("class", GetItemClass(menu, item));
                        //WebControlAdapterExtender.WriteTargetAttribute(writer, item.Target);

                        if (!String.IsNullOrEmpty(item.ToolTip))
                        {
                            writer.WriteAttribute("title", item.ToolTip);
                        }
                        else if (!String.IsNullOrEmpty(menu.ToolTip))
                        {
                            writer.WriteAttribute("title", menu.ToolTip);
                        }
                        writer.Write(HtmlTextWriter.TagRightChar);
                        writer.Indent++;
                        writer.WriteLine();
                    }
                    else
                    {
                        writer.WriteBeginTag("span");
                        writer.WriteAttribute("class", GetItemClass(menu, item));
                        writer.Write(HtmlTextWriter.TagRightChar);
                        writer.Indent++;
                        writer.WriteLine();
                    }

                    if (!String.IsNullOrEmpty(item.ImageUrl))
                    {
                        writer.WriteBeginTag("img");
                        writer.WriteAttribute("src", menu.ResolveClientUrl(item.ImageUrl));
                        writer.WriteAttribute("alt", !String.IsNullOrEmpty(item.ToolTip) ? item.ToolTip : (!String.IsNullOrEmpty(menu.ToolTip) ? menu.ToolTip : item.Text));
                        writer.Write(HtmlTextWriter.SelfClosingTagEnd);
                    }

                    string formattedText = item.Text;
                    if (!String.IsNullOrEmpty(menu.StaticItemFormatString))
                    {
                        formattedText = String.Format(menu.StaticItemFormatString, item.Text);
                    }
                    writer.Write(formattedText);

                    if (IsLink(item))
                    {
                        writer.Indent--;
                        writer.WriteEndTag("a");
                    }
                    else
                    {
                        writer.Indent--;
                        writer.WriteEndTag("span");
                    }

                }

                if ((item.ChildItems != null) && (item.ChildItems.Count > 0))
                {
                    BuildItems(item.ChildItems, false, writer);
                }

                writer.Indent--;
                writer.WriteLine();
                writer.WriteEndTag("td");
            }
        }

        private bool IsLink(MenuItem item)
        {
            return (item != null) && item.Enabled && ((!String.IsNullOrEmpty(item.NavigateUrl)) || item.Selectable);
        }

        private string GetItemClass(Menu menu, MenuItem item)
        {
            string value = "AspNet-Menu-NonLink";
            if (item != null)
            {
                if (((item.Depth < menu.StaticDisplayLevels) && (menu.StaticItemTemplate != null)) ||
                    ((item.Depth >= menu.StaticDisplayLevels) && (menu.DynamicItemTemplate != null)))
                {
                    value = "AspNet-Menu-Template";
                }
                else if (IsLink(item))
                {
                    value =  "AspNet-Menu-Link";
                }
                string selectedStatusClass = GetSelectStatusClass(item);
                if (!String.IsNullOrEmpty(selectedStatusClass))
                {
                    value += " " + selectedStatusClass;
                }
            }
            return value;
        }

        private string GetSelectStatusClass(MenuItem item)
        {
            string value = "";
                if (item.Selected)
                {
                    value += " AspNet-Menu-Selected";
                }
                else if (IsChildItemSelected(item))
                {
                    value += " AspNet-Menu-ChildSelected";
                }
                else if (IsParentItemSelected(item))
                {
                    value += " AspNet-Menu-ParentSelected";
            }
            return value;
        }

        private bool IsChildItemSelected(MenuItem item)
        {
            bool bRet = false;

            if ((item != null) && (item.ChildItems != null))
            {
                bRet = IsChildItemSelected(item.ChildItems);
            }

            return bRet;
        }

        private bool IsChildItemSelected(MenuItemCollection items)
        {
            bool bRet = false;

            if (items != null)
            {
                foreach (MenuItem item in items)
                {
                    if (item.Selected || IsChildItemSelected(item.ChildItems))
                    {
                        bRet = true;
                        break;
                    }
                }
            }

            return bRet;
        }

        private bool IsParentItemSelected(MenuItem item)
        {
            bool bRet = false;

            if ((item != null) && (item.Parent != null))
            {
                if (item.Parent.Selected)
                {
                    bRet = true;
                }
                else
                {
                    bRet = IsParentItemSelected(item.Parent);
                }
            }

            return bRet;
        }
    }
}
