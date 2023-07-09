import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/common/provider.dart';
import '/common/localization/language.dart';
import '/common/custom_widgets/all_custom_widgets.dart'
    show
        SliverErrorMessage,
        SliverNoElementsMessage,
        AsyncOptionBuilder,
        SliverActivityIndicator;

class AsyncSliverListBuilder<T> extends ConsumerWidget {
  const AsyncSliverListBuilder({
    required AsyncValue<List<T>?> future,
    required Widget Function(List<T>) success,
    Widget Function()? loading,
    Widget Function(String emptyMessage)? empty,
    Widget Function(Object?)? error,
    this.onNullMessage,
    this.emptyMessage,
    this.errorMessage,
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

  final String? onNullMessage;
  final String? emptyMessage;
  final String? errorMessage;
  final double? errorMessagesPadding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Language language =
        ref.watch(Providers.settingsControllerProvider).language;
    return AsyncOptionBuilder(
        future: _future,
        success: (data) {
          if (data.isEmpty) {
            return _onEmptyBuilder
                    ?.call(emptyMessage ?? language.infoGenericEmpty) ??
                SliverNoElementsMessage(
                  message: emptyMessage ?? language.infoGenericEmpty,
                  minPadding: errorMessagesPadding,
                );
          } else {
            return _onSuccessBuilder(data);
          }
        },
        error: _onErrorBuilder ??
            (_) => SliverErrorMessage(
                  message: errorMessage ?? language.errGenericLoad,
                  minPadding: errorMessagesPadding,
                ),
        loading: _onLoadingBuilder ?? () => const SliverActivityIndicator());
  }
}
