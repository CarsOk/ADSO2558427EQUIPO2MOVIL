import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pages/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Creditos 3A',
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}
