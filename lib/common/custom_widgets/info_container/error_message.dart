import 'package:flutter/cupertino.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage(
      {String message = 'Something went wrong', double? minPadding, super.key})
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
