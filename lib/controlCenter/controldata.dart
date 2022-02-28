import 'package:codesad/apis/api.dart';
import 'package:codesad/db_h.dart';
import 'package:codesad/main.dart';
import 'package:codesad/modules/hakemislem.dart';
import 'package:codesad/modules/makaleislem.dart';
import 'package:codesad/modules/makales.dart';
import 'package:codesad/modules/users.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';


class ControlCenter {

hakemdavetcontrol() async{
///hakem son islem tarihi ve durum ile davet controlü yapılır 
///
DbHelper dbHelper=DbHelper();
List<HakemIslem> liste=(await dbHelper.getHakemIslemList());
for (var item in liste) {
  if (item.durum==1 ){
    //2021-10-12
    
    String ay=item.sonislem!.substring(5,7);
    String gun=item.sonislem!.substring(8,10);
    String yil=item.sonislem!.substring(0,4);
 var time=DateTime(int.parse( yil),int.parse( ay),int.parse( gun));
var ara=time.add(Duration(days: 10));
var timetut=DateTime.now();
 //2021 10 10
  //2 zaman arası fark datetime-datetime
var difference=timetut.difference(ara).inDays;
if (difference>=0){

dbHelper.deleteHakemIslem(item.id!);
}

  }
  else if (item.durum==2){
      
    String ay=item.sonislem!.substring(5,7);
    String gun=item.sonislem!.substring(8,10);
    String yil=item.sonislem!.substring(0,4);
 var time=DateTime(int.parse( yil),int.parse( ay),int.parse( gun));
var ara=time.add(Duration(days: 21));
var timetut=DateTime.now();
 //2021 10 10
  //2 zaman arası fark datetime-datetime
var difference=timetut.difference(ara).inDays;
if (difference>=0){

dbHelper.deleteHakemIslem(item.id!);
}


  }
  
}



}
kurulumcontol()async{
  //deleteDatabase("/data/user/0/com.example.codesad/app_flutter/MakaleDb.db");
  DbHelper dbHelper=DbHelper();
  List<User> users =(await  dbHelper.getSearchUserList(" WHERE yetki=4"));

  //delete
  if (users.isEmpty){
    
    runApp(MyApp(sayfakod: 100));
  }
  else {
hakemdavetcontrol();
    revizyoncontrol();
      runApp(MyApp(sayfakod: sayfalar.last,));
  }
}



yetkilibildirimcontrol() async{


  if (girisyapan.yetki==4) {
    DbHelper dbHelper =DbHelper();
        List<Makale> liste= (await dbHelper.getMakaleListSearch(" WHERE onay=0"));
        if (liste.isNotEmpty){
           NotificationService().showNotification(1, "Atama Gereken Makaleler Var.!.", liste.length.toString()+ " Adet Atama Yapılmamış\nMakale Mevcut", 2);
        }
  }
   else if (girisyapan.yetki==2) {
    DbHelper dbHelper =DbHelper();
    List<MakaleIslem> makaleislemlist=[];
       List<Makale> liste= (await dbHelper.getMakaleListSearch(" WHERE onay=1 OR onay=4 "));
       for (var item in liste) {
       makaleislemlist.add(  (await dbHelper.getSearchMakaleIslem(" WHERE makaleid="+item.id.toString()+" AND alaneditorid="+girisyapan.id.toString())).first);
       }
        if (makaleislemlist.isNotEmpty){
           NotificationService().showNotification(1, "İşlem Gereken Makaleler Var.!.", makaleislemlist.length.toString()+ " Adet Atama Ve İnceleme Gerektiren \nMakaleler Mevcut", 2);
        }
  }
     else if (girisyapan.yetki==1) {
       List<MakaleIslem> makaleislemlist=[];
    DbHelper dbHelper =DbHelper();
       List<Makale> liste= (await dbHelper.getMakaleListSearch(" WHERE onay=5"));
       for (var item in liste) {
       makaleislemlist.add(  (await dbHelper.getSearchMakaleIslem(" WHERE makaleid="+item.id.toString()+" AND yazarid="+girisyapan.id.toString())).first);
       }
        if (makaleislemlist.isNotEmpty){
           NotificationService().showNotification(1, "İşlem Gereken Makaleler Var.!.", makaleislemlist.length.toString()+ " Adet Revizyon Gerektiren \nMakaleler Mevcut", 2);
        }
  }
   else if (girisyapan.yetki==3) {
    DbHelper dbHelper =DbHelper();
      
       List<HakemIslem> liste= (await dbHelper.getHakemIslemSearch(" WHERE durum=1 AND hakemid="+girisyapan.id.toString()));
            List<HakemIslem> liste1= (await dbHelper.getHakemIslemSearch(" WHERE durum=2 AND hakemid="+girisyapan.id.toString()));
        if (liste.isNotEmpty){
           NotificationService().showNotification(1, "İşlem Gereken Makaleler Var.!.", liste.length.toString()+ " Adet Davet Mevcut", 2);
        }
        if (liste1.isNotEmpty){
           NotificationService().showNotification(1, "İşlem Gereken Makaleler Var.!.", liste1.length.toString()+ " Adet Puanlama Gerektiren \nMakaleler Mevcut", 5);
        }
  }
}

}
revizyoncontrol() async{
DbHelper dbHelper=DbHelper();
List<Makale> makaleler=await dbHelper.getMakaleListSearch("WHERE onay=6");
if (makaleler.isNotEmpty){
  for (var item in makaleler) {
    String ay=item.revizyonzamani!.substring(5,7);
    String gun=item.revizyonzamani!.substring(8,10);
    String yil=item.revizyonzamani!.substring(0,4);
 var time=DateTime(int.parse( yil),int.parse( ay),int.parse( gun));
var ara=time.add(Duration(days: 10));
var timetut=DateTime.now();
 //2021 10 10
  //2 zaman arası fark datetime-datetime
var difference=timetut.difference(ara).inDays;
if (difference>=0){

dbHelper.updateMakale(Makale(id: item.id,baslik: item.baslik, mail: item.mail, zaman: item.zaman, onay: 7, yazar: item.yazar, revizyonzamani: item.revizyonzamani, yol: item.yol));
  }
}
}
}




















  void fonk() {
    DbHelper db;
    db = DbHelper();
    fonkekleuser("yazar", 1);
    fonkekleuser("alaneditor", 2);
    fonkekleuser("hakem", 3);

 //  fonkeklemakale("makale", "yazar");
     db.insertUser( User(ad: "baseditor", mail: "baseditor@gmail.com", parola: "1", yetki: 4,aktif: 1));
    // ignore: avoid_print
    print("Tüm veriler eklendi Hakem yazar alan ed. makale");
  }

  fonkekleuser(String ad, int yetki) {
    DbHelper db;
    db = DbHelper();
    User user =
        User(ad: "admin", mail: "admin@@gmail.com", parola: "1", yetki: 4,aktif: 1);
        db.insertUser(user);
    for (int i = 0; i < 25; i++) {
      user = User(
          ad: ad + i.toString(),
          mail: ad + "mail" + i.toString() + "@gmail.com",
          parola: i.toString(),
          yetki: yetki,aktif: 1);
      db.insertUser(user);
    }
  }
List<int> tut=[];
  fonkeklemakale(String baslik, String mail) {
    DbHelper db;
    db = DbHelper();
    Makale makale;
  
    for (int i = 0; i < 10; i++) {
        
    
      db.insertMakale(Makale(
          zaman: DateTime.now().toString(),
          baslik: baslik + i.toString(),
          mail: mail + "mail"+i.toString()+"@gmail.com",
          onay: (i%7)+1,
          yazar: "digeryazar",revizyonzamani: "",yol: ""));
    }

    
  }

