import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:uni_miskolc_datashare/core/errors/exceptions.dart';
import 'package:uni_miskolc_datashare/features/session_handler/data/datasources/remote_datasource.dart';

class RemoteDataSourceImplementation implements RemoteDataSource {
  final FirebaseAuth auth = FirebaseAuth.instance;
  /* final SecureStore secureStore;

  RemoteDataSourceImplementation({@required this.secureStore, @required this.auth}); */
  @override
  Future<FirebaseUser> login({
    @required String email,
    @required String password,
  }) async {
    try {
      final FirebaseUser user = (await auth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
      print(user);
      return user;
    } on PlatformException {
      throw LoginException();
    }
  }

  @override
  Future<bool> logout() {
    // TODO: implement logout
    return null;
  }
}
