import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/common/provider.dart';
import '/common/theme/custom_theme_data.dart';

class SelectionDialog<Selectable> extends ConsumerWidget {
  const SelectionDialog({
    required List<Selectable> selectables,
    required void Function(Selectable selected) onTapped,

    /// Function to determine if a selectable is selected
    /// If true, a checkmark will be displayed next to the selectable
    required bool Function(Selectable) isSelected,

    /// The title of the dialog being displayed above the ListSection
    String title = "Select an item",

    /// The header of the ListSection
    String? header,

    /// Builder for items in the ListSection
    final Widget Function(Selectable selectable)? builder,
    Key? key,
  })  : _onTapped = onTapped,
        _isSelected = isSelected,
        _selectables = selectables,
        _title = title,
        _header = header,
        _builder = builder,
        super(key: key);

  final List<Selectable> _selectables;
  final bool Function(Selectable) _isSelected;
  final void Function(Selectable selected) _onTapped;
  final String _title;
  final String? _header;
  final Widget Function(Selectable selectable)? _builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CustomThemeData theme = ref.watch(Providers.themeControllerProvider);
    return CupertinoAlertDialog(
      title: Text(_title),
      content: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: theme.groupingColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: CupertinoListSection.insetGrouped(
              backgroundColor: Colors.transparent,
              decoration: BoxDecoration(
                color: theme.backgroundColor,
              ),
              margin: const EdgeInsets.fromLTRB(8, 16, 8, 8),
              header: _header != null ? Text(_header!) : null,
              children: _selectables.map((selectable) {
                return CupertinoListTile(
                  title:
                      _builder?.call(selectable) ?? Text(selectable.toString()),
                  leadingSize: 20,
                  leadingToTitle: 5,
                  leading: _isSelected(selectable)
                      ? Icon(
                          CupertinoIcons.check_mark,
                          color: theme.accentColor,
                          size: 20,
                        )
                      : null,
                  onTap: () {
                    _onTapped(selectable);
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        CupertinoDialogAction(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
