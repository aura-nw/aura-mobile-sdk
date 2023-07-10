import 'package:alan/proto/cosmos/bank/v1beta1/export.dart';
import 'dart:developer' as auraLog;

class LogInter implements ClientInterceptor {
  @override
  ResponseStream<R> interceptStreaming<Q, R>(
      ClientMethod<Q, R> method,
      Stream<Q> requests,
      CallOptions options,
      ClientStreamingInvoker<Q, R> invoker) {
    return invoker(method, requests, options);
  }

  @override
  ResponseFuture<R> interceptUnary<Q, R>(ClientMethod<Q, R> method, Q request,
      CallOptions options, ClientUnaryInvoker<Q, R> invoker) {
    auraLog.log(
      'Grpc request. '
          'method: ${method.path}, '
          'request: $request',
    );
    final response = invoker(method, request, options);

    response.then((r) {
      auraLog.log(
        'Grpc response. '
            'method: ${method.path}, '
            'response: ${r.toString()}',
      );
    });

    return response;
  }
}