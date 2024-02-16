import 'package:arthub/Home/detail_page.dart';
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key, required CartItem cartItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Aquí podrías obtener la lista de productos del carrito
    // Podrías recibir esta lista como parámetro o utilizando algún estado global
    final List<Product> cartProducts = []; // Supongamos que esta es la lista de productos del carrito

    return Scaffold(
      appBar: AppBar(
        title: Text('Carrito de Compras'),
      ),
      body: ListView.builder(
        itemCount: cartProducts.length,
        itemBuilder: (context, index) {
          final product = cartProducts[index];
          return ListTile(
            leading: Image.network(product.imageUrl),
            title: Text(product.name),
            subtitle: Text(product.description),
            trailing: Text('\$${product.price.toStringAsFixed(2)}'),
            // Aquí podrías agregar botones para modificar la cantidad o eliminar el producto del carrito
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                '\$${_calculateTotalPrice(cartProducts).toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: () {
                  // Aquí podrías implementar la lógica para finalizar la compra
                },
                child: Text('Finalizar Compra'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double _calculateTotalPrice(List<Product> cartProducts) {
    double totalPrice = 0;
    for (var product in cartProducts) {
      totalPrice += product.price;
    }
    return totalPrice;
  }
}

class Product {
  final String imageUrl;
  final String name;
  final String description;
  final double price;

  Product({
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.price,
  });
}
