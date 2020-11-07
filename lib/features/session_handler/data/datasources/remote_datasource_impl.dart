import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
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
  var databaseReference = Firestore.instance;

  RemoteDataSourceImplementation(
      {@required this.secureStore,
      @required this.auth,
      @required this.client,
      @required this.databaseReference});
  @override
  Future<FirebaseUser> login({
    @required String email,
    @required String password,
  }) async {
    try {
      final FirebaseUser user = (await auth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
      if (user.isEmailVerified == false) {
        user.sendEmailVerification();
      }
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
      print('checkfrom datasource');
      throw LoginException();
    } else {
      return oldUser;
    }
  }

  Future<void> _waitingForEmailVerification({Completer completer}) async {
    Timer.periodic(Duration(seconds: 3), (timer) async {
      FirebaseUser user = await auth.currentUser();
      user.reload();
      if (user.isEmailVerified == true) {
        timer.cancel();
        completer.complete(user);
      }
    });
  }

  @override
  Future<FirebaseUser> signUp({
    @required String email,
    @required String password,
  }) async {
    Completer completer = new Completer();
    try {
      final FirebaseUser newUser = (await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;
      newUser.sendEmailVerification();
      _waitingForEmailVerification(completer: completer);
      return await completer.future;
    } on PlatformException {
      throw SignUpException();
    }
  }

  @override
  Future<void> waitingForEmailVerification() async {
    Completer completer = new Completer();
    _waitingForEmailVerification(completer: completer);
    return await completer.future;
  }

  Future<bool> resendVerificationEmail() async {
    try {
      final FirebaseUser user = await auth.currentUser();
      user.sendEmailVerification();
      return true;
    } on PlatformException {
      throw EmailResendException();
    }
  }

  @override
  Future<bool> updateUserData({String displayname, String phoneNumber}) async {
    try {
      final FirebaseUser user = await auth.currentUser();
      UserUpdateInfo userUpdateInfo = new UserUpdateInfo();
      if (displayname != 'N/A' && displayname != '') {
        userUpdateInfo.displayName = displayname;
        await user.updateProfile(userUpdateInfo);
        await user.reload();
      }
      return true;
    } on PlatformException {
      throw UserProfileUpdateException();
    }
  }

  @override
  Future<String> checkAccountType({String userUID}) async {
    try {
      final answer = await databaseReference
          .collection('accountType')
          .document(userUID)
          .get();
      final type =
          answer.data != null ? answer.data.entries.first.value : 'null';
      return type;
    } on PlatformException {
      throw CannotCheckAccountTypeException();
    }
  }

  @override
  Future<bool> updateAccountType({String userUID, String type}) async {
    try {
      final requestJSON = {'type': type};
      await databaseReference
          .collection('accountType')
          .document(userUID)
          .setData(requestJSON);
      return true;
    } on PlatformException {
      throw CannotUpdateAccountTypeException();
    }
  }
}
