import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {

  final VoidCallback? onClicked;
  final Widget buttonChild;

  RoundButton({this.onClicked, required this.buttonChild});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onClicked,
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          backgroundColor: Colors.white,
          padding: const EdgeInsets.all(10.0),
        ),
        child: buttonChild
    );
  }
}
