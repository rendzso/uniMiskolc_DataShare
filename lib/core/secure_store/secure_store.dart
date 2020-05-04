abstract class SecureStore {
  Future<Null> saveToken(String token);
  Future<String> getToken();
  Future<Null> deleteToken();
  Future<Null> saveKeyValue(String key, String value);
  Future<String> getKeyValue(String key);
}
