import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timezone/data/latest.dart' as tz;

import '/common/theme/custom_theme_data.dart';
import '/common/services/persistence/db_model.dart';
import 'common/provider.dart';
import 'router/router.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Call to this provider should open the database
    DbModel dbC = ref.watch(Providers.dbControllerProvider);
    CustomThemeData theme = ref.watch(Providers.themeControllerProvider);
    return CupertinoApp.router(
      theme: CupertinoThemeData(
        brightness: theme.brightness,
        primaryColor: theme.accentColor,
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
