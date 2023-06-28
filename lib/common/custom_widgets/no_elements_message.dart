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
    return SliverSafeArea(
      minimum: EdgeInsets.only(
        top: _minPadding ?? MediaQuery.of(context).size.height / 4,
        bottom: _minPadding ?? 0.0,
      ),
      sliver: SliverToBoxAdapter(
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
      ),
    );
  }
}
