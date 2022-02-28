

import 'package:codesad/addandrev/makaleadd.dart';
import 'package:codesad/addandrev/revizyon.dart';
import 'package:codesad/addandrev/useradd.dart';
import 'package:codesad/apis/api.dart';
import 'package:codesad/atama/alanedata.dart';
import 'package:codesad/atama/hakemata.dart';
import 'package:codesad/controlCenter/controldata.dart';
import 'package:codesad/db_h.dart';

import 'package:codesad/makaleDetailForm.dart';
import 'package:codesad/makalelistform.dart';
import 'package:codesad/modules/makales.dart';
import 'package:codesad/modules/users.dart';
import 'package:codesad/mywidgets/specialwidgets.dart';
import 'package:codesad/viewandedit/alaneinceleme.dart';
import 'package:codesad/viewandedit/hakemdavet.dart';
import 'package:codesad/viewandedit/kurulum.dart';
import 'package:codesad/viewandedit/makalegoruntuleme.dart';
import 'package:codesad/viewandedit/oyform.dart';

import 'package:codesad/viewandedit/personelbilgi.dart';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

void main() async {
//WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  sayfalar.add(1);

  aktifsayfa = 1;
  runApp(MyApp(sayfakod: 101));
}

User girisyapan = User(id: 3, ad: "ADMİN", mail: "A@A", parola: "1", yetki: 1,aktif: 1);
Makale aktifmakale = Makale(
    baslik: "baslik",
    mail: "mail",
    zaman: "zaman",
    onay: 1,
    yazar: "",
    yol: "",
    revizyonzamani: "");

List<int> sayfalar = [];
int sayfa = 1;

int aktifsayfa = 1;
String bosgirdin = "";

class MyApp extends StatelessWidget {
  final int sayfakod;
  const MyApp({Key? key, @required this.sayfakod = 1}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blueGrey,
        ),
        home: seciliform(sayfakod)
        // MyHomePage(title: "title"),
        );
  }
}

sayfacontrol(int sayfakod) {
  for (var a in sayfalar) {
    if (sayfakod == a) {
      return 1;
    }
  }
  return -1;
}

seciliformfuntion({int deger = 1, required int sayfakodu}) {
  if (deger == sayfakodu && aktifsayfa != sayfakodu) {
    //kaydet yapıldıgında  giris sayfasına atma sorununu çözer programlamacı içindir
    int controlsayfa = sayfacontrol(deger);
    if (controlsayfa == -1) {
      sayfalar.add(deger);
    }
    aktifsayfa = deger;

    return true;
  }
  return false;
}

//////////////
Widget seciliform(@required int sayfac) {
  for (var a in sayfalar) {
    
    print(a.toString());
  }
if (sayfalar.length>1 && sayfalar.last==aktifsayfa){
 
  aktifsayfa=1;
}
  if (sayfac == 1) {
sayfalar=[1];
    return const MyHomePage(
      title: "GİRİŞ",
    );
  }
  if (seciliformfuntion(sayfakodu: sayfac, deger: 2)) {
    // return const MakeleRevizyonForm();
    return const MakaleListForm();
  } else if (seciliformfuntion(sayfakodu: sayfac, deger: 3)) {
    return const MakaleDetailForm();
  } else if (seciliformfuntion(sayfakodu: sayfac, deger: 5)) {
    return const MakaleAddForm();
  } else if (seciliformfuntion(sayfakodu: sayfac, deger: 6)) {
    return const HakemAtamaForm();
  } else if (seciliformfuntion(sayfakodu: sayfac, deger: 7)) {
    return const AlanEdInceleme();
  } else if (seciliformfuntion(sayfakodu: sayfac, deger: 9)) {
    return const AlanEdAtamaForm();
  } else if (seciliformfuntion(sayfakodu: sayfac, deger: 10)) {
    return const HakemDavetForm();
  } else if (seciliformfuntion(sayfakodu: sayfac, deger: 15)) {
    return const HakemOyForm();
  } else if (seciliformfuntion(sayfakodu: sayfac, deger: 17)) {
    return const UserAddForm();
  } else if (seciliformfuntion(sayfakodu: sayfac, deger: 18)) {
    return const MakeleRevizyonForm();
  }
  else if (seciliformfuntion(sayfakodu: sayfac, deger: 19)) {
    return const MakaleGoruntuleForm();
  }
   else if (seciliformfuntion(sayfakodu: sayfac, deger: 97)) {
    return const PersonelForm();
  } else if (seciliformfuntion(sayfakodu: sayfac, deger: 100)) {
    return const KurulumForm();
  } else if (sayfac == 101) {
    ControlCenter().kurulumcontol();
    return const MyHomePage(title: "GİRİŞ");
  }
  // ignore: curly_braces_in_flow_control_structures
  else {
    return const MyHomePage(
      title: "GİRİŞ",
    );
  }
}

///////////////////
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var mail = TextEditingController();
  var parola = TextEditingController();
  
  @override
  void initState() {
    super.initState();

    tz.initializeTimeZones();
  }
  @override

  Widget build(BuildContext context) {
    //aktif sayfayı 1 yapar ve sayfaları temizler sadece ilk sayfa kalır;

    aktifsayfa=1;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(bosgirdin,
                  style: TextStyle(fontSize: 19, color: Colors.red)),
            ),
            TextFieldInputDec(text: "Mail",controllername: mail),
              TextFieldInputDec(text: "Parola",controllername: parola),
        
            NewButtonElement(
                colorbutton: Colors.blue.shade200,
                text: "Giriş Yap",
                colortext: Colors.black,
                function: () {
                  
                  if (parola.text != "" && mail.text != "") {
                    sayfa = 1;
                    setState(() {
                      sayfa = 1;
                    });
                    loginControl();
                  } else {
                    setState(() {
                      bosgirdin = "Boş girdiniz.!.";
                    });
                  }
                }),
            NewButtonElement(
                text: "Giriş Yapmadan Makale Ara",
                colorbutton: Colors.orangeAccent.shade100,
                colortext: Colors.black,function: (){
            
                   
                         runApp(MyApp(sayfakod: 19));
          
                
                 
                })
          ],
        ),
      ),
    );
  }

  void loginControl() async {
    List<User> a = (await DbHelper().getUserSearch(" WHERE aktif=1 AND mail=" +"'"+ mail.text+"'"+" AND parola="+"'"+ parola.text+"'" ));
    if (a.isNotEmpty) {
      setState(() {
        girisyapan = a.first;
        yetkili = girisyapan.yetki;

ControlCenter().yetkilibildirimcontrol();
//

//NotificationApi().funkkk();



      });
      runApp(MyApp(
        sayfakod: 2,
      ));
    }else { sayfalar = [1];
   
    bosgirdin = "Bilgiler Uyumsuz";
        
        }
//runApp(const MakaleListForm());
    // List<User> liste=LoginF().doldurliste();
    //liste.forEach((element) {
    //if (element.name==mail.text && element.parola==parola.text){
    //txt.text="           Giriş Yapıldı";
//form1gir();
  }
}
