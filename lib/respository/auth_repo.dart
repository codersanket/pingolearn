import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {
  AuthRepo(this._firebaseAuth, FirebaseFirestore firestore)
      : _collectionReference = firestore.collection("Users");

  final FirebaseAuth _firebaseAuth;
  final CollectionReference _collectionReference;
  User? credential;
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      if (response.user != null) {
        credential = response.user;
        return true;
      }
      return false;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> createUser(
      {required String email,
      required String password,
      required String name}) async {
    try {
      final res = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (res.user != null) {
        credential = res.user;
        await _collectionReference.doc(res.user!.uid).set({"name": name});
        return true;
      }
      return false;
    } catch (e) {
      rethrow;
    }
  }

  Stream<User?> get getCurrentUser => _firebaseAuth.userChanges().distinct();
}
