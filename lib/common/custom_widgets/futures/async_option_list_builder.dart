import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/common/custom_widgets/all_custom_widgets.dart' show AsyncOptionBuilder;

class AsyncOptionListBuilder<T> extends StatelessWidget {
  const AsyncOptionListBuilder({
    required AsyncValue<List<T>?> future,
    required Widget Function(List<T>) success,
    this.empty,
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

  final Widget Function(String)? empty;

  final String onNullMessage;
  final String emptyMessage;
  final String errorMessage;
  final double? errorMessagesPadding;

  Widget _centerAligned({required Widget child}) => Align(
        alignment: Alignment.center,
        child: Padding(padding: const EdgeInsets.all(8.0), child: child),
      );

  @override
  Widget build(BuildContext context) {
    return AsyncOptionBuilder(
      future: _future,
      success: (data) {
        if (data == null) {
          return _centerAligned(child: Text(onNullMessage));
        } else if (data.isEmpty) {
          return empty == null
              ? _centerAligned(child: Text(emptyMessage))
              : empty!(emptyMessage);
        } else {
          return _onSuccessBuilder(data);
        }
      },
      error: (_) => _centerAligned(child: Text(errorMessage)),
      loading: () => _centerAligned(child: const CupertinoActivityIndicator()),
    );
  }
}
