using System;
using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;
using CosmosApi.Extensions;
using CosmosApi.Models;
using Flurl.Http;

namespace CosmosApi.Endpoints
{
    internal class Transactions : ITransactions
    {
        private readonly Func<IFlurlClient> _clientGetter;

        public Transactions(Func<IFlurlClient> clientGetter)
        {
            _clientGetter = clientGetter;
        }

        public Task<PaginatedTxs> GetSearchAsync(string messageAction, string messageSender, int page = 1, int limit = 10,
            int minHeight = default, int maxHeight = default, CancellationToken cancellationToken = default)
        {
            return _clientGetter()
                .Request("txs")
                .SetQueryParam("message.action", messageAction)
                .SetQueryParam("message.sender", messageSender)
                .SetQueryParam("page", page)
                .SetQueryParam("limit", limit)
                .SetQueryParam("tx.minheight", minHeight)
                .SetQueryParam("tx.maxheight", maxHeight)
                .GetJsonAsync<PaginatedTxs>(cancellationToken)
                .WrapExceptions();
        }

        public PaginatedTxs GetSearch(string messageAction, string messageSender, int page = default, int limit = default,
            int minHeight = default, int maxHeight = default)
        {
            return GetSearchAsync(messageAction, messageSender, page, limit, minHeight, maxHeight).Sync();
        }

        public Task<TxResponse> GetByHashAsync(byte[] hash, CancellationToken cancellationToken = default)
        {
            return _clientGetter()
                .Request("txs", hash.ToHexString())
                .GetJsonAsync<TxResponse>(cancellationToken)
                .WrapExceptions();
        }

        public TxResponse GetByHash(byte[] hash)
        {
            return GetByHashAsync(hash).Sync();
        }

        public async Task<BroadcastTxResult> PostBroadcastAsync(BroadcastTxBody txBroadcast, CancellationToken cancellationToken = default)
        {
            //IFlurlRequest request = _clientGetter().Request("txs");
            IFlurlRequest request = _clientGetter().Request("cosmos", "tx", "v1beta1", "txs");
            Logging.Info(request.Url, txBroadcast.Tx.GetMsgs()[0].SignBytesObject().ToString(), txBroadcast.Mode);
            System.Net.Http.HttpResponseMessage httpResponseMessage = await request.PostJsonAsync(txBroadcast, cancellationToken);
            Logging.Info("response", httpResponseMessage);
            BroadcastTxResult result = null; //httpResponseMessage.ReceiveJson<BroadcastTxResult>();
            return result;
        }

        public BroadcastTxResult PostBroadcast(BroadcastTxBody txBroadcast)
        {
            return PostBroadcastAsync(txBroadcast).Sync();
        }

        public Task<EncodeTxResponse> PostEncodeAsync(ITx tx, CancellationToken cancellationToken = default)
        {
            return _clientGetter()
                .Request("txs", "encode")
                .PostJsonAsync(tx, cancellationToken)
                .ReceiveJson<EncodeTxResponse>()
                .WrapExceptions();
        }
    }
}