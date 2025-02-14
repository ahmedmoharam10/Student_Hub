import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final VoidCallback onPressed;
  final Color buttonColor;

   const Button({
    required this.onPressed,
    required this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text('Sign In'),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
      ),
    );
  }
}