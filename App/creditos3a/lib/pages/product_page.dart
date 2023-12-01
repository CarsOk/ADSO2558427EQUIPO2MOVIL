import 'dart:convert';
import 'package:flutter/material.dart';
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
    cargarProductos();
  }

  Future<void> cargarProductos() async {
    try {
      List<Producto> listaProductos = await fetchProductos();
      setState(() {
        productos = listaProductos;
      });

      // Imprimir los productos en la consola para verificar
      print('Productos cargados correctamente:');
      for (var producto in productos) {
        print(
            'ID: ${producto.id}, Nombre: ${producto.nombre}, Descripción: ${producto.descripcion}, '
            'Precio: ${producto.precio}, Categoría ID: ${producto.categoriaId}, Avatar: ${producto.avatar}');
      }
    } catch (e) {
      print('Error al cargar productos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Productos'),
        backgroundColor: Colors.transparent,
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
      body: Center(
        child: productos.isEmpty
            ? const CircularProgressIndicator()
            : ListView.builder(
                itemCount: productos.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(productos[index].nombre),
                    subtitle: Text(productos[index].descripcion),
                    // Muestra el precio y la categoría ID
                    trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Precio: ${productos[index].precio}'),
                        Text('Categoría ID: ${productos[index].categoriaId}'),
                      ],
                    ),
                    // Muestra el avatar (imagen) si está disponible
                    leading: productos[index].avatar != null
                        ? CircleAvatar(
                            backgroundImage:
                                NetworkImage(productos[index].avatar!),
                          )
                        : null,
                    // Otros campos del producto que desees mostrar
                  );
                },
              ),
      ),
    );
  }
}

class Producto {
  int id;
  String nombre;
  String descripcion;
  double precio;
  int categoriaId;
  String? avatar; // Puede ser nulo

  Producto({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.precio,
    required this.categoriaId,
    this.avatar,
  });

  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      precio: json['precio'].toDouble(),
      categoriaId: json['categoria_id'],
      avatar: json['avatar'],
    );
  }
}

Future<List<Producto>> fetchProductos() async {
  final response = await http
      .get(Uri.parse('http://0.0.0.0:3001/pages/categorias/productos.json'));
  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body)['productos'];
    List<Producto> productos =
        data.map((item) => Producto.fromJson(item)).toList();
    return productos;
  } else {
    throw Exception('Error al cargar productos');
  }
}
