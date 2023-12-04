import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pages/welcome_screen.dart';
import 'package:flutter/foundation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyAPtgpSBVQypHMnqyAO7EgtqW4EMYSTqyw",
            appId: "1:392820006582:web:80922e8d1c5710794bd017",
            messagingSenderId: "392820006582",
            projectId: "creditos3a-3d880"));
  }
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
