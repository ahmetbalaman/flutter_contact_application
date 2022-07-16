
import 'package:flutter_kisiler_uygulamasi/classlar.dart';

import 'VeritabaniYardimcisi.dart';

class VeritabaniDAO{

  Future<List<Kisiler>> listele() async{

    var db=await VeritabaniYardimcisi.veritabaniErisim();
    List<Map<String, dynamic>> maps =
    await db.rawQuery("SELECT * FROM kisiler");
    return List.generate(maps.length, (index) {
      var row = maps[index];
      return Kisiler(kisi_id:  row["kisi_id"], kisi_ad: row["kisi_ad"], kisi_tel: row["kisi_tel"]);
    });

  }

  Future<List<Kisiler>> ara(String? aramakelimesi) async{

    var db=await VeritabaniYardimcisi.veritabaniErisim();

    List<Map<String, dynamic>> maps =
    await db.rawQuery("SELECT * FROM kisiler WHERE kisi_ad like '%$aramakelimesi%'");

    return List.generate(maps.length, (index) {
      var row = maps[index];
      return Kisiler(kisi_id:  row["kisi_id"], kisi_ad: row["kisi_ad"], kisi_tel: row["kisi_tel"]);
    });

  }
  Future<void> kisiSil(int kisi_id) async{
    var db=await VeritabaniYardimcisi.veritabaniErisim();
    await db.delete("kisiler",where: "kisi_id=?",whereArgs: [kisi_id]);
  }
  Future<void> kisileriEkle({required String kisi_ad,required String kisi_numara}) async{
    var db= await VeritabaniYardimcisi.veritabaniErisim();
    var satir=Map<String,dynamic>();
    satir["kisi_ad"]=kisi_ad;
    satir["kisi_tel"]=kisi_numara;
    await db.insert("kisiler", satir);
  }

  Future<void> kisileriGuncelle({required int kisi_id,required String kisi_ad,required String kisi_tel}) async{
    var db=await VeritabaniYardimcisi.veritabaniErisim();
    var bilgiler=Map<String,dynamic>();
    bilgiler["kisi_ad"]=kisi_ad;
    bilgiler["kisi_tel"]=kisi_tel;
    print("burası da çalışıyor");
    await db.update("kisiler", bilgiler,where: "kisi_id=?",whereArgs: [kisi_id]);
  }

}