// Importing required packages and files
import 'package:flutter/material.dart';
import 'package:mindful_state/services/auth_service.dart';
import 'package:sign_in_button/sign_in_button.dart';
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
            Image.asset('images/login-bw.png', height: imageHeight),
            // implementing the sign in button from the sign_in_button package
            // the onPressed method is used to navigate to the home page
            // perhaps if time allows we can keep the old material3 sign in/up
            // button and handle authentication ourselves in addition to the
            // Google buttons
            SignInButton(
              Buttons.google,
              text: "Sign in with Google",
              onPressed: () {
                AuthService().signInWithgoogle((user) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(user: user),
                    ),
                  );
                });
              },
            ),
            // creating some space between the sign in and sign up buttons
            const SizedBox(
              height: 10,
            ),
            SignInButton(
              Buttons.google,
              text: "BYPASS SIGN IN",
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const HomePage(
                        user: null,
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
