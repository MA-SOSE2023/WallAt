import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/common/provider.dart';
import '/router/router.dart';

import 'bottom_nav_bar_model.dart';
export 'bottom_nav_bar_model.dart';

class CustomBottomNavBarScreen extends StatelessWidget {
  const CustomBottomNavBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Beamer(
        key: Routers.bottomNavRouterBeamerKey,
        routerDelegate: Routers.bottomNavRouterDelegate,
      ),
      bottomNavigationBar: CustomBottomNavBar(
        beamerKey: Routers.bottomNavRouterBeamerKey,
      ),
    );
  }
}

class CustomBottomNavBar extends ConsumerStatefulWidget {
  const CustomBottomNavBar({super.key, required this.beamerKey});

  final GlobalKey<BeamerState> beamerKey;

  static const double iconSize = 30.0;

  static const List<CustomBottomNavBarItem> baseItems = [
    CustomBottomNavBarItem(
      icon: Icon(Icons.home),
      activeIcon: Icon(Icons.home),
      label: 'HOME',
      initialLocation: '/home',
    ),
    CustomBottomNavBarItem(
      icon: Icon(Icons.favorite_outline),
      activeIcon: Icon(Icons.favorite),
      label: 'FAVORITES',
      initialLocation: '/favorites',
    ),
    CustomBottomNavBarItem(
      icon: Icon(Icons.folder_open),
      activeIcon: Icon(Icons.folder),
      label: 'FOLDERS',
      initialLocation: '/folders',
    ),
  ];

  static const CustomBottomNavBarItem cameraItem = CustomBottomNavBarItem(
    icon: Icon(Icons.camera_alt_outlined),
    activeIcon: Icon(Icons.camera_alt),
    label: 'CAMERA',
    initialLocation: '/camera',
  );

  static const CustomBottomNavBarItem settingsItem = CustomBottomNavBarItem(
    icon: Icon(Icons.settings_outlined),
    activeIcon: Icon(Icons.settings),
    label: 'SETTINGS',
    initialLocation: '/settings',
  );

  @override
  ConsumerState<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends ConsumerState<CustomBottomNavBar> {
  late final BeamerDelegate _beamerDelegate;

  void _setStateListener() => setState(() {});

  @override
  void initState() {
    super.initState();
    _beamerDelegate = widget.beamerKey.currentState!.routerDelegate;
    _beamerDelegate.addListener(_setStateListener);
  }

  @override
  Widget build(BuildContext context) {
    CustomBottomNavBarModel state =
        ref.watch(Providers.customBottomNavBarControllerProvider);
    CustomBottomNavBarController controller =
        ref.read(Providers.customBottomNavBarControllerProvider.notifier);

    return CupertinoTabBar(
      iconSize: state.iconSize,
      onTap: (index) => controller.goToOtherPage(index, context),
      currentIndex: state.currentIndex,
      items: controller.getNavBarItems(),
    );
  }

  @override
  void dispose() {
    _beamerDelegate.removeListener(_setStateListener);
    super.dispose();
  }
}

class CustomBottomNavBarItem extends BottomNavigationBarItem {
  final String initialLocation;

  const CustomBottomNavBarItem(
      {required this.initialLocation,
      required Widget icon,
      String? label,
      Widget? activeIcon})
      : super(icon: icon, label: label, activeIcon: activeIcon ?? icon);
}

abstract class CustomBottomNavBarController
    extends StateNotifier<CustomBottomNavBarModel> {
  CustomBottomNavBarController() : super(const CustomBottomNavBarModel());

  List<CustomBottomNavBarItem> getNavBarItems();
  void goToOtherPage(int index, BuildContext context);
}
