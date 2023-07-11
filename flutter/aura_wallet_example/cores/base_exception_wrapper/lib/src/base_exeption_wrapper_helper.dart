import 'package:base_response/base_response.dart';
import 'base_exception_wrapper.dart';

abstract class BaseExceptionWrapperHelper with BaseExceptionWrapper {
  Future<T> call<T>({
    required Future<T> onRequest,
  }) async {
    try {
      return await onRequest;
    } catch (e) {
      observersError(e);

      if (e is AppError){
        if(errorMapperHandler(e) !=null){
          throw errorMapperHandler(e)!;
        }
        rethrow;
      }

      final appError = handleError(e);

      if(errorMapperHandler(appError) !=null){
        throw errorMapperHandler(appError)!;
      }

      throw appError;
    }
  }

  Future<T?> callNonObserver<T>({
    required Future<T> onRequest,
  }) async {
    try {
      return await onRequest;
    } catch (e) {
      if (e is AppError){
        if(errorMapperHandler(e) !=null){
          throw errorMapperHandler(e)!;
        }

        rethrow;
      }

      final appError = handleError(e);

      if(errorMapperHandler(appError) !=null){
        throw errorMapperHandler(appError)!;
      }

      throw appError;
    }
  }
}
