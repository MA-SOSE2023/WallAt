import 'package:flutter/cupertino.dart';

import 'search_bar.dart';

class SearchBarContainer extends StatelessWidget {
  const SearchBarContainer(
      {required ValueChanged<String> onChanged,
      Iterable<String>? autoFillHints,
      super.key})
      : _onChanged = onChanged,
        _autoFillHints = autoFillHints;

  final ValueChanged<String> _onChanged;
  final Iterable<String>? _autoFillHints;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CupertinoTheme.of(context).barBackgroundColor,
      padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: CupertinoDynamicColor.resolve(
                CupertinoColors.systemGrey2, context),
            width: 1,
          ),
          color: CupertinoTheme.of(context)
              .scaffoldBackgroundColor
              .withOpacity(0.75),
        ),
        child: SearchBar(
          onChanged: _onChanged,
          autoFillHints: _autoFillHints,
        ),
      ),
    );
  }
}
