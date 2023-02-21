// Importing required packages and files
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
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

  // Defining the default light color scheme for the app
  static final _defaultLightColorScheme =
      ColorScheme.fromSwatch(primarySwatch: Colors.pink);

  // Defining the default dark color scheme for the app
  static final _defaultDarkColorScheme = ColorScheme.fromSwatch(
      primarySwatch: Colors.pink, brightness: Brightness.dark);

  // Building the widget tree for the MindfulState widget
  @override
  Widget build(BuildContext context) {
    // Using DynamicColorBuilder to dynamically generate light and dark color schemes based on device settings
    return DynamicColorBuilder(builder: (lightColorScheme, darkColorScheme) {
      // Creating the MaterialApp widget and setting its properties
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: lightColorScheme ?? _defaultLightColorScheme,
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          colorScheme: darkColorScheme ?? _defaultDarkColorScheme,
          useMaterial3: true,
        ),
        themeMode: ThemeMode.light,
        home: const LoginPage(),
      );
    });
  }
}

// Defining the LoginPage widget as a stateless widget
class LoginPage extends StatelessWidget {
  // Constructor for the LoginPage widget
  const LoginPage({super.key});

  // Building the widget tree for the LoginPage widget
  @override
  Widget build(BuildContext context) {
    // Creating a scaffold widget and centering its child
    return Scaffold(
      body: Center(
        // Creating a column widget to display welcome message, image and buttons
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "welcome to",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
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
            Image.asset('images/notes.png'),
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
