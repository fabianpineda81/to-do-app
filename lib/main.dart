import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/config/app_theme.dart';
import 'package:todo_app/config/router/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child:  MainApp()
    )
    
    );
    


  
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});
  

  @override
  Widget build(BuildContext context,ref) {
     bool isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
     final appRouter = ref.watch(goRouterProvider);
      return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      theme: AppTheme(isDarkMode).getTheme(),
    );
    
  }

}
