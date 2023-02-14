import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {
  runApp(const MindfulState());
}

class MindfulState extends StatelessWidget {
  const MindfulState({super.key});

  static final _defaultLightColorScheme =
      ColorScheme.fromSwatch(primarySwatch: Colors.pink);
  static final _defaultDarkColorScheme = ColorScheme.fromSwatch(
      primarySwatch: Colors.pink, brightness: Brightness.dark);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(builder: (lightColorScheme, darkColorScheme) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: lightColorScheme ?? _defaultLightColorScheme,
          //colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue),
          // Enable Material 3 (Material You) design.
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          colorScheme: darkColorScheme ?? _defaultDarkColorScheme,
          useMaterial3: true,
        ),
        themeMode: ThemeMode.dark,
        home: const LoginPage(),
      );
    });
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.deepPurple[300],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "welcome to",
              style: TextStyle(
                //color: Colors.white70,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              "mindful state",
              style: TextStyle(
                //color: Colors.white,
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Image.asset('images/notes.png'),
            const SizedBox(
              height: 20.0,
            ),
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
                  //foregroundColor: Colors.white,
                  //backgroundColor: Colors.deepPurple[200],
                  minimumSize: const Size(100, 40)),
              child: const Text('login'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  //foregroundColor: Colors.white,
                  //backgroundColor: Colors.deepPurple[200],
                  minimumSize: const Size(100, 40)),
              child: const Text('sign up'),
            ),
          ],
        ),
      ),
    );
  }
}
