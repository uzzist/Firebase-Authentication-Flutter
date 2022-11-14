import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseService {
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();
  TextEditingController codeController = TextEditingController();

  signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn
          .signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount
            .authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        await _auth.signInWithCredential(credential);
      }
    } on FirebaseAuthException catch (e) {

    }
  }

  googleSignOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

  signUpWithEmailAndPassword(String userEmail, String userPassword) async {
    try {
      final newUser = await _auth.createUserWithEmailAndPassword(email: userEmail, password: userPassword);
      return true;
    } catch (e) {
      return false;
    }
  }

  loginWithEmailAndPassword(String userEmail, String userPassword) async {
    try {
      final newUser = await _auth.signInWithEmailAndPassword(email: userEmail, password: userPassword);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future verifyNumber(String number, BuildContext context) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: number,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential).then(
              (value) {
                Navigator.pushNamed(context, '/homePage');
          },
        );
      },
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? token) async {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: const Center(
              child: Text('Enter OTP'),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: codeController,
                  decoration: const InputDecoration(hintText: 'Enter OTP'),
                )
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () async {
                  PhoneAuthCredential credential =
                  PhoneAuthProvider.credential(
                    verificationId: verificationId,
                    smsCode: codeController.text.trim(),
                  );
                  await _auth.signInWithCredential(credential).then(
                        (value) {
                          Navigator.pushNamed(context, '/homePage');
                    },
                  );
                },
                child: const Text('Login'),
              )
            ],
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        verificationId = verificationId;
      },
    );
  }

  Future resetPassword(String userEmail) async {
    try {
      await _auth.sendPasswordResetEmail(email: userEmail);
      return true;
    } on FirebaseAuthException catch (e) {
      return false;
    }
  }

}