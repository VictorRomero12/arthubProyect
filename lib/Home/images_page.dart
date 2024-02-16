import 'dart:convert';
import 'dart:math';
import 'package:arthub/search/search_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'detail_page.dart';


class ApiPage extends StatefulWidget {
  @override
  _ApiPageState createState() => _ApiPageState();
}

class _ApiPageState extends State<ApiPage> {
  List<String> imageUrls = [];

  @override
  void initState() {
    super.initState();
    fetchImageUrls();
  }

  Future<void> fetchImageUrls() async {
    try {
      final response = await http.get(
        Uri.parse('http://arthub.somee.com/api/Publicacion'),
        headers: {'accept': '*/*'},
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData is List) {
          setState(() {
            imageUrls = jsonData.map<String>((json) => json['archivo']).toList();
          });
        } else {
          throw Exception('Invalid JSON data format');
        }
      } else {
        throw Exception('Failed to load images');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  double calculateRandomPrice() {
    final random = Random();
    return (random.nextDouble() * 45) + 5;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchPage()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemCount: imageUrls.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(
                      imageUrl: imageUrls[index],
                      name: 'Producto ${index + 1}',
                      description: 'Descripción del producto ${index + 1}',
                      randomPrice: calculateRandomPrice(),
                    ),
                  ),
                );
              },
              child: Hero(
                tag: 'imageTag$index',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    imageUrls[index],
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ApiPage(),
  ));
}
