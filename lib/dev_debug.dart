import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/common/custom_widgets/event_card/event_card_view.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(),
        child: Align(
          alignment: Alignment.center,
          child: Center(
            child: SafeArea(
                child: EventCard(date: DateTime.now(), description: 'Event 1')),
          ),
        ),
      ),
    );
  }
}

void main() => runApp(const ProviderScope(child: App()));
