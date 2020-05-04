import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:uni_miskolc_datashare/core/errors/exceptions.dart';
import 'package:uni_miskolc_datashare/features/session_handler/data/datasources/remote_datasource.dart';

class RemoteDataSourceImplementation implements RemoteDataSource {
  final FirebaseAuth auth = FirebaseAuth.instance;
  /* final SecureStore secureStore;

  RemoteDataSourceImplementation({@required this.secureStore, @required this.auth}); */
  @override
  Future<bool> login({String email, String password}) async {
    try {
      final FirebaseUser user =
          (await auth.signInWithEmailAndPassword(email: email, password: password)).user;
      return true;
    } on AuthException {
      throw LoginException();
    }
  }

  @override
  Future<bool> logout() {
    // TODO: implement logout
    return null;
  }
}
