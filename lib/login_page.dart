// Importing required packages and files
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'home_page.dart';

// The entry point of the application
void main() {
  // Running the MindfulState widget as the root of the application
  runApp(const MindfulState());
}

// Defining the MindfulState widget as a stateless widget
class MindfulState extends StatelessWidget {
  // Constructor for the MindfulState widget
  const MindfulState({super.key});

  // Building the widget tree for the MindfulState widget
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginPage(),
    );
  }
}

// Defining the LoginPage widget as a stateless widget
class LoginPage extends StatelessWidget {
  // Constructor for the LoginPage widget
  const LoginPage({super.key});

  // Building the widget tree for the LoginPage widget
  @override
  Widget build(BuildContext context) {
    final double imageHeight = MediaQuery.of(context).size.height * 0.4;
    // Creating a scaffold widget and centering its child
    return Scaffold(
      body: Center(
        // Creating a column widget to display welcome message, image and buttons
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "mindful state",
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            // Displaying an image from the assets folder
            Image.asset('images/login-bw.png', height: imageHeight),
            const SizedBox(
              height: 20.0,
            ),
            // Creating an elevated button to navigate to the home page
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const HomePage();
                    },
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(100, 40),
              ),
              child: const Text('login'),
            ),
            // Creating an elevated button for signing up
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(100, 40),
              ),
              child: const Text('sign up'),
            ),
          ],
        ),
      ),
    );
  }
}
