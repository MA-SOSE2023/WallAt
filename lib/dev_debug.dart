import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gruppe4/common/custom_widgets/all_custom_widgets.dart';
import 'package:gruppe4/router/router.dart';

import 'pages/single_item/single_item_view.dart';
import 'pages/single_item/edit_single_item_view.dart';

void main() => runApp(const ProviderScope(child: MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
        home: Scaffold(
      body: const SingleItemPage(id: "1"),
      bottomNavigationBar: CupertinoTabBar(
        iconSize: 30,
        onTap: (index) => {},
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: "Favorites"),
        ],
      ),
    ));
  }
}
