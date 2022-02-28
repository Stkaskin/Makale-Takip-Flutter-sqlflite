
// ignore_for_file: file_names, use_key_in_widget_constructors

import 'package:codesad/addandrev/makaleadd.dart';
import 'package:codesad/atama/alanedata.dart';

import 'package:codesad/db_h.dart';
import 'package:codesad/main.dart';
import 'package:codesad/makaleDetailForm.dart';
import 'package:codesad/modules/hakemislem.dart';

import 'package:codesad/modules/makaleislem.dart';
import 'package:codesad/modules/makales.dart';


import 'package:codesad/mywidgets/specialwidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';

 

class AlanEdInceleme extends StatefulWidget{


const AlanEdInceleme ({Key? key}):super(key:key);
     
  @override
  // ignore: no_logic_in_create_state
  _AlanEdInceleme createState()=>_AlanEdInceleme();



} 
  class _AlanEdInceleme extends State<AlanEdInceleme>{

 HakemIslem hakem1=HakemIslem(makaleid: -1, hakemid: -1, durum: -1, oy: -1,sonislem: "",rapor: "");
 
 HakemIslem hakem2=HakemIslem(makaleid: -1, hakemid: -1, durum: -1, oy: -1,sonislem: "",rapor: "");
 
 HakemIslem hakem3=HakemIslem(makaleid: -1, hakemid: -1, durum: -1, oy: -1,sonislem: "",rapor: "");
  MakaleIslem? makaleislem=MakaleIslem(id: -1,makaleid: -1, yazarid: -1, alaneditorid: -1, baseditorid: -1, hakemcevap: -1, alaneditorcevap: -1, baseditorcevap: -1, durum: -1,alaneditorzaman: "-1",baseditorzaman: "-1");
      
  DbHelper? dbHelper;
   

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper=DbHelper();
    loadData();
    
  } 

loadData() async{
    MakaleIslem tutislem;
  tutislem=(await dbHelper!.getSearchMakaleIslem( " WHERE makaleid="+aktifmakale.id.toString())).first;  
if (tutislem!=null){
 
     makaleislem=tutislem;

List<HakemIslem> hakemler = await dbHelper!.getHakemIslemSearch(" WHERE makaleid="+aktifmakale.id.toString());
if (hakemler.isNotEmpty){
  int i=0;
  if (hakemler.length>0){hakem1=hakemler[i];i++;}
   if (hakemler.length>0){hakem2=hakemler[i];i++;}
    if (hakemler.length>0){hakem3=hakemler[i];}
    setState(() {
      makaleislem=makaleislem;
      hakem1;hakem2;hakem3;
    });
}

}

else {
  makaleislem=MakaleIslem(id: -1,makaleid: -1, yazarid: -1, alaneditorid: -1, baseditorid: -1, hakemcevap: -1, alaneditorcevap: -1, baseditorcevap: -1, durum: -1,baseditorzaman: "-1",alaneditorzaman: "-1");
}
}

   _AlanEdInceleme ();

  @override 
  Widget build(BuildContext context) {
  

    // ignore: todo
    // TODO: implement build
   return Scaffold(
      appBar: BackButtoninAppBar(text: "Makale İnceleme"),
   body: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [Expanded(child: RadiusContainerWidget(   
       child: Column(
      
      children: [ RowPaddingRowInText(konum: MainAxisAlignment.center,textstart: "MAKALE ID"),
      
       RowPaddingRowInText(textstart: "IŞLEM ID",text: makaleislem!.id.toString()),
       RowPaddingRowInText(textstart: "MAKALE ID",text: makaleislem!.makaleid.toString()),
        RowPaddingRowInText(textstart: "YAZAR ID",text: makaleislem!.yazarid.toString()),
           RowPaddingRowInText(textstart: "ALAN EDİTOR ID",text: makaleislem!.alaneditorid.toString()),
           RowPaddingRowInText(textstart: "BAS EDİTÖR ID",text: makaleislem!.baseditorid.toString()),
           RowPaddingRowInText(textstart: "İŞLEM DURUMU",text: makaleislem!.durum.toString()),
      ],
      ),color: Colors.red,
   
   
    )),
    Expanded(child: RadiusContainerWidget(color: Colors.blue.shade200,
    child: Column(
      
      children: [ RowPaddingRowInText(konum: MainAxisAlignment.center,textstart: "MAKALE ID",text:""),
      
       RowPaddingRowInText(textstart: "1.Hakem Id: "+hakem1.id.toString(),text: " PUAN: "+hakem1.oy.toString()),
   RowPaddingRowInText(textstart: "1.Hakem Id: "+hakem2.id.toString(),text: " PUAN: "+hakem2.oy.toString()),
   RowPaddingRowInText(textstart: "1.Hakem Id: "+hakem3.id.toString(),text: " PUAN: "+hakem3.oy.toString()),
      RowPaddingRowInText(textstart: "ORTALAMA:",text:makaleislem!.hakemcevap.toString() ),
      
      onayredrevizyonbutton()
      ],
      ),
    ))]
   ));
  }

  Row onayredrevizyonbutton() {
    if  (makaleislem!=null && makaleislem!.id!=-1 ){
    return Row(children: [onayandredbtn(),
    Expanded(child: NewButtonElement(colortext: Colors.yellow,colorbutton: Colors.brown,text: "REVİZYON",function: (){
showDialog<void>(context: context, builder: (_) => MyWidgetAlertDialog(onaybtnfunc:(){cevapfunc(cevap:3);},redbtnfunc: (){},context: context,uptext: "Cevap Kayıt Ekranı",centertext: "Revizyon Talebiniz Kaydedilsin Mi ?"), barrierDismissible: false);
  


    } )),],);}
    return Row();
  }
  Widget onayandredbtn (){
    if (makaleislem!.hakemcevap>=75){
return Expanded(child: NewButtonElement(colortext: Colors.yellow,colorbutton: Colors.green,text: "Onayla",function: (){

showDialog<void>(context: context, builder: (_) => MyWidgetAlertDialog(onaybtnfunc:(){cevapfunc(cevap:1);},redbtnfunc: (){},context: context,uptext: "Cevap Kayıt Ekranı",centertext: "Onay Cevabınız Kaydedilsin Mi ?"), barrierDismissible: false);
   
    } ));
    }
    else {
return  Expanded(child: NewButtonElement(colortext: Colors.yellow,colorbutton: Colors.red,text: "RED ET",function: (){

showDialog<void>(context: context, builder: (_) => MyWidgetAlertDialog(onaybtnfunc:(){cevapfunc(cevap:2);},redbtnfunc: (){},context: context,uptext: "Cevap Kayıt Ekranı",centertext: "Onay Cevabınız Kaydedilsin Mi ?"), barrierDismissible: false);
    

    } ));
    }

}


  // ignore: non_constant_identifier_names
  Padding PaddingRowInText({String? text ,MainAxisAlignment? konum}){
    konum ??= MainAxisAlignment.start;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment:konum ,
        children: [
          // ignore: prefer_const_constructors
          Text(text! ,style: TextStyle(

color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold

  ),),
        ],
      ),
    );
  }
 
   cevapfunc({int cevap=-1}){
     
     if (cevap!=-1){
       DbHelper dbHelper=  DbHelper();
       int alaned=-1;
       int sondurum=-1;
     if (cevap==1){
       alaned=1;
       sondurum=5;
     }
     else if (cevap==2){
alaned=2;
sondurum=7;
     }
     else if (cevap==3){
alaned=3;
sondurum=6;
     }
     
  String _formatDateTime(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }
 
 DateTime _now = DateTime.now();
    final String formattedDateTime = _formatDateTime(_now);

dbHelper.updateMakaleIslem(MakaleIslem(id:makaleislem!.id,makaleid: makaleislem!.makaleid, yazarid: makaleislem!.yazarid, alaneditorid: makaleislem!.alaneditorid, baseditorid: makaleislem!.baseditorid, hakemcevap: makaleislem!.hakemcevap, alaneditorcevap: alaned, baseditorcevap: makaleislem!.baseditorcevap, durum: makaleislem!.durum,alaneditorzaman: formattedDateTime,baseditorzaman: makaleislem!.baseditorzaman));
dbHelper.updateMakale(Makale(id:aktifmakale.id,baslik: aktifmakale.baslik, mail: aktifmakale.mail, zaman: aktifmakale.zaman, onay: sondurum, yazar: aktifmakale.yazar,revizyonzamani: cevap==3?formattedDateTime: aktifmakale.revizyonzamani,yol: aktifmakale.yol));
control();
  }

   }
  
  }

 