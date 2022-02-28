import 'package:codesad/addandrev/makaleadd.dart';
import 'package:codesad/makaleDetailForm.dart';
import 'package:codesad/makalelistform.dart';
import 'package:codesad/modules/hakemislem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class RadiusContainerWidget extends StatelessWidget {
  final Color color;
  Widget? child;
  RadiusContainerWidget({this.color = Colors.white, this.child});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: child,
        margin: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0), color: color),
      ),
    );
  }
}

Widget TextFieldInputDec(
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

Widget ButtonF(
    {Function? fonksiyon,
    String? text = "Button",
    Color? buttoncolor = Colors.deepPurpleAccent,
    Color? disabledcolor = Colors.deepPurpleAccent}) {
  return ButtonTheme(
      buttonColor: buttoncolor,
      disabledColor: disabledcolor,
      // ignore: deprecated_member_use
      child: RaisedButton(
          disabledElevation: 5.0,
          onPressed: () {
            fonksiyon!();
          },
          child: Text(text!)));
}
Widget NewButtonElement({Function? function,String text="Button",Color colortext=Colors.deepPurpleAccent,Color colorbutton=Colors.grey}){

  return ElevatedButton(

        style: ButtonStyle( backgroundColor: MaterialStateProperty.all<Color>(colorbutton) ),
            
        onPressed: () {
          if (function != null) {
            function();
          }
        },
        child: Text( text,
          style: TextStyle(color: colortext,)
  ));
  } 

Widget DetailDialogPanel({required BuildContext context,String makaleid="-1",String durum="bilinmiyor",String baseditortarih="bilinmiyor",String alaneditortarih="bilinmiyor",String hakem1tarih="bilinmiyor",String hakem2tarih="bilinmiyor",String hakem3tarih="bilinmiyor"}){
  return CupertinoAlertDialog(
    title: Text(makaleid),
    content: SingleChildScrollView(
      child: Column(children: [
        RowPaddingRowInText(textstart: "Son Durum "+durum,text:"",konum: MainAxisAlignment.center),
      RowPaddingRowInText(textstart: "Baş E. Tarihi",text: baseditortarih),
      RowPaddingRowInText(textstart: "Alan E. Tarihi",text: alaneditortarih),
      RowPaddingRowInText(textstart: "1.Hakem Tarihi",text: hakem1tarih),
      RowPaddingRowInText(textstart: "2.Hakem Tarihi",text: hakem2tarih),
      RowPaddingRowInText(textstart: "3.Hakem Tarihi",text: hakem3tarih)
      
      ]),
    ),
    actions: [
      NewButtonElement(
        text: "Tamam",
        colortext: Colors.white,colorbutton: Colors.red.shade500,
        function: () {
      

        Navigator.pop(context);
      })
    ],
  );
  
}
// ignore: non_constant_identifier_names
Widget ErrorDialogPanel({required BuildContext context,String text="Top Text",String textunder="Bottom Text"}){
  return CupertinoAlertDialog(
    title: Text(text),
    content: Text(textunder),
    actions: [
      NewButtonElement(
        text: "Tamam",
        colortext: Colors.white,colorbutton: Colors.red.shade500,
        function: () {
      

        Navigator.pop(context);
      })
    ],
  );
  
}
Widget AletDialogPanel({required BuildContext context,String text="Top Text",String textunder="Bottom Text"}) {
  return CupertinoAlertDialog(
    title: Text(text),
    content: Text(textunder),
    actions: [
      NewButtonElement(
        text: "Tamam",
        colortext: Colors.white,colorbutton: Colors.deepOrangeAccent,
        function: () {
      
    control();
        Navigator.pop(context);
      })
    ],
  );
}

// ignore: non_constant_identifier_names
AlertDialog MyWidgetAlertDialog({required BuildContext context,String? onaytext="Onayla",String? redtext="Red et",String? uptext="Yukarı Text",String? centertext="Orta Text",Function? onaybtnfunc,Function? redbtnfunc,Function? iptalbtnfunc}){
return  AlertDialog(
      title: Text(uptext!),
      
      contentPadding: EdgeInsets.zero,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
        Text(centertext!)
        ],
      ),
      actions: [
        NewButtonElement(colortext:   Colors.yellow,colorbutton: Colors.green,text: onaytext!,function: (){Navigator.pop(context);
        if (onaybtnfunc!=null){onaybtnfunc();}
        } ),
     NewButtonElement(colortext: Colors.yellow,colorbutton: Colors.red,text: redtext!,function: (){Navigator.pop(context);
           if (redbtnfunc!=null){redbtnfunc();}
     
     } ),
     NewButtonElement(colortext: Colors.yellow,colorbutton: Colors.brown,text: "Daha Sonra",function: (){Navigator.pop(context);
           if (iptalbtnfunc!=null){iptalbtnfunc();}
     } )

      
      ],
    );
}