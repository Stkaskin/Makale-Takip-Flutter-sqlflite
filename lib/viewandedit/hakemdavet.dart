
import 'package:codesad/addandrev/makaleadd.dart';

import 'package:codesad/db_h.dart';
import 'package:codesad/main.dart';
import 'package:codesad/modules/hakemislem.dart';
import 'package:codesad/modules/makales.dart';


import 'package:codesad/mywidgets/specialwidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



class HakemDavetForm extends StatefulWidget {
  const HakemDavetForm({Key? key}) : super(key: key);

  @override
  _HakemDavetForm createState() => _HakemDavetForm();
}

class _HakemDavetForm extends State<HakemDavetForm> {
  DbHelper? dbHelper;   
  Future<List<Makale>>? makaleList;
  List<HakemIslem>? hakemSorumlumakalelistesi;

  @override  
  
  void initState() {
    
    super.initState();
    dbHelper = DbHelper();
    loadData();
 
  }
/*
//ConvertToFuture
makaleList=Future.value(m);
*/ 
  loadData() async {
 List<Makale>? liste=[];

  
    hakemSorumlumakalelistesi =await dbHelper!.getHakemIslemSearch("WHERE hakemid="+girisyapan.id.toString()+" AND durum=1");
   //for herşeyin ilacı 
   for(var element in hakemSorumlumakalelistesi!) {
      
liste.add((await dbHelper!.getMakaleListSearch("WHERE id="+element.makaleid.toString())).first);
// ignore: avoid_print
print("sorum:" +element.durum.toString());

    }
   setState(() {
  if(liste!=null){
  makaleList=Future.value(liste);}
  for(var i in liste){
    print(i.onay);
  }
});
    
     
  }

  @override
  Widget build(BuildContext context) {


 // TODO: implement build
    return Scaffold(
      appBar: BackButtoninAppBar(text: "Hakem Davetler"),
      body: Column(
        children: [
       
        
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
                              child: ListTile(
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
                                trailing:  
                                   NewButtonElement(colortext: Colors.yellow,colorbutton: Colors.green,text: "Cevap Ver",function: (){
                                  showDialog<void>(context: context, builder: (_) => MyWidgetAlertDialog(onaybtnfunc:(){davetcevapfunc(snapshot.data![index],1);},redbtnfunc: (){davetcevapfunc(snapshot.data![index],-1);},context: context,uptext: "Davet Cevap Ekranı",centertext: "Davete cevabınız nedir?"), barrierDismissible: false);
           
      
                                  } 
                                  
                                  ,
                                                              ),
                                ),
                              
                            ),
                          );
                        });
                  } else {
                    return SizedBox();
                  }
                }),
          ),
        
        ],
      ),
    );
  }



  davetcevapfunc(Makale makale ,int islem){
hakemSorumlumakalelistesi!.forEach((element) {
if (girisyapan.id==element.hakemid && makale.id==element.makaleid){
  print(element.durum);
  if (islem==1){
  
 DateTime _now = DateTime.now();
    final String formattedDateTime = _formatDateTime(_now);
  dbHelper!.updateHakemIslem(HakemIslem(id:element.id, makaleid: element.makaleid, hakemid: element.hakemid, durum:2, oy:element.oy,sonislem: formattedDateTime,rapor: element.rapor));
 
}
else if (islem==-1){
dbHelper!.deleteHakemIslem(element.id!);
}
loadData();
}


 }); 
 

  }

  }   String _formatDateTime(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }