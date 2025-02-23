

import 'package:todo_app/domain/entities/user_entity.dart';

abstract class AuthDataSource {
  AuthDataSource();
  Future<UserEntity> login(String email, String password);
  Future<UserEntity> loginWithGmail();
  Future<UserEntity> checkAuthStatus();
  Future<void> logOut();
}
