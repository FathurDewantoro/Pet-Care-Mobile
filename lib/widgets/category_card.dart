import 'package:flutter/material.dart';
import 'package:pet_care_icp/components/colors.dart';
import 'package:pet_care_icp/screens/show_all_penitipan.dart';
import 'package:pet_care_icp/screens/show_all_perawatan.dart';

import '../models/category.dart';

class CardCategories extends StatelessWidget {
  final Category category;
  const CardCategories({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            if (category.title == "Penitipan") {
              return ShowAllPenitipan(url: category.url, namaKategori: category.title);
            } else {
              return ShowAllPerawatan(
                  url: category.url, namaKategori: category.title);
            }
          },
        ),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.42,
        padding: EdgeInsets.only(right: 10, left: 3),
        margin: EdgeInsets.only(left: 20),
        decoration: BoxDecoration(
          border: Border.all(width: 0.4, color: Colors.grey),
          borderRadius: BorderRadius.circular(7),
        ),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 5),
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  image: DecorationImage(
                      image: AssetImage(category.thumbnail),
                      fit: BoxFit.cover)),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              category.title,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
