import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/common/provider.dart';
import 'settings_model.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SettingsModel settings = ref.watch(Providers.settingsControllerProvider);
    SettingsController controller =
        ref.read(Providers.settingsControllerProvider.notifier);
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text("Settings"),
        ),
        child: SafeArea(
            child: Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(
                    color: CupertinoDynamicColor.resolve(
                        CupertinoColors.systemGrey5, context),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: CupertinoListSection.insetGrouped(
                      backgroundColor: Colors.transparent,
                      decoration: BoxDecoration(
                          color: CupertinoDynamicColor.resolve(
                              CupertinoColors.systemBackground, context)),
                      header: Text("Common"),
                      children: [
                        CupertinoListTile(
                            title: Text("Toggle Color Theme"),
                            trailing: CupertinoSwitch(
                                onChanged: (value) =>
                                    {controller.toggleColorTheme(value)},
                                value: controller.isDarkMode()))
                      ]),
                ))));
  }
}

abstract class SettingsController extends StateNotifier<SettingsModel> {
  SettingsController(SettingsModel state) : super(state);

  bool isDarkMode() {
    return state.brightness == Brightness.dark;
  }

  void toggleColorTheme(bool value);
}
