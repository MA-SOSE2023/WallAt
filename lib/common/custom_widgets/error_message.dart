import 'package:flutter/cupertino.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({String message = 'Something went wrong', super.key})
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
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: CupertinoDynamicColor.resolve(
              CupertinoColors.destructiveRed,
              context,
            ),
          ),
        ),
      ),
    );
  }
}
