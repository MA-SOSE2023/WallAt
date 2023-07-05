import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/common/custom_widgets/all_custom_widgets.dart'
    show
        SliverErrorMessage,
        SliverNoElementsMessage,
        AsyncOptionBuilder,
        SliverActivityIndicator;

class AsyncSliverListBuilder<T> extends StatelessWidget {
  const AsyncSliverListBuilder({
    required AsyncValue<List<T>?> future,
    required Widget Function(List<T>) success,
    Widget Function()? loading,
    Widget Function(String emptyMessage)? empty,
    Widget Function(Object?)? error,
    this.onNullMessage = 'No matching item was found.\nTry restarting the app.',
    this.emptyMessage = 'There are no entries yet.\nTry adding some items.',
    this.errorMessage =
        'An error occurred while loading.\nTry restarting the app.',
    this.errorMessagesPadding,
    super.key,
  })  : _future = future,
        _onSuccessBuilder = success,
        _onLoadingBuilder = loading,
        _onEmptyBuilder = empty,
        _onErrorBuilder = error;

  final AsyncValue<List<T>?> _future;
  final Widget Function(List<T>) _onSuccessBuilder;
  final Widget Function()? _onLoadingBuilder;
  final Widget Function(String emptyMessage)? _onEmptyBuilder;
  final Widget Function(Object?)? _onErrorBuilder;

  final String onNullMessage;
  final String emptyMessage;
  final String errorMessage;
  final double? errorMessagesPadding;

  @override
  Widget build(BuildContext context) {
    return AsyncOptionBuilder(
        future: _future,
        success: (data) {
          if (data.isEmpty) {
            return _onEmptyBuilder?.call(emptyMessage) ??
                SliverNoElementsMessage(
                  message: emptyMessage,
                  minPadding: errorMessagesPadding,
                );
          } else {
            return _onSuccessBuilder(data);
          }
        },
        error: _onErrorBuilder ??
            (_) => SliverErrorMessage(
                  message: errorMessage,
                  minPadding: errorMessagesPadding,
                ),
        loading: _onLoadingBuilder ?? () => const SliverActivityIndicator());
  }
}
