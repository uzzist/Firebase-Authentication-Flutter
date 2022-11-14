import 'package:firebase_authentication/components/input_container.dart';
import 'package:firebase_authentication/database/firebase_service.dart';
import 'package:firebase_authentication/utils/constants.dart';
import 'package:flutter/material.dart';
import '../components/custom_elevatedButton.dart';
import '../components/custom_textField.dart';

class PhoneLogin extends StatefulWidget {
  const PhoneLogin({Key? key}) : super(key: key);

  @override
  State<PhoneLogin> createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {

  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Phone Login',
              style: kTitleTextStyle,
            ),
            InputContainer(
              containerChild: CustomTextField(
                controller: phoneController,
                hint: 'Phone No.',
                isObscure: false,
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            CustomElevatedButton(
              onPress: () async {
                await FirebaseService().verifyNumber(phoneController.text.trim(), context);
              },
              buttonText: 'Login',
            ),
          ],
        ),
      ),
    );
  }
}
