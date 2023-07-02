import 'package:flutter/cupertino.dart';

import '/common/custom_widgets/all_custom_widgets.dart'
    show ActivityIndicator, ErrorMessage;

class FutureOptionBuilder<T> extends StatelessWidget {
  const FutureOptionBuilder({
    required Future<T> future,
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

  final Future<T> _future;

  final Widget Function(T) _onSuccessBuilder;
  final Widget Function()? _onLoadingBuilder;
  final String _errorMessage;
  final Widget Function(Object?)? _onErrorBuilder;
  final T? _initialData;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      initialData: _initialData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;
          if (data == null) {
            return _onErrorBuilder == null
                ? ErrorMessage(message: _errorMessage)
                : _onErrorBuilder!(snapshot.error);
          } else {
            return _onSuccessBuilder(data);
          }
        } else if (snapshot.hasError) {
          print(snapshot.error);
          print(snapshot.stackTrace); // TODO: look into logging framework
          return _onErrorBuilder == null
              ? ErrorMessage(message: _errorMessage)
              : _onErrorBuilder!(snapshot.error);
        } else {
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
        }
      },
    );
  }
}
