class Makale{
  final int? id;
  final String baslik;
  final String zaman;
  final String yazar;
  final int onay;
  final String mail;
  final String? revizyonzamani;
    final String? yol;
   Makale(
      {this.id,
      required this.baslik,
      required this.mail,
      required this.zaman,
      required this.onay,
      required this.yazar,
   required   this.revizyonzamani,
         required   this.yol});

  Makale.fromMap(Map<String, dynamic> res)
      : baslik = res["baslik"],
        zaman = res["zaman"],
        yazar = res["yazar"],
        mail = res["mail"],
        id = res["id"],
        onay=res["onay"],
        revizyonzamani=res["revizyonzamani"],
            yol=res["yol"];
        
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'baslik': baslik,
      'zaman': zaman,
      'yazar': yazar,
      'mail': mail,
      'onay':onay,
      'revizyonzamani':revizyonzamani,
      'yol':yol

    };
  }
}