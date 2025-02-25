
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/domain/entities/user_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/domain/utils/authentication_method_enum.dart';
import 'package:todo_app/infrastructure/datasource/auth_firebase_datasource_impl.dart';
import 'package:todo_app/infrastructure/repositories/auth_firebase_repository_impl.dart';
import 'package:todo_app/presentation/enums.dart';
import 'package:todo_app/presentation/providers/auth_provider/auth_state.dart';


final authProvider = StateNotifierProvider<AuthNotifier,AuthState>((ref){
  final AuthFirebaseDatasourceImpl authFirebaseDatasourceImpl=AuthFirebaseDatasourceImpl();
  final AuthFirebaseRepositoryImpl authFirebaseRepositoryImpl= AuthFirebaseRepositoryImpl(authDataSource: authFirebaseDatasourceImpl);
  return AuthNotifier(authFirebaseRepositoryImpl: authFirebaseRepositoryImpl);
});

class AuthNotifier extends StateNotifier<AuthState>{
  final AuthFirebaseRepositoryImpl authFirebaseRepositoryImpl;
  AuthNotifier({
    required this.authFirebaseRepositoryImpl
  }):super(AuthState()){
    checkAuthStatus();
  }
  
  void checkAuthStatus() {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        state = state.copyWith(
        authStatus: AuthStatus.notAuthenticated,
        user: null,
        errorMessage: "",
      );
      } else {
        state = state.copyWith(
        authStatus: AuthStatus.authenticated,
        user: UserEntity(
          email: user.email!, 
          method: AuthenticationMethodEnum.gmail, 
          userId: user.uid,
          name: user.displayName??""
          ),
        errorMessage: "",
      );
      }
    });
  }

  Future<void> loginWithGmail() async{
     state = state.copyWith(
        authStatus: AuthStatus.checking,
        user: null,
        errorMessage: "",
      );
    final user=await authFirebaseRepositoryImpl.loginWithGmail();
      state = state.copyWith(
        authStatus: AuthStatus.authenticated,
        user: user,
        errorMessage: "",
      );
    
  }
  Future<void> login(String email,String password)async{
     state = state.copyWith(
        authStatus: AuthStatus.checking,
        user: null,
        errorMessage: "",
      );
    final user=await authFirebaseRepositoryImpl.login(email, password);
      state = state.copyWith(
        authStatus: AuthStatus.authenticated,
        user: user,
        errorMessage: "",
      );
  }
  Future<void> logout()async{
     state = state.copyWith(
        authStatus: AuthStatus.checking,
        errorMessage: "",
      );
      await authFirebaseRepositoryImpl.logOut();
      state = state.copyWith(
        authStatus: AuthStatus.notAuthenticated,
        user: null,
        errorMessage: "",
      );

  }
}

