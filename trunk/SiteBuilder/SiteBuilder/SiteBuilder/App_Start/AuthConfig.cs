﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.AspNet.Membership.OpenAuth;

namespace SiteBuilder
{
    internal static class AuthConfig
    {
        public static void RegisterOpenAuth()
        {
            // See http://go.microsoft.com/fwlink/?LinkId=252803 for details on setting up this ASP.NET
            // application to support logging in via external services.

            //OpenAuth.AuthenticationClients.AddTwitter(
            //    consumerKey: "your Twitter consumer key",
            //    consumerSecret: "your Twitter consumer secret");

            OpenAuth.AuthenticationClients.AddFacebook(
                appId: "616513065147166",
                appSecret: "d5a899c0f4ac5ba73da4d6d8ac9005cf");

            //OpenAuth.AuthenticationClients.AddMicrosoft(
            //    clientId: "your Microsoft account client id",
            //    clientSecret: "your Microsoft account client secret");

            OpenAuth.AuthenticationClients.AddGoogle();
        }
    }
}