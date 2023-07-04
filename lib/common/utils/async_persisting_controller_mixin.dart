import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/common/provider.dart';
import '/common/services/persistence/persistence_service.dart';

mixin AsyncPersistingControllerMixin<State, Arg>
    on FamilyAsyncNotifier<State?, Arg> {
  PersistenceService? _service;

  Future<dynamic> persistUpdate(State updated);

  PersistenceService get persistence {
    if (_service == null) {
      _setService();
    }
    return _service!;
  }

  void _setService() =>
      _service = ref.watch(Providers.persistenceServiceProvider);

  void updateState(State Function(State) update) {
    state = state.whenData(
      (value) {
        if (value == null) {
          return value;
        }
        final State updated = update(value);
        persistUpdate(updated);
        return updated;
      },
    );
  }
}

// The same logic has to be coped to the async version of the mixin
// since dart does not support multiple inheritance
mixin AutoDisposeAsyncPersistingControllerMixin<State, Arg>
    on AutoDisposeFamilyAsyncNotifier<State?, Arg> {
  PersistenceService? _service;

  Future<dynamic> persistUpdate(State updated);

  PersistenceService get persistence {
    if (_service == null) {
      _setService();
    }
    return _service!;
  }

  void _setService() =>
      _service = ref.watch(Providers.persistenceServiceProvider);

  Future<void> updateState(State Function(State) update) async {
    state = state.whenData(
      (value) {
        if (value == null) {
          return value;
        }
        final State updated = update(value);
        persistUpdate(updated);
        return updated;
      },
    );
    // read overwritten state to ensure function does not return when waited for
    await future;
  }
}
