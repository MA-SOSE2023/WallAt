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
    this.onNullMessage = 'No matching item was found.\nTry restarting the app.',
    this.emptyMessage = 'There are no entries yet.\nTry adding some items.',
    this.errorMessage =
        'An error occurred while loading.\nTry restarting the app.',
    this.errorMessagesPadding,
    super.key,
  })  : _future = future,
        _onSuccessBuilder = success;

  final AsyncValue<List<T>?> _future;
  final Widget Function(List<T>) _onSuccessBuilder;

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
            return SliverNoElementsMessage(
              message: emptyMessage,
              minPadding: errorMessagesPadding,
            );
          } else {
            return _onSuccessBuilder(data);
          }
        },
        error: (_) => SliverErrorMessage(
              message: errorMessage,
              minPadding: errorMessagesPadding,
            ),
        loading: () => const SliverActivityIndicator());
  }
}
