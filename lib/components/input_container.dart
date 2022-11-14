import 'package:firebase_authentication/utils/constants.dart';
import 'package:flutter/material.dart';

class InputContainer extends StatelessWidget {
  final Widget? containerChild;

  InputContainer({required this.containerChild});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: kContainerMargin),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.0)
      ),
      child: containerChild,
    );
  }
}
