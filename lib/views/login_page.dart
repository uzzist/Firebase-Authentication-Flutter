import 'package:firebase_authentication/components/input_container.dart';
import 'package:firebase_authentication/controllers/auth_controller.dart';
import 'package:firebase_authentication/database/firebase_service.dart';
import 'package:firebase_authentication/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/custom_elevatedButton.dart';
import '../components/round_button.dart';
import 'package:firebase_authentication/components/custom_textField.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController userEmail = TextEditingController();
  TextEditingController userPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String loginError = Provider.of<AuthController>(context).error;
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Login',
              style: kTitleTextStyle,
            ),
            InputContainer(
              containerChild: CustomTextField(
                controller: userEmail,
                hint: 'Email',
                isObscure: false,
              ),
            ),
            InputContainer(
              containerChild: CustomTextField(
                controller: userPassword,
                hint: 'Password',
                isObscure: true,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/forgotPassword');
              },
              child: const Text(
                'Forgot Password',
                textAlign: TextAlign.end,
                style: TextStyle(fontSize: 15.0, color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              loginError,
              style: const TextStyle(color: Colors.red, fontSize: 15.0),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RoundButton(
                  onClicked: () {
                    Navigator.pushNamed(context, '/phoneLogin');
                  },
                  buttonChild: const Icon(
                    Icons.phone,
                    size: 25.0,
                    color: Colors.blue,
                  ),
                ),
                RoundButton(
                  onClicked: () async {
                    await FirebaseService().signInWithGoogle();
                    Navigator.pushNamed(context, '/homePage');
                  },
                  buttonChild: const Icon(
                    Icons.email,
                    size: 25.0,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30.0,
            ),
            CustomElevatedButton(
              onPress: () async {
                bool isSuccess = await FirebaseService()
                    .loginWithEmailAndPassword(userEmail.text, userPassword.text);
                if (isSuccess) {
                  Navigator.pushNamed(context, '/homePage');
                  Provider.of<AuthController>(context, listen: false)
                      .deactivateError();
                } else {
                  Provider.of<AuthController>(context, listen: false)
                      .activateError();
                }
              },
              buttonText: 'Login',
            ),
            const SizedBox(
              height: 10.0,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/signupPage');
              },
              child: const Text(
                'Don\'t have an account? Sign Up',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15.0, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
