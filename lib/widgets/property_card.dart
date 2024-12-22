// lib/widgets/property_card.dart
import 'package:flutter/material.dart';

class PropertyCard extends StatelessWidget {
  final List<String> images;
  final String price;
  final String location;
  final String size;
  final String rooms;
  final String parking;

  PropertyCard({
    required this.images,
    required this.price,
    required this.location,
    required this.size,
    required this.rooms,
    required this.parking,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            child: Image.network(
              images[0],
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) { // 📌 Hata yönetimi ekledik
                return Container(
                  height: 150,
                  color: Colors.grey[300],
                  child: Icon(Icons.image, size: 50, color: Colors.grey[600]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '₺$price',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  location,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Boyut: $size'),
                    Text('Oda: $rooms'),
                    Text('Park: $parking'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
