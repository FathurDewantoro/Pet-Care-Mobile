// To parse this JSON data, do
//
//     final perawatan = perawatanFromJson(jsonString);

import 'dart:convert';

List<Perawatan> perawatanFromJson(String str) =>
    List<Perawatan>.from(json.decode(str).map((x) => Perawatan.fromJson(x)));

String perawatanToJson(List<Perawatan> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Perawatan {
  Perawatan({
    required this.id,
    required this.nama,
    required this.harga,
    required this.deskripsi,
    required this.thumbnail,
    required this.terakhirDiperbarui,
  });

  int id;
  String nama;
  int harga;
  String deskripsi;
  String thumbnail;
  DateTime terakhirDiperbarui;

  factory Perawatan.fromJson(Map<String, dynamic> json) => Perawatan(
        id: json["id"],
        nama: json["nama"],
        harga: json["harga"],
        deskripsi: json["deskripsi"],
        thumbnail: json["thumbnail"],
        terakhirDiperbarui: DateTime.parse(json["terakhir_diperbarui"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "harga": harga,
        "deskripsi": deskripsi,
        "thumbnail": thumbnail,
        "terakhir_diperbarui": terakhirDiperbarui.toIso8601String(),
      };
}
