class HakemIslem {
  final int? id;
//hakemlerin id si
  final int hakemid;
  //ilgili makale id
  final int makaleid;
  //hakem : 0 =davet , 1 =incelemede ,2 =oylandı
  final int durum;
  //verdikleri puanlar
  final int oy;
  final String? sonislem;
final String? rapor;
  HakemIslem(
      {this.id, 
      required this.makaleid,
      required this.hakemid,
      required this.durum,
      required this.oy,
      // ignore: unnecessary_new
    required  this.sonislem,
   required this.rapor});

  HakemIslem.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        makaleid = res["makaleid"],
        hakemid = res["hakemid"],
        durum = res["durum"],
        oy = res["oy"],
         sonislem = res["sonislem"], 
            rapor = res["rapor"];
        

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'makaleid': makaleid,
      'hakemid': hakemid,
      'durum': durum,
      'oy': oy,
      'sonislem': sonislem,
      'rapor':rapor
    };
  }
  
}
