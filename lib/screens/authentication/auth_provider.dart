import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pingolearn/app/modal_helper.dart';
import 'package:pingolearn/respository/auth_repo.dart';

enum UserStatus { loggedIn, loggedOut, initial }

class AuthProvider extends ChangeNotifier {
  final AuthRepo _authRepo;
  final ModalHelper _modal;
  AuthProvider(this._authRepo, this._modal) {
    _authRepo.getCurrentUser.listen(
      (event) {
        if (event != null) {
          userStatus = UserStatus.loggedIn;
        } else {
          userStatus = UserStatus.loggedOut;
        }
      },
    );
  }

  final GlobalKey<FormState> key = GlobalKey<FormState>();

  bool _isRegistering = false;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  bool get isRegistering => _isRegistering;

  set isRegistering(bool val) {
    _isRegistering = val;
    notifyListeners();
  }

  void onRichTextClick() {
    _isRegistering = !_isRegistering;
    notifyListeners();
  }

  String _email = '';
  String _password = '';
  String _name = '';

  set email(String val) => _email = val;

  set password(String val) => _password = val;

  set name(String val) => _name = val;

  Future<void> _login() async {
    try {
      await _authRepo.login(email: _email, password: _password);
    } on FirebaseAuthException catch (e) {
      _modal.showSnackBar(e.message.toString());
    }
  }

  Future<void> _register() async {
    try {
      await _authRepo.createUser(
          email: _email, password: _password, name: _name);
    } on FirebaseAuthException catch (e) {
      _modal.showSnackBar(e.message.toString());
    }
  }

  Future onClick() async {
    if (key.currentState!.validate()) {
      isLoading = true;
      if (isRegistering) {
        await _register();
      } else {
        await _login();
      }
      isLoading = false;
    }
  }

  UserStatus _userStatus = UserStatus.initial;

  UserStatus get userStatus => _userStatus;

  set userStatus(UserStatus value) {
    _userStatus = value;
    notifyListeners();
  }
}
