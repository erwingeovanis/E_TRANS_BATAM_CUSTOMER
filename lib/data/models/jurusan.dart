// To parse this JSON data, do
//
//     final jurusan = jurusanFromJson(jsonString);

import 'dart:convert';

List<Jurusan> jurusanFromJson(String str) =>
    List<Jurusan>.from(json.decode(str).map((x) => Jurusan.fromJson(x)));

String jurusanToJson(List<Jurusan> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Jurusan {
  Jurusan({
    this.idJurusan,
    this.jadwal,
    this.ket,
    this.nama,
    this.rute,
    this.currentRoute,
  });

  int? idJurusan;
  List<String>? jadwal;
  String? ket;
  String? nama;
  List<Rute>? rute;
  int? currentRoute;

  factory Jurusan.fromJson(Map<String, dynamic> json) => Jurusan(
        idJurusan: json["id_jurusan"],
        jadwal: List<String>.from(json["jadwal"].map((x) => x)),
        ket: json["ket"],
        nama: json["nama"],
        rute: List<Rute>.from(json["rute"].map((x) => Rute.fromJson(x))),
        currentRoute: json["current_route"],
      );

  Map<String, dynamic> toJson() => {
        "id_jurusan": idJurusan,
        "jadwal": List<dynamic>.from(jadwal!.map((x) => x)),
        "ket": ket,
        "current_route": currentRoute,
        "nama": nama,
        "rute": List<dynamic>.from(rute!.map((x) => x.toJson())),
      };
}

class Rute {
  Rute({
    this.daerah,
    this.idHalte,
    this.latitude,
    this.longitude,
    this.nama,
  });

  String? daerah;
  int? idHalte;
  double? latitude;
  double? longitude;
  String? nama;

  factory Rute.fromJson(Map<String, dynamic> json) => Rute(
        daerah: json["daerah"],
        idHalte: json["id_halte"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        nama: json["nama"],
      );

  Map<String, dynamic> toJson() => {
        "daerah": daerah,
        "id_halte": idHalte,
        "latitude": latitude,
        "longitude": longitude,
        "nama": nama,
      };
}
