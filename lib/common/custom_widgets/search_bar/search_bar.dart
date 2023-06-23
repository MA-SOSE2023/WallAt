import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  const SearchBar(
      {required ValueChanged<String> onChanged,
      Iterable<String>? autoFillHints,
      super.key})
      : _onChanged = onChanged,
        _autoFillHints = autoFillHints;

  final ValueChanged<String> _onChanged;
  final Iterable<String>? _autoFillHints;

  @override
  State<StatefulWidget> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  late bool _searching;
  late final TextEditingController _controller;
  late final FocusNode _textFieldFocusNode;

  @override
  void initState() {
    super.initState();
    _searching = false;
    _controller = TextEditingController(text: '');
    _textFieldFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    _textFieldFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField.borderless(
      prefix: IconButton(
        onPressed: () {
          if (_searching) {
            setState(() {
              _searching = false;
              _controller.clear();
              widget._onChanged('');
              FocusManager.instance.primaryFocus?.unfocus();
            });
          } else if (!_textFieldFocusNode.hasFocus) {
            setState(() {
              FocusManager.instance.primaryFocus
                  ?.requestFocus(_textFieldFocusNode);
            });
          }
        },
        color: CupertinoColors.systemGrey,
        splashColor: CupertinoDynamicColor.resolve(
            CupertinoColors.systemGrey3.withOpacity(0.5), context),
        icon: Icon(
          _searching ? CupertinoIcons.xmark : CupertinoIcons.search,
        ),
      ),
      placeholder: 'Search',
      focusNode: _textFieldFocusNode,
      autofillHints: widget._autoFillHints,
      controller: _controller,
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10),
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      onChanged: (text) {
        if (_searching && text.isEmpty) {
          setState(() {
            _searching = false;
          });
        } else if (!_searching && text.isNotEmpty) {
          setState(() {
            _searching = true;
          });
        }
        widget._onChanged(text);
      },
    );
  }
}
