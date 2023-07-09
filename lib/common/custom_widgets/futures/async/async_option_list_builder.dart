import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/common/provider.dart';
import '/common/localization/language.dart';
import '/common/custom_widgets/all_custom_widgets.dart'
    show AsyncOptionBuilder, NoElementsMessage;

class AsyncOptionListBuilder<T> extends ConsumerWidget {
  const AsyncOptionListBuilder({
    required AsyncValue<List<T>?> future,
    required Widget Function(List<T>) success,
    this.empty,
    this.emptyMessage,
    this.errorMessage,
    this.errorMessagesPadding,
    super.key,
  })  : _future = future,
        _onSuccessBuilder = success;

  final AsyncValue<List<T>?> _future;
  final Widget Function(List<T>) _onSuccessBuilder;

  final Widget Function(String)? empty;

  final String? emptyMessage;
  final String? errorMessage;
  final double? errorMessagesPadding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Language language =
        ref.watch(Providers.settingsControllerProvider).language;
    return AsyncOptionBuilder(
      future: _future,
      errorMessage: errorMessage,
      success: (data) {
        if (data.isEmpty) {
          return empty == null
              ? NoElementsMessage(
                  message: emptyMessage ?? language.infoGenericEmpty)
              : empty!(emptyMessage ?? language.infoGenericEmpty);
        } else {
          return _onSuccessBuilder(data);
        }
      },
    );
  }
}
