// ignore_for_file: file_names, use_key_in_widget_constructors

import 'package:codesad/addandrev/makaleadd.dart';
import 'package:codesad/addandrev/revizyon.dart';

import 'package:codesad/db_h.dart';
import 'package:codesad/main.dart';
import 'package:codesad/modules/hakemislem.dart';

import 'package:codesad/modules/makaleislem.dart';
import 'package:codesad/modules/makales.dart';
import 'package:codesad/mywidgets/specialwidgets.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';



class HakemOyForm extends StatefulWidget {
  const HakemOyForm({Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _HakemOyForm createState() => _HakemOyForm();
}

class _HakemOyForm extends State<HakemOyForm> {
  var puan = TextEditingController();
  late List<MakaleIslem> islemlist;
String path="";
  String filetext="PDF SEÇİLMEDİ";
  DbHelper? dbHelper;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = DbHelper();
    loadData();
  }

  loadData() async {
    late Future<List<MakaleIslem>> makaleList;
    makaleList = dbHelper!.getMakaleIslemList();
    islemlist = await makaleList;
  }

  _HakemOyForm();

  @override
  Widget build(BuildContext context) {
    // ignore: todo
    // TODO: implement build
    return Scaffold(
        appBar: BackButtoninAppBar(text: "Oy Verme Ekranı"),
        body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Expanded(
              child: RadiusContainerWidget(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  PaddingRowInText(
                      konum: MainAxisAlignment.center,
                      text: aktifmakale.baslik.characters.length>16?aktifmakale.baslik.substring(0,15):aktifmakale.baslik),
                  PaddingRowInText(text: aktifmakale.yazar),
                  PaddingRowInText(text: aktifmakale.id.toString()),
                  PaddingRowInText(text: aktifmakale.zaman),
                  PaddingRowInText(text: aktifmakale.onay.toString()),
                     MyFileSelectWidget(),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        helperText: "Puan Giriniz",
                        hintText: 'Lütfen Puan Girin'),
                    onChanged: (value) {
                      // ignore: avoid_print
                      try {
                        if (value != "" && int.parse(value) > 0) {
                          int puantut = int.parse(value);

                          if (puantut > 100) {
                            puan.text = 100.toString();
                          }
                        } else {
                          puan.text = 0.toString();
                        }
                      } catch (e) {
                        puan.text = "";
                      }
                    },
                    controller: puan,
                  ),
                  NewButtonElement(
                      function: () {
                        if (puan.text != "") {
                          int puantut = int.parse(puan.text);
                          if (puantut >= 0 && puantut <= 100) {
                         showDialog<void>(context: context, builder: (_) => MyWidgetAlertDialog(onaybtnfunc:(){
                           hakemoyver(gelenoy: puan.text,path: path);
                         },context: context,uptext: "Oy Kaydetme Ekranı" ,onaytext: "Onayla",redtext: "İptal",centertext:"Bu makaleye "+ puan.text+" puan veriyorsunuz . Onaylıyor musunuz ?"), barrierDismissible: false);
           
                          }
                        }
                      },
                      text: "Kaydet",
                      colorbutton: Colors.black87,
                      colortext: Colors.white)
                ],
              ),
            ),
            color: Colors.brown.shade200,
          )),
        ]));
  }

  Padding PaddingRowInText({String? text, MainAxisAlignment? konum}) {
    konum ??= MainAxisAlignment.start;
    return Padding(
      padding: const EdgeInsets.all(13.0),
      child: Row(
        mainAxisAlignment: konum,
        children: [
          // ignore: prefer_const_constructors
          Text(
            text!,
            // ignore: prefer_const_constructors
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
 Future selectFile() async{
     
final result =await FilePicker.platform.pickFiles(allowMultiple: false);
if (result==null){return null;}

 path =result.files.single.path!;
print(path.substring(path.length-3,path.length));
if (path.substring(path.length-3,path.length)=='pdf'){
  setState(() {
    filetext="PDF SEÇİLDİ";
  });

}
else {
   setState(() {
  path="";
  filetext="PDF SEÇİLMEDİ";
    });
}

}
 Widget MyFileSelectWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
  children: [
      Expanded(child: Text(path!=""?"PDF SEÇİLDİ":"PDF SEÇİLMEDİ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)),  
       Expanded(
         child: ElevatedButton(
       
           
                  
              onPressed: selectFile,
              child: Text( "Dosya Seç")
             
             ),
       ),
  ],
),
    );
  }
}

void hakemoyver({required String gelenoy, String path=""} ) async{
  
  DbHelper dbHelper = DbHelper();
  int oy =int.parse(gelenoy);
  String _formatDateTime(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }
 
 DateTime _now = DateTime.now();
    final String formattedDateTime = _formatDateTime(_now);
    
  HakemIslem hakem=(await dbHelper.getHakemIslemSearch(" WHERE hakemid="+girisyapan.id.toString()+ " AND makaleid="+aktifmakale.id.toString())).first;
if (hakem!=null){

  dbHelper.updateHakemIslem(HakemIslem(id:hakem.id, makaleid: hakem.makaleid, hakemid: hakem.hakemid, durum: 3, oy:oy ,rapor: path,sonislem: formattedDateTime));
  List<HakemIslem> hakemler=(await dbHelper.getHakemIslemSearch(" WHERE makaleid="+aktifmakale.id.toString()));
if (hakemler.isNotEmpty){
if (hakemler[0].durum==3 && hakemler[1].durum==3 && hakemler[2].durum==3){
 double ortalama=( hakemler[0].oy+   hakemler[1].oy+ hakemler[2].oy)/3;
 int sortalama=(ortalama).toInt() ;
  MakaleIslem islem=(await dbHelper.getSearchMakaleIslem(" WHERE makaleid="+aktifmakale.id.toString())).first; 
  //makaleislem durum değişikliği
  dbHelper.updateMakaleIslem(MakaleIslem(id:islem.id,makaleid: islem.makaleid, yazarid: islem.yazarid, alaneditorid: islem.alaneditorid, baseditorid: islem.baseditorid, hakemcevap: sortalama, alaneditorcevap: islem.alaneditorcevap, baseditorcevap: islem.baseditorcevap, durum: 4,baseditorzaman: islem.baseditorzaman,alaneditorzaman: islem.alaneditorzaman));
    Makale makale=(await dbHelper.getMakaleListSearch(" WHERE id="+aktifmakale.id.toString())).first; 
    dbHelper.updateMakale(Makale(id: makale.id,baslik:  makale.baslik, mail:  makale.mail, zaman:  makale.zaman, onay: 4, yazar:  makale.yazar,yol: makale.yol,revizyonzamani: makale.revizyonzamani));
} 

}
  
  print("BULUNDU DEĞİŞTİ");control();
  }
  
   
}
