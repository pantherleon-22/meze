import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/property_list_screen.dart';
import 'screens/property_detail_screen.dart';
import 'screens/add_property_screen.dart';
import 'screens/personal_info.dart';
import 'screens/navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCXnqSYXvThSfO5785FrywMucH-LGrGgGE",
      authDomain: "kutay-e94e5.firebaseapp.com",
      projectId: "kutay-e94e5",
      storageBucket: "kutay-e94e5.firebasestorage.app",
      messagingSenderId: "998102945039",
      appId: "1:998102945039:web:f8fc53468a3a4e5a3a427a",
      measurementId: "G-SKWH00TYJS",
    ),
  );
  runApp(HermesKiralamaUygulamasi());
}

class HermesKiralamaUygulamasi extends StatefulWidget {
  const HermesKiralamaUygulamasi({super.key});

  @override
  _HermesKiralamaUygulamasiState createState() =>
      _HermesKiralamaUygulamasiState();
}

class _HermesKiralamaUygulamasiState extends State<HermesKiralamaUygulamasi> {
  // Tüm property verilerini burada tutuyoruz
  final List<Map<String, dynamic>> tumIlanlar = [
    {
      'images': [
        'https://photos.zillowstatic.com/fp/f3f1f33e57fee9e0df8c20ece86901b6-cc_ft_960.webp',
        'https://res.cloudinary.com/onmap-prod/image/upload/if_iw_gt_1508,w_1508,c_fill/if_else,h_900,c_fill/q_auto,f_auto/j6os8qjcrynuxdniotjb'
      ],
      'price': '11,000',
      'location': 'Avraham Boyer St. 5, Ramat Aviv Gimel',
      'size': '126 m²',
      'rooms': '5+1',
      'parking': '1'
    },
    {
      'images': [
        'https://photos.zillowstatic.com/fp/b5ec9e8aca91d62ce27e806ac9fc59c7-uncropped_scaled_within_1536_1152.webp',
        'https://res.cloudinary.com/onmap-prod/image/upload/if_iw_gt_1508,w_1508,c_fill/if_else,h_900,c_fill/q_auto,f_auto/g4p1qmqm5svtcmogvglu'
      ],
      'price': '6,400',
      'location': 'HaKongres St. 6, Neve Sha\'anan',
      'size': '52 m²',
      'rooms': '2+1',
      'parking': '0'
    },
    {
      'images': [
        'https://photos.zillowstatic.com/fp/a3b718e08f7ce2868bda898f20919d28-cc_ft_960.webp',
        'https://res.cloudinary.com/onmap-prod/image/upload/if_iw_gt_1508,w_1508,c_fill/if_else,h_900,c_fill/q_auto,f_auto/mqie28qxziczhafgog7e'
      ],
      'price': '7,500',
      'location': 'Derech HaShalom 10, Tel Aviv',
      'size': '95 m²',
      'rooms': '3+1',
      'parking': '1'
    },
  ];

  // Yeni bir property eklemek için kullanılacak yöntem
  void ilanEkle(Map<String, dynamic> yeniIlan) {
    setState(() {
      tumIlanlar.add(yeniIlan);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hermes Kiralama',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => PropertyListScreen(
              allProperties: tumIlanlar,
              addProperty: ilanEkle,
            ),
        '/detail': (context) => PropertyDetailScreen(),
        '/add': (context) => AddPropertyScreen(),
        '/kisisel_bilgiler': (context) => KisiselBilgilerEkrani(),
        '/harita': (context) => const NavigationPage(), // Yeni rota
      },
    );
  }
}
