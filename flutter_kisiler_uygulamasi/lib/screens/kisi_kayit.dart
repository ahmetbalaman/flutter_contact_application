import 'package:flutter/material.dart';
import 'package:flutter_kisiler_uygulamasi/veritabani_dao.dart';


class KisiKayit extends StatefulWidget {

  @override
  State<KisiKayit> createState() => _KisiKayitState();
}

class _KisiKayitState extends State<KisiKayit> {

  Future<void> ekle({required String kisi_ad, required String numara}) async {
    await VeritabaniDAO().kisileriEkle(kisi_ad: kisi_ad, kisi_numara: numara);
  }
  TextEditingController kontrolAd=TextEditingController();

  TextEditingController kontrolNumara=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kisi Kayıt")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(controller: kontrolAd,decoration: InputDecoration(hintText: "İsim"),),
            TextField(controller:kontrolNumara,decoration: InputDecoration(hintText: "Numara"),keyboardType: TextInputType.number,maxLength: 11),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: (){

      ekle(kisi_ad: kontrolAd.text.toString(), numara: kontrolNumara.text.toString());
      Navigator.pop(context);
      }, label: Text("Kisi Kayıt"),icon: Icon(Icons.save)),
    );
  }
}
