import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:dynamic_color/dynamic_color.dart';

import 'login_page.dart';

void main() {
  runApp(const MindfulState());
}

class MindfulState extends StatelessWidget {
  const MindfulState({Key? key}) : super(key: key);

  static final _defaultLightColorScheme =
      ColorScheme.fromSwatch(primarySwatch: Colors.pink);
  static final _defaultDarkColorScheme = ColorScheme.fromSwatch(
      primarySwatch: Colors.pink, brightness: Brightness.dark);

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightColorScheme, darkColorScheme) {
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
          themeMode: ThemeMode.dark,
          home: IntroductionPage(),
        );
      },
    );
  }
}

class IntroductionPage extends StatelessWidget {
  IntroductionPage({Key? key}) : super(key: key);

  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => const LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: TextStyle(fontSize: 19.0),
      //descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      imagePadding: EdgeInsets.zero,
    );
    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "Welcome to Mindful State!",
          body: "Our app helps you stay mindful throughout the day.",
          image: Center(child: Image.asset('images/notes.png', height: 250.0)),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Track Your Progress",
          body:
              "Record your daily meditation sessions and track your progress over time.",
          image: Center(child: Image.asset('images/notes.png', height: 250.0)),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Improve Your Focus",
          body:
              "Learn to focus your mind and improve your mental clarity with our guided meditations.",
          image: Center(child: Image.asset('images/notes.png', height: 250.0)),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      done: const Text("Let's get started!",
          style: TextStyle(fontWeight: FontWeight.w600)),
      showSkipButton: true,
      skip: const Text('Skip'),
      next: const Icon(Icons.arrow_forward),
      //doneColor: Colors.pink,
      //nextColor: Colors.pink,
      //skipColor: Colors.grey[700],
      dotsDecorator: DotsDecorator(
        size: const Size.square(10.0),
        activeSize: const Size(20.0, 10.0),
        activeShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      ),
    );
  }
}
