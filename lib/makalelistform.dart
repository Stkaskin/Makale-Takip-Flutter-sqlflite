import 'package:codesad/addandrev/makaleadd.dart';
import 'package:codesad/controlCenter/controldata.dart';
import 'package:codesad/db_h.dart';
import 'package:codesad/main.dart';
import 'package:codesad/model.dart';
import 'package:codesad/modules/hakemislem.dart';
import 'package:codesad/modules/makaleislem.dart';
import 'package:codesad/modules/makales.dart';
import 'package:codesad/mywidgets/specialwidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

var yetkili = 3;

class MakaleListForm extends StatefulWidget {
  const MakaleListForm({Key? key}) : super(key: key);

  @override
  _MakaleListForm createState() => _MakaleListForm();
}

class _MakaleListForm extends State<MakaleListForm> {
  DbHelper? dbHelper;
  List<HakemIslem> atamalarcontol = [];
  Future<List<Makale>>? makaleList;
  List<int>? makaleidtut = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = DbHelper();
    loadData();
  }

  loadData() async {
    
    if (yetkili == 1) {
      //  girisyapan=(await dbHelper!.getUserSearch("WHERE yetki=1")).first;
            List<Makale> makaleler = [];
         List<MakaleIslem> islemler = await dbHelper!.getSearchMakaleIslem(" WHERE yazarid="+girisyapan.id.toString());
          if (islemler.isNotEmpty) {
                   for (var element in islemler) {
 Makale mkl = (await dbHelper!.getMakaleListSearch(
                  " WHERE id=" + element.makaleid.toString())).first;
                makaleler.add(mkl);
                }
               
          }
         
            setState(() {
        makaleList = Future.value(makaleler);
      });

    } else if (yetkili == 2) {
      List<Makale> makaleler = [];
      //    girisyapan=(await dbHelper!.getUserSearch("WHERE yetki=2")).first;
      List<MakaleIslem> islemler = await dbHelper!.getSearchMakaleIslem(
          " WHERE alaneditorid=" + girisyapan.id.toString());
      if (islemler.isNotEmpty) {
        for (var element in islemler) {
          Makale mkl = (await dbHelper!.getMakaleListSearch(
                  " WHERE id=" + element.makaleid.toString()))
              .first;

          atamalarcontol = await dbHelper!.getHakemIslemSearch(
              " WHERE makaleid=" + element.makaleid.toString());

          if (atamalarcontol.isNotEmpty && atamalarcontol.length < 3) {
            mkl.onay != 1;
            makaleler.add(Makale(
                id: mkl.id,
                baslik: mkl.baslik,
                mail: mkl.mail,
                zaman: mkl.zaman,
                onay: 1,
                yazar: mkl.yazar,revizyonzamani: mkl.revizyonzamani,yol: mkl.yol));
          } else {
            makaleler.add(mkl);
          }
        }
      }
      setState(() {
        makaleList = Future.value(makaleler);
      });
    } else if (yetkili == 3) {
      //  girisyapan=(await dbHelper!.getUserSearch("WHERE yetki=3")).first;
      List<Makale> liste = [];
      List<HakemIslem> hakemSorumlumakalelistesi = await dbHelper!
          .getHakemIslemSearch("WHERE hakemid=" +
              girisyapan.id.toString() +
              " AND (durum=3 OR durum=2)");
      for (var element in hakemSorumlumakalelistesi) {
        liste.add((await dbHelper!
                .getMakaleListSearch("WHERE  id=" + element.makaleid.toString()))
            .first);
      }
      setState(() {
        if (liste != null) {
          makaleList = Future.value(liste);
        }
        for (var i in liste) {}
      });
      for (var el in (await makaleList!)) {
        if (await hakemMakaleControl(el) != -1 && el.onay!=5 && el.onay!=7) {
          makaleidtut!.add(el.id!);
          print(el.id!.toString());
        }
      }
      if (girisyapan != null) {
        setState(() {
          girisyapan = girisyapan;
          print("girisyapan:" +
              girisyapan.id.toString() +
              " yetki" +
              girisyapan.yetki.toString());
        });
      }
    } else if (yetkili == 4) {
      //  girisyapan=(await dbHelper!.getUserSearch("WHERE yetki=4")).first;
      makaleList = dbHelper!.getMakaleList();
    }   
    setState(() {
      makaleList;
   
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: BackButtoninAppBar(text: "MAKALELER"),
      body: Column(
        children: [
          // ignore: avoid_print
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              yetkiliControlYazar(function: () {}),
              personelbilgibuttoncontrol()
            ],
          ),

          Expanded(
            child: FutureBuilder(
                future: makaleList,
                builder: (context, AsyncSnapshot<List<Makale>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data?.length,
                        reverse: false,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return InkWell(
                            child: Card(
                              child: ListTile(
                                title: Text(
                                    snapshot.data![index].baslik.toString()),
                                subtitle: Text("#" +
                                    snapshot.data![index].yazar.toString() +
                                    "\n" +
                                    snapshot.data![index].zaman
                                        .toString()
                                        .substring(0, 16)),
                                leading:
                                    Text(snapshot.data![index].id!.toString()),
                                isThreeLine: (true),
                                trailing: ButtonOrTextListeleme(
                                    snapshot.data![index]),
                                onTap: () {
                                  aktifmakale = snapshot.data![index];
                                  goDetailForm(snapshot.data![index]);
                                },
                              ),
                            ),
                          );
                        });
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
          )
        ],
      ),
    );
  }

  Widget personelbilgibuttoncontrol() {
    if (girisyapan.yetki==2 || girisyapan.yetki==4){
    return NewButtonElement(
                function: () {
                  runApp(MyApp(sayfakod: 97));
                },
                text: "Personel Bilgi");}
                else {return SizedBox();}
  }

  goDetailForm(Makale makale) {
    print("makale baslik" + makale.baslik);
//burada sayfa 3 e gidecek makale gonderilecek
    print("object");
    aktifmakale = makale;
    runApp(MyApp(sayfakod: 3));
  }

  // ignore: non_constant_identifier_names
  Widget ButtonOrTextListeleme(Makale snapshot) {
    //Button or text gönderilecek
    //alan editor control
    if (yetkili==1 && snapshot.onay==6){
return revizyonbuttonadd(snapshot);

    }
    if (yetkili == 2 && (snapshot.onay == 1 || snapshot.onay == 4)) {
      return alaneditorbuttonadd(snapshot);
    } else if (yetkili == 4 && snapshot.onay == 0) {
      return oyveaaatamabutton(
          snapshot: snapshot, text: "A.ATAMA", function: () {}, sayfa: 9);
    } else if (yetkili == 3) {
      for (var a in makaleidtut!) {
        if (snapshot.id == a) {
          return oyveaaatamabutton(
              snapshot: snapshot, text: "OY VER", function: () {}, sayfa: 15);
        }
      }
    }
    //Genel gönderim
    return Text(textonaydondur(snapshot.onay));
  }
}

Widget yetkiliControlYazar({required Function? function}) {
  if (yetkili == 1) {
    return NewButtonElement(
        text: "Yeni Makale Ekle",
        colorbutton: Colors.indigo,
        colortext: Colors.white,
        function: () {
          runApp(const MyApp(sayfakod: 5));
        });
  } else if (yetkili == 3) {
    return hakemDavetlerimButton(function: () {});
  } 
  else if (yetkili==2 || yetkili==4){
return NewButtonElement(
        text: "Persone Ekle",
        colorbutton: Colors.indigo,
        colortext: Colors.white,
        function: () {
          runApp(const MyApp(sayfakod: 17));
        });

  } else {
    return SizedBox();
  }
}

Widget hakemDavetlerimButton({required Function function}) {
  if (yetkili == 3) {
    return NewButtonElement(
        text: "Davetlerim",
        colorbutton: Colors.orangeAccent.shade400,
        colortext: Colors.white,
        function: () async {
          if (yetkili == 3) {
            DbHelper dbHelper = DbHelper();
            // girisyapan= (await dbHelper.getSearchUserList(" WHERE yetki=3")).first;

            runApp(const MyApp(sayfakod: 10));
          }
        });
  } else {
    return SizedBox();
  }
}

// ignore: non_constant_identifier_names

Future<int> hakemMakaleControl(Makale makale) async {
  DbHelper dbHelper = DbHelper();
  List<HakemIslem> hakemler = (await dbHelper
      .getHakemIslemSearch("WHERE makaleid=" + makale.id.toString()));
  if (hakemler != null) {
    for (var element in hakemler) {
      if (element.hakemid == girisyapan.id) {
        if (element.durum == 2) {
          return element.makaleid;
        }
      }
    }
  }
  return -1;
}

String textonaydondur(int onay) {
  return onay == 0
      ? "Alan E. Atanıyor"
      : onay == 1
          ? "Hakemler Atamıyor"
          : onay == 2
              ? "Hakemler Seçiliyor"
              : onay == 3
                  ? "Hakemler Cevaplıyor"
                  : onay == 4
                      ? "Alan E. İnceliyor"
                      : onay == 5
                          ? "Onaylandı"
                          : onay == 6
                              ? "Revizyon Talebi"
                              : onay == 7
                                  ? "Red Edildi"
                                  : "";
}

Widget oyveaaatamabutton(
    {required Makale snapshot,
    required String text,
    required Function function,
    required int sayfa}) {
  return NewButtonElement(
      colortext: Colors.teal.shade800,
      colorbutton: Colors.yellow.shade300,
      text: text,
      function: () {
//runapp > atama sayfası numarasını

        aktifmakale = snapshot;
        //9 alan editör atamaya 15  hakemoylamaa

        runApp(MyApp(sayfakod: sayfa));
      });
}
revizyonbuttonadd(Makale snapshot){
    return NewButtonElement(
        colortext: Colors.teal.shade800,
        colorbutton: Colors.green.shade300,
        text: "Revizyon",
        function: () {
          aktifmakale = snapshot;
//runapp > inceleme sayfası numarasını

          runApp(MyApp(sayfakod: 18));
        });
  
}



Widget alaneditorbuttonadd(Makale snapshot) {
  if (snapshot.onay == 1) {
    return NewButtonElement(
        colortext: Colors.teal.shade800,
        colorbutton: Colors.yellow.shade300,
        text: "ATAMA",
        function: () {
//runapp > atama sayfası numarasını
          aktifmakale = snapshot;
          runApp(MyApp(sayfakod: 6));
        });
  } else {
    return NewButtonElement(
        colortext: Colors.teal.shade800,
        colorbutton: Colors.yellow.shade300,
        text: "İNCELE",
        function: () {
          aktifmakale = snapshot;
//runapp > inceleme sayfası numarasını

          runApp(MyApp(sayfakod: 7));
        });
  }
}
