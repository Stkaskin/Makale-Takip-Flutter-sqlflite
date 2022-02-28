

import 'package:codesad/addandrev/makaleadd.dart';
import 'package:codesad/db_h.dart';
import 'package:codesad/main.dart';
import 'package:codesad/modules/hakemislem.dart';
import 'package:codesad/modules/makaleislem.dart';
import 'package:codesad/modules/makales.dart';
import 'package:codesad/modules/users.dart';
import 'package:codesad/mywidgets/specialwidgets.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:flutter/widgets.dart';


var drop1 = TextEditingController();
int yukleme=0;

class HakemAtamaForm extends StatefulWidget {
  const HakemAtamaForm({Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _HakemAtamaForm createState() => _HakemAtamaForm();
}
String aynisecilemez="Hakemler Aynı Seçilemez.!.";
class _HakemAtamaForm extends State<HakemAtamaForm> {
  _HakemAtamaForm();
 
 DbHelper? dbHelper;
 User? hakem1;
 User? hakem2;
 User? hakem3;
  User? hakem1tut;
 User? hakem2tut;
 User? hakem3tut;
 int tekraratama=1;
 int tekraratamatut=1;
List<int> idler=[];

late Future<List<User>> ListFuture;
List<User>? listeUser;
List<String>?  indexS;

 List<DropdownMenuItem<User>>? items=[DropdownMenuItem(value: User(ad: "ad", mail: "mail", parola: "parola", yetki: 3,aktif: 1) ,child: Text("sec"))];
 List<DropdownMenuItem<User>>? items1=[DropdownMenuItem(value: User(ad: "ad", mail: "mail", parola: "parola", yetki: 3,aktif: 1) ,child: Text("sec"))];
 List<DropdownMenuItem<User>>? items2=[DropdownMenuItem(value: User(ad: "ad", mail: "mail", parola: "parola", yetki: 3,aktif: 1) ,child: Text("sec"))];
  @override
  void initState() {
// TODO: implement initState
super.initState();
dbHelper=DbHelper();
loadData ();
  } 
 
loadData() async{
 
  ListFuture=dbHelper!.getSearchUserList(" WHERE yetki=3 AND aktif=1");  
  listeUser=await ListFuture;

  
List<HakemIslem>   atamalarcontol= await dbHelper!.getHakemIslemSearch(" WHERE makaleid="+aktifmakale.id.toString());
   if (atamalarcontol.isNotEmpty && atamalarcontol.length<3){
 tekraratama=atamalarcontol.length;
tekraratamatut=tekraratama;

   }


  for (var element in listeUser!) {
   
if (atamalarcontol.isNotEmpty ){
  
 if (atamalarcontol.isNotEmpty){
  if (atamalarcontol[0].hakemid==element.id){
hakem1=element;
idler.add(hakem1!.id!);
  

}
 }
 if (atamalarcontol.length>1){
if (atamalarcontol[1].hakemid==element.id){
  hakem2=element;
 idler.add(hakem2!.id!);
   
  }
 }
 if (atamalarcontol.length>2){
if (atamalarcontol[2].hakemid==element.id){
  hakem3=element;
idler.add(hakem3!.id!);
  }
 }

  
}

items!.add(DropdownMenuItem(value: element ,child: Text(element.id.toString()+"* "+element.ad),));

   }
 
   
 


 if (items!.length>1){  items!.remove(items!.first);
}


 

items1=items2=items;

hakem1tut=hakem1;
hakem2tut=hakem2;
hakem3tut=hakem3;

hakem1 ??= items!.first.value;
hakem2 ??= items1!.first.value;
hakem3 ??= items2!.first.value;
 /*
  if (atamalarcontol.length==0){ hakem1=items!.first.value; hakem2=items1!.first.value; hakem3=items2!.first.value; }
  if (atamalarcontol.length==1){hakem1=items!.first.value; hakem2=items1!.first.value; }
  if (atamalarcontol.length==2){ hakem1=items!.first.value;}*/

 
print(aktifmakale.baslik+"makale  id "+aktifmakale.id.toString());
setState(() {
 tekraratama=atamalarcontol.length;
 
});


}
  @override
  Widget build(BuildContext context) {
// ignore: todo
// TODO: implement build

   // final items = ['item1', 'item2', "item3", "item4", "item5"];
  if (yukleme==0)
  {
yukleme=1;
return Scaffold();
}
return Scaffold(
appBar: BackButtoninAppBar(text: "Hakem Atama"),
body:  Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
  Expanded(
  child: RadiusContainerWidget(
child: SingleChildScrollView(
  child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
children: [
  PaddingRowInText(
  konum: MainAxisAlignment.center,
  text: "Hakem Atama Sayfası"),
  
   RowTextandDropDown(text: "1. Hakem",user: this.hakem1,userlist: items!,hakemkod: 1),
   RowTextandDropDown(text: "2. Hakem",user: this.hakem2,userlist: items1!,hakemkod: 2),
   RowTextandDropDown(text: "3. Hakem",user: this.hakem3,userlist: items2!,hakemkod: 3),
   
  
  ButtonF(text: "Kaydet",fonksiyon: () {
setState(() {
  
if (  hakemDropDownControl()==1){
 //atama işlemini başlat
 tekraratama=tekraratamatut;
 print("atama yapıldı") ;
   showDialog<void>(context: context, builder: (_) =>   MyWidgetAlertDialog(uptext: "Hakem Atama Onay Ekranı",centertext: "Hakem Atamasını Onaylıyor Musunuz?",context:context,onaybtnfunc: (){

 hakemlerieslestir();
dbHelper!.updateMakale(Makale(
  //degistirildi onay aktifmakale.onay+1 > 2
 id:aktifmakale.id, baslik: aktifmakale.baslik, mail: aktifmakale.mail, zaman: aktifmakale.zaman, onay: 2, yazar: aktifmakale.yazar,yol: aktifmakale.yol,revizyonzamani: aktifmakale.revizyonzamani));
print("Hakemler atandı");
control();
  } ), barrierDismissible: false);
   


}
});

  }),
  Padding(
padding: const EdgeInsets.all(20.0),
child: Text(aynisecilemez,style: TextStyle(color: Colors.red,fontSize: 20,fontWeight: FontWeight.bold),),
  )

],
  ),
),
color: Colors.yellow.shade100,
  )),
]));
  }
 hakemDropDownControl() {
  
  
 if (hakem1==hakem2|| hakem3==hakem1 ||hakem2==hakem3)
 {
   aynisecilemez="Aynı hakemler seçilemez";
 tekraratama=tekraratamatut;
 return 0;}
 else {aynisecilemez=""; 
  
 
 return 1;}


}
void hakemlerieslestir(){
  
  String _formatDateTime(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }
 
 DateTime _now = DateTime.now();
    final String formattedDateTime = _formatDateTime(_now);
     setState(() {
    
   if (hakem1tut==null){
dbHelper!.insertHakemIslem(HakemIslem(makaleid: aktifmakale.id!, hakemid: hakem1!.id!, durum: 1, oy: -1,sonislem:formattedDateTime,rapor: ""));
   }
 });
 setState(() {
if (hakem2tut==null){
dbHelper!.insertHakemIslem(HakemIslem(makaleid: aktifmakale.id!, hakemid: hakem2!.id!, durum: 1, oy: -1,sonislem:formattedDateTime ,rapor: ""));
  } });
   setState(() {
  if (hakem3tut==null){
dbHelper!.insertHakemIslem(HakemIslem(makaleid: aktifmakale.id!, hakemid: hakem3!.id!, durum: 1, oy: -1,sonislem: formattedDateTime,rapor: ""));
 }  });
alaneditorislemguncelle(formattedDateTime); 
}

alaneditorislemguncelle(String time)async{
  DbHelper dbHelper =DbHelper();
    MakaleIslem islem=(await dbHelper.getSearchMakaleIslem(" WHERE makaleid="+aktifmakale.id.toString())).first; 
    dbHelper.updateMakaleIslem(MakaleIslem(id: islem.id,makaleid: islem.makaleid, yazarid: islem.yazarid, alaneditorid: islem.alaneditorid, baseditorid: islem.baseditorid, hakemcevap: islem.hakemcevap, alaneditorcevap: islem.alaneditorcevap, baseditorcevap: islem.baseditorcevap, baseditorzaman: islem.baseditorzaman, alaneditorzaman:time , durum: islem.durum));

}
  Row RowTextandDropDown({  List<DropdownMenuItem<User>>?  userlist, User? user,required String? text,required  int hakemkod}) {
   
   if (hakemkod==1){
if (hakem1tut!=null && hakem1tut!.id!=null){
  return Row();
} 
   }
   if (hakemkod==2){
if (hakem2tut!=null && hakem2tut!.id!=null){
  return Row();
} 
   }
  if (hakemkod==3){
if (hakem3tut!=null && hakem3tut!.id!=null){
  return Row();
} 
   }

   
return Row(
//   children: [Expanded(child: Text(tekraratama.toString()+". Hakem")),
   children: [Expanded(child: Text(text!)),
 Expanded(
   child: DropdownButton<User>( items: userlist!.toList(),value: user,onChanged: (value){print(value!.ad.toString());
   setState(() {
 if (hakemkod==1){
   
   hakem1=value;
   }
 else if (hakemkod==2){hakem2=value;}
 else {hakem3=value;}
tekraratama=tekraratamatut;
   
 
   });
   },),
 ),
   ],
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


  
}

