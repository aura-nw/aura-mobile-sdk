import 'package:aura_wallet/src/data/repository/horo_scope_repository_iml.dart';
import 'package:aura_wallet/src/data/repository/market_repository_iml.dart';
import 'package:aura_wallet/src/data/resource/remote/horo_scope_api_service.dart';
import 'package:aura_wallet/src/data/resource/remote/market_api_service.dart';
import 'package:aura_wallet/src/domain/repository/horo_scope_repository.dart';
import 'package:aura_wallet/src/domain/repository/market_repository.dart';
import 'package:aura_wallet/src/domain/use_case/horo_scope_use_case.dart';
import 'package:aura_wallet/src/domain/use_case/market_use_case.dart';
import 'package:aura_wallet/src/presentation/screens/home/wallet/wallet_screen_bloc.dart';
import 'package:aura_wallet/src/presentation/screens/send_transaction/send_transaction_bloc.dart';
import 'package:aura_wallet/src/presentation/screens/splash/splash_screen_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'aura_wallet_config.dart';

final getIt = GetIt.instance;

Future<void> initDependency(
  AuraWalletConfig config,
) async {
  Dio dio = Dio(
    BaseOptions(
      baseUrl: config.baseUrl + config.configs!.apiVersion,
      connectTimeout: const Duration(
        milliseconds: 60000,
      ),
      receiveTimeout: const Duration(
        milliseconds: 60000,
      ),
      contentType: 'application/json; charset=utf-8',
    ),
  );

  getIt.registerFactory<Dio>(
    () => dio,
  );

  getIt.registerLazySingleton<AuraWalletConfig>(
    () => config,
  );

  ///Api service
  getIt.registerLazySingleton<HoroScopeApiService>(
    () => HoroScopeApiService(
      getIt.get<Dio>(),
      baseUrl: config.configs!.horoScopeUrl + config.configs!.apiVersion,
    ),
  );
  getIt.registerLazySingleton<MarketApiService>(
    () => MarketApiService(
      getIt.get<Dio>(),
    ),
  );

  ///Repository
  getIt.registerLazySingleton<HoroScopeRepository>(
    () => HoroScopeRepositoryIml(
      getIt.get<HoroScopeApiService>(),
    ),
  );
  getIt.registerLazySingleton<MarketRepository>(
    () => MarketRepositoryIml(
      getIt.get<MarketApiService>(),
    ),
  );

  ///Use case
  getIt.registerLazySingleton<HoroScopeUseCase>(
    () => HoroScopeUseCase(
      getIt.get<HoroScopeRepository>(),
    ),
  );
  getIt.registerLazySingleton<MarketUseCase>(
    () => MarketUseCase(
      getIt.get<MarketRepository>(),
    ),
  );

  ///Bloc
  getIt.registerFactory<SplashScreenCubit>(
    () => SplashScreenCubit(),
  );

  getIt.registerFactory<WalletScreenBloc>(
    () => WalletScreenBloc(
      getIt.get<HoroScopeUseCase>(),
      getIt.get<MarketUseCase>(),
    ),
  );
  getIt.registerFactory<SendTransactionBloc>(
    () => SendTransactionBloc(),
  );
}
