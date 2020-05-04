abstract class RemoteDataSource {
  Future<bool> login({String email, String password});
  Future<bool> logout();
}