<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LabelPreview.aspx.cs" Inherits="IMDBWeb.Secure.SPAKpages.LabelPreview" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
<form id="form1" runat="server">
<asp:ScriptManager ID="sm1" runat="server" />
<rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" 
    Font-Size="8pt" InteractiveDeviceInfos="(Collection)" 
    WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Width="6in" Height="4in">
    <LocalReport ReportPath="Secure\SPAKpages\LabelView.rdlc">
        <DataSources>
            <rsweb:ReportDataSource DataSourceId="sdsLblPreview" Name="DataSet1" />
        </DataSources>
    </LocalReport>
</rsweb:ReportViewer>
<asp:SqlDataSource ID="sdsLblPreview" runat="server" 
    ConnectionString="<%$ ConnectionStrings:IMDB_SQL %>" 
    SelectCommand="SELECT ID, [CntrID] FROM [PreviewLabels] ORDER BY ID Asc"></asp:SqlDataSource>
</form>
</body>
</html>

