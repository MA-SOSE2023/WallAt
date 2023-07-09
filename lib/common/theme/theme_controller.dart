import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/common/localization/language.dart';
import '/common/theme/custom_theme_data.dart';

class ThemeControllerImpl extends ThemeController {
  ThemeControllerImpl({required int index, required Language language})
      : super(selectableThemes(language)[index]);
}

abstract class ThemeController extends StateNotifier<CustomThemeData> {
  ThemeController(CustomThemeData theme) : super(theme);
}
