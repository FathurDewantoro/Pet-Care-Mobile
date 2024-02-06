// To parse this JSON data, do
//
//     final modelIklan = modelIklanFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<ModelIklan> modelIklanFromJson(String str) =>
    List<ModelIklan>.from(json.decode(str).map((x) => ModelIklan.fromJson(x)));

String modelIklanToJson(List<ModelIklan> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelIklan {
  ModelIklan({
    required this.id,
    required this.foto,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String foto;
  final String title;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory ModelIklan.fromJson(Map<String, dynamic> json) => ModelIklan(
        id: json["id"],
        foto: json["foto"],
        title: json["title"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "foto": foto,
        "title": title,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
