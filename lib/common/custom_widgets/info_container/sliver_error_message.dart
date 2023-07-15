import 'package:flutter/cupertino.dart';

class SliverErrorMessage extends StatelessWidget {
  const SliverErrorMessage(
      {String message = 'Something went wrong', double? minPadding, super.key})
      : _message = message,
        _minPadding = minPadding;

  final String _message;
  final double? _minPadding;

  @override
  Widget build(BuildContext context) {
    return SliverSafeArea(
      minimum: EdgeInsets.only(
        top: _minPadding ?? MediaQuery.of(context).size.height / 4,
        bottom: _minPadding ?? 0.0,
      ),
      sliver: SliverToBoxAdapter(
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
