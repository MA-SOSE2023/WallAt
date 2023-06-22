import 'package:flutter/cupertino.dart';

class NoElementsMessage extends StatelessWidget {
  const NoElementsMessage({String message = 'No elements yet.', super.key})
      : _message = message;

  final String _message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Center(
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
