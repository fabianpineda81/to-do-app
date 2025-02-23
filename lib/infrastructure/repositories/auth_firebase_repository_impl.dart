import 'package:todo_app/domain/datasource/abstract_auth_datasource.dart';
import 'package:todo_app/domain/entities/user_entity.dart';
import 'package:todo_app/domain/repositories/abstract_auth_repository.dart';


class AuthFirebaseRepositoryImpl extends AuthRepository {
  final AuthDataSource authDataSource;

  AuthFirebaseRepositoryImpl({required this.authDataSource});

  @override
  Future<UserEntity> checkAuthStatus() {
    return authDataSource.checkAuthStatus();
    
  }

  @override
  Future<void> logOut() {
    return authDataSource.logOut();
  }

  @override
  Future<UserEntity> login(String email, String password) {
    return authDataSource.login(email, password);
  }

  @override
  Future<UserEntity> loginWithGmail() {
    return authDataSource.loginWithGmail();
  }

}