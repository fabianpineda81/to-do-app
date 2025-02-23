import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_app/domain/datasource/abstract_auth_datasource.dart';
import 'package:todo_app/domain/entities/user_entity.dart';
import 'package:todo_app/domain/utils/authentication_method_enum.dart';

class AuthFirebaseDatasourceImpl extends AuthDataSource{
  @override
  Future<UserEntity> checkAuthStatus() {
    throw UnimplementedError();
  }

  @override
  Future<void> logOut() async  {
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().disconnect();
  }

  @override
  Future<UserEntity> login(String email, String password) {
  
    throw UnimplementedError();
  }

  @override
  Future<UserEntity> loginWithGmail() async {
     // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  final UserCredential userCredential= await FirebaseAuth.instance.signInWithCredential(credential);

  return UserEntity(
    email: userCredential.user!.email!, 
    method:AuthenticationMethodEnum.gmail , 
    userId: userCredential.user!.uid,
    name: userCredential.user!.displayName??""
    );
  }
  


}