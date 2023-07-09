import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/common/localization/language.dart';
import '/common/provider.dart';
import '/common/custom_widgets/all_custom_widgets.dart'
    show
        SliverErrorMessage,
        SliverNoElementsMessage,
        FutureOptionBuilder,
        SliverActivityIndicator;

class FutureSliverListBuilder<T> extends ConsumerWidget {
  const FutureSliverListBuilder({
    required Future<List<T>?> future,
    required Widget Function(List<T>) success,
    this.emptyMessage,
    this.errorMessage,
    this.errorMessagesPadding,
    super.key,
  })  : _future = future,
        _onSuccessBuilder = success;

  final Future<List<T>?> _future;
  final Widget Function(List<T>) _onSuccessBuilder;

  final String? emptyMessage;
  final String? errorMessage;
  final double? errorMessagesPadding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Language language =
        ref.watch(Providers.settingsControllerProvider).language;
    return FutureOptionBuilder(
        future: _future,
        success: (data) {
          if (data.isEmpty) {
            return SliverNoElementsMessage(
              message: emptyMessage ?? language.infoGenericEmpty,
              minPadding: errorMessagesPadding,
            );
          } else {
            return _onSuccessBuilder(data);
          }
        },
        error: (_) => SliverErrorMessage(
              message: errorMessage ?? language.errGenericLoad,
              minPadding: errorMessagesPadding,
            ),
        loading: () => const SliverActivityIndicator());
  }
}
