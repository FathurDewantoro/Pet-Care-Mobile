import 'package:flutter/material.dart';

class Category {
  String thumbnail;
  String title;
  String url;

  Category({required this.thumbnail, required this.title, required this.url});
}

List<Category> categoryList = [
  Category(
    thumbnail: 'assets/images/pet-cargo.jpg',
    title: "Penitipan",
    url: "/penitipan",
  ),
  Category(
    thumbnail: 'assets/images/pet-cleanliness.jpg',
    title: "Perawatan",
    url: "/perawatan",
  ),
];
