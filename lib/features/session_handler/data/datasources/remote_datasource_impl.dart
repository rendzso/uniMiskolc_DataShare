import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:uni_miskolc_datashare/core/errors/exceptions.dart';
import 'package:uni_miskolc_datashare/core/secure_store/secure_store.dart';
import 'package:uni_miskolc_datashare/features/session_handler/data/datasources/remote_datasource.dart';

class RemoteDataSourceImplementation implements RemoteDataSource {
  final FirebaseAuth auth;
  final SecureStore secureStore;
  final http.Client client;

  RemoteDataSourceImplementation(
      {@required this.secureStore, @required this.auth, @required this.client});
  @override
  Future<FirebaseUser> login({
    @required String email,
    @required String password,
  }) async {
    try {
      final FirebaseUser user = (await auth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
      return user;
    } on PlatformException {
      throw LoginException();
    }
  }

  @override
  Future<bool> logout() async {
    try {
      await auth.signOut();
      return true;
    } on PlatformException {
      throw LogoutException();
    }
  }

  @override
  Future<FirebaseUser> checkIfLoggedIn() async {
    final oldUser = await auth.currentUser();
    if (oldUser == null) {
      throw LoginException();
    } else {
      return oldUser;
    }
  }

  @override
  Future<FirebaseUser> signUp({
    @required String email,
    @required String password,
  }) async {
    try {
      final FirebaseUser newUser = (await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      )).user;
      return newUser;
    } on PlatformException {
      throw SignUpException();
    }
  }
}
