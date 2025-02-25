import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/presentation/providers/auth_provider/auth_provider.dart';

final loginProvider = StateNotifierProvider<LoginNotifier,LoginState>((ref){
  final loginUserCallback= ref.read(authProvider.notifier).login;
  final loginWithGmail= ref.read(authProvider.notifier).loginWithGmail; 
  return LoginNotifier(
    loginUserCallback: loginUserCallback,
    loginUserWithGmailCallback: loginWithGmail
  );
});

class LoginNotifier  extends StateNotifier<LoginState> {
   final Function(String, String) loginUserCallback;
   final Function() loginUserWithGmailCallback;
  LoginNotifier({
    required this.loginUserCallback,
    required this.loginUserWithGmailCallback
    }): super(LoginState());

     loginUserWithGmail(){
      loginUserWithGmailCallback();
     }
  
}

class LoginState {
  final bool isPosting ;

  LoginState({ 
    this.isPosting=false 
    }); 

    LoginState copyWith({
      bool? isPosting,
    })=>LoginState(
      isPosting: isPosting ?? this.isPosting,
    );
}