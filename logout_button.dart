import 'package:flutter/material.dart';

class LogoutButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Color buttonColor;

  const LogoutButton({
    Key? key,
    required this.onPressed,
    required this.buttonColor,
  }) : super(key: key);

  @override
  State<LogoutButton> createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<LogoutButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    const text = "Logout"; // Change text accordingly
    const textLength = text.length;
    const buttonWidth = textLength * 10.0 + 60; // Adjust multiplier and constant as needed

    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTapDown: (_) {
          setState(() {
            _isPressed = true;
          });
        },
        onTapUp: (_) {
          setState(() {
            _isPressed = false;
          });
          widget.onPressed();
        },
        onTapCancel: () {
          setState(() {
            _isPressed = false;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: buttonWidth,
          padding: _isPressed
              ? const EdgeInsets.symmetric(vertical: 12, horizontal: 28)
              : const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          margin: const EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
            color: widget.buttonColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: _isPressed
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: const Center(
            child: Text(
              "Logout", // Change text accordingly
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
