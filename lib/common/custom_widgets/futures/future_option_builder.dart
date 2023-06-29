import 'package:flutter/cupertino.dart';

class FutureOptionBuilder<T> extends StatelessWidget {
  const FutureOptionBuilder({
    required Future<T> future,
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

  final Future<T> _future;

  final Widget Function(T) _onSuccessBuilder;
  final Widget Function() _onLoadingBuilder;
  final Widget Function(Object?) _onErrorBuilder;
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
            return _onErrorBuilder(
                'Something went wrong while loading.\nTry restarting the app.');
          } else {
            return _onSuccessBuilder(data);
          }
        } else if (snapshot.hasError) {
          // TODO: add logging
          print('============= Fatal error in FutureOptionBuilder:');
          print(snapshot.error);
          return _onErrorBuilder(snapshot.error);
        } else {
          return _onLoadingBuilder();
        }
      },
    );
  }
}
