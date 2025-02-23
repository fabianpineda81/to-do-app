import 'package:flutter/material.dart';
import 'package:todo_app/presentation/widgets/full_screen_loader.dart';


class SplashPage extends StatelessWidget {
  const SplashPage({super.key});
  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      body: FullScreenLoader(),
    );
  }
}
