// To parse this JSON data, do
//
//     final modelTransaksiPerawatan = modelTransaksiPerawatanFromJson(jsonString);

import 'dart:convert';

List<ModelTransaksiPerawatan> modelTransaksiPerawatanFromJson(String str) =>
    List<ModelTransaksiPerawatan>.from(
        json.decode(str).map((x) => ModelTransaksiPerawatan.fromJson(x)));

String modelTransaksiPerawatanToJson(List<ModelTransaksiPerawatan> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelTransaksiPerawatan {
  String id;
  int idUser;
  int idPerawatan;
  DateTime tanggalPerawatan;
  String status;
  String statusPembayaran;
  int total;
  String fotoHewan;
  DateTime tanggalDibuat;
  String metodePembayaran;
  InfoPerawatan infoPerawatan;
  String snapToken;

  ModelTransaksiPerawatan({
    required this.id,
    required this.idUser,
    required this.idPerawatan,
    required this.tanggalPerawatan,
    required this.status,
    required this.statusPembayaran,
    required this.total,
    required this.fotoHewan,
    required this.tanggalDibuat,
    required this.metodePembayaran,
    required this.infoPerawatan,
    required this.snapToken,
  });

  factory ModelTransaksiPerawatan.fromJson(Map<String, dynamic> json) =>
      ModelTransaksiPerawatan(
        id: json["id"],
        idUser: json["id_user"],
        idPerawatan: json["id_perawatan"],
        tanggalPerawatan: DateTime.parse(json["tanggal_perawatan"]),
        status: json["status"],
        statusPembayaran: json["status_pembayaran"],
        total: json["total"],
        fotoHewan: json["foto_hewan"],
        tanggalDibuat: DateTime.parse(json["tanggal_dibuat"]),
        metodePembayaran: json["metode_pembayaran"],
        infoPerawatan: InfoPerawatan.fromJson(json["info_perawatan"]),
        snapToken: json["snapToken"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_user": idUser,
        "id_perawatan": idPerawatan,
        "tanggal_perawatan":
            "${tanggalPerawatan.year.toString().padLeft(4, '0')}-${tanggalPerawatan.month.toString().padLeft(2, '0')}-${tanggalPerawatan.day.toString().padLeft(2, '0')}",
        "status": status,
        "status_pembayaran": statusPembayaran,
        "total": total,
        "foto_hewan": fotoHewan,
        "tanggal_dibuat": tanggalDibuat.toIso8601String(),
        "metode_pembayaran": metodePembayaran,
        "info_perawatan": infoPerawatan.toJson(),
        "snapToken": snapToken,
      };
}

class InfoPerawatan {
  String namaPerawatan;
  String thumbnail;

  InfoPerawatan({
    required this.namaPerawatan,
    required this.thumbnail,
  });

  factory InfoPerawatan.fromJson(Map<String, dynamic> json) => InfoPerawatan(
        namaPerawatan: json["nama_perawatan"],
        thumbnail: json["thumbnail"],
      );

  Map<String, dynamic> toJson() => {
        "nama_perawatan": namaPerawatan,
        "thumbnail": thumbnail,
      };
}
