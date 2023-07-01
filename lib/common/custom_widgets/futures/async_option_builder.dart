import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/common/custom_widgets/all_custom_widgets.dart'
    show ActivityIndicator, ErrorMessage;

class AsyncOptionBuilder<T> extends StatelessWidget {
  const AsyncOptionBuilder({
    required AsyncValue<T> future,
    required Widget Function(T) success,
    Widget Function()? loading,
    Widget Function(Object?)? error,
    String errorMessage =
        'Something went wrong while loading.\nTry restarting the app.',
    T? initialData,
    super.key,
  })  : _future = future,
        _onSuccessBuilder = success,
        _onLoadingBuilder = loading,
        _onErrorBuilder = error,
        _initialData = initialData,
        _errorMessage = errorMessage;

  final AsyncValue<T> _future;

  final Widget Function(T) _onSuccessBuilder;
  final Widget Function()? _onLoadingBuilder;
  final String _errorMessage;
  final Widget Function(Object?)? _onErrorBuilder;
  final T? _initialData;

  @override
  Widget build(BuildContext context) => _future.when(
      data: _onSuccessBuilder,
      error: (obj, stackTrace) {
        print(stackTrace); // TODO: look into logging framework
        return _onErrorBuilder == null
            ? ErrorMessage(message: _errorMessage)
            : _onErrorBuilder!(obj);
      },
      loading: () {
        // (unnecessary) assignment to local variable to satisfy null safety
        // logic of compiler
        final T? data = this._initialData;
        if (data != null) {
          return _onSuccessBuilder(data);
        } else {
          return _onLoadingBuilder == null
              ? const ActivityIndicator()
              : _onLoadingBuilder!();
        }
      });
}
