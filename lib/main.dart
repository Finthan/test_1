import 'package:flutter/material.dart';

import 'all_colors.dart';
import 'screens/main_screen.dart';
import 'screens/registration_screen.dart';

void main() {
  runApp(const Main());
}

class Main extends StatefulWidget {
  static bool isAuth = false;

  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const RegistrationScreen(),
        '/main': (context) => const MainScreen(),
      },
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
        scaffoldBackgroundColor: kBackgroundColor,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: kBackgroundColor,
          titleTextStyle: TextStyle(
            color: kTitleColor,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
