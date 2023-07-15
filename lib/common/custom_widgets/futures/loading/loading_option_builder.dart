import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/common/provider.dart';
import '/common/localization/language.dart';
import '/common/utils/external_resource_mixin.dart';
import '/common/custom_widgets/all_custom_widgets.dart'
    show ActivityIndicator, ErrorMessage;

class LoadingOptionBuilder<T extends ExternalResource> extends ConsumerWidget {
  const LoadingOptionBuilder({
    required T resource,
    required Widget Function(T) success,
    Widget Function()? loading,
    Widget Function()? onNull,
    Widget Function()? error,
    String? errorMessage,
    T? initialData,
    super.key,
  })  : _resource = resource,
        _onSuccessBuilder = success,
        _onLoadingBuilder = loading,
        _onErrorBuilder = error,
        _initialData = initialData,
        _errorMessage = errorMessage;

  final T _resource;

  final Widget Function(T) _onSuccessBuilder;
  final Widget Function()? _onLoadingBuilder;
  final String? _errorMessage;
  final Widget Function()? _onErrorBuilder;
  final T? _initialData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Language language =
        ref.watch(Providers.settingsControllerProvider).language;
    if (_resource.isLoading) {
      if (_initialData != null) {
        return _onSuccessBuilder(_initialData!);
      }
      return _onLoadingBuilder == null
          ? const ActivityIndicator()
          : _onLoadingBuilder!();
    } else if (_resource.hasError) {
      return _onErrorBuilder == null
          ? ErrorMessage(message: _errorMessage ?? language.errGenericLoad)
          : _onErrorBuilder!();
    } else {
      return _onSuccessBuilder(_resource);
    }
  }
}
