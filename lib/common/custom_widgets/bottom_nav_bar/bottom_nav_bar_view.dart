import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../provider.dart';
import 'bottom_nav_bar_model.dart';

class CustomBottomNavBar extends ConsumerStatefulWidget {
  const CustomBottomNavBar({super.key, required this.beamerKey});

  final GlobalKey<BeamerState> beamerKey;

  static const double iconSize = 30.0;

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

  List<BottomNavigationBarItem> getNavBarItems();
  void goToOtherPage(int index, BuildContext context);

  set currentIndex(int index);
  set iconSize(double iconSize);
}
