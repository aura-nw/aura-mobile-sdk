import 'package:base_response/base_response.dart';

typedef BaseExceptionListener = void Function(Object e);

mixin BaseExceptionWrapper {
  final List<BaseExceptionListener> _listeners = List.empty(growable: true);

  AppError handleError(Object e);

  Object ? errorMapperHandler(AppError error);

  void addListener(BaseExceptionListener listener){
    if(_listeners.contains(listener)) return;

    _listeners.add(listener);
  }

  void removeListener(BaseExceptionListener listener){
    if(!_listeners.contains(listener)) return;

    _listeners.remove(listener);
  }

  void clear(){
    _listeners.clear();
  }

  void observersError(Object e){
    for(final listener in _listeners){
      listener.call(e);
    }
  }
}
