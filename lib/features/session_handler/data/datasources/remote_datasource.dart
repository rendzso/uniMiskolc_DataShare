import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

abstract class RemoteDataSource {
  Future<FirebaseUser> login({
    @required String email,
    @required String password,
  });

  Future<bool> logout();

  Future<FirebaseUser> checkIfLoggedIn();

  Future<FirebaseUser> signUp({
    @required String email,
    @required String password,
  });

  Future<void> waitingForEmailVerification();

  Future<bool> resendVerificationEmail();

  Future<bool> updateUserData({String displayname, String phoneNumber});

  Future<String> checkAccountType({String userUID, @required String fcmToken});

  Future<bool> updateAccountType({String userUID, String type});
}
