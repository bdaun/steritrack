<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LabelPreview.aspx.cs" Inherits="IMDBWeb.Secure.SPAKpages.LabelPreview" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
<form id="form1" runat="server">
<CR:CrystalReportViewer ID="crvPreviewLabel" runat="server" AutoDataBind="True" 
    GroupTreeImagesFolderUrl="" Height="530px" ReportSourceID="crsPreviewPallet" 
    ToolbarImagesFolderUrl="" ToolPanelView="None" ToolPanelWidth="200px" 
    Width="864px" HasRefreshButton="True" />
<CR:CrystalReportSource ID="crsPreviewPallet" runat="server">
    <Report FileName="PreviewLabel.rpt">
    </Report>
</CR:CrystalReportSource>
</form>
</body>
</html>

