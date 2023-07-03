import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/common/theme/custom_theme_data.dart';
import '/common/provider.dart';
import '/router/router.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    initializeApp();
  }

  Future<void> initializeApp() async {
    // Initialize the database
    ref.read(Providers.dbControllerProvider);
    // Wait for root folder to be loaded or created
    await ref.read(Providers.dbControllerProvider.notifier).rootFolderId;
    // Add puffer delay to reduce lag
    await Future.delayed(const Duration(seconds: 3));

    // Wait for the root folder to finish loading
    // subsequent calls to the provider for the root folder will be cached by riverpod
    await Future.doWhile(() {
      return Future.delayed(const Duration(seconds: 1), () {
        return ref.read(Providers.foldersControllerProvider(null)).isLoading;
      });
    });

    // Beam to home once initialization is complete
    Routers.globalRouterDelegate.beamToNamed("/home");
  }

  @override
  Widget build(BuildContext context) {
    CustomThemeData theme = ref.watch(Providers.themeControllerProvider);
    final double iconSize = MediaQuery.of(context).size.width * 0.75;
    return Scaffold(
      backgroundColor: theme.navBarColor,
      body: Center(
        child: SizedBox(
            width: iconSize,
            height: iconSize,
            child: Image.asset(
                "assets/dev_debug_images/splash_gif_wo_background.gif")),
      ),
    );
  }
}
