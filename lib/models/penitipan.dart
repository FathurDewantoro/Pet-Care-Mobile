import 'dart:convert';

Penitipan penitipanFromJson(String str) => Penitipan.fromJson(json.decode(str));

String penitipanToJson(Penitipan data) => json.encode(data.toJson());

class Penitipan {
  Penitipan({
    required this.id,
    required this.namaPenitipan,
    required this.harga,
    required this.deskripsi,
    required this.sisa,
    required this.jumlah,
    required this.lama,
    required this.thumbnail,
    required this.terakhir,
  });

  int id;
  String namaPenitipan;
  int harga;
  String deskripsi;
  int sisa;
  int jumlah;
  int lama;
  String thumbnail;
  DateTime terakhir;

  factory Penitipan.fromJson(Map<String, dynamic> json) => Penitipan(
        id: json["id"],
        namaPenitipan: json["nama_penitipan"],
        harga: json["harga"],
        deskripsi: json["deskripsi"],
        sisa: json["sisa"],
        jumlah: json["jumlah"],
        lama: json["lama"],
        thumbnail: json["thumbnail"],
        terakhir: DateTime.parse(json["terakhir"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_penitipan": namaPenitipan,
        "harga": harga,
        "deskripsi": deskripsi,
        "sisa": sisa,
        "jumlah": jumlah,
        "lama": lama,
        "thumbnail": thumbnail,
        "terakhir": terakhir.toIso8601String(),
      };
}
