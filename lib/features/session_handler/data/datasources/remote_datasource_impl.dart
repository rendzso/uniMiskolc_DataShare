import 'package:firebase_auth/firebase_auth.dart';
import 'package:uni_miskolc_datashare/features/session_handler/data/datasources/remote_datasource.dart';

class RemoteDataSourceImplementation implements RemoteDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Future<bool> login(String email, String pass) async {
    final user =
        await _auth.signInWithEmailAndPassword(email: email, password: pass);
    print(user.user);
  }

  @override
  Future<bool> logout() {
    // TODO: implement logout
    return null;
  }
}
