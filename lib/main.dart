import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'services/firebase_options.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'login_page.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      builder: (
        lightColorScheme,
        darkColorScheme,
      ) {
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
    final double imageHeight = MediaQuery.of(context).size.height * 0.4;
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
          body:
              "A simple and elegant app that helps you stay mindful and productive.",
          image: Center(
              child: Image.asset('images/welcome-bw.png', height: imageHeight)),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Discover Healthier Living in Your Community",
          body:
              "Personalized recommendations based on your location, goals, and mood.",
          image: Center(
              child:
                  Image.asset('images/discover-bw.png', height: imageHeight)),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Track Your Progress",
          body:
              "Set goals, track your progress and see how you are improving over time.",
          image: Center(
              child: Image.asset('images/track-bw.png', height: imageHeight)),
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
