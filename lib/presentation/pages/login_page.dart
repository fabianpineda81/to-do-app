import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:todo_app/presentation/providers/login_provider.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context,ref) {
   
    return  Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SignInButton(
              Buttons.Google,
              onPressed: () {
                ref.read(loginProvider.notifier).loginUserWithGmail();    
                },
              ),
          ),
        ],
      )
    );
  }
 
}