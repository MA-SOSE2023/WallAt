import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gruppe4/common/provider.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'router/router.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Call to this provider should open the database
    ref.read(Providers.persistenceServiceProvider);
    return CupertinoApp.router(
      theme: const CupertinoThemeData(
        brightness: Brightness.dark,
      ),
      localizationsDelegates: const [
        DefaultCupertinoLocalizations.delegate,
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      routerDelegate: Routers.globalRouterDelegate,
      routeInformationParser: BeamerParser(),
    );
  }
}

void main() =>
    {tz.initializeTimeZones(), runApp(const ProviderScope(child: App()))};
