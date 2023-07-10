import 'package:aura_wallet/src/core/constants/end_point.dart';
import 'package:base_response/base_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'market_api_service.g.dart';

@RestApi()
abstract class MarketApiService{
  factory MarketApiService(Dio dio, {String? baseUrl}) =
  _MarketApiService;

  @GET(EndPoint.tokenMarket)
  Future<AuraBaseResponse> getTokenMarket(@Query('coinId') String id);
}