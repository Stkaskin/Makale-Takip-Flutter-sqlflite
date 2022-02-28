// ignore_for_file: file_names, use_key_in_widget_constructors

import 'package:codesad/addandrev/makaleadd.dart';
import 'package:codesad/addandrev/revizyon.dart';
import 'package:codesad/db_h.dart';
import 'package:codesad/main.dart';

import 'package:codesad/modules/users.dart';
import 'package:codesad/mywidgets/specialwidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class UserAddForm extends StatefulWidget {
  const UserAddForm({Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _UserAddForm createState() => _UserAddForm();
}

class yetkiler {
  final String yetkitext;
  final int yetkikodu;
  yetkiler({required this.yetkitext, required this.yetkikodu});
}

class _UserAddForm extends State<UserAddForm> {
  // ignore: prefer_const_literals_to_create_immutables, prefer_const_constructors [yetkiler(yetki: "BAŞ EDİTÖR",yetkikodu: 1)]
  yetkiler? yetkikaydet;
  List<DropdownMenuItem<yetkiler>> items = [
    DropdownMenuItem(
        value: yetkiler(yetkitext: "YAZAR", yetkikodu: 1),
        child: Text("YAZAR")),
    DropdownMenuItem(
        value: yetkiler(yetkitext: "ALAN EDİTÖR", yetkikodu: 2),
        child: Text("ALAN EDİTÖR")),
    DropdownMenuItem(
        value: yetkiler(yetkitext: "HAKEM", yetkikodu: 3), child: Text("HAKEM"))
  ];

  var ad = TextEditingController();
  var mail = TextEditingController();
  var tel = TextEditingController();
  var parola = TextEditingController();
  var yetki = TextEditingController();

  _UserAddForm();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() {
    if (girisyapan.yetki == 2) {
      items.removeAt(1);
    }
    yetkikaydet = items.first.value;
  }

  @override
  Widget build(BuildContext context) {
    // ignore: todo
    // TODO: implement build
    return Scaffold(
        appBar: BackButtoninAppBar(text: "Yeni Personel"),
        body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Expanded(
              child: RadiusContainerWidget(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  PaddingRowInText(
                      konum: MainAxisAlignment.center,
                      text: "Yeni Personel Ekleme Ekranı"),
                  TextFieldInputDec(controllername: ad, text: "AD"),
                  TextFieldInputDec(controllername: mail, text: "Mail"),
                  TextFieldInputDec(controllername: tel, text: "Telefon"),
                  TextFieldInputDec(controllername: parola, text: "Parola"),
                  Row(
                    /*
                 icon: Icon(Icons.send),
      hintText: text,
      helperText: text,
      //counterText: '0 characters',

      border: const OutlineInputBorder(),
               */
                    //   children: [Expanded(child: Text(tekraratama.toString()+". Hakem")),
                    children: [
                      Icon(Icons.send),
                      Expanded(
                          child: Text(
                        "  Yetki Türü",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                      Expanded(
                        child: DropdownButton<yetkiler>(
                          items: items.toList(),
                          value: yetkikaydet,
                          onChanged: (value) {
                            print(value!.yetkitext.toString());
                            setState(() {
                              yetkikaydet = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  NewButtonElement(
                      text: "Kaydet",
                      function: () {
                        if (ad.text != "" &&
                            mail.text != "" &&
                            parola.text != "") {
                          bool aetcontrol = false;
                          for (var item in mail.text.characters) {
                            if (item == "@") {
                              aetcontrol = true;
                            }
                          }
                          if (aetcontrol) {
                            showDialog<void>(
                                context: context,
                                builder: (_) => MyWidgetAlertDialog(
                                    uptext: "Yeni Personel Onay Ekranı",
                                    centertext:
                                        "Yeni Personeli Eklemek İstiyor Musunuz?",
                                    context: context,
                                    onaybtnfunc: () {
                                      ekleUser();
                                     
                                    }),
                                barrierDismissible: false);
                          } else
                        showDialog<void>(
                                context: context,
                                builder: (_) =>     ErrorDialogPanel(
                                context: context,
                                text: "Geçerli Mail Adresi Giriniz",
                                textunder:
                                    "Girdiğiniz Mail Adresi Geçersizdir.!."),barrierDismissible: false);
                        }
                      })
                ],
              ),
            ),
            color: Colors.yellow.shade100,
          )),
        ]));
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

   ekleUser()async {

List<User> liste= await DbHelper().getUserSearch(" WHERE mail='"+mail.text+"'");
if (liste.isEmpty){

    User user = User(
        ad: ad.text,
        mail: mail.text,
        parola: parola.text,
        yetki: yetkikaydet!.yetkikodu,aktif: 1);
    DbHelper db = DbHelper();
    db.insertUser(user);
    print("Usereklendi");
     control();
  }
  else {
    showDialog<void>(
                                context: context,
                                builder: (_) =>     ErrorDialogPanel(
                                context: context,
                                text: "Mail Hatası",
                                textunder:
                                    "Farklı Bir Mail Adresi Giriniz.!.\n Girdiğiniz Mail Adresi Bulunmaktadır."),barrierDismissible: false);

  }


  }
}

TextField TextFieldInputText() {
  return TextField();
}
/**
 * 
 *   showDialog<void>(
                                context: context,
                                builder: (_) =>     ErrorDialogPanel(
                                context: context,
                                text: "Mail Hatası",
                                textunder:
                                    "Farklı Bir Mail Adresi Giriniz.!.\n Girdiğiniz Mail Adresi Bulunmaktadır."),barrierDismissible: false);

 * 
 */