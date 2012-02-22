﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.239
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace TestProject1
{
    using System;
    using System.Collections.Generic;
    using Microsoft.VisualStudio.TestTools.WebTesting;


    public class WebTest1Coded : WebTest
    {
        public WebTest1Coded()
        {
            this.PreAuthenticate = true;
        }

        public override IEnumerator<WebTestRequest> GetRequestEnumerator()
        {
            var login = Rnd.Next(1, 3);
            var r = Rnd.Next(1, 5);
            for (int i = 1; i <= r; i++)
            {
                var request1 = new WebTestRequest("http://localhost:1200/s10.g");
                request1.QueryStringParameters.Add("account", "vip32");
                request1.QueryStringParameters.Add("site", "testclient" + login.ToString());
                yield return request1;    
            }
            
            //request1 = null;
        }
    }

    public class WebTest2Coded : WebTest
    {
        public WebTest2Coded()
        {
            this.PreAuthenticate = true;
        }

        public override IEnumerator<WebTestRequest> GetRequestEnumerator()
        {
            var login = Rnd.Next(10000, 11000);
            var r = Rnd.Next(1, 25);
            for (int i = 1; i <= r; i++)
            {
                var request1 = new WebTestRequest("http://127.0.0.1:1200/s10.g");
                request1.QueryStringParameters.Add("login", login.ToString());
                yield return request1;
            }

            //request1 = null;
        }
    }

    public static class Rnd
    {
        private static readonly Random _rnd;

        static Rnd()
        {
            _rnd = new Random();
        }

        public static int Next(int start, int end)
        {
            return _rnd.Next(start, end);
        }
    }
}
