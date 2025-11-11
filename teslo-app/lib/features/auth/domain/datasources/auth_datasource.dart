import 'package:teslo_shop/features/auth/domain/entities/user.dart';

abstract class AuthDatasource {
  Future<User> login(String username, String password);
  Future<User> register(String email, String password, String fullName);
  Future<User> checkAuthStatus(String token);
}
