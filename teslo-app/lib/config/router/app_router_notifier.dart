import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/auth/presentation/providers/auth_provider.dart';

final goRouterNotifierProvider = Provider((ref) {
  final authNotifier = ref.read(authProvider.notifier);
  return GoRouterNotifier(authNotifier);
});

class GoRouterNotifier extends ChangeNotifier {
  final AuthNotifier _authNotifier;

  AuthStatus _authState = AuthStatus.checking;

  GoRouterNotifier(this._authNotifier) {
    _authNotifier.addListener((state) {
      authState = state.authStatus;
    });
  }

  AuthStatus get authState => _authState;

  set authState(AuthStatus state) {
    if (state != _authState) {
      _authState = state;
      notifyListeners();
    }
  }
}
