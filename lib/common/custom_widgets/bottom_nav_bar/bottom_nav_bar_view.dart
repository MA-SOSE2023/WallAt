import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../router/locations/locations.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key, required this.beamerKey});

  final GlobalKey<BeamerState> beamerKey;

  static const double iconSize = 30.0;

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  late final BeamerDelegate _beamerDelegate;
  BeamLocation? _currentLocation;
  int _currentIndex = 0;

  static const List<CustomBottomNavBarItem> _baseTabs = [
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

  static const CustomBottomNavBarItem _cameraItem = CustomBottomNavBarItem(
    icon: Icon(Icons.camera_alt_outlined),
    activeIcon: Icon(Icons.camera_alt),
    label: 'CAMERA',
    initialLocation: '/camera',
  );

  static const CustomBottomNavBarItem _settingsItem = CustomBottomNavBarItem(
    icon: Icon(Icons.settings_outlined),
    activeIcon: Icon(Icons.settings),
    label: 'SETTINGS',
    initialLocation: '/settings',
  );

  void _setStateListener() => setState(() {});

  @override
  void initState() {
    super.initState();
    _beamerDelegate = widget.beamerKey.currentState!.routerDelegate;
    _beamerDelegate.addListener(_setStateListener);
  }

  @override
  Widget build(BuildContext context) {
    _currentLocation = _beamerDelegate.currentBeamLocation;
    _currentIndex = _currentLocation is HomeLocation
        ? 0
        : _currentLocation is FavoritesLocation
            ? 1
            : _currentLocation is FoldersLocation
                ? 2
                : 3;

    double iconSize = CustomBottomNavBar.iconSize;

    return CupertinoTabBar(
      iconSize: iconSize,
      onTap: (index) => _goOtherPage(index),
      currentIndex: _currentIndex,
      items: [..._baseTabs, _currentIndex == 0 ? _settingsItem : _cameraItem],
    );
  }

  void _goOtherPage(int index) {
    if (index == 3) {
      if (_currentIndex == 0) {
        context.beamToNamed(_settingsItem.initialLocation);
      } else {
        context.beamToNamed(_cameraItem.initialLocation);
      }
    } else {
      context.beamToNamed(_baseTabs[index].initialLocation);
    }
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
