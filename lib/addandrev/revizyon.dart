// ignore_for_file: file_names, use_key_in_widget_constructors







import 'package:codesad/addandrev/makaleadd.dart';
import 'package:codesad/controlCenter/controldata.dart';
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





class MakeleRevizyonForm extends StatefulWidget {
 

  const MakeleRevizyonForm({Key? key}) : super(key: key);

  @override
  
  // ignore: no_logic_in_create_state
  _MakeleRevizyonForm createState() => _MakeleRevizyonForm();
}

var ad=TextEditingController();
var mail=TextEditingController();
var baslik=TextEditingController();
var kurum=TextEditingController();

class _MakeleRevizyonForm extends State<MakeleRevizyonForm> {
   String path="";
     String filetext="PDF SEÇİLMEDİ";
  @override
  
// ignore: must_call_super
initState(){
  baslik.text=aktifmakale.baslik;
    mail.text=aktifmakale.mail;
      ad.text=aktifmakale.yazar;
}

  _MakeleRevizyonForm();
  @override
  Widget build(BuildContext context) {
    
    // ignore: todo
    // TODO: implement build
    return Scaffold(
        appBar: BackButtoninAppBar(text: "Makale Revizyon"),
        body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Expanded(
              child: RadiusContainerWidget(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  
                    PaddingRowInText(
                      konum: MainAxisAlignment.center, text: "Makale REVİZYON Ekranı"),
                   
                   
                        
                          TextFieldText(controllername:baslik ,text: "Başlık"),
                           TextFieldText(controllername:ad ,text: "Ad"),
                          TextFieldText(controllername:mail ,text: "Mail"),
                            MyFileSelectWidget(),

                          //TextFieldInputDec(controllername:kurum ,text: "kurum"),
                  
                    NewButtonElement(text: "Revizyon Gönder",colorbutton: Colors.orange,colortext: Colors.lightBlueAccent,function: (){


                     revizyonkaydet();
                    }),
                        
            
               
                ],
              ),
            ),
            color: Colors.yellow.shade100,
          )),
        
          



          ]));
  }

 

  revizyonkaydet()async{
    if (path!=""){
    DbHelper dbHelper=DbHelper();
  MakaleIslem islem=(await dbHelper.getSearchMakaleIslem(" WHERE makaleid="+aktifmakale.id.toString())).first; 
  //makaleislem durum değişikliği
  dbHelper.updateMakaleIslem(MakaleIslem(id:islem.id,makaleid: islem.makaleid, yazarid: islem.yazarid, alaneditorid: islem.alaneditorid, baseditorid: islem.baseditorid, hakemcevap: -1, alaneditorcevap: islem.alaneditorcevap, baseditorcevap: islem.baseditorcevap, durum: 3,baseditorzaman: islem.baseditorzaman,alaneditorzaman: islem.alaneditorzaman));
    Makale makale=(await dbHelper.getMakaleListSearch(" WHERE id="+aktifmakale.id.toString())).first; 
    dbHelper.updateMakale(Makale(id: makale.id,baslik:  makale.baslik, mail:  makale.mail, zaman:  makale.zaman, onay: 3, yazar:  makale.yazar,yol: path,revizyonzamani: makale.revizyonzamani));
    List<HakemIslem> hakemler=(await dbHelper.getHakemIslemSearch(" WHERE makaleid="+aktifmakale.id.toString()));
    if (hakemler.isNotEmpty){
      for (var item in hakemler) {
        dbHelper.updateHakemIslem(HakemIslem(id: item.id,makaleid: item.makaleid, hakemid: item.hakemid, durum: 2, oy: -1,sonislem: item.sonislem,rapor: ""));
        
      }
      }
      control();
      }
      else {
         showDialog(context: context, builder: (_)=>ErrorDialogPanel(context: context,text: "Lütfen Dosya Seçin",textunder: "Lütfen Dosya Seçin" ),barrierDismissible: false);

      }
    }
  
Widget TextFieldText(
    {TextEditingController? controllername, String? text}) {
  return TextField(enabled: false,
    controller: controllername,
    decoration: InputDecoration(
      icon: Icon(Icons.send),
      hintText: text,
      helperText: text,
      //counterText: '0 characters',

      border: const OutlineInputBorder(),
    ),
  );
}

  // ignore: non_constant_identifier_names
  Padding PaddingRowInText({String? text, MainAxisAlignment? konum}) {
    konum ??= MainAxisAlignment.start;
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


