import 'package:aura_wallet/src/core/constants/end_point.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:base_response/base_response.dart';

part 'horo_scope_api_service.g.dart';

@RestApi()
abstract class HoroScopeApiService {
  factory HoroScopeApiService(Dio dio, {String? baseUrl}) =
      _HoroScopeApiService;

  @GET(EndPoint.transaction)
  Future<HoroScopeBaseResponse> getTransactions(
      @Queries() Map<String, dynamic> queries);

  @GET(EndPoint.block)
  Future<HoroScopeBaseResponse> getBlocks(
      @Queries() Map<String, dynamic> queries);

  @GET(EndPoint.walletBalance)
  Future<HoroScopeBaseResponse> getBalances(
      @Queries() Map<String, dynamic> queries);
}
