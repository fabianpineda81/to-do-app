import 'package:todo_app/domain/utils/authentication_method_enum.dart';

class UserEntity {
  String userId; 
  String email;
  String name; 
  AuthenticationMethodEnum method; 

  UserEntity({
    required this.email,
    required this.method,
    required this.userId,
    required this.name
  });
}