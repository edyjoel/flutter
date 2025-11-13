import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:teslo_shop/features/auth/domain/domain.dart';
import 'package:teslo_shop/features/auth/domain/entities/user.dart';
import 'package:teslo_shop/features/auth/infraestructure/infraestructure.dart';
import 'package:teslo_shop/features/shared/infraestructure/services/key_value_storage_service.dart';
import 'package:teslo_shop/features/shared/infraestructure/services/key_value_storage_service_impl.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = AuthRepositoryImpl();
  final keyValueStorageService = KeyValueStorageServiceImpl();

  return AuthNotifier(
      authRepository: authRepository,
      keyValueStorageService: keyValueStorageService);
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;
  final KeyValueStorageService keyValueStorageService;

  AuthNotifier(
      {AuthRepository? authRepository,
      KeyValueStorageService? keyValueStorageService})
      : authRepository = authRepository ?? AuthRepositoryImpl(),
        keyValueStorageService =
            keyValueStorageService ?? KeyValueStorageServiceImpl(),
        super(AuthState()) {
    checkAuthStatus();
  }

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

  void checkAuthStatus() async {
    final token = await keyValueStorageService.getKeyValue<String>('token');

    if (token == null) {
      logout();
      return;
    }

    try {
      final user = await authRepository.checkAuthStatus(token);
      _setLoggedUser(user);
    } catch (e) {
      logout();
    }
  }

  _setLoggedUser(User user) async {
    await keyValueStorageService.setKeyValue('token', user.token);
    state = state.copyWith(
        user: user, authStatus: AuthStatus.authenticated, errorMessage: '');
  }

  Future<void> logout({String? errorMessage}) async {
    await keyValueStorageService.removeKey('token');
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
