// ignore_for_file: file_names, use_key_in_widget_constructors

import 'package:codesad/addandrev/makaleadd.dart';

import 'package:codesad/db_h.dart';
import 'package:codesad/main.dart';
import 'package:codesad/makalelistform.dart';
import 'package:codesad/modules/hakemislem.dart';
import 'package:codesad/modules/makaleislem.dart';

import 'package:codesad/mywidgets/specialwidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

class MakaleDetailForm extends StatefulWidget {


  const MakaleDetailForm({Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _MakaleDetailForm createState() => _MakaleDetailForm();
}

class _MakaleDetailForm extends State<MakaleDetailForm> {
 
  late MakaleIslem islemlist=MakaleIslem(makaleid: 9999, yazarid: 99999, alaneditorid: 9999, baseditorid: 99999, hakemcevap: 99999, alaneditorcevap: 9999, baseditorcevap: 9999, durum: 999,baseditorzaman: "",alaneditorzaman: "");

   HakemIslem hakem1=HakemIslem(id:-1,makaleid: -1, hakemid: -1, durum: -1, oy: -1,sonislem: "",rapor: "");
 HakemIslem hakem2=HakemIslem(id:-1,makaleid: -1, hakemid: -1, durum: -1, oy: -1,sonislem: "",rapor: "");
 HakemIslem hakem3=HakemIslem(id:-1,makaleid: -1, hakemid: -1, durum: -1, oy: -1,sonislem: "",rapor: "");
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
    makaleList = dbHelper!.getSearchMakaleIslem('WHERE makaleid='+aktifmakale.id.toString());
      //  makaleList = dbHelper!.getMakaleIslemList();
   var list=await makaleList;

  List<HakemIslem> hakemler=(await dbHelper!.getHakemIslemSearch("WHERE makaleid="+aktifmakale.id.toString()));
  if (hakemler.isNotEmpty){
//gecici olarka index ayarlama 
int i=0;
if (hakemler.length>0){hakem1=hakemler[i];i++;}
if (hakemler.length>1){hakem2=hakemler[i];i++;}
if (hakemler.length>2){hakem3=hakemler[i];}
    
  }
   setState(() {
     
  
    if(list.length>0) {
    islemlist = list.first;
    }
 
    });
   
   
  }

  _MakaleDetailForm();

  @override
  Widget build(BuildContext context) {
    // ignore: todo
    // TODO: implement build
    return Scaffold(
        appBar: BackButtoninAppBar(text: "Makale Detayları"),
        body: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            RadiusContainerWidget(
              child: Column(
            children: [
              RowPaddingRowInText(
                  konum: MainAxisAlignment.center, text: aktifmakale.baslik,textstart: "BAŞLIK"),
              RowPaddingRowInText(text:aktifmakale.id.toString(),textstart: "ID"),
                 RowPaddingRowInText(text: islemlist.yazarid.toString(),textstart: "YAZAR ID"),
            
              RowPaddingRowInText(text: aktifmakale.yazar,textstart: "DİĞER YAZAR"),
              RowPaddingRowInText(text: aktifmakale.zaman.substring(0, 16),textstart: "GÖNDERİM"),
              RowPaddingRowInText(text: textonaydondur(aktifmakale.onay),textstart: "DURUM")
            ],
              ),
              color: Colors.red,
            ),
            RadiusContainerWidget(
              color: Colors.blue.shade200,
              child: Column(
            children: [
              RowPaddingRowInText(
                  konum: MainAxisAlignment.center, text: islemlist.id.toString(),textstart: "ID"),
              RowPaddingRowInText(textstart:"MAKALE DURUM",text:textonaydondur(aktifmakale.onay)),
                       RowPaddingRowInText(text: islemlist.makaleid.toString(),textstart: "Makale ID:"),
                        RowPaddingRowInText(text: islemlist.baseditorid.toString(),textstart: "Baş Editör ID"),
                         RowPaddingRowInText(text: islemlist.baseditorzaman.toString(),textstart: "Baş Editör Son İşlem"),
              RowPaddingRowInText(text: islemlist.alaneditorid.toString(),textstart: "Alan Editör ID"),
                 RowPaddingRowInText(text: islemlist.alaneditorzaman.toString(),textstart: "Alan Editör Son İşlem"),
              RowPaddingRowInText(text: hakem1.hakemid.toString(),textstart: "1.Hakem"),
                                 RowPaddingRowInText(text: hakem1.oy.toString(),textstart: "1.Hakem Puan"),
                      RowPaddingRowInText(text: hakem1.sonislem.toString(),textstart: "1.Hakem Son İşlem"),
                      hakempdflinkbuttonandtext(text: "2",link: hakem1.rapor.toString()),
         
                   RowPaddingRowInText(text: hakem2.hakemid.toString(),textstart: "2.Hakem"),
                                RowPaddingRowInText(text: hakem2.oy.toString(),textstart: "2.Hakem Puan"),
                      RowPaddingRowInText(text: hakem2.sonislem.toString(),textstart: "2.Hakem Son İşlem"),
              hakempdflinkbuttonandtext(text: "2",link: hakem2.rapor.toString()),
                          RowPaddingRowInText(text:  hakem3.hakemid.toString(),textstart: "3.Hakem"),
                                       RowPaddingRowInText(text: hakem3.oy.toString(),textstart: "3.Hakem Puan"),
                      RowPaddingRowInText(text: hakem3.sonislem.toString(),textstart: "3.Hakem Son İşlem"),
                           hakempdflinkbuttonandtext(text: "3",link: hakem3.rapor.toString()),
         
                         
            ],
              ),
            )
          ]),
        ));
  }

  Widget hakempdflinkbuttonandtext({required String text,String link="YOK"}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(children: [
                        Expanded(child: Text(text+".Hakem Rapor Pdf",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)),Expanded(child: NewButtonElement(colorbutton: Colors.yellow,colortext: Colors.black,text: "PDF'Link",
                        
                        function: (){
 showDialog<void>(context: context, builder: (_) => MyWidgetAlertDialog(onaybtnfunc:(){
                           

                         },context: context,uptext: "PDF EKRANI" ,onaytext: "Git",redtext: "Kopyala",centertext:"PDF ADRESİ\n "+link), barrierDismissible: false);
           
                        }
                        
                        ))
                      ],),
    );
  }


 
}
 // ignore: non_constant_identifier_names
 Widget RowPaddingRowInText ({ String text="", MainAxisAlignment konum=MainAxisAlignment.start, String textstart=":"}) {
    if (konum == null) {
      konum = MainAxisAlignment.start;
    }
    // ignore: unrelated_type_equality_checks, unnecessary_null_comparison
    if ( konum==MainAxisAlignment.center) {
      return RowTextMy(konum:konum, textstart: textstart);
    };
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
           Expanded(
             child: RowTextMy( textstart: textstart),
           ),
          Expanded(
            child: RowTextMy(textstart: " : "+text),
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Row RowTextMy({MainAxisAlignment? konum=MainAxisAlignment.start,required String textstart}) {
    return Row(
           mainAxisAlignment: konum!,
           children: [
             Text(
               textstart,
               // ignore: prefer_const_constructors
               style: TextStyle(
                   color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
             ),
           ],
         );
  }