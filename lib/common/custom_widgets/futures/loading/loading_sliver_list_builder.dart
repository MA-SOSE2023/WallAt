import 'package:flutter/cupertino.dart';

import '/common/utils/external_resource_mixin.dart';
import '/common/custom_widgets/all_custom_widgets.dart'
    show SliverErrorMessage, SliverNoElementsMessage, SliverActivityIndicator;

class LoadingSliverListBuilder<T extends ExternalResource>
    extends StatelessWidget {
  const LoadingSliverListBuilder({
    required List<T>? resources,
    required Widget Function(List<T>) success,
    this.onNullMessage = 'No matching item was found.\nTry restarting the app.',
    this.emptyMessage = 'There are no entries yet.\nTry adding some items.',
    this.errorMessage =
        'An error occurred while loading.\nTry restarting the app.',
    this.errorMessagesPadding,
    super.key,
  })  : _resources = resources,
        _onSuccessBuilder = success;

  final List<T>? _resources;
  final Widget Function(List<T>) _onSuccessBuilder;

  final String onNullMessage;
  final String emptyMessage;
  final String errorMessage;
  final double? errorMessagesPadding;

  @override
  Widget build(BuildContext context) {
    bool anyLoading = false;
    bool anyHasError = false;
    for (final resource in _resources ?? []) {
      if (resource.isLoading) {
        anyLoading = true;
      } else if (resource.hasError) {
        anyHasError = true;
      }
    }
    if (anyHasError) {
      return SliverErrorMessage(
        message: errorMessage,
        minPadding: errorMessagesPadding,
      );
    } else if (anyLoading) {
      return const SliverActivityIndicator();
    } else {
      if (_resources == null) {
        return SliverErrorMessage(
          message: onNullMessage,
          minPadding: errorMessagesPadding,
        );
      } else if (_resources!.isEmpty) {
        return SliverNoElementsMessage(
          message: emptyMessage,
          minPadding: errorMessagesPadding,
        );
      } else {
        return _onSuccessBuilder(_resources!);
      }
    }
  }
}
