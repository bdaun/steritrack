<%@ Page Title="" Language="C#" MasterPageFile="~/Secure/Page.Master" AutoEventWireup="true" CodeBehind="MeManagement.aspx.cs" Inherits="BEFOnTheWeb.Secure.MeManagement" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<h1>Contact Information</h1><br />
<asp:Label ID="lblErrMsg" runat="server" />
<div class="UserMsg"><asp:Label ID="lblUserMsg" runat="server" /></div>
<asp:FormView ID="fvContactInfo" runat="server" DataSourceID="sdsContactInfo" DefaultMode="ReadOnly" CssClass="formentry" >
    <EditItemTemplate>
        <table  class="formtable">
<%--            <tr><td class="form1sttd">ID:</td><td><asp:Label ID="IDTextBox" runat="server" Visible="false" Text='<%# Eval("ID") %>' /></td></tr>--%>
            <tr><td class="form1sttd">FirstName:</td><td><asp:TextBox ID="FirstNameTextBox" runat ="server" Text='<%# Bind("FirstName") %>' /></td></tr>
            <tr><td class="form1sttd">LastName:</td><td><asp:TextBox ID="LastNameTextBox" runat="server" Text='<%# Bind("LastName") %>' /></td></tr>
            <tr><td class="form1sttd">HomePhone:</td><td><asp:TextBox ID="HomePhoneTextBox" runat="server" ValidationGroup="vgHomePhone" Text='<%# Bind("HomePhone") %>' />
                <ajaxToolkit:MaskedEditExtender ID="meHomePhone" runat="server" TargetControlID="HomePhoneTextBox" Mask="999-999-9999"
                    ClearMaskOnLostFocus="false" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus" OnInvalidCssClass="MaskedEditError"
                    MaskType="None" InputDirection="LeftToRight" AcceptNegative="None" DisplayMoney="Left" Filtered="-" ErrorTooltipEnabled="True" />
                <ajaxToolkit:MaskedEditValidator ID="mevHomePhone" runat="server" ControlExtender="meHomePhone"
                    ControlToValidate="HomePhoneTextBox" IsValidEmpty="false" InitialValue="___-___-____" ValidationExpression ="[0-9]{3}\-[0-9]{3}\-[0-9]{4}" 
                     Display="Dynamic" TooltipMessage="XXX-XXX-XXXX" InvalidValueMessage="Please enter a valid phone number!"
                     ValidationGroup="vgHomePhone" /></td></tr>
            <tr><td class="form1sttd">MobilePhone:</td><td><asp:TextBox ID="MobilePhoneTextBox" runat="server" ValidationGroup="vgMobilePhone" Text='<%# Bind("MobilePhone") %>' />
                <ajaxToolkit:MaskedEditExtender ID="meMobilePhone" runat="server" TargetControlID="MobilePhoneTextBox" Mask="999-999-9999"
                    ClearMaskOnLostFocus="false" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus" OnInvalidCssClass="MaskedEditError"
                    MaskType="None" InputDirection="LeftToRight" AcceptNegative="None" DisplayMoney="Left" Filtered="-" ErrorTooltipEnabled="True" />
                <ajaxToolkit:MaskedEditValidator ID="mevMobilePhone" runat="server" ControlExtender="meMobilePhone"
                    ControlToValidate="MobilePhoneTextBox" IsValidEmpty="false" InitialValue="___-___-____" ValidationExpression ="[0-9]{3}\-[0-9]{3}\-[0-9]{4}" 
                     Display="Dynamic" TooltipMessage="XXX-XXX-XXXX" InvalidValueMessage="Please enter a valid phone number!"
                    ValidationGroup="vgMobilePhone"  /></td></tr>
            <tr><td class="form1sttd">WorkPhone:</td><td><asp:TextBox ID="WorkPhoneTextBox" runat="server" ValidationGroup="vgWorkPhone" Text='<%# Bind("WorkPhone") %>' />
                <ajaxToolkit:MaskedEditExtender ID="meWorkPhone" runat="server" TargetControlID="WorkPhoneTextBox" Mask="999-999-9999"
                    ClearMaskOnLostFocus="false" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus" OnInvalidCssClass="MaskedEditError"
                    MaskType="None" InputDirection="LeftToRight" AcceptNegative="None" DisplayMoney="Left" Filtered="-" ErrorTooltipEnabled="True" />
                <ajaxToolkit:MaskedEditValidator ID="mevWorkPhone" runat="server" ControlExtender="meWorkPhone"
                    ControlToValidate="WorkPhoneTextBox" IsValidEmpty="false" InitialValue="___-___-____" ValidationExpression ="[0-9]{3}\-[0-9]{3}\-[0-9]{4}" 
                     Display="Dynamic" TooltipMessage="XXX-XXX-XXXX" InvalidValueMessage="Please enter a valid phone number!"
                     ValidationGroup="vgWorkPhone" /></td></tr>
            <tr><td class="form1sttd">Street:</td><td><asp:TextBox ID="StreetTextBox" runat="server" Text='<%# Bind("Street") %>' /></td></tr>
            <tr><td class="form1sttd">City:</td><td><asp:TextBox ID="CityTextBox" runat="server" Text='<%# Bind("City") %>' /></td></tr>
            <tr><td class="form1sttd">State:</td><td>
                <asp:DropDownList ID="StateTextBox" runat="server" SelectedValue='<%# Bind("State") %>'>
                    <asp:ListItem Value=""  Text="Select from List" />
                    <asp:ListItem Value="AL" Text="Alabama"/>
                    <asp:ListItem Value="AK" Text="Alaska"/>
                    <asp:ListItem Value="AZ" Text="Arizona"/>
                    <asp:ListItem Value="AR" Text="Arkansas"/>
                    <asp:ListItem Value="CA" Text="California"/>
                    <asp:ListItem Value="CO" Text="Colorado"/>
                    <asp:ListItem Value="CT" Text="Connecticut"/>
                    <asp:ListItem Value="DC" Text="D.C."/>
                    <asp:ListItem Value="DE" Text="Delaware"/>
                    <asp:ListItem Value="FL" Text="Florida"/>
                    <asp:ListItem Value="GA" Text="Georgia"/>
                    <asp:ListItem Value="HI" Text="Hawaii"/>
                    <asp:ListItem Value="ID" Text="Idaho"/>
                    <asp:ListItem Value="IL" Text="Illinois"/>
                    <asp:ListItem Value="IN" Text="Indiana"/>
                    <asp:ListItem Value="IA" Text="Iowa"/>
                    <asp:ListItem Value="KS" Text="Kansas"/>
                    <asp:ListItem Value="KY" Text="Kentucky"/>
                    <asp:ListItem Value="LA" Text="Louisiana"/>
                    <asp:ListItem Value="ME" Text="Maine"/>
                    <asp:ListItem Value="MD" Text="Maryland"/>
                    <asp:ListItem Value="MA" Text="Massachusetts"/>
                    <asp:ListItem Value="MI" Text="Michigan"/>
                    <asp:ListItem Value="MN" Text="Minnesota"/>
                    <asp:ListItem Value="MS" Text="Mississippi"/>
                    <asp:ListItem Value="MO" Text="Missouri"/>
                    <asp:ListItem Value="MT" Text="Montana"/>
                    <asp:ListItem Value="NE" Text="Nebraska"/>
                    <asp:ListItem Value="NV" Text="Nevada"/>
                    <asp:ListItem Value="NH" Text="New Hampshire"/>
                    <asp:ListItem Value="NJ" Text="New Jersey"/>
                    <asp:ListItem Value="NM" Text="New Mexico"/>
                    <asp:ListItem Value="NY" Text="New York"/>
                    <asp:ListItem Value="NC" Text="North Carolina"/>
                    <asp:ListItem Value="ND" Text="North Dakota"/>
                    <asp:ListItem Value="OH" Text="Ohio"/>
                    <asp:ListItem Value="OK" Text="Oklahoma"/>
                    <asp:ListItem Value="OR" Text="Oregon"/>
                    <asp:ListItem Value="PA" Text="Pennsylvania"/>
                    <asp:ListItem Value="RI" Text="Rhode Island"/>
                    <asp:ListItem Value="SC" Text="South Carolina"/>
                    <asp:ListItem Value="SD" Text="South Dakota"/>
                    <asp:ListItem Value="TN" Text="Tennessee"/>
                    <asp:ListItem Value="TX" Text="Texas"/>
                    <asp:ListItem Value="UT" Text="Utah"/>
                    <asp:ListItem Value="VT" Text="Vermont"/>
                    <asp:ListItem Value="VA" Text="Virginia"/>
                    <asp:ListItem Value="WA" Text="Washington"/>
                    <asp:ListItem Value="WV" Text="West Virginia"/>
                    <asp:ListItem Value="WI" Text="Wisconsin"/>
                    <asp:ListItem Value="WY" Text="Wyoming"/>
                </asp:DropDownList></td></tr>
            <tr><td class="form1sttd">ZIP:</td><td><asp:TextBox ID="ZIPTextBox" runat="server" ValidationGroup="vgZIP" Text='<%# Bind("ZIP") %>' />
                <ajaxToolkit:MaskedEditExtender ID="meZIP" runat="server" TargetControlID="ZIPTextBox" Mask="99999"
                    ClearMaskOnLostFocus="false" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus" OnInvalidCssClass="MaskedEditError"
                    MaskType="None" InputDirection="LeftToRight" AcceptNegative="None" DisplayMoney="Left" ErrorTooltipEnabled="True" />
                <ajaxToolkit:MaskedEditValidator ID="mevZIP" runat="server" ControlExtender="meZIP"
                    ControlToValidate="ZIPTextBox" IsValidEmpty="True" ValidationExpression ="^\d{5}?$"
                     Display="Dynamic" TooltipMessage="XXXXX" InvalidValueMessage="Please input a valid ZIP number!" ValidationGroup="vgZIP" /></td></tr>
            <tr><td class="form1sttd">Email:</td><td><asp:TextBox ID="EmailTextBox" runat="server" Text='<%# Bind("Email") %>' /></td></tr>
            <tr><td class="formsubmit" colspan="2"><asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
                    &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" OnClick="UpdateCancelButton_Click" Text="Cancel" /></td></tr>
        </table>
    </EditItemTemplate>
    <InsertItemTemplate>
        <table class="formtable">
            <tr><td class="form1sttd">FirstName:</td><td><asp:TextBox ID="FirstNameTextBox" runat="server" Text='<%# Bind("FirstName") %>' /></td></tr>
            <tr><td class="form1sttd">LastName:</td><td><asp:TextBox ID="LastNameTextBox" runat="server" Text='<%# Bind("LastName") %>' /></td></tr>
            <tr><td class="form1sttd">HomePhone:</td><td><asp:TextBox ID="HomePhoneTextBox" runat="server" ValidationGroup="vgHomePhone" Text='<%# Bind("HomePhone") %>' />
                <ajaxToolkit:MaskedEditExtender ID="meHomePhone" runat="server" TargetControlID="HomePhoneTextBox" Mask="999-999-9999"
                    ClearMaskOnLostFocus="false" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus" OnInvalidCssClass="MaskedEditError"
                    MaskType="None" InputDirection="LeftToRight" AcceptNegative="None" DisplayMoney="Left" Filtered="-" ErrorTooltipEnabled="True" />
                <ajaxToolkit:MaskedEditValidator ID="mevHomePhone" runat="server" ControlExtender="meHomePhone"
                    ControlToValidate="HomePhoneTextBox" IsValidEmpty="false" InitialValue="___-___-____" ValidationExpression ="[0-9]{3}\-[0-9]{3}\-[0-9]{4}" 
                     Display="Dynamic" TooltipMessage="XXX-XXX-XXXX" InvalidValueMessage="Please enter a valid phone number!"
                     ValidationGroup="vgHomePhone" /></td></tr>
            <tr><td class="form1sttd">MobilePhone:</td><td><asp:TextBox ID="MobilePhoneTextBox" runat="server" ValidationGroup="vgMobilePhone" Text='<%# Bind("MobilePhone") %>' />
                <ajaxToolkit:MaskedEditExtender ID="meMobilePhone" runat="server" TargetControlID="MobilePhoneTextBox" Mask="999-999-9999"
                    ClearMaskOnLostFocus="false" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus" OnInvalidCssClass="MaskedEditError"
                    MaskType="None" InputDirection="LeftToRight" AcceptNegative="None" DisplayMoney="Left" Filtered="-" ErrorTooltipEnabled="True" />
                <ajaxToolkit:MaskedEditValidator ID="mevMobilePhone" runat="server" ControlExtender="meMobilePhone"
                    ControlToValidate="MobilePhoneTextBox" IsValidEmpty="false" InitialValue="___-___-____" ValidationExpression ="[0-9]{3}\-[0-9]{3}\-[0-9]{4}" 
                     Display="Dynamic" TooltipMessage="XXX-XXX-XXXX" InvalidValueMessage="Please enter a valid phone number!"
                    ValidationGroup="vgMobilePhone"  /></td></tr>
            <tr><td class="form1sttd">WorkPhone:</td><td><asp:TextBox ID="WorkPhoneTextBox" runat="server" ValidationGroup="vgWorkPhone" Text='<%# Bind("WorkPhone") %>' />
                <ajaxToolkit:MaskedEditExtender ID="meWorkPhone" runat="server" TargetControlID="WorkPhoneTextBox" Mask="999-999-9999"
                    ClearMaskOnLostFocus="false" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus" OnInvalidCssClass="MaskedEditError"
                    MaskType="None" InputDirection="LeftToRight" AcceptNegative="None" DisplayMoney="Left" Filtered="-" ErrorTooltipEnabled="True" />
                <ajaxToolkit:MaskedEditValidator ID="mevWorkPhone" runat="server" ControlExtender="meWorkPhone"
                    ControlToValidate="WorkPhoneTextBox" IsValidEmpty="false" InitialValue="___-___-____" ValidationExpression ="[0-9]{3}\-[0-9]{3}\-[0-9]{4}" 
                     Display="Dynamic" TooltipMessage="XXX-XXX-XXXX" InvalidValueMessage="Please enter a valid phone number!"
                     ValidationGroup="vgWorkPhone" /></td></tr>
            <tr><td class="form1sttd">Street:</td><td><asp:TextBox ID="StreetTextBox" runat="server" Text='<%# Bind("Street") %>' /></td></tr>
            <tr><td class="form1sttd">City:</td><td><asp:TextBox ID="CityTextBox" runat="server" Text='<%# Bind("City") %>' /></td></tr>
            <tr><td class="form1sttd">State:</td><td>
                <asp:DropDownList ID="StateTextBox" runat="server" SelectedValue='<%# Bind("State") %>'>
                    <asp:ListItem Value=""  Text="Select from List" />
                    <asp:ListItem Value="AL" Text="Alabama"/>
                    <asp:ListItem Value="AK" Text="Alaska"/>
                    <asp:ListItem Value="AZ" Text="Arizona"/>
                    <asp:ListItem Value="AR" Text="Arkansas"/>
                    <asp:ListItem Value="CA" Text="California"/>
                    <asp:ListItem Value="CO" Text="Colorado"/>
                    <asp:ListItem Value="CT" Text="Connecticut"/>
                    <asp:ListItem Value="DC" Text="D.C."/>
                    <asp:ListItem Value="DE" Text="Delaware"/>
                    <asp:ListItem Value="FL" Text="Florida"/>
                    <asp:ListItem Value="GA" Text="Georgia"/>
                    <asp:ListItem Value="HI" Text="Hawaii"/>
                    <asp:ListItem Value="ID" Text="Idaho"/>
                    <asp:ListItem Value="IL" Text="Illinois"/>
                    <asp:ListItem Value="IN" Text="Indiana" Selected="True" />
                    <asp:ListItem Value="IA" Text="Iowa"/>
                    <asp:ListItem Value="KS" Text="Kansas"/>
                    <asp:ListItem Value="KY" Text="Kentucky"/>
                    <asp:ListItem Value="LA" Text="Louisiana"/>
                    <asp:ListItem Value="ME" Text="Maine"/>
                    <asp:ListItem Value="MD" Text="Maryland"/>
                    <asp:ListItem Value="MA" Text="Massachusetts"/>
                    <asp:ListItem Value="MI" Text="Michigan"/>
                    <asp:ListItem Value="MN" Text="Minnesota"/>
                    <asp:ListItem Value="MS" Text="Mississippi"/>
                    <asp:ListItem Value="MO" Text="Missouri"/>
                    <asp:ListItem Value="MT" Text="Montana"/>
                    <asp:ListItem Value="NE" Text="Nebraska"/>
                    <asp:ListItem Value="NV" Text="Nevada"/>
                    <asp:ListItem Value="NH" Text="New Hampshire"/>
                    <asp:ListItem Value="NJ" Text="New Jersey"/>
                    <asp:ListItem Value="NM" Text="New Mexico"/>
                    <asp:ListItem Value="NY" Text="New York"/>
                    <asp:ListItem Value="NC" Text="North Carolina"/>
                    <asp:ListItem Value="ND" Text="North Dakota"/>
                    <asp:ListItem Value="OH" Text="Ohio"/>
                    <asp:ListItem Value="OK" Text="Oklahoma"/>
                    <asp:ListItem Value="OR" Text="Oregon"/>
                    <asp:ListItem Value="PA" Text="Pennsylvania"/>
                    <asp:ListItem Value="RI" Text="Rhode Island"/>
                    <asp:ListItem Value="SC" Text="South Carolina"/>
                    <asp:ListItem Value="SD" Text="South Dakota"/>
                    <asp:ListItem Value="TN" Text="Tennessee"/>
                    <asp:ListItem Value="TX" Text="Texas"/>
                    <asp:ListItem Value="UT" Text="Utah"/>
                    <asp:ListItem Value="VT" Text="Vermont"/>
                    <asp:ListItem Value="VA" Text="Virginia"/>
                    <asp:ListItem Value="WA" Text="Washington"/>
                    <asp:ListItem Value="WV" Text="West Virginia"/>
                    <asp:ListItem Value="WI" Text="Wisconsin"/>
                    <asp:ListItem Value="WY" Text="Wyoming"/>
                </asp:DropDownList></td></tr>
            <tr><td class="form1sttd">ZIP:</td><td><asp:TextBox ID="ZIPTextBox" runat="server" ValidationGroup="vgZIP" Text='<%# Bind("ZIP") %>' />
                <ajaxToolkit:MaskedEditExtender ID="meZIP" runat="server" TargetControlID="ZIPTextBox" Mask="99999"
                    ClearMaskOnLostFocus="false" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus" OnInvalidCssClass="MaskedEditError"
                    MaskType="None" InputDirection="LeftToRight" AcceptNegative="None" DisplayMoney="Left" ErrorTooltipEnabled="True" />
                <ajaxToolkit:MaskedEditValidator ID="mevZIP" runat="server" ControlExtender="meZIP"
                    ControlToValidate="ZIPTextBox" IsValidEmpty="True" ValidationExpression ="^\d{5}?$"
                     Display="Dynamic" TooltipMessage="XXXXX" InvalidValueMessage="Please input a valid ZIP number!" ValidationGroup="vgZIP" /></td></tr>
            <tr><td class="form1sttd">Email:</td><td><asp:TextBox ID="EmailTextBox" runat="server" Text='<%# Bind("Email") %>' /></td></tr>
            <tr><td class="formsubmit" colspan="2"><asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
            &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" OnClick="InsertCancelButton_Click" Text="Cancel" /></td></tr>
        </table>
    </InsertItemTemplate>
    <ItemTemplate>
        <table class="formtable">
            <tr><td class="form1sttd">Username:</td><td><asp:Label ID="UserNameLabel" runat="server" Text='<%# Eval("UserName") %>' /></td></tr>
            <tr><td class="form1sttd">FirstName:</td><td><asp:Label ID="FirstNameLabel" runat="server" Text='<%# Bind("FirstName") %>' /></td></tr>
            <tr><td class="form1sttd">LastName:</td><td> <asp:Label ID="LastNameLabel" runat="server" Text='<%# Bind("LastName") %>' /></td></tr>
            <tr><td class="form1sttd">HomePhone:</td><td><asp:Label ID="HomePhoneLabel" runat="server" Text='<%# Bind("HomePhone") %>' /></td></tr>
            <tr><td class="form1sttd">MobilePhone:</td><td><asp:Label ID="MobilePhoneLabel" runat="server" Text='<%# Bind("MobilePhone") %>' /></td></tr>
            <tr><td class="form1sttd">WorkPhone:</td><td><asp:Label ID="WorkPhoneLabel" runat="server" Text='<%# Bind("WorkPhone") %>' /></td></tr>
            <tr><td class="form1sttd">Street:</td><td><asp:Label ID="StreetLabel" runat="server" Text='<%# Bind("Street") %>' /></td></tr>
            <tr><td class="form1sttd">City:</td><td><asp:Label ID="CityLabel" runat="server" Text='<%# Bind("City") %>' /></td></tr>
            <tr><td class="form1sttd">State:</td><td><asp:Label ID="StateLabel" runat="server" Text='<%# Bind("State") %>' /></td></tr>
            <tr><td class="form1sttd">ZIP:</td><td><asp:Label ID="ZIPLabel" runat="server" Text='<%# Bind("ZIP") %>' /></td></tr>
            <tr><td class="form1sttd">Email:</td><td><asp:Label ID="EmailLabel" runat="server" Text='<%# Bind("Email") %>' /></td></tr>
            <tr><td class="formsubmit"><asp:LinkButton ID="lnkEdit" runat="server" CommandName="Edit" >Edit Info</asp:LinkButton></td>
                <td style="text-align:right;font-size:small">ID:&nbsp;&nbsp;<asp:Label ID="IDLabel" runat="server" Text='<%# Eval("ID") %>' /></td></tr>
        </table>
    </ItemTemplate>
    </asp:FormView>

<asp:SqlDataSource ID="sdsContactInfo" runat="server" 
    ConnectionString="<%$ ConnectionStrings:BEF %>" 
    OnSelecting="sdsContactInfo_OnSelecting"
    OnUpdating="sdsContactInfo_OnUpdating"
    OnInserting="sdsContactInfo_OnInserting"
    OnInserted="sdsContactInfo_Inserted"
    SelectCommand="Me_UserInfo_Sel" SelectCommandType="StoredProcedure"
    UpdateCommand="Me_UserInfo_upd" UpdateCommandType="StoredProcedure"
    InsertCommand="Me_UserInfo_ins" InsertCommandType="StoredProcedure">
    <SelectParameters>
        <asp:Parameter Name="UserName" />
    </SelectParameters>
    <UpdateParameters>
        <asp:Parameter Name="UserName" />
    </UpdateParameters>
    <InsertParameters>
        <asp:Parameter Name="UserName" />
    </InsertParameters>
</asp:SqlDataSource>
</asp:Content>
