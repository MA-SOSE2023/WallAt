import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin FutureControllerMixin<T> on StateNotifier<Future<T>> {
  void futureState(T Function(T) getValue) {
    state.then((val) => mounted ? state = Future.value(getValue(val)) : {});
  }
}
