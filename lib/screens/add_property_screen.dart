// lib/screens/add_property_screen.dart
import 'package:flutter/material.dart';

class AddPropertyScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController imageUrlController = TextEditingController();
  final TextEditingController secondImageUrlController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();
  final TextEditingController roomsController = TextEditingController();
  final TextEditingController parkingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yeni Ev Ekle'),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
      ),
      // Eğer Drawer eklemek istiyorsanız, aşağıdaki satırı ekleyin:
      // drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: imageUrlController,
                  decoration: InputDecoration(labelText: 'Görsel URL 1'),
                  keyboardType: TextInputType.url,
                ),
                TextFormField(
                  controller: secondImageUrlController,
                  decoration: InputDecoration(labelText: 'Görsel URL 2'),
                  keyboardType: TextInputType.url,
                ),
                TextFormField(
                  controller: priceController,
                  decoration: InputDecoration(labelText: 'Fiyat'),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  controller: locationController,
                  decoration: InputDecoration(labelText: 'Lokasyon'),
                ),
                TextFormField(
                  controller: sizeController,
                  decoration: InputDecoration(labelText: 'Boyut'),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  controller: roomsController,
                  decoration: InputDecoration(labelText: 'Oda Sayısı'),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  controller: parkingController,
                  decoration: InputDecoration(labelText: 'Park Yeri'),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Form doğrulaması eklemek iyi bir uygulamadır
                    if (_formKey.currentState!.validate()) {
                      final newProperty = {
                        'images': [
                          imageUrlController.text,
                          secondImageUrlController.text
                        ],
                        'price': priceController.text,
                        'location': locationController.text,
                        'size': sizeController.text,
                        'rooms': roomsController.text,
                        'parking': parkingController.text,
                      };
                      Navigator.pop(context, newProperty); // 📌 Yeni property'yi geri döndür
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                  ),
                  child: Text('Kaydet'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
