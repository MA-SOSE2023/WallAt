import 'package:flutter/cupertino.dart';

import 'search_bar.dart';

class SearchBarContainer extends StatelessWidget {
  const SearchBarContainer({required ValueChanged<String> onChanged, super.key})
      : _onChanged = onChanged;

  final ValueChanged<String> _onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CupertinoTheme.of(context).barBackgroundColor,
      padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color:
                CupertinoDynamicColor.resolve(CupertinoColors.label, context),
            width: 1,
          ),
          color:
              CupertinoTheme.of(context).scaffoldBackgroundColor.withAlpha(200),
        ),
        child: SearchBar(onChanged: _onChanged),
      ),
    );
  }
}
