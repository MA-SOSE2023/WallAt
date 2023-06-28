import 'package:flutter/cupertino.dart';

import '/common/custom_widgets/all_custom_widgets.dart'
    show ErrorMessage, NoElementsMessage, FutureOptionBuilder;

class FutureSliverListBuilder<T> extends StatelessWidget {
  const FutureSliverListBuilder({
    required Future<List<T>?> future,
    required Widget Function(List<T>) success,
    this.onNullMessage = 'No matching item was found.\nTry restarting the app.',
    this.emptyListMessage = 'There are no entries yet.\nTry adding some items.',
    this.errorMessage =
        'An error occurred while loading.\nTry restarting the app.',
    super.key,
  })  : _future = future,
        _onSuccessBuilder = success;

  final Future<List<T>?> _future;
  final Widget Function(List<T>) _onSuccessBuilder;

  final String onNullMessage;
  final String emptyListMessage;
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return FutureOptionBuilder(
      future: _future,
      success: (data) {
        if (data == null) {
          return ErrorMessage(
            message: onNullMessage,
          );
        } else if (data.isEmpty) {
          return NoElementsMessage(
            message: emptyListMessage,
          );
        } else {
          return _onSuccessBuilder(data);
        }
      },
      errror: (_) => ErrorMessage(
        message: errorMessage,
      ),
      loading: () => SliverSafeArea(
        minimum: EdgeInsets.only(top: MediaQuery.of(context).size.height / 4),
        sliver: const SliverToBoxAdapter(
          child: Center(
            child: CupertinoActivityIndicator(),
          ),
        ),
      ),
    );
  }
}
