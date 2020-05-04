abstract class RemoteDataSource {
  Future<bool> login(String email, String pass);
  Future<bool> logout();
}