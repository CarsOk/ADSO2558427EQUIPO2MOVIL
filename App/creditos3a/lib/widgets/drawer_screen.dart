import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DrawerHome extends StatelessWidget {
  const DrawerHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.purple[900]!,
                  Colors.deepPurple[300]!,
                ],
              ),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                Image(
                  image: AssetImage('assets/images/LogoCreditos.jpg'),
                  height: 110,
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
          ListTile(
            title: const Text('Productos'),
            leading: const Icon(Icons.people),
            onTap: () {
              Navigator.pushNamed(context, '/product');
            },
          ),
          ListTile(
            title: const Text('My Account'),
            leading: const Icon(Icons.account_box_rounded),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Cerrar sesión'),
            leading: const Icon(Icons.exit_to_app),
            onTap: () async {
              // Acciones para "Sign Out"
              try {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/login');
              } catch (e) {
                ("Error al cerrar sesión: $e");
                // Manejar el error según sea necesario
              }
            },
          ),
        ],
      ),
    );
  }
}
