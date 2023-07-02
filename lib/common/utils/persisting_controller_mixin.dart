import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/common/services/persistence/persistence_service.dart';

mixin PersistingControllerMixin<T> on StateNotifier<T> {
  Future<dynamic> persistUpdate(T updated);

  PersistenceService get persistence;

  @override
  set state(T value) {
    super.state = value;
    persistUpdate(value);
  }
}
