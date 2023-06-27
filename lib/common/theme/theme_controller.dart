import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/common/theme/custom_theme_data.dart';

class ThemeControllerImpl extends ThemeController {
  ThemeControllerImpl({required int index}) : super(selectableThemes[index]);
}

abstract class ThemeController extends StateNotifier<CustomThemeData> {
  ThemeController(CustomThemeData theme) : super(theme);
}
