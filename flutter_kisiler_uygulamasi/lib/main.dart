import 'package:flutter/material.dart';
import 'package:flutter_kisiler_uygulamasi/classlar.dart';
import 'package:flutter_kisiler_uygulamasi/screens/kisi_detay.dart';
import 'package:flutter_kisiler_uygulamasi/screens/kisi_kayit.dart';
import 'package:flutter_kisiler_uygulamasi/veritabani_dao.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kişiler Uygulaması',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  Future<List<Kisiler>> kelimeleriGetir() async {
    List<Kisiler> liste = await VeritabaniDAO().listele();
    return liste;
  }
  Future<List<Kisiler>> kelimeleriAra(String aramakelimesi) async {
    List<Kisiler> liste = await VeritabaniDAO().ara(aramakelimesi);
    return liste;
  }
  Future<void> kisiyiSil(int id) async {
    await VeritabaniDAO().kisiSil(id);
    setState((){
    });
  }
  @override
  String aramaKismi = "";
  bool secildi = false;
  @override
  Widget build(BuildContext context) {
    var ekranolc = MediaQuery.of(context).size;
    var ekranyuk = ekranolc.height;
    var ekrangen = ekranolc.width;

    return Scaffold(
        appBar: AppBar(
          title: secildi
              ? TextField(
                  decoration: const InputDecoration(hintText: "Deneme"),
                  onChanged: (String? arama) {
                    setState(() {
                      aramaKismi = arama.toString();
                    });
                  },
                )
              : const Text("Sozluk Uygulaması"),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: ekrangen / 12),
              child: GestureDetector(
                  child: secildi
                      ? const Icon(Icons.cancel)
                      : const Icon(Icons.search),
                  onTap: () {
                    setState(() {
                      secildi = !secildi;
                      aramaKismi = "";
                    });
                  }),
            ),
          ],
        ),
        body: FutureBuilder<List<Kisiler>>(
          future: secildi ? kelimeleriAra(aramaKismi) : kelimeleriGetir(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Kisiler>? listeler = snapshot.data!;
              return ListView.builder(
                itemCount: listeler.length,
                itemBuilder: (context, index) {
                  var liste = listeler[index];
                  return GestureDetector(
                      child: SizedBox(
                        height: ekranyuk / 10,
                        child: Card(
                            elevation: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  liste.kisi_ad.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(liste.kisi_tel.toString()),
                                GestureDetector(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text(
                                                  "Silmek istediğinden emin misin?"),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        kisiyiSil(
                                                            liste.kisi_id!);
                                                      });
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("Evet")),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("Hayır")),
                                              ],
                                            );
                                          });
                                    },
                                    child: Icon(Icons.delete))
                              ],
                            )),
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => KisiDetay(liste),));

                      });
                },
              );
            } else {
              return const Center();
            }
          },
        ),
      floatingActionButton:FloatingActionButton(
        onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) => KisiKayit(),)),
    child: Icon(Icons.add),
    ),

    );
  }
}
