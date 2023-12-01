import 'package:flutter/material.dart';

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                Image(
                  image: AssetImage('assets/LogoCreditos.jpg'),
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
            onTap: () {
              
            },
          ),
          ListTile(
            title: const Text('Favourites'),
            leading: const Icon(Icons.favorite_outline),
            onTap: () {
              // 
            },
          ),
         
        ],
      ),
    );
  }
}
