// ignore_for_file: file_names, use_key_in_widget_constructors







import 'package:codesad/addandrev/makaleadd.dart';
import 'package:codesad/addandrev/useradd.dart';
import 'package:codesad/controlCenter/controldata.dart';
import 'package:codesad/db_h.dart';
import 'package:codesad/main.dart';
import 'package:codesad/modules/hakemislem.dart';

import 'package:codesad/modules/makaleislem.dart';
import 'package:codesad/modules/makales.dart';
import 'package:codesad/modules/users.dart';
import 'package:codesad/mywidgets/specialwidgets.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';





class KurulumForm extends StatefulWidget {
 

  const KurulumForm({Key? key}) : super(key: key);

  @override
  
  // ignore: no_logic_in_create_state
  _KurulumForm createState() => _KurulumForm();
}



class _KurulumForm extends State<KurulumForm> {
var mail =TextEditingController();
var parola =TextEditingController();

    String path="";
  @override
  
// ignore: must_call_super
initState(){
  
}

  _KurulumForm();
  @override
  Widget build(BuildContext context) {

    // ignore: todo
    // TODO: implement build
    return Scaffold(
        appBar: BackButtoninAppBar(text: "ADMİN İLK KURLUM"),
        body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Expanded(
              child: RadiusContainerWidget(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  
                    PaddingRowInText(
                      konum: MainAxisAlignment.center, text: "ADMİN İLK KURLUM"),
                   
                   
                        
                          TextFieldText(controllername:mail ,text: "Yeni Admin Mail"),
                           TextFieldText(controllername:parola,text: "Yeni Admin Parola"),
                  


                       
                  
                    NewButtonElement(text: "Kaydet",colorbutton: Colors.orange,colortext: Colors.lightBlueAccent,function: (){
 if (mail.text!="" && parola.text!=""){
 DbHelper dbHelper=DbHelper();
  dbHelper.insertUser(User(ad: "admin", mail: mail.text, parola: parola.text, yetki: 4,aktif: 1));
  control();

             }
                    }),
                        
            
               
                ],
              ),
            ),
            color: Colors.yellow.shade100,
          )),
        
          



          ]));
  }

 


  
Widget TextFieldText(
    {TextEditingController? controllername, String? text}) {
  return TextField(
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


}


