import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../pages/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        backgroundColor: const Color(0xFF807CB9),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              _showLogoutMenu(context);
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Bienvenido'),
      ),
    );
  }

  void _showLogoutMenu(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: const Color(0xFF807CB9),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: const Text(
                  'Cerrar Sesión',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () async {
                  await _auth.signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
