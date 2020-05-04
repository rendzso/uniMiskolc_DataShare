import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'secure_store.dart';


class SecureStoreImplementation implements SecureStore {
  final FlutterSecureStorage storage;

  SecureStoreImplementation({@required this.storage});

  @override
  Future<Null> deleteToken() async {
    await storage.delete(key: 'TOKEN');
  }

  @override
  Future<String> getToken() async {
    return await storage.read(key: 'TOKEN');
  }

  @override
  Future<Null> saveToken(String token) async {
    await storage.write(key: 'TOKEN', value: token);
  }

  @override
  Future<String> getKeyValue(String key) async {
    return await storage.read(key: key);
  }

  @override
  Future<Null> saveKeyValue(String key, String value) async {
    await storage.write(key: key, value: value);
  }
}
