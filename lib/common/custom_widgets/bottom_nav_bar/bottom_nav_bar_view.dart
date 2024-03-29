import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gruppe4/common/theme/custom_theme_data.dart';

import 'bottom_nav_bar_model.dart';
import '/common/provider.dart';
import '/router/router.dart';

export 'bottom_nav_bar_model.dart';
export 'bottom_nav_bar_controller.dart';

class CustomBottomNavBarScreen extends ConsumerWidget {
  const CustomBottomNavBarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

  @override
  ConsumerState<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends ConsumerState<CustomBottomNavBar> {
  late final BeamerDelegate _beamerDelegate;
  Color? accentColor;

  void _setStateListener() => setState(() {});

  @override
  void initState() {
    super.initState();
    _beamerDelegate = widget.beamerKey.currentState!.routerDelegate;
    _beamerDelegate.addListener(_setStateListener);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        CustomBottomNavBarModel state =
            ref.watch(Providers.customBottomNavBarControllerProvider);
        CustomBottomNavBarController controller =
            ref.read(Providers.customBottomNavBarControllerProvider.notifier);

        CustomThemeData theme = ref.watch(Providers.themeControllerProvider);

        return CupertinoTabBar(
          backgroundColor: theme.navBarColor,
          iconSize: state.iconSize,
          onTap: (index) => controller.goToOtherPage(index, context, ref),
          currentIndex: state.currentIndex,
          items: controller.getNavBarItems(),
        );
      },
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

  const CustomBottomNavBarItem({
    required this.initialLocation,
    required Widget icon,
    String? label,
    Widget? activeIcon,
    this.onTap,
  }) : super(icon: icon, label: label, activeIcon: activeIcon ?? icon);

  final void Function(WidgetRef)? onTap;
}

abstract class CustomBottomNavBarController
    extends StateNotifier<CustomBottomNavBarModel> {
  CustomBottomNavBarController() : super(const CustomBottomNavBarModel());

  List<CustomBottomNavBarItem> getNavBarItems();
  void goToOtherPage(int index, BuildContext context, WidgetRef ref);
}
