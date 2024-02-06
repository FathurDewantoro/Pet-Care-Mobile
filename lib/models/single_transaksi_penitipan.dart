// To parse this JSON data, do
//
//     final modelSingleTransaksiPenitipan = modelSingleTransaksiPenitipanFromJson(jsonString);

import 'dart:convert';

ModelSingleTransaksiPenitipan modelSingleTransaksiPenitipanFromJson(
        String str) =>
    ModelSingleTransaksiPenitipan.fromJson(json.decode(str));

String modelSingleTransaksiPenitipanToJson(
        ModelSingleTransaksiPenitipan data) =>
    json.encode(data.toJson());

class ModelSingleTransaksiPenitipan {
  String idPenitipan;
  int idUser;
  DateTime tanggalTitip;
  DateTime tanggalAmbil;
  String statusPenitipan;
  String statusPembayaran;
  int totalPembayaran;
  String fotoHewan;
  DateTime dibuatTanggal;
  InfoPenitipan infoPenitipan;
  String snapToken;

  ModelSingleTransaksiPenitipan({
    required this.idPenitipan,
    required this.idUser,
    required this.tanggalTitip,
    required this.tanggalAmbil,
    required this.statusPenitipan,
    required this.statusPembayaran,
    required this.totalPembayaran,
    required this.fotoHewan,
    required this.dibuatTanggal,
    required this.infoPenitipan,
    required this.snapToken,
  });

  factory ModelSingleTransaksiPenitipan.fromJson(Map<String, dynamic> json) =>
      ModelSingleTransaksiPenitipan(
        idPenitipan: json["id_penitipan"],
        idUser: json["id_user"],
        tanggalTitip: DateTime.parse(json["tanggal_titip"]),
        tanggalAmbil: DateTime.parse(json["tanggal_ambil"]),
        statusPenitipan: json["status_penitipan"],
        statusPembayaran: json["status_pembayaran"],
        totalPembayaran: json["total_pembayaran"],
        fotoHewan: json["foto_hewan"],
        dibuatTanggal: DateTime.parse(json["dibuat_tanggal"]),
        infoPenitipan: InfoPenitipan.fromJson(json["info_penitipan"]),
        snapToken: json["snapToken"],
      );

  Map<String, dynamic> toJson() => {
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
