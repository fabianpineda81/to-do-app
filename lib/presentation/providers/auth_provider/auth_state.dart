import 'package:todo_app/domain/entities/user_entity.dart';
import 'package:todo_app/presentation/enums.dart';

class AuthState {
    final AuthStatus authStatus;
    final UserEntity? user;
    final String errorMessage;

  AuthState({
     this.authStatus= AuthStatus.checking, 
     this.user, 
     this.errorMessage=""
    });

     AuthState copyWith({
    AuthStatus? authStatus,
    UserEntity? user,
    String? errorMessage
  }) => AuthState(
    authStatus: authStatus ?? this.authStatus,
    user: user ?? this.user,
    errorMessage: errorMessage ?? this.errorMessage,
  );
}