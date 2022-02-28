class User {
  final int? id;
  final String ad;
  final String mail;

  final String parola;
  //1 yazar 2 alan 3 hak 4 alan
  final int yetki;
  final int aktif;
  User(
      {this.id,
      required this.ad,
      required this.mail,
      required this.parola,
  
      required this.yetki,
       required this.aktif });

  User.fromMap(Map<String, dynamic> res)
      : yetki = res["yetki"],
         aktif = res["aktif"],
      
        parola = res["parola"],
        mail = res["mail"],
        id = res["id"],ad=res['ad'];
        
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'yetki': yetki,
         'aktif': aktif,
      'parola': parola,
      'mail': mail,
      'ad':ad

    };
  }

  
}
