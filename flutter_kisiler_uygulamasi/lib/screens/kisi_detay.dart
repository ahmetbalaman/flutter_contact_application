import 'package:flutter/material.dart';
import 'package:flutter_kisiler_uygulamasi/main.dart';

import '../classlar.dart';
import '../veritabani_dao.dart';

class KisiDetay extends StatefulWidget {
  Kisiler kisi;

  KisiDetay(this.kisi);

  @override
  State<KisiDetay> createState() => _KisiDetayState();
}

class _KisiDetayState extends State<KisiDetay> {
  Future<void> guncelle(
      {required int id, required String kisi, required String kisi_tel}) async {
    await VeritabaniDAO()
        .kisileriGuncelle(kisi_id: id, kisi_ad: kisi, kisi_tel: kisi_tel);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    kontrolAd.text = widget.kisi.kisi_ad!;
    kontrolNumara.text = widget.kisi.kisi_tel!;
  }
  TextEditingController kontrolAd = TextEditingController();
  TextEditingController kontrolNumara = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kisi Güncelle")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: kontrolAd,
              decoration: InputDecoration(hintText: "İsim"),
            ),
            TextField(
                controller: kontrolNumara,
                decoration: InputDecoration(hintText: "Numara"),
                keyboardType: TextInputType.number,
                maxLength: 11),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            guncelle(
                id: widget.kisi.kisi_id!,
                kisi: kontrolAd.text,
                kisi_tel: kontrolNumara.text);
            Navigator.pop(context);
          },
          label: Text("Güncelle"),
          icon: Icon(Icons.restart_alt_rounded)),
    );
  }
}