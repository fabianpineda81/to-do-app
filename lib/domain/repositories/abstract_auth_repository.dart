
import 'package:todo_app/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> login(String email, String password);
  Future<UserEntity> loginWithGmail();
  Future<UserEntity> checkAuthStatus();
  Future<void> logOut();
}
