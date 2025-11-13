import 'package:teslo_shop/config/constants/environment.dart';
import 'package:teslo_shop/features/auth/domain/datasources/auth_datasource.dart';
import 'package:teslo_shop/features/auth/domain/entities/user.dart';

import 'package:dio/dio.dart';
import 'package:teslo_shop/features/auth/infraestructure/errors/auth_errors.dart';
import 'package:teslo_shop/features/auth/infraestructure/mappers/user_mapper.dart';

class AuthDatasourceImpl implements AuthDatasource {
  final dio = Dio(BaseOptions(
    baseUrl: Environment.apiUrl,
  ));

  @override
  Future<User> login(String email, String password) async {
    try {
      final response = await dio.post('/auth/login', data: {
        'email': email,
        'password': password,
      });

      final user = UserMapper.userJsonToEntity(response.data);
      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw WrongCredentials();
      }

      if (e.type == DioExceptionType.connectionTimeout) {
        throw ConnectionTimeout();
      }

      throw CustomError('Error ${e.response?.statusCode ?? ''}: ${e.message}',
          errorCode: e.response?.statusCode ?? 0);
    } catch (e) {
      throw CustomError('Unexpected error: $e');
    }
  }

  @override
  Future<User> register(String email, String password, String fullName) {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  Future<User> checkAuthStatus(String token) async {
    try {
      final response = await dio.get('/auth/check-status',
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      final user = UserMapper.userJsonToEntity(response.data);
      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw WrongCredentials();
      }

      if (e.type == DioExceptionType.connectionTimeout) {
        throw ConnectionTimeout();
      }

      throw CustomError('Error ${e.response?.statusCode ?? ''}: ${e.message}',
          errorCode: e.response?.statusCode ?? 0);
    } catch (e) {
      throw CustomError('Unexpected error: $e');
    }
  }
}
