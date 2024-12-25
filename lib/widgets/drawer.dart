// lib/widgets/drawer.dart
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Drawer'ın üst kısmındaki başlık
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blueGrey,
            ),
            child: Text(
              'Hermes Rental',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          // Drawer Menüsü Öğeleri
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Ana Sayfa'),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            },
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Ev Ekle'),
            onTap: () {
              Navigator.pushNamed(context, '/add');
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('Musteri_kayıt'),
            onTap: () {
              Navigator.pushNamed(context, '/kisisel_bilgiler');
            },
          ),
          ListTile(
            leading: Icon(Icons.map),
            title: Text('Harita'),
            onTap: () {
              Navigator.pushNamed(context, '/harita');
            },
          ),

          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Çıkış'),
            onTap: () {
              // Uygulamadan çıkmak için kullanılabilir (sadece Android)
              // SistemNavigator.pop() kullanabilirsiniz
              Navigator.of(context).pop(); // Drawer'ı kapatır
            },
          ),
        ],
      ),
    );
  }
}
