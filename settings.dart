import 'package:flutter/material.dart';
import 'package:student_guide/app_Colors.dart';
import 'package:student_guide/components/logout_button.dart';
import 'package:student_guide/login.dart';


class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Color buttonColor = sGbuttonBackground; // Default color

  void goToLoginPage(BuildContext context) { // Add BuildContext as a parameter
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: sGbackgroundColor,
      appBar: AppBar(title: const Text('Settings')),
      body:
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            LogoutButton(
            onPressed: () => goToLoginPage(context), // Pass context to the method
            buttonColor: buttonColor,
          ),
        ],
      )
      );
  }
}