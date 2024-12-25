import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class KisiselBilgilerEkrani extends StatefulWidget {
  const KisiselBilgilerEkrani({super.key});

  @override
  _KisiselBilgilerEkraniState createState() => _KisiselBilgilerEkraniState();
}

class _KisiselBilgilerEkraniState extends State<KisiselBilgilerEkrani> {
  final TextEditingController _adController = TextEditingController();
  final TextEditingController _telefonController = TextEditingController();

  final CollectionReference _kisiselBilgiler =
      FirebaseFirestore.instance.collection('kisisel_bilgiler');

  String _seciliBelgeId = ''; // Güncelleme için belge ID'sini tutar

  // Yeni bilgi ekleme
  void _bilgiEkle() {
    if (_adController.text.isNotEmpty && _telefonController.text.isNotEmpty) {
      int telefon = int.tryParse(_telefonController.text) ?? 0;
      if (telefon > 0) {
        _kisiselBilgiler.add({
          'ad': _adController.text,
          'telefon': telefon,
          'eklenme_tarihi': Timestamp.now(),
        }).then((_) {
          // Başarılı ekleme sonrası alanları temizle
          _adController.clear();
          _telefonController.clear();
          _seciliBelgeId = '';
        }).catchError((error) {
          _hataMesajiGoster("Ekleme başarısız: $error");
        });
      } else {
        _hataMesajiGoster("Telefon numarası geçersiz!");
      }
    }
  }

  // Bilgi güncelleme
  void _bilgiGuncelle() {
    if (_seciliBelgeId.isNotEmpty &&
        _adController.text.isNotEmpty &&
        _telefonController.text.isNotEmpty) {
      int telefon = int.tryParse(_telefonController.text) ?? 0;
      if (telefon > 0) {
        // Mevcut belgeyi güncelle
        _kisiselBilgiler.doc(_seciliBelgeId).update({
          'ad': _adController.text,
          'telefon': telefon,
          'guncellenme_tarihi': Timestamp.now(),
        }).then((_) {
          // Başarılı güncelleme sonrası alanları temizle
          setState(() {
            _adController.clear();
            _telefonController.clear();
            _seciliBelgeId = ''; // Güncelleme durumunu sıfırla
          });
        }).catchError((error) {
          // Hata durumunda mesaj göster
          _hataMesajiGoster("Güncelleme başarısız: $error");
        });
      } else {
        _hataMesajiGoster("Telefon numarası geçersiz!");
      }
    } else {
      _hataMesajiGoster("Lütfen bilgileri doldurun!");
    }
  }

  // Hata mesajı gösterme
  void _hataMesajiGoster(String mesaj) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(mesaj)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alıcı/Satıcı Bilgileri'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        children: [
          // Yeni bilgi ekleme/güncelleme alanı
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: _adController,
                  decoration: InputDecoration(labelText: 'Alıcı/Satıcı Adı'),
                ),
                TextField(
                  controller: _telefonController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Telefon Numarası'),
                ),
                ElevatedButton(
                  onPressed:
                      _seciliBelgeId.isEmpty ? _bilgiEkle : _bilgiGuncelle,
                  child: Text(
                      _seciliBelgeId.isEmpty ? 'Bilgi Ekle' : 'Bilgi Güncelle'),
                ),
              ],
            ),
          ),
          Divider(),
          // Firestore'dan verileri listeleme
          Expanded(
            child: StreamBuilder(
              stream: _kisiselBilgiler
                  .orderBy('eklenme_tarihi', descending: true)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Hata: ${snapshot.error}'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                final belgeler = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: belgeler.length,
                  itemBuilder: (context, index) {
                    final veri = belgeler[index];
                    return ListTile(
                      title: Text('Ad: ${veri['ad']}'),
                      subtitle: Text('Telefon: ${veri['telefon']}'),
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          setState(() {
                            _adController.text = veri['ad'];
                            _telefonController.text =
                                veri['telefon'].toString();
                            _seciliBelgeId = veri.id; // Belge ID'sini ata
                          });
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
