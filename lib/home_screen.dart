/*import 'package:codesad/controlCenter/controldata.dart';
import 'package:codesad/db_h.dart';
import 'package:codesad/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget{


const HomeScreen ({Key? key}):super(key:key);

  @override
  _HomeScreenState createState()=>_HomeScreenState();

} 
class _HomeScreenState extends State<HomeScreen>{

  DbHelper? dbHelper;
    late Future<List<NotesModel>> notesList;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper=DbHelper();
    loadData ();
  } 
 
loadData() async{
  notesList=dbHelper!.getNotesList();  
}
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
  return Scaffold(appBar: AppBar(title: Text('DATABASE'),
  centerTitle: true,),
  body: Column(
    children: [
      Expanded(
        child: FutureBuilder(
          future: notesList,
          builder: (context, AsyncSnapshot<List<NotesModel>> snapshot){
            if (snapshot.hasData){
  return   
         ListView.builder(
           itemCount: snapshot.data?.length,
           reverse: false,
           shrinkWrap: true,

           itemBuilder: (context,index){
              
      return InkWell(
        onTap: (){
          print("updatecode");
          dbHelper!.update(NotesModel(
            id: snapshot.data![index].id!,
            title: "update title ", age:   snapshot.data![index].id!));
            //Data update
            setState(() {
//data list get 
              notesList=dbHelper!.getNotesList();
            });

        },
        child: Dismissible(
           direction: DismissDirection.endToStart,
           background: Container(
            color: Colors.red,
            
            child: Icon(Icons.delete_forever)),
            onDismissed: (DismissDirection direction){
          //Data delete
              setState(() {
                dbHelper!.delete(snapshot.data![index].id!);
                notesList=dbHelper!.getNotesList();
                snapshot.data!.remove(snapshot.data![index]);
                
              });
            },
          key: ValueKey<int>(snapshot.data![index].id!) ,
          child: Card(
            child: ListTile(
            title: Text(snapshot.data![index].title.toString()),
            subtitle: Text(snapshot.data![index].age.toString()),
          
          ),
          ),
        ),
      );
            });
            }
            else {return CircularProgressIndicator(); }
       
      
        }
        ),
      )
      
      ],
    ),
  floatingActionButton: FloatingActionButton(
    onPressed: (){//Data add 
    dbHelper!.insert(NotesModel(age: 21,title: "ff")).then((value) {
   ControlCenter c=ControlCenter();
  c.fonk();


setState(() {
     notesList =dbHelper!.getNotesList();
});
   
      } ).onError((error, stackTrace) {

        print(error.toString());
      
    }
    );
    },
    child:const Icon(Icons.add),
  ),
    );
  }
}
*/