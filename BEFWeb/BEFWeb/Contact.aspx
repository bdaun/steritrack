<%@ Page Title="Contact" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="BEFWeb.Contact" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <hgroup class="title">
        <h1><%: Title %>.</h1>
        <h2>Your contact page.</h2>
    </hgroup>

    <section class="contact">
        <header>
            <h3>Phone:</h3>
        </header>
        <p>
            <span class="label">Main:</span>
            <span>317.852.1056</span>
        </p>
    </section>

    <section class="contact">
        <header>
            <h3>Email:</h3>
        </header>
        <p>
            <span class="label">Web Support:</span>
            <span><a href="mailto:bdaun1@gmail.com">BEF Application Webmaster</a></span>
        </p>
        <p>
            <span class="label">General:</span>
            <span><a href="mailto:BEFInfo@BrownsburgEducationFoundation.org">Rene Behrend</a></span>
        </p>
    </section>

    <section class="contact">
        <header>
            <h3>Address:</h3>
        </header>
        <p>
            Brownsburg Education Foundation<br />
            444 East Tilden Drive<br />
            Brownsburg, IN 46112
        </p>
    </section>
</asp:Content>