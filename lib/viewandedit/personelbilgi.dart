import 'package:codesad/addandrev/makaleadd.dart';

import 'package:codesad/db_h.dart';
import 'package:codesad/main.dart';
import 'package:codesad/makalelistform.dart';
import 'package:codesad/modules/hakemislem.dart';
import 'package:codesad/modules/makaleislem.dart';


import 'package:codesad/modules/makales.dart';
import 'package:codesad/modules/users.dart';
import 'package:codesad/mywidgets/specialwidgets.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class PersonelForm extends StatefulWidget {
  const PersonelForm({Key? key}) : super(key: key);

  @override
  _PersonelForm createState() => _PersonelForm();
}

class _PersonelForm extends State<PersonelForm> {
  DbHelper? dbHelper;
     Future<List<User>>? users;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = DbHelper();
    loadData();
    
  }

  loadData() async {
   List<User> s=[];
users=Future.value(s);
String arama =" WHERE  aktif=1 ";
if (girisyapan.yetki==2){arama+=" AND (yetki=3 OR yetki=1 )";}

    List<User>? cevir= await dbHelper!.getSearchUserList(arama);
    
     if (cevir.isEmpty){ 
         users=Future.value(s);
         }
         else {users=Future.value(cevir);
           }

     1==1;
    setState(() {
    
    users;
    });
   
          
 
   
   
    }
   
  

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: BackButtoninAppBar(text: "Personel"),
      body: Column(
        children: [
          // ignore: avoid_print
        
         
          Expanded(
            child: FutureBuilder(
                future: users,
                builder: (context, AsyncSnapshot<List<User>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount:  snapshot.data!.length,
                        reverse: false,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onLongPress: (){
               personeldevredisi(snapshot.data![index]);
                            },
                            child: Card(
                              child: ListTile(
                                
                                title: Text(
                                    snapshot.data![index].ad.toString()),
                                subtitle: Text("mail    : #" +
                                  snapshot.data![index].mail+ "\nparola: " +
                                    snapshot.data![index].parola
                                       ),
                               leading:
                                   Text(snapshot.data![index].id.toString()),
                                isThreeLine: (true),
                                trailing: Text(snapshot.data![index].yetki==1?"YAZAR":
                                snapshot.data![index].yetki==2?"ALAN E.":
                                snapshot.data![index].yetki==3?"HAKEM":
                                snapshot.data![index].yetki==4?"BAŞ E.":"yok"),
                                
                             
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







 



 personeldevredisi(User user ){
      if (user.yetki==4){
          showDialog<void>(context: context, builder: (_) =>ErrorDialogPanel(context: context,text: "UYARI",textunder: "Baş Editör Silinemez.!."),barrierDismissible: false);
      
      }
      else{
                 showDialog<void>(context: context, builder: (_) => MyWidgetAlertDialog(context: context,redtext: "Vazgeç",onaytext:"SİL",uptext: "Silmek İster Misiniz?",centertext: "Silmek İstiyor Musunuz?",
                              
                              onaybtnfunc: () async{
                                if (user.yetki==1){
                                dbHelper!.updateUser(User(id : user.id, ad: user.ad, mail:user.mail, parola: user.parola, yetki: user.yetki, aktif: 0));
                                List<MakaleIslem> islems =await  dbHelper!.getSearchMakaleIslem(" WHERE yazarid="+user.id.toString());
                                for (var item in islems) {
                                  Makale makaleup=(await dbHelper!.getMakaleListSearch(" WHERE (onay!=5 OR onay!=6) AND id="+item.id.toString())).first;
                                  if (makaleup!=null){
                                    dbHelper!.updateMakale(Makale(id: makaleup.id,baslik: makaleup.baslik, mail: makaleup.mail, zaman: makaleup.zaman, onay: 7, yazar: makaleup.yazar, revizyonzamani: makaleup.revizyonzamani, yol: makaleup.yol));
                                  }
                                  List<HakemIslem> listehakem=await dbHelper!.getHakemIslemSearch(" WHERE makaleid="+item.makaleid.toString());
                                  for (var item in listehakem) {
                                       dbHelper!.updateHakemIslem(HakemIslem(id:item.id,makaleid: item.makaleid, hakemid: item.hakemid, durum: 0, oy: item.oy, sonislem: item.sonislem, rapor: item.rapor));
                                    
                                  }
                                }
                                
                                }
                                 else if (user.yetki==3){
                         dbHelper!.updateUser(User(id : user.id, ad: user.ad, mail:user.mail, parola: user.parola, yetki: user.yetki, aktif: 0));
                           List<HakemIslem> islems=(await dbHelper!.getHakemIslemSearch(" WHERE (durum=2 OR durum=1) AND hakemid="+user.id.toString()));
                           for (var item in islems) {
                             dbHelper!.deleteHakemIslem(item.id!);

                             
                           }
                   
                                 }
                                 else if (user.yetki==2){
                              
                               dbHelper!.updateUser(User(id : user.id, ad: user.ad, mail:user.mail, parola: user.parola, yetki: user.yetki, aktif: 0));
                                List<MakaleIslem> islems =await  dbHelper!.getSearchMakaleIslem(" WHERE alaneditorid="+user.id.toString());
                                for (var item in islems) {
                                  Makale makaleup=(await dbHelper!.getMakaleListSearch(" WHERE  (onay!=5 OR onay!=7) AND id="+item.id.toString())).first;
                                  if (makaleup!=null){
                                    dbHelper!.updateMakale(Makale(id: makaleup.id,baslik: makaleup.baslik, mail: makaleup.mail, zaman: makaleup.zaman, onay:0, yazar: makaleup.yazar, revizyonzamani: makaleup.revizyonzamani, yol: makaleup.yol));
                                  dbHelper!.updateMakaleIslem(MakaleIslem(id: item.id! ,makaleid: item.makaleid, yazarid: item.yazarid, alaneditorid: -1, baseditorid: item.baseditorid, hakemcevap: item.hakemcevap, alaneditorcevap: item.alaneditorcevap, baseditorcevap: item.baseditorcevap, baseditorzaman: item.baseditorzaman, alaneditorzaman: "", durum: item.durum));
                                  }
                                }

                                 }
                               








                          control();
                          }
                              ),barrierDismissible: false);
                              }
}

}

