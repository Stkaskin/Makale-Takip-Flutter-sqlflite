class MakaleIslem {
  final int? id;

  final int makaleid;
   final int yazarid;
  final int alaneditorid;
  final int baseditorid;
//hakemlerin ortak kararı...
  final int hakemcevap;
  //0 = atama bekleniyor 1 =inceleme bekleniyor 2=incelendi
  final int alaneditorcevap;
  //0 = atama bekleniyor 1=atama yaptı 2=makale ret
  final int baseditorcevap;
  //0 = alan editör ataması bekleniyor 1 =hakem ataması bek 2 =hakem cevap bek 3= alan edit ince bek 4=onaylandı 5 = rev 6=ret
  final int durum;
    final String baseditorzaman;
       final String alaneditorzaman;

  MakaleIslem({
    this.id,
    required this.makaleid,
    required this.yazarid,
    required this.alaneditorid,
    required this.baseditorid,
    required this.hakemcevap,
    required this.alaneditorcevap,
    required this.baseditorcevap,
     required this.baseditorzaman,
      required this.alaneditorzaman,
    required this.durum,
  });

  MakaleIslem.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        makaleid = res["makaleid"],
        yazarid = res["yazarid"],
        alaneditorid = res["alaneditorid"],
        baseditorid = res["baseditorid"],
        hakemcevap = res["hakemcevap"],
        alaneditorcevap = res['alaneditorcevap'],
        baseditorcevap = res["baseditorcevap"],
                baseditorzaman = res["baseditorzaman"],
                        alaneditorzaman = res["alaneditorzaman"],
        durum = res["durum"];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'makaleid': makaleid,
      'yazarid': yazarid,
      'alaneditorid': alaneditorid,
      'baseditorid': baseditorid,
      'hakemcevap': hakemcevap,
      'alaneditorcevap': alaneditorcevap,
      'baseditorcevap': baseditorcevap,
        'baseditorzaman': baseditorzaman,
          'alaneditorzaman': alaneditorzaman,
      'durum': durum
    };
  }
}
