import 'package:codesad/addandrev/makaleadd.dart';
import 'package:codesad/db_h.dart';
import 'package:codesad/main.dart';
import 'package:codesad/modules/makaleislem.dart';
import 'package:codesad/modules/makales.dart';
import 'package:codesad/modules/users.dart';
import 'package:codesad/mywidgets/specialwidgets.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:intl/intl.dart';

var drop1 = TextEditingController();

class AlanEdAtamaForm extends StatefulWidget {
  const AlanEdAtamaForm({Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _AlanEdAtamaForm createState() => _AlanEdAtamaForm();
}

class _AlanEdAtamaForm extends State<AlanEdAtamaForm> {
  //islem usten alta alındı globaldan private
  MakaleIslem? islem;
  _AlanEdAtamaForm();
  DbHelper? dbHelper;
  User? value;
  late Future<List<User>> ListFuture;
  List<User>? listeUser;
  List<String>? indexS;
  var dergi1 = TextEditingController();
  var dergi2 = TextEditingController();
  List<DropdownMenuItem<User>>? items = [
    DropdownMenuItem(
        value: User(ad: "ad", mail: "mail", parola: "parola", yetki: 3,aktif: 1),
        child: Text("sec"))
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = DbHelper();
    loadData();
  }

  loadData() async {
    ListFuture = dbHelper!.getSearchUserList(" WHERE yetki=2 AND aktif=1");
    listeUser = await ListFuture;
    islem = (await dbHelper!.getSearchMakaleIslem(
            'WHERE makaleid=' + aktifmakale.id.toString()))
        .first;
    listeUser!.forEach((element) {
      items!.add(DropdownMenuItem(
        value: element,
        child: Text(element.id.toString() + "* " + element.ad),
      ));

      print(element.id.toString());
    });
    setState(() {
      aktifmakale = aktifmakale;
      islem = islem;
      if (items!.length != 1) {
        items!.remove(items!.first);
      }

      value = items!.first.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: todo
    // TODO: implement build

    // final items = ['item1', 'item2', "item3", "item4", "item5"];
    return Scaffold(
        appBar: BackButtoninAppBar(text: "Alan Editör Atama"),
        body: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            RadiusContainerWidget(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0,top: 15.0),
                child: Column(
                  children: [
                    PaddingRowInText(
                        konum: MainAxisAlignment.center,
                        text: "Alan  Editör Atama Sayfası"),
                    DropdownButton<User>(
                      items: items!.toList(),
                      value: this.value,
                      onChanged: (value) {
                        print(value!.ad.toString());
                        setState(() {
                          this.value = value;
                          print(value.id.toString());
                        });
                      },
                    ),
                    alaneditorata()
                  ],
                ),
              ),
              color: Colors.yellow.shade100,
            ),
            baseditorredpanel(),
          ]),
        ));
  }

  Widget baseditorredpanel() {
      if (items!.first.value!.ad=="sec" || items!.first.value!.id==null){
        return const SizedBox();
      }
    return RadiusContainerWidget(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                children: [
                  TextFieldInputDec(
                      text: "1.Dergi Öner", controllername: dergi1),
                  TextFieldInputDec(
                      text: "2.Dergi Öner ", controllername: dergi2),
                  NewButtonElement(
                      text: "RET ET",
                      colorbutton: Colors.red,
                      colortext: Colors.black,
                      function: () {
                        baseditorred();
                      })
                ],
              ),
            ),
            color: Colors.lightBlue.shade100,
          );
  }

  Padding PaddingRowInText({String? text, MainAxisAlignment? konum}) {
    if (konum == null) {
      konum = MainAxisAlignment.start;
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: konum,
        children: [
          Text(
            text!,
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  baseditorred() {
    dbHelper!.updateMakale(Makale(
        id: aktifmakale.id,
        baslik: aktifmakale.baslik,
        mail: aktifmakale.mail,
        zaman: aktifmakale.zaman,
        onay: 7,
        yazar: aktifmakale.yazar,revizyonzamani: aktifmakale.revizyonzamani,yol: aktifmakale.yol));
            control();
  }

  Widget alaneditorata() {
    if (items!.first.value!.ad=="sec" || items!.first.value!.id==null){
      return NewButtonElement(
 colortext: Colors.teal.shade800,
        colorbutton: Colors.yellow.shade300,
        text: "Alan editörü Yok \n Önceki Sayfaya Dön",
        function: () {
          control();
        }
      );
    }
    return NewButtonElement(
        colortext: Colors.teal.shade800,
        colorbutton: Colors.yellow.shade300,
        text: "ATAMA YAP",
        function: () {
//runapp > atama sayfası numarasını
          if (islem != null) {
            print(islem!.id.toString());
  String _formatDateTime(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }
 
 DateTime _now = DateTime.now();
    final String formattedDateTime = _formatDateTime(_now);
            setState(() {
              Makale mv = Makale(
                  id: aktifmakale.id,
                  baslik: aktifmakale.baslik,
                  mail: aktifmakale.mail,
                  zaman: aktifmakale.zaman,
                  onay: 1,
                  yazar: aktifmakale.yazar,revizyonzamani: aktifmakale.revizyonzamani,yol: aktifmakale.yol);

              MakaleIslem miv = MakaleIslem(
                  id: islem!.id,
                  makaleid: islem!.makaleid,
                  yazarid: islem!.yazarid,
                  alaneditorid: value!.id!,
                  baseditorid: islem!.baseditorid,
                  hakemcevap: islem!.hakemcevap,
                  alaneditorcevap: islem!.alaneditorcevap,
                  baseditorcevap: islem!.baseditorcevap,
                  baseditorzaman: formattedDateTime,
                  alaneditorzaman: islem!.alaneditorzaman,
                  durum: islem!.durum);

              islem!.alaneditorid != this.value!.id;
              dbHelper!.updateMakaleIslem(miv);
              dbHelper!.updateMakale(mv);
              // dbHelper!.updateMakale();
            });

            control();
          }
        });

    
  }
}
