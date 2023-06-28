import 'package:flutter/cupertino.dart';

class SliverActivityIndicator extends StatelessWidget {
  const SliverActivityIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverSafeArea(
      minimum: EdgeInsets.only(top: MediaQuery.of(context).size.height / 4),
      sliver: const SliverToBoxAdapter(
        child: Center(
          child: CupertinoActivityIndicator(),
        ),
      ),
    );
  }
}
