import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:teslo_shop/features/auth/domain/domain.dart';
import 'package:teslo_shop/features/auth/domain/entities/user.dart';
import 'package:teslo_shop/features/auth/infraestructure/infraestructure.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = AuthRepositoryImpl();

  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;

  AuthNotifier({AuthRepository? authRepository})
      : authRepository = authRepository ?? AuthRepositoryImpl(),
        super(AuthState());

  Future<void> loginUser(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2));

    try {
      final user = await authRepository.login(email, password);
      _setLoggedUser(user);
    } catch (e) {
      logout(errorMessage: e.toString());
    }
  }

  void registerUser(String email, String password) async {}

  void checkAuthStatus() async {}

  _setLoggedUser(User user) {
    state = state.copyWith(user: user, authStatus: AuthStatus.authenticated);
  }

  Future<void> logout({String? errorMessage}) async {
    // TODO: limpiar el token del storage
    state = state.copyWith(
      user: null,
      authStatus: AuthStatus.notAuthenticated,
      errorMessage: errorMessage ?? '',
    );
  }
}

enum AuthStatus {
  checking,
  authenticated,
  notAuthenticated,
}

class AuthState {
  final AuthStatus authStatus;
  final User? user;
  final String errorMessage;

  AuthState(
      {this.authStatus = AuthStatus.checking,
      this.user,
      this.errorMessage = ''});

  AuthState copyWith({
    AuthStatus? authStatus,
    User? user,
    String? errorMessage,
  }) {
    return AuthState(
      authStatus: authStatus ?? this.authStatus,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
