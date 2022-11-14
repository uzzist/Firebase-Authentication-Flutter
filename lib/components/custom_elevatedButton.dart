import 'package:flutter/material.dart';
import '../utils/constants.dart';

class CustomElevatedButton extends StatelessWidget {

  final VoidCallback onPress;
  final String buttonText;

  CustomElevatedButton({required this.onPress, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(kButtonColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0)
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          buttonText,
          style: const TextStyle(color: Colors.blue, fontSize: 20.0),
        ),
      ),
    );
  }
}
