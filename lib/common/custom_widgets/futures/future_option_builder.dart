import 'package:flutter/cupertino.dart';

class FutureOptionBuilder<T> extends StatelessWidget {
  const FutureOptionBuilder({
    required Future<T> future,
    required Widget Function(T?) success,
    required Widget Function() loading,
    required Widget Function(Object?) errror,
    super.key,
  })  : _future = future,
        _onSuccessBuilder = success,
        _onLoadingBuilder = loading,
        _onErrorBuilder = errror;

  final Future<T> _future;

  final Widget Function(T?) _onSuccessBuilder;
  final Widget Function() _onLoadingBuilder;
  final Widget Function(Object?) _onErrorBuilder;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _onSuccessBuilder(snapshot.data);
        } else if (snapshot.hasError) {
          return _onErrorBuilder(snapshot.error);
        } else {
          return _onLoadingBuilder();
        }
      },
    );
  }
}
