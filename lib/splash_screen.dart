import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gruppe4/common/theme/custom_theme_data.dart';
import 'common/provider.dart';
import 'router/router.dart';

class SplashScreen extends ConsumerStatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    initializeApp();
  }

  Future<void> initializeApp() async {
    // @TODO - Wait until the database finished loading all the data.
    await Future.delayed(const Duration(seconds: 2));

    // Invoke the callback when initialization is complete
    Routers.globalRouterDelegate.beamToNamed("/home");
  }

  @override
  Widget build(BuildContext context) {
    CustomThemeData theme = ref.watch(Providers.themeControllerProvider);
    return Scaffold(
      backgroundColor: theme.navBarColor,
      body: Center(
        child: SizedBox(
            width: 400,
            height: 400,
            child: Image.asset(
                "assets/dev_debug_images/splash_gif_wo_background.gif")),
      ),
    );
  }
}
