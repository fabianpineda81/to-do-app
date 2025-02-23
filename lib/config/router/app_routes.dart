
enum AppRoutesEnum {
  login,
  todos,
  splash,

}

extension AppRoutesEnumExtension on AppRoutesEnum {
  String get path {
    switch(this) {  
      case AppRoutesEnum.splash: return '/splash';
      case AppRoutesEnum.login: return '/login';
      case AppRoutesEnum.todos: return '/todos';
      
    }
  }
}