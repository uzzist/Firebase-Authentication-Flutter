import 'package:flutter/cupertino.dart';

class AuthController extends ChangeNotifier {
  String error = "";
  String signupError = "";
  String reset = "";

  void activateError() {
    error = "Error Logging In";
    notifyListeners();
  }

  void deactivateError() {
    error = "";
    notifyListeners();
  }

  void activateSignupError() {
    signupError = "Error creating account";
    notifyListeners();
  }

  void deactivateSignupError() {
    signupError = "";
    notifyListeners();
  }

  void activateResetError() {
    reset = "An error occurred while sending a link";
    notifyListeners();
  }

  void deactivateResetError() {
    reset = "";
    notifyListeners();
  }
}