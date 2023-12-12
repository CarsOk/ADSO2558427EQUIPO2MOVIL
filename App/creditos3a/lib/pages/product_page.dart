import 'dart:convert';
import 'package:flutter/material.dart';
import '../widgets/widgets.dart';
import 'package:http/http.dart' as http;

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<Producto> productos = [];

  @override
  void initState() {
    super.initState();
    _fetchProductos();
  }

  Future<void> _fetchProductos() async {
    try {
      final response = await tomarProductos();

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          productos =
              data.map((producto) => Producto.fromJson(producto)).toList();
        });
      } else {
        throw ServerException(
            'Error al cargar los productos: ${response.statusCode}');
      }
    } on NetworkException catch (error) {
      print('Error de red: $error');
      _showErrorDialog('Error de red. Verifica tu conexión a Internet.');
    } on ServerException catch (error) {
      print('Error del servidor: $error');
      _showErrorDialog(
          'Error del servidor. Por favor, intenta nuevamente más tarde.');
    } catch (error) {
      print('Error desconocido: $error');
      _showErrorDialog('Ocurrió un error. Por favor, intenta nuevamente.');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Creditos3A'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        flexibleSpace: Container(
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
        ),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: productos.length,
        itemBuilder: (context, index) {
          final producto = productos[index];
          return Card(
            margin: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  producto.avatarUrl,
                  fit: BoxFit.cover,
                  height: 200.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    producto.nombre,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(producto.descripcion),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Precio: \$${producto.precio.toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Cantidad: ${producto.cantidad}'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    producto.disponible
                        ? 'Producto Disponible'
                        : 'Producto No Disponible',
                    style: TextStyle(
                      color: producto.disponible ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      drawer: const DrawerHome(),
    );
  }

  void _showLogoutMenu(BuildContext context) {
    // ... tu código existente ...
  }
}

class Producto {
  final int id;
  final String nombre;
  final String descripcion;
  final bool disponible;
  final String avatarUrl;
  final int precio;
  final int cantidad;

  Producto({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.disponible,
    required this.avatarUrl,
    required this.precio,
    required this.cantidad,
  });

  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      disponible: json['disponible'],
      avatarUrl: 'http://localhost:3000${json['avatar']['url']}',
      precio: json['precio'],
      cantidad: json['cantidad'],
    );
  }
}

Future<http.Response> tomarProductos() async {
  final url = Uri.http('localhost:3000', '/api/v1/productos');
  final respuestaApi = await http.get(url);

  if (respuestaApi.statusCode == 200) {
    return respuestaApi;
  } else {
    throw ServerException('Error en la solicitud: ${respuestaApi.statusCode}');
  }
}

class NetworkException implements Exception {
  final String message;

  NetworkException(this.message);
}

class ServerException implements Exception {
  final String message;

  ServerException(this.message);
}
