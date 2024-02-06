// To parse this JSON data, do
//
//     final modelTransaksiPenitipan = modelTransaksiPenitipanFromJson(jsonString);

import 'dart:convert';

List<ModelTransaksiPenitipan> modelTransaksiPenitipanFromJson(String str) =>
    List<ModelTransaksiPenitipan>.from(
        json.decode(str).map((x) => ModelTransaksiPenitipan.fromJson(x)));

String modelTransaksiPenitipanToJson(List<ModelTransaksiPenitipan> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelTransaksiPenitipan {
  String id;
  int idPenitipan;
  int idUser;
  DateTime tanggalTitip;
  DateTime tanggalAmbil;
  String statusPenitipan;
  String statusPembayaran;
  int totalPembayaran;
  String fotoHewan;
  DateTime dibuatTanggal;
  String metodePembayaran;
  InfoPenitipan infoPenitipan;
  String snapToken;

  ModelTransaksiPenitipan({
    required this.id,
    required this.idPenitipan,
    required this.idUser,
    required this.tanggalTitip,
    required this.tanggalAmbil,
    required this.statusPenitipan,
    required this.statusPembayaran,
    required this.totalPembayaran,
    required this.fotoHewan,
    required this.dibuatTanggal,
    required this.metodePembayaran,
    required this.infoPenitipan,
    required this.snapToken,
  });

  factory ModelTransaksiPenitipan.fromJson(Map<String, dynamic> json) =>
      ModelTransaksiPenitipan(
        id: json["id"],
        idPenitipan: json["id_penitipan"],
        idUser: json["id_user"],
        tanggalTitip: DateTime.parse(json["tanggal_titip"]),
        tanggalAmbil: DateTime.parse(json["tanggal_ambil"]),
        statusPenitipan: json["status_penitipan"],
        statusPembayaran: json["status_pembayaran"],
        totalPembayaran: json["total_pembayaran"],
        fotoHewan: json["foto_hewan"],
        dibuatTanggal: DateTime.parse(json["dibuat_tanggal"]),
        metodePembayaran: json["metode_pembayaran"],
        infoPenitipan: InfoPenitipan.fromJson(json["info_penitipan"]),
        snapToken: json["snapToken"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_penitipan": idPenitipan,
        "id_user": idUser,
        "tanggal_titip":
            "${tanggalTitip.year.toString().padLeft(4, '0')}-${tanggalTitip.month.toString().padLeft(2, '0')}-${tanggalTitip.day.toString().padLeft(2, '0')}",
        "tanggal_ambil":
            "${tanggalAmbil.year.toString().padLeft(4, '0')}-${tanggalAmbil.month.toString().padLeft(2, '0')}-${tanggalAmbil.day.toString().padLeft(2, '0')}",
        "status_penitipan": statusPenitipan,
        "status_pembayaran": statusPembayaran,
        "total_pembayaran": totalPembayaran,
        "foto_hewan": fotoHewan,
        "dibuat_tanggal": dibuatTanggal.toIso8601String(),
        "metode_pembayaran": metodePembayaran,
        "info_penitipan": infoPenitipan.toJson(),
        "snapToken": snapToken,
      };
}

class InfoPenitipan {
  String namaPenitipan;
  String thumbnail;

  InfoPenitipan({
    required this.namaPenitipan,
    required this.thumbnail,
  });

  factory InfoPenitipan.fromJson(Map<String, dynamic> json) => InfoPenitipan(
        namaPenitipan: json["nama_penitipan"],
        thumbnail: json["thumbnail"],
      );

  Map<String, dynamic> toJson() => {
        "nama_penitipan": namaPenitipan,
        "thumbnail": thumbnail,
      };
}
