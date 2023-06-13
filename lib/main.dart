import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'router/router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp.router(
      debugShowCheckedModeBanner: false,
      routerDelegate: Routers.globalRouterDelegate,
      routeInformationParser: BeamerParser(),
    );
  }
}

void main() => runApp(const ProviderScope(child: App()));
