using System;
using System.Net.Http;

namespace CosmosApi.Callbacks
{
    public class AfterCall
    {
        /// <summary>The HttpRequestMessage associated with this call.</summary>
        public HttpRequestMessage Request { get; set; }
        /// <summary>
        /// HttpResponseMessage associated with the call if the call completed, otherwise null.
        /// </summary>
        public HttpResponseMessage Response { get; set; }
        /// <summary>DateTime the moment the request was sent.</summary>
        public DateTime StartedUtc { get; set; }
        /// <summary>DateTime the moment a response was received.</summary>
        public DateTime? EndedUtc { get; set; }

        public AfterCall(HttpRequestMessage request, HttpResponseMessage response, DateTime startedUtc, DateTime? endedUtc)
        {
            Request = request;
            Response = response;
            StartedUtc = startedUtc;
            EndedUtc = endedUtc;
        }
    }
}