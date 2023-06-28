import 'package:flutter/cupertino.dart';

class ActivityIndicator extends StatelessWidget {
  const ActivityIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      minimum: EdgeInsets.only(top: 50),
      child: Align(
        alignment: Alignment.center,
        child: CupertinoActivityIndicator(),
      ),
    );
  }
}
