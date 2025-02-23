import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/config/router/app_router_notifier.dart';
import 'package:todo_app/config/router/app_routes.dart';
import 'package:todo_app/presentation/pages/login_page.dart';
import 'package:todo_app/presentation/pages/splash_page.dart';
import 'package:todo_app/presentation/pages/todo_page.dart';
import 'package:todo_app/presentation/providers/auth_provider.dart';

final goRouterProvider = Provider((ref) {
  final goRouterNotifier= ref.watch(goRouterNotifierProvider);
 return GoRouter(
  initialLocation: AppRoutesEnum.splash.path,
  refreshListenable: goRouterNotifier,
  routes: [
      GoRoute(
        path: AppRoutesEnum.splash.path,
        builder: (context, state) => const SplashPage(),
      ),
    GoRoute(
      path: AppRoutesEnum.login.path,
      builder: (context, state) => const LoginPage() ,
    ),
    GoRoute(
      path: AppRoutesEnum.todos.path,
      builder: (context, state) {
        return  const TodoPage();
      }
    )
  ],
  redirect: (context, state) {
    final goInto = state.fullPath!;
    final authStatus = goRouterNotifier.authStatus;
    if(authStatus== AuthStatus.checking){
      return AppRoutesEnum.splash.path;
    }


     if (authStatus == AuthStatus.notAuthenticated) {
        if (goInto == AppRoutesEnum.login.path ) {
          return null;
        }
        return AppRoutesEnum.login.path;
      }

      if(authStatus == AuthStatus.authenticated && (goInto== AppRoutesEnum.splash.path || goInto==AppRoutesEnum.login.path)){
          return AppRoutesEnum.todos.path;
      }


    
    return null;
  },
);  
});
