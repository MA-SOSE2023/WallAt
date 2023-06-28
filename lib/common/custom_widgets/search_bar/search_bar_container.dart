import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gruppe4/common/theme/custom_theme_data.dart';

import '../../provider.dart';
import 'search_bar.dart';

class SearchBarContainer extends ConsumerWidget {
  const SearchBarContainer(
      {required ValueChanged<String> onChanged,
      Iterable<String>? autoFillHints,
      super.key})
      : _onChanged = onChanged,
        _autoFillHints = autoFillHints;

  final ValueChanged<String> _onChanged;
  final Iterable<String>? _autoFillHints;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CustomThemeData theme = ref.watch(Providers.themeControllerProvider);
    return Container(
      color: theme.groupingColor,
      padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: theme.groupingColor,
            width: 1,
          ),
          color: theme.backgroundColor,
        ),
        child: SearchBar(
          onChanged: _onChanged,
          autoFillHints: _autoFillHints,
        ),
      ),
    );
  }
}
