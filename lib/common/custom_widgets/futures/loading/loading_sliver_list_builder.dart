import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gruppe4/common/localization/language.dart';

import '../../../provider.dart';
import '/common/utils/external_resource_mixin.dart';
import '/common/custom_widgets/all_custom_widgets.dart'
    show SliverErrorMessage, SliverNoElementsMessage, SliverActivityIndicator;

class LoadingSliverListBuilder<T extends ExternalResource>
    extends ConsumerWidget {
  const LoadingSliverListBuilder({
    required List<T>? resources,
    required Widget Function(List<T>) success,
    this.onNullMessage,
    this.emptyMessage,
    this.errorMessage,
    this.errorMessagesPadding,
    super.key,
  })  : _resources = resources,
        _onSuccessBuilder = success;

  final List<T>? _resources;
  final Widget Function(List<T>) _onSuccessBuilder;

  final String? onNullMessage;
  final String? emptyMessage;
  final String? errorMessage;
  final double? errorMessagesPadding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Language language =
        ref.watch(Providers.settingsControllerProvider).language;

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
        message: errorMessage ?? language.errGenericLoad,
        minPadding: errorMessagesPadding,
      );
    } else if (anyLoading) {
      return const SliverActivityIndicator();
    } else {
      if (_resources == null) {
        return SliverErrorMessage(
          message: onNullMessage ?? language.errGenericLoad,
          minPadding: errorMessagesPadding,
        );
      } else if (_resources!.isEmpty) {
        return SliverNoElementsMessage(
          message: emptyMessage ?? language.infoGenericEmpty,
          minPadding: errorMessagesPadding,
        );
      } else {
        return _onSuccessBuilder(_resources!);
      }
    }
  }
}
