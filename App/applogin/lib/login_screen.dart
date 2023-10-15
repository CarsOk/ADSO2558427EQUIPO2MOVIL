import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color(0xFFA39DCD)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Cuadro de usuario con ícono
              Container(
                width: 150,
                height: 130,
                decoration: BoxDecoration(
                  color: const Color(0xFF807CB9),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Center(
                  child: Icon(
                    Icons.person,
                    size: 140,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 30), // Espaciado
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Correo Electrónico',
                    labelStyle: TextStyle(fontSize: 20, color: Colors.black45),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF807CB9)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Contraseña',
                    labelStyle: TextStyle(fontSize: 20, color: Colors.black45),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF807CB9)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // lógica
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF807CB9),
                ),
                child: const Text(
                  'Iniciar Sesión',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
