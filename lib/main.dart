import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'services/firebase_options.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MindfulState());
}

class MindfulState extends StatefulWidget {
  const MindfulState({Key? key}) : super(key: key);

  @override
  _MindfulStateState createState() => _MindfulStateState();
}

class _MindfulStateState extends State<MindfulState> {
  bool _showIntro = true;

  @override
  void initState() {
    super.initState();
    _checkShowIntro();
  }

  Future<void> _checkShowIntro() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool showIntro = prefs.getBool('showIntro') ?? true;
    setState(() {
      _showIntro = showIntro;
    });
  }

  Future<void> _setShowIntro(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('showIntro', value);
    setState(() {
      _showIntro = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (
        lightColorScheme,
        darkColorScheme,
      ) {
        final defaultLightColorScheme =
            ColorScheme.fromSwatch(primarySwatch: Colors.pink);
        final defaultDarkColorScheme = ColorScheme.fromSwatch(
            primarySwatch: Colors.pink, brightness: Brightness.dark);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: lightColorScheme ?? defaultLightColorScheme,
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            colorScheme: darkColorScheme ?? defaultDarkColorScheme,
            useMaterial3: true,
          ),
          themeMode: ThemeMode.light,
          home: _showIntro
              ? IntroductionPage(onIntroEnd: () => _setShowIntro(false))
              : const LoginPage(),
        );
      },
    );
  }
}

class IntroductionPage extends StatelessWidget {
  final VoidCallback onIntroEnd;

  IntroductionPage({Key? key, required this.onIntroEnd}) : super(key: key);

  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(BuildContext context) {
    onIntroEnd();
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
