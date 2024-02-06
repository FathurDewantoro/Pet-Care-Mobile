// To parse this JSON data, do
//
//     final modelSingleTransaksiPerawatan = modelSingleTransaksiPerawatanFromJson(jsonString);

import 'dart:convert';

ModelSingleTransaksiPerawatan modelSingleTransaksiPerawatanFromJson(
        String str) =>
    ModelSingleTransaksiPerawatan.fromJson(json.decode(str));

String modelSingleTransaksiPerawatanToJson(
        ModelSingleTransaksiPerawatan data) =>
    json.encode(data.toJson());

class ModelSingleTransaksiPerawatan {
  String id;
  int idUser;
  String idPerawatan;
  String tanggalPerawatan;
  String status;
  String statusPembayaran;
  int total;
  String fotoHewan;
  DateTime tanggalDibuat;
  String metodePembayaran;
  InfoPerawatan infoPerawatan;
  String snapToken;

  ModelSingleTransaksiPerawatan({
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

  factory ModelSingleTransaksiPerawatan.fromJson(Map<String, dynamic> json) =>
      ModelSingleTransaksiPerawatan(
        id: json["id"],
        idUser: json["id_user"],
        idPerawatan: json["id_perawatan"],
        tanggalPerawatan: json["tanggal_perawatan"],
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
        "tanggal_perawatan": tanggalPerawatan,
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
