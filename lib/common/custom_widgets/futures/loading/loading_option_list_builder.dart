import 'package:flutter/cupertino.dart';

import '/common/utils/external_resource_mixin.dart';
import '/common/custom_widgets/all_custom_widgets.dart'
    show LoadingOptionBuilder, NoElementsMessage;
/*
class LoadingOptionListBuilder<T extends ExternalResource>
    extends StatelessWidget {
  const LoadingOptionListBuilder({
    required List<T> resources,
    required Widget Function(List<T>) success,
    this.empty,
    this.onNullMessage = 'No matching item was found.\nTry restarting the app.',
    this.emptyMessage = 'There are no entries yet.\nTry adding some items.',
    this.errorMessage =
        'An error occurred while loading.\nTry restarting the app.',
    this.errorMessagesPadding,
    super.key,
  })  : _resources = resources,
        _onSuccessBuilder = success;

  final List<T> _resources;
  final Widget Function(List<T>) _onSuccessBuilder;

  final Widget Function(String)? empty;

  final String onNullMessage;
  final String emptyMessage;
  final String errorMessage;
  final double? errorMessagesPadding;

  @override
  Widget build(BuildContext context) {
    return LoadingOptionBuilder(
      resource: _resources,
      success: (data) {
        if (data == null) {
          return NoElementsMessage(message: onNullMessage);
        } else if (data.isEmpty) {
          return empty == null
              ? NoElementsMessage(message: emptyMessage)
              : empty!(emptyMessage);
        } else {
          return _onSuccessBuilder(data);
        }
      },
    );
  }
}
*/