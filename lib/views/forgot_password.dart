import 'package:firebase_authentication/controllers/auth_controller.dart';
import 'package:firebase_authentication/database/firebase_service.dart';
import 'package:firebase_authentication/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/custom_elevatedButton.dart';
import '../components/custom_textField.dart';
import '../components/input_container.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String resetError = Provider.of<AuthController>(context).reset;
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Reset Password',
              style: kTitleTextStyle,
            ),
            InputContainer(
              containerChild: CustomTextField(
                controller: emailController,
                hint: 'Enter your email',
                isObscure: false,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              resetError,
              style: kErrorTextStyle,
            ),
            const SizedBox(
              height: 10.0,
            ),
            CustomElevatedButton(
              onPress: () async {
                bool isSuccess = await FirebaseService()
                    .resetPassword(emailController.text.trim());
                if (isSuccess) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const AlertDialog(
                        content:
                            Text('Password reset link sent. Check your email!'),
                      );
                    },
                  );
                  Provider.of<AuthController>(context, listen: false)
                      .deactivateResetError();
                } else {
                  Provider.of<AuthController>(context, listen: false)
                      .activateResetError();
                }
              },
              buttonText: 'Verify',
            ),
          ],
        ),
      ),
    );
  }
}
