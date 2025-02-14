// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:student_guide/app_colors.dart';
import 'package:student_guide/components/text_fields.dart';
import 'package:student_guide/components/login_button.dart';
import 'package:student_guide/main.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Color buttonColor = Colors.grey; // Default color

  // Future<void> insertrecord() async {
  //   if (idController.text.isNotEmpty && passwordController.text.isNotEmpty) {
  //     try {
  //       String uri = "http://192.168.0.105/student_guide_api/insert_record.php";

  //       var res = await http.post(Uri.parse(uri), body: {
  //         "id": idController.text,
  //         "password": passwordController.text
  //       });
        
  //       var response = jsonDecode(res.body);
  //       if (response["success"] == "true") {
  //         print("Record inserted");
  //       } else {
  //         print("error");
  //       }
  //     } catch (e) {
  //       print(e);
  //     }
  //   } else {
  //     print("Please fill all fields");
  //   }
  // }

  @override
  void initState() {
    super.initState();
    idController.addListener(_updateButtonColor);
    passwordController.addListener(_updateButtonColor);
  }

  @override
  void dispose() {
    idController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _updateButtonColor() {
    setState(() {
      if (idController.text.isNotEmpty &&
          passwordController.text.isNotEmpty) {
        buttonColor = sGbuttonBackground; // Change to desired color when both fields are filled
      } else {
        buttonColor = Colors.grey; // Change to default color when any field is empty
      }
    });
  }

  Future<void> login() async {
    String id = idController.text;
    String password = passwordController.text;

    // Send a request to fetch data from the server
    var response = await http.get(Uri.parse("http://192.168.0.105/student_guide_api/view_data.php"));

    if (response.statusCode == 200) {
      // If the request is successful, parse the JSON response
      var data = jsonDecode(response.body);
      bool credentialsCorrect = false;

      // Check if the entered ID and password match any entry in the database
      for (var entry in data) {
        if (entry['SID'] == id && entry['S_Password'] == password) {
          credentialsCorrect = true;
          break;
        }
      }

      if (credentialsCorrect) {
        // Redirect to the register page if credentials are correct
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MyHomePage(title:'Student Guide')),
        );
      } else {
        // Display pop-up message for invalid ID or password
        String errorMessage = (data.any((entry) => entry['SID'] == id)) ? "Invalid password" : "Invalid ID";
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Login Failed"),
              content: Text(errorMessage),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
      }
    } else {
      // If the request fails, print an error message
      print("Failed to fetch data from server");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: sGbackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 125),
            Image.asset('BUELogo.png', width: 100, height: 100, color: sGiconsColor),
            const SizedBox(height: 25),
            const Text(
              'Welcome back!',
              style: TextStyle(color: sGtitlesColor, fontSize: 30),
            ),
            const SizedBox(height: 25),
            MyTextField(
              controller: idController,
              hintText: 'ID',
            ),
            const SizedBox(height: 10),
            MyTextField(
              controller: passwordController,
              hintText: 'Password',
              obscureText: true,
            ),
            const SizedBox(height: 25),
            LoginButton(
              // onPressed: (){insertrecord();
              onPressed: () {
                login();
              },
              buttonColor: buttonColor, // Pass buttonColor to LoginButton
            ),
          ],
        ),
      ),
    );
  }
}