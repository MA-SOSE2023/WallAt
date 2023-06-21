import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gruppe4/common/custom_widgets/all_custom_widgets.dart';
import 'package:gruppe4/common/custom_widgets/document_card_container.dart';
import 'package:gruppe4/router/router.dart';

import 'pages/single_item/single_item_view.dart';
import 'pages/single_item/edit_single_item_view.dart';

void main() => runApp(const ProviderScope(child: MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
        localizationsDelegates: [
          DefaultCupertinoLocalizations.delegate,
          DefaultMaterialLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
        ],
        home: CupertinoPageScaffold(
          child: Center(child: DocumentCardContainer(id: '1')),
        ));
  }
}
