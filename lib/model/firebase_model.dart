import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseModel {
  String? name;
  String? mobileNo;
  String? billNo;
  String? id;
  double? plength;
  double? front;
  double? chhati;
  double? seat;
  double? jang;
  double? ghutan;
  double? jolo;
  double? moli;
  double? kamar;
  double? slength;
  double? solder;
  double? bay;
  double? kolar;
  double? cup;
  DateTime? deliveryDate;

  FirebaseModel(
      {this.id,
      required this.name,
      required this.mobileNo,
      required this.billNo,
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
      required this.deliveryDate});

  factory FirebaseModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return FirebaseModel(
        id: doc.id,
        name: data['name'],
        billNo: data['billNo'],
        mobileNo: data['mobileNo'],
        plength: (data['plength'] ?? 0).toDouble(),
        front: (data['front'] ?? 0).toDouble(),
        chhati: (data['chhati'] ?? 0).toDouble(),
        seat: (data['seat'] ?? 0).toDouble(),
        jang: (data['jang'] ?? 0).toDouble(),
        ghutan: (data['ghutan'] ?? 0).toDouble(),
        jolo: (data['jolo'] ?? 0).toDouble(),
        moli: (data['moli'] ?? 0).toDouble(),
        kamar: (data['kamar'] ?? 0).toDouble(),
        slength: (data['slength'] ?? 0).toDouble(),
        solder: (data['solder'] ?? 0).toDouble(),
        bay: (data['bay'] ?? 0).toDouble(),
        kolar: (data['kolar'] ?? 0).toDouble(),
        cup: (data['cup'] ?? 0).toDouble(),
        deliveryDate: (data['deliveryDate'] as Timestamp).toDate());
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'mobileNo': mobileNo,
      'billNo': billNo,
      'plength': plength,
      'front': front,
      'chhati': chhati,
      'seat': seat,
      'jang': jang,
      'ghutan': ghutan,
      'jolo': jolo,
      'moli': moli,
      'kamar': kamar,
      'slength': slength,
      'solder': solder,
      'bay': bay,
      'kolar': kolar,
      'cup': cup,
      'deliveryDate': deliveryDate!.toIso8601String()
    };
  }
}
