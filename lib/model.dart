class NotesModel {
  final int? id;
  final String title;
  final int age;
  NotesModel({this.id, required this.title, required this.age});
  NotesModel.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        title = res["title"],
        age = res["age"];
  Map<String, Object?> toMap() {
    return {'id': id, 'title': title, 'age': age};
  }
}
