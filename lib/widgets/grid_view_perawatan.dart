import 'package:flutter/material.dart';
import 'package:pet_care_icp/components/colors.dart';
import 'package:pet_care_icp/components/money_format.dart';
import 'package:pet_care_icp/components/size_helper.dart';
import 'package:pet_care_icp/components/url_api.dart';
import 'package:pet_care_icp/models/perawatan.dart';
import 'package:pet_care_icp/screens/detail_perawatan.dart';

class GridViewPerawatan extends StatelessWidget {
  const GridViewPerawatan({
    Key? key,
    required this.dataPerawatan,
    required this.widget,
  }) : super(key: key);

  final List<Perawatan> dataPerawatan;
  final widget;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: dataPerawatan.length,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 2 / 3.70,
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return DetailPerawatan(
                idPerawatan: dataPerawatan[index].id,
              );
            },
          )),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3), //color of shadow
                    spreadRadius: 1, //spread radius
                    blurRadius: 5, // blur radius
                    offset: Offset(0, 1), // changes position of shadow
                    //first paramerter of offset is left-right
                    //second parameter is top to down
                  )
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: displayWidth(context) * 0.35,
                  height: displayWidth(context) * 0.35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(apiUrl +
                          '/storage/images/foto_layanan/' +
                          dataPerawatan[index].thumbnail),
                    ),
                  ),
                ),
                SizedBox(
                  height: 7,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(2),
                          width: 47,
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            "Tersedia",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      dataPerawatan[index].nama,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w600),
                      maxLines: 2,
                      softWrap: true,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      dataPerawatan[index].deskripsi,
                      style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w300,
                          color: unselectedColor),
                      maxLines: 3,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      CurrencyFormat.convertToIdr(
                          dataPerawatan[index].harga, 0),
                      style: const TextStyle(
                        color: primaryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
