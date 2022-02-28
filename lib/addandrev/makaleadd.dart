// ignore_for_file: file_names, use_key_in_widget_constructors






import 'package:codesad/db_h.dart';
import 'package:codesad/main.dart';


import 'package:codesad/modules/makales.dart';
import 'package:codesad/mywidgets/specialwidgets.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';




class MakaleAddForm extends StatefulWidget {
 

  const MakaleAddForm({Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _MakaleAddForm createState() => _MakaleAddForm();
}

class _MakaleAddForm extends State<MakaleAddForm> {

  _MakaleAddForm();
  
var ad=TextEditingController();
var mail=TextEditingController();
var baslik=TextEditingController();
var kurum=TextEditingController();

  String path="";
  String filetext="PDF SEÇİLMEDİ";
  @override
  Widget build(BuildContext context) {
    // ignore: todo
    // TODO: implement build
    return Scaffold(
        appBar: BackButtoninAppBar(text: "Yeni Makale"),
        body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Expanded(
              child: RadiusContainerWidget(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  
                    PaddingRowInText(
                      konum: MainAxisAlignment.center, text: "Yeni Makale Ekleme Ekranı"),
                   
                   
                        
                          TextFieldInputDec(controllername:baslik ,text: "Başlık"),  
                           TextFieldInputDec(controllername:ad ,text: "AD"),
                          TextFieldInputDec(controllername:mail ,text: "Mail"),

                          //TextFieldInputDec(controllername:kurum ,text: "kurum"),
                            MyFileSelectWidget(),
                            
                            NewButtonElement(colorbutton: Colors.orangeAccent.shade400,colortext: Colors.green.shade800,text: "Kaydet",function: (){ekleMakale(context:context,path: path);})
                        
            
               
                ],
              ),
            ),
            color: Colors.yellow.shade100,
          )),
        
          



          ]));
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
// ignore: non_constant_identifier_names
Widget MyFileSelectWidget() {
  setState(() {
    
  });
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
  children: [
      Expanded(child: Text(filetext,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)),  
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

 void ekleMakale({required BuildContext context,String? path }) {
  if(ad.text!="" && path!="") {

Makale makale=Makale(baslik: baslik.text, mail: mail.text, zaman: DateTime.now().toString() ,onay: 0 ,yazar:1.toString(),yol: path,revizyonzamani: "");
DbHelper db=DbHelper();

db.insertMakale(makale);
print("Makaleeklendi");
 showDialog(context: context, builder: (_)=>AletDialogPanel(context: context,text: "Ekleme Başarılı",textunder: "Makale Ekleme İşlemi Başarıyla Tamamlandı" ),barrierDismissible: false);
print("path:"+path!);
}
else {
  showDialog(context: context, builder: (_)=>ErrorDialogPanel(context: context,text: "Lütfen Başlık Seçin veya Dosya Seçin",textunder: "Lütfen Başlık Seçin veya Dosya Seçin" ),barrierDismissible: false);

}



}
}
   

TextField TextFieldInputText(){
  
  return TextField();
}
 AppBar BackButtoninAppBar( {required String text}) {
    return AppBar(
        automaticallyImplyLeading: true,
  leading: IconButton(icon: Icon(Icons.arrow_back_sharp),onPressed: (){
   
control();

  })
        ,
        title:  Text(text),
        centerTitle: true,
      );
  }
  void control(){
     if (sayfalar.length>1){
sayfalar.removeLast();
sayfa=sayfalar.last;
aktifsayfa=-1;
runApp(MyApp(sayfakod: sayfa));
}  




 // ignore: non_constant_identifier_names, unused_element
 

  }
