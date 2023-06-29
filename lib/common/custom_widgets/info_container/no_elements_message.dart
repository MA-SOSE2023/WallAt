import 'package:flutter/cupertino.dart';

class NoElementsMessage extends StatelessWidget {
  const NoElementsMessage(
      {String message = 'No elements yet.', double? minPadding, super.key})
      : _message = message,
        _minPadding = minPadding;

  final String _message;
  final double? _minPadding;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.only(
        top: _minPadding ?? 50,
        bottom: _minPadding ?? 0.0,
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          _message,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: CupertinoDynamicColor.resolve(
              CupertinoColors.inactiveGray,
              context,
            ),
          ),
        ),
      ),
    );
  }
}
