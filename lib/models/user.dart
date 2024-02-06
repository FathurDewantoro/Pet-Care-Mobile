import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.alamat,
    required this.telepon,
    required this.jenisKelamin,
    required this.foto,
    required this.terakhirDiperbarui,
  });

  int id;
  String name;
  String email;
  String alamat;
  String telepon;
  String jenisKelamin;
  String foto;
  DateTime terakhirDiperbarui;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        alamat: json["alamat"],
        telepon: json["telepon"],
        jenisKelamin: json["jenis_kelamin"],
        foto: json["foto"],
        terakhirDiperbarui: DateTime.parse(json["terakhir_diperbarui"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "alamat": alamat,
        "telepon": telepon,
        "jenis_kelamin": jenisKelamin,
        "foto": foto,
        "terakhir_diperbarui": terakhirDiperbarui.toIso8601String(),
      };
}
