import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AsyncOptionBuilder<T> extends StatelessWidget {
  const AsyncOptionBuilder({
    required AsyncValue<T> future,
    required Widget Function(T) success,
    required Widget Function() loading,
    required Widget Function(Object?) error,
    T? initialData,
    super.key,
  })  : _future = future,
        _onSuccessBuilder = success,
        _onLoadingBuilder = loading,
        _onErrorBuilder = error,
        _initialData = initialData;

  final AsyncValue<T> _future;

  final Widget Function(T) _onSuccessBuilder;
  final Widget Function() _onLoadingBuilder;
  final Widget Function(Object?) _onErrorBuilder;
  final T? _initialData;

  @override
  Widget build(BuildContext context) => _future.when(
      data: _onSuccessBuilder,
      error: (obj, stackTrace) {
        print(stackTrace); // TODO: look into logging framework
        return _onErrorBuilder(obj);
      },
      loading: () {
        // (unnecessary) assignment to local variable to satisfy null safety
        // logic of compiler
        final T? data = this._initialData;
        if (data != null) {
          return _onSuccessBuilder(data);
        } else {
          return _onLoadingBuilder();
        }
      });
}
