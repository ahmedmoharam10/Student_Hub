import 'package:flutter/material.dart';
import 'package:student_guide/app_colors.dart';
import 'package:student_guide/settings.dart';
import 'package:student_guide/office_hours.dart';
import 'package:student_guide/room_guide.dart';
import 'package:student_guide/staff_information.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Guide',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: sGbackgroundColor),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Student Guide'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isSettingsPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: sGbackgroundColor,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('sGbackground.png'), // Adjust the path as needed
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // Student Guide Image
            Positioned(
              top: MediaQuery.of(context).size.height * 0.1, // Adjust positioning here
              left: 0,
              right: 0,
              child: Center(
                child: Image.asset(
                  'sG.png', // Replace with the correct image name
                  height: 100, // Adjust the height as needed
                ),
              ),
            ),
            Positioned.fill(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FloatingActionButton.extended(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      StaffInformationPage(),
                                ),
                              );
                            },
                            label: const Text('Staff Information',
                                style: TextStyle(
                                    fontFamily: 'San Francisco',
                                    fontWeight: FontWeight.bold,
                                    color: sGbuttonText)),
                            backgroundColor: sGbuttonBackground,
                          ),
                          const SizedBox(height: 20),
                          FloatingActionButton.extended(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const OfficeHoursPage(),
                                ),
                              );
                            },
                            label: const Text('Office Hours',
                                style: TextStyle(
                                    fontFamily: 'San Francisco',
                                    fontWeight: FontWeight.bold,
                                    color: sGbuttonText)),
                            backgroundColor: sGbuttonBackground,
                          ),
                          const SizedBox(height: 20),
                          FloatingActionButton.extended(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RoomGuidePage(),
                                ),
                              );
                            },
                            label: const Text('Room Guide',
                                style: TextStyle(
                                    fontFamily: 'San Francisco',
                                    fontWeight: FontWeight.bold,
                                    color: sGbuttonText)),
                            backgroundColor: sGbuttonBackground,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // "Settings" Icon
            Positioned(
              bottom: 30,
              right: 30,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isSettingsPressed = !isSettingsPressed;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsPage(),
                    ),
                  );
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  width: isSettingsPressed ? 35 : 30,
                  height: isSettingsPressed ? 35 : 30,
                  child: Transform.rotate(
                    angle: isSettingsPressed ? math.pi * 1.5 : 0,
                    child: Image.asset(
                      'SettingsIcon.png',
                      width: 30,
                      height: 30,
                      color: sGiconsColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
