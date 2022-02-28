import 'dart:math';

import 'package:codesad/addandrev/makaleadd.dart';
import 'package:codesad/addandrev/useradd.dart';
import 'package:codesad/controlCenter/controldata.dart';

import 'package:codesad/main.dart';
import 'package:codesad/model.dart';
import 'package:codesad/modules/hakemislem.dart';
import 'package:codesad/modules/makaleislem.dart';
import 'package:codesad/modules/makales.dart';
import 'package:codesad/modules/users.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:codesad/db_h.dart';

class DbHelper {
  static Database? _db;
  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    
    return _db;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "MakaleDb.db");
    print("path:"+path);
    //veritabanını siler
 //deleteDatabase(path);

    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
   
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE NOTES (id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT NOT NULL,age INTEGER)");
     
    await db.execute(
        "CREATE TABLE users (id INTEGER PRIMARY KEY AUTOINCREMENT,mail TEXT NOT NULL,parola TEXT NOT NULL,ad TEXT NOT NULL,yetki INTEGER,aktif INTEGER)");

    await db.execute(
        "CREATE TABLE makales (id INTEGER PRIMARY KEY AUTOINCREMENT , baslik TEXT NOT NULL , zaman TEXT NOT NULL , yazar TEXT NOT NULL , onay INTEGER , mail TEXT NOT NULL , revizyonzamani TEXT , yol TEXT)");
 await db.execute(
        "CREATE TABLE makaleislem (id INTEGER PRIMARY KEY AUTOINCREMENT,makaleid INTEGER, yazarid INTEGER,alaneditorid INTEGER, baseditorid INTEGER,hakemcevap INTEGER,alaneditorcevap INTEGER,baseditorcevap INTEGER,durum, baseditorzaman TEXT, alaneditorzaman TEXT)");
  //makaleid INTEGER, hakemid INTEGER, durum INTEGER, oy INTEGER
  await db.execute(
        "CREATE TABLE hakemislem (id INTEGER PRIMARY KEY AUTOINCREMENT,makaleid INTEGER, hakemid INTEGER, durum INTEGER, oy INTEGER,sonislem ,rapor TEXT)");

 }

  Future<NotesModel> insert(NotesModel notesModel) async {
    var dbClient = await db;
    await dbClient!.insert('notes', notesModel.toMap());
    return notesModel;
  }

  Future<List<NotesModel>> getNotesList() async {
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult =
        await dbClient!.query('notes');
    return queryResult.map((e) => NotesModel.fromMap(e)).toList();
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient!.delete('notes', where: 'id=?', whereArgs: [id]);
  }

  Future<int> update(NotesModel notesModel) async {
    var dbClient = await db;
    return await dbClient!.update('notes', notesModel.toMap(),
        where: 'id=?', whereArgs: [notesModel.id]);
  }

//////////////
  Future<User> insertUser(User user) async {
    var dbClient = await db;
    await dbClient!.insert('users', user.toMap());
    return user;
  }

  Future<List<User>> getUserList() async {
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult =
        await dbClient!.query('users');
    return queryResult.map((e) => User.fromMap(e)).toList();
  }

  Future<List<User>> getUserSearch(String arama) async {
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult =
        await dbClient!.rawQuery('SELECT * FROM users '+arama);

    return queryResult.map((e) => User.fromMap(e)).toList();
  }

  Future<int> deleteUser(int id) async {
    var dbClient = await db;
    return await dbClient!.delete('users', where: 'id=?', whereArgs: [id]);
  }

  Future<int> updateUser(User user) async {
    var dbClient = await db;
    return await dbClient!
        .update('users', user.toMap(), where: 'id=?', whereArgs: [user.id]);
  }
  Future<List<User>> getSearchUserList(String arama) async{
       var dbClient = await db;
    final List<Map<String, Object?>> queryResult =
        await dbClient!.rawQuery('SELECT * FROM users '+arama);

    return queryResult.map((e) => User.fromMap(e)).toList();

  }

////
  ///makaleccc
  Future<Makale> insertMakale(Makale makale) async {
    var dbClient = await db;
    await dbClient!.insert('makales', makale.toMap());


    var lastInsertRowId =
        (await dbClient.rawQuery('SELECT last_insert_rowid()'))
            .first
            .values
            .first as int;
            
         int a=girisyapan.id!;
            var rng = new Random();
int i=rng.nextInt(max(1,7));
      insertMakaleIslem(MakaleIslem(makaleid: lastInsertRowId, yazarid:girisyapan.id!, alaneditorid: -1, baseditorid: -1, hakemcevap: -1, alaneditorcevap: -1, baseditorcevap: -1, durum: 1,alaneditorzaman: "",baseditorzaman: ""));

  

    return makale;
  }

  Future<List<Makale>> getMakaleList() async {
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult =
        await dbClient!.query('makales');
    return queryResult.map((e) => Makale.fromMap(e)).toList();
  }
  Future<List<Makale>> getMakaleListSearch(String arama) async {
          var dbClient = await db;
    final List<Map<String, Object?>> queryResult =
        await dbClient!.rawQuery('SELECT * FROM makales '+ arama);

    return queryResult.map((e) => Makale.fromMap(e)).toList();
  }
  


  Future<int> deleteMakale(int id) async {
    var dbClient = await db;
    print("silindi" + id.toString());
    return await dbClient!.delete('makales', where: 'id=?', whereArgs: [id]);
  }

  Future<int> updateMakale(Makale makale) async {
    var dbClient = await db;
    return await dbClient!.update('makales', makale.toMap(),
        where: 'id=?', whereArgs: [makale.id]);
  }

  ///
  ///
  ///
  Future<List<MakaleIslem>> getSearchMakaleIslem(String arama) async{
       var dbClient = await db;
    final List<Map<String, Object?>> queryResult =
        await dbClient!.rawQuery('SELECT * FROM makaleislem '+ arama);

    return queryResult.map((e) => MakaleIslem.fromMap(e)).toList();

  }
  Future<MakaleIslem> insertMakaleIslem(MakaleIslem makaleislem) async {

    var dbClient = await db;
    await dbClient!.insert('makaleislem', makaleislem.toMap());
    return makaleislem;
  }

  Future<List<MakaleIslem>> getMakaleIslemList() async {
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult =
        await dbClient!.query('makaleislem');
    return queryResult.map((e) => MakaleIslem.fromMap(e)).toList();
  }



  Future<int> deleteMakaleIslem(int id) async {
    var dbClient = await db;
    return await dbClient!
        .delete('makaleislem', where: 'id=?', whereArgs: [id]);
  }

  Future<int> updateMakaleIslem(MakaleIslem makaleislem) async {
    var dbClient = await db;
    return await dbClient!.update('makaleislem', makaleislem.toMap(),
        where: 'id=?', whereArgs: [makaleislem.id]);
  }
/////

 Future<List<HakemIslem>> getHakemIslemSearch(String arama) async{
       var dbClient = await db;
    final List<Map<String, Object?>> queryResult =
        await dbClient!.rawQuery('SELECT * FROM hakemislem '+ arama);

    return queryResult.map((e) => HakemIslem.fromMap(e)).toList();

  }
  Future<HakemIslem> insertHakemIslem(HakemIslem hakemislem) async {
    var dbClient = await db;
    await dbClient!.insert('hakemislem', hakemislem.toMap());
    return hakemislem;
  }

  Future<List<HakemIslem>> getHakemIslemList() async {
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult =
        await dbClient!.query('hakemislem');
    return queryResult.map((e) => HakemIslem.fromMap(e)).toList();
  }

  Future<int> deleteHakemIslem(int id) async {
    var dbClient = await db;
    return await dbClient!.delete('hakemislem', where: 'id=?', whereArgs: [id]);
  }

  Future<int> updateHakemIslem(HakemIslem hakemislem) async {
    var dbClient = await db;
    return await dbClient!.update('hakemislem', hakemislem.toMap(),
        where: 'id=?', whereArgs: [hakemislem.id]);
  }
}
