class FirebaseModel {
  double plength;
  double front;
  double chhati;
  double seat;
  double jang;
  double ghutan;
  double jolo;
  double moli;
  double kamar;
  double slength;
  double solder;
  double bay;
  double kolar;
  double cup;

  FirebaseModel({
    required this.plength,
    required this.front,
    required this.chhati,
    required this.seat,
    required this.jang,
    required this.ghutan,
    required this.jolo,
    required this.moli,
    required this.kamar,
    required this.slength,
    required this.solder,
    required this.bay,
    required this.kolar,
    required this.cup,
  });

  factory FirebaseModel.fromJson(Map<String, dynamic> map) => FirebaseModel(
        plength: map['plength'],
        front: map['front'],
        chhati: map['chhati'],
        seat: map['seat'],
        jang: map['jang'],
        ghutan: map['ghutan'],
        jolo: map['jolo'],
        moli: map['moli'],
        kamar: map['kamar'],
        slength: map['slength'],
        solder: map['solder'],
        bay: map['bay'],
        kolar: map['kolar'],
        cup: map['cup'],
      );
}
