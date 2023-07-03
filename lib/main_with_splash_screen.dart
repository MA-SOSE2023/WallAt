import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'splash_screen.dart';

import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'common/provider.dart';

import '/common/theme/custom_theme_data.dart';
import 'router/router.dart';

void main() {
  tz.initializeTimeZones();
  runApp(const ProviderScope(child: App()));
}

class App extends ConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Call to this provider should open the database
    ref.read(Providers.persistenceServiceProvider);
    CustomThemeData theme = ref.watch(Providers.themeControllerProvider);
    // Navigate to the SplashScreen before building the main app
    return CupertinoApp.router(
      theme: CupertinoThemeData(
        brightness: theme.brightness,
        primaryColor: theme.accentColor,
        textTheme: CupertinoTextThemeData(
            navTitleTextStyle: TextStyle(
              color: theme.textColor,
            ),
            textStyle: TextStyle(color: theme.textColor)),
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
