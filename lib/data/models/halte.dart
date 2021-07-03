// To parse this JSON data, do
//
//     final halte = halteFromJson(jsonString);

import 'dart:convert';

List<Halte> halteFromJson(String str) =>
    List<Halte>.from(json.decode(str).map((x) => Halte.fromJson(x)));

String halteToJson(List<Halte> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Halte {
  Halte({
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

  factory Halte.fromJson(Map<String, dynamic> json) => Halte(
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
