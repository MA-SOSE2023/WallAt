import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/common/provider.dart';
import '/common/services/persistence/persistence_service.dart';

mixin PersistingControllerMixin<T, A> on AutoDisposeFamilyAsyncNotifier<T?, A> {
  PersistenceService? _service;

  Future<dynamic> persistUpdate(T updated);

  PersistenceService get persistence {
    if (_service == null) {
      _setService();
    }
    return _service!;
  }

  void _setService() =>
      _service = ref.watch(Providers.persistenceServiceProvider);

  void updateState(T Function(T) update) {
    state = state.whenData(
      (value) {
        if (value == null) {
          return value;
        }
        final T updated = update(value);
        persistUpdate(updated);
        return updated;
      },
    );
  }
}
