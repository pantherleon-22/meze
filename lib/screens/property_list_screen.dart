// lib/screens/property_list_screen.dart
import 'package:flutter/material.dart';
import '../widgets/property_card.dart';
import '../widgets/drawer.dart'; // 📌 Drawer'ı import ettik

class PropertyListScreen extends StatefulWidget {
  final List<Map<String, dynamic>> allProperties;
  final Function(Map<String, dynamic>) addProperty;

  PropertyListScreen({required this.allProperties, required this.addProperty});

  @override
  _PropertyListScreenState createState() => _PropertyListScreenState();
}

class _PropertyListScreenState extends State<PropertyListScreen> {
  List<Map<String, dynamic>> filteredProperties = [];

  @override
  void initState() {
    super.initState();
    filteredProperties = widget.allProperties;
  }

  @override
  void didUpdateWidget(covariant PropertyListScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    filteredProperties = widget.allProperties;
  }

  void _filterProperties(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredProperties = widget.allProperties;
      });
      return;
    }

    setState(() {
      filteredProperties = widget.allProperties.where((property) {
        final location = property['location'].toLowerCase();
        final price = property['price'].toLowerCase();
        final searchQuery = query.toLowerCase();
        return location.contains(searchQuery) || price.contains(searchQuery);
      }).toList();
    });
  }

  void _navigateToAddProperty() async {
    final newProperty = await Navigator.pushNamed(context, '/add');
    if (newProperty != null && newProperty is Map<String, dynamic>) {
      widget.addProperty(newProperty); // 📌 addProperty metodunu çağırdık
      setState(() {
        filteredProperties = widget.allProperties;
      });
    }
  }

  void _navigateToDetailPage(Map<String, dynamic> property) {
    Navigator.pushNamed(context, '/detail', arguments: property);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hermes Rental'),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        elevation: 10,
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      drawer: AppDrawer(), // 📌 Drawer'ı ekledik
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Ara (Örn: Lokasyon, Fiyat)...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) => _filterProperties(value),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredProperties.length,
              itemBuilder: (context, index) {
                final property = filteredProperties[index];
                return GestureDetector(
                  onTap: () => _navigateToDetailPage(property),
                  child: PropertyCard(
                    images: property['images'].cast<String>(),
                    price: property['price'],
                    location: property['location'],
                    size: property['size'],
                    rooms: property['rooms'],
                    parking: property['parking'],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddProperty,
        backgroundColor: Colors.blueGrey,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
