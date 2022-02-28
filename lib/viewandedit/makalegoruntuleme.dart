


import 'package:codesad/addandrev/makaleadd.dart';
import 'package:codesad/addandrev/revizyon.dart';

import 'package:codesad/db_h.dart';
import 'package:codesad/makalelistform.dart';
import 'package:codesad/modules/hakemislem.dart';
import 'package:codesad/modules/makaleislem.dart';


import 'package:codesad/modules/makales.dart';
import 'package:codesad/modules/users.dart';


import 'package:codesad/mywidgets/specialwidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';



class MakaleGoruntuleForm extends StatefulWidget {
  const MakaleGoruntuleForm({Key? key}) : super(key: key);

  @override
  _MakaleGoruntuleForm createState() => _MakaleGoruntuleForm();
}

class _MakaleGoruntuleForm extends State<MakaleGoruntuleForm> {
  DbHelper dbHelper=DbHelper();
  Future<List<Makale>>? makaleList;
  List<MakaleIslem>? makaleislemler;
   List<User>? yazar;
   String kayitliordiger="";
  var mail =TextEditingController();
late MakaleIslem islemlist=MakaleIslem(makaleid: 9999, yazarid: 99999, alaneditorid: 9999, baseditorid: 99999, hakemcevap: 99999, alaneditorcevap: 9999, baseditorcevap: 9999, durum: 999,baseditorzaman: "",alaneditorzaman: "");



 
  
  
/*
//ConvertToFuture
makaleList=Future.value(m);
*/ 

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: BackButtoninAppBar(text: "Makaleni Ara"),
      body: Column(
        children: [
       Padding(
         padding: const EdgeInsets.all(15.0),
         child: TextFieldInputDec(text: "Mail",controllername: mail),
       ),
     Row(children: [ Padding(
       padding: const EdgeInsets.all(10.0),
       child: NewButtonElement(text: "Kayıtlı Yazar Olarak Ara",colortext: Colors.black,colorbutton: Colors.orange,function: (){
if (mail.text!=""){
makaleyidolduryazar();
}

         }),
     ),
       
       Padding(
         padding: const EdgeInsets.all(8.0),
         child: NewButtonElement(text: "Diğer Yazar Olarak Ara",colortext: Colors.black,colorbutton: Colors.green,function: (){
if (mail.text!=""){
makaleyidoldurdigeryazar();
}

         }),
       )
       ],), 
        Row(mainAxisAlignment: MainAxisAlignment.center,children: [Text(kayitliordiger,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)],),
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
                              child: ListTile(onTap: (){
                                loadData(snapshot.data![index].id!,snapshot.data![index].onay);
                         
                              },
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
                                trailing:  const Text("Ks"),
                                                              ),
                                ),
                              
                            
                          );
                        });
                  } else {
                    return const SizedBox();
                  }
                }),
          ),
        
        ],
      ),
    );
  }


 makaleyidoldurdigeryazar()async {
DbHelper  dbHelper=DbHelper();
String arayazarbilgi="'"+mail.text+"'";
 List<Makale>  liste=await dbHelper.getMakaleListSearch("WHERE mail="+arayazarbilgi);

  setState(() {
    
    makaleList=Future.value(liste);
      if (liste.isNotEmpty){
      kayitliordiger="Kayıtlı Yazar Makaleleri";
    }
    else {kayitliordiger="";}
    
  });
}

 makaleyidolduryazar() async{
   DbHelper  dbHelper=DbHelper();
String arayazarbilgi="'"+mail.text+"'";
List<Makale> liste=[];

yazar=(await dbHelper.getSearchUserList(" WHERE mail="+arayazarbilgi)); 
if (yazar!.isNotEmpty){
  makaleislemler=(await dbHelper.getSearchMakaleIslem(" WHERE yazarid="+yazar![0].id.toString()));

for (var item in makaleislemler!) {
  liste.add((await dbHelper.getMakaleListSearch(" WHERE id="+item.makaleid.toString())).first);
  
}
 
}

setState(() {
    
    makaleList=Future.value(liste);
    if (liste.isNotEmpty){
      kayitliordiger="Diğer Yazar Makaleleri";
    }
    else {kayitliordiger="";}
    
  });
  
}
loadData(int makaleid,int onay) async{
      late Future<List<MakaleIslem>> makaleList;
    MakaleIslem islem =  (await dbHelper.getSearchMakaleIslem('WHERE makaleid='+makaleid.toString())).first;
      //  makaleList = dbHelper!.getMakaleIslemList();
 
   HakemIslem hakem1=HakemIslem(id:-1,makaleid: -1, hakemid: -1, durum: -1, oy: -1,sonislem: "",rapor: "");
 HakemIslem hakem2=HakemIslem(id:-1,makaleid: -1, hakemid: -1, durum: -1, oy: -1,sonislem: "",rapor: "");
 HakemIslem hakem3=HakemIslem(id:-1,makaleid: -1, hakemid: -1, durum: -1, oy: -1,sonislem: "",rapor: "");
  List<HakemIslem> hakemler=(await dbHelper.getHakemIslemSearch("WHERE makaleid="+makaleid.toString()));
  if (hakemler.isNotEmpty){
//gecici olarka index ayarlama 
int i=0;
if (hakemler.length>0){hakem1=hakemler[i];i++;}
if (hakemler.length>1){hakem2=hakemler[i];i++;}
if (hakemler.length>2){hakem3=hakemler[i];}
    
  }

          showDialog<void>(context: context, builder: (_) =>  DetailDialogPanel(context: context,durum:textonaydondur(onay),alaneditortarih: islem.alaneditorzaman,baseditortarih: islem.baseditorzaman,
                                  hakem1tarih: hakem1.sonislem!,  hakem2tarih: hakem2.sonislem!,  hakem3tarih: hakem3.sonislem!,makaleid: makaleid.toString()),barrierDismissible: false);
   setState(() {
    
  hakemler;
  islemlist=islem;
    
 
    });
  }
}

