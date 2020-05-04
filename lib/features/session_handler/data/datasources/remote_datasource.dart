import 'package:firebase_auth/firebase_auth.dart';

abstract class RemoteDataSource {
  Future<FirebaseUser> login({String email, String password});
  Future<bool> logout();
  Future<FirebaseUser> checkIfLoggedIn();
}