import 'package:flutter/cupertino.dart';

class SliverActivityIndicator extends StatelessWidget {
  const SliverActivityIndicator({this.padding, super.key});

  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return SliverSafeArea(
      minimum: padding ??
          EdgeInsets.only(top: MediaQuery.of(context).size.height / 4),
      sliver: const SliverToBoxAdapter(
        child: Center(
          child: CupertinoActivityIndicator(),
        ),
      ),
    );
  }
}
