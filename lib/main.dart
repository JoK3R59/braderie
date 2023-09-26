import 'package:flutter/material.dart';

// Screens
import 'screens/create_user/create.dart';
import 'screens/home/home.dart';
import 'screens/splash/splash.dart';
import 'screens/login/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      routes: {
        '/home':
            (context) => const HomePage(title: 'Flutter Demo Home Page'),
        '/login':
            (context) => const LoginPage(),
        '/create':
            (context) => const SignUpPage(),
      },
    );
  }
}