import 'package:firebase_authentication/components/custom_textField.dart';
import 'package:firebase_authentication/controllers/auth_controller.dart';
import 'package:firebase_authentication/database/firebase_service.dart';
import 'package:firebase_authentication/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/custom_elevatedButton.dart';
import '../components/input_container.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {


  TextEditingController userEmail = TextEditingController();
  TextEditingController userPassword = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();


  @override
  Widget build(BuildContext context) {
    String registerError = Provider.of<AuthController>(context).signupError;
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Sign Up',
              style: kTitleTextStyle,
            ),
            InputContainer(
              containerChild: CustomTextField(
                controller: firstName,
                isObscure: false,
                hint: 'FirstName',
              )
            ),
            InputContainer(
                containerChild: CustomTextField(
                  controller: lastName,
                  isObscure: false,
                  hint: 'LastName',
                )
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
            Text(
              registerError,
              style: kErrorTextStyle,
            ),
            const SizedBox(
              height: 30.0,
            ),
            CustomElevatedButton(
              onPress: () async {
                bool isSuccess = await FirebaseService()
                    .signUpWithEmailAndPassword(userEmail.text, userPassword.text);
                if (isSuccess) {
                  Navigator.pushNamed(context, '/homePage');
                  Provider.of<AuthController>(context, listen: false)
                      .deactivateSignupError();
                } else {
                  Provider.of<AuthController>(context, listen: false)
                      .activateSignupError();
                }
              },
             buttonText: 'Sign Up',
            ),
            const SizedBox(
              height: 10.0,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/loginPage');
              },
              child: const Text(
                'Already have an account? Login',
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
