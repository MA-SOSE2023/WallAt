import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/common/provider.dart';
import '/common/theme/custom_theme_data.dart';

class CustomFormSection extends ConsumerWidget {
  const CustomFormSection({required List<Widget> children, Key? key})
      : _children = children,
        super(key: key);

  final List<Widget> _children;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CustomThemeData theme = ref.watch(Providers.themeControllerProvider);
    return CupertinoFormSection.insetGrouped(
      backgroundColor: Colors.transparent,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      children: _children,
    );
  }
}
