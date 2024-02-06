import 'package:flutter/material.dart';
import 'package:pet_care_icp/components/colors.dart';
import 'package:pet_care_icp/components/money_format.dart';
import 'package:pet_care_icp/components/size_helper.dart';
import 'package:pet_care_icp/components/url_api.dart';
import 'package:pet_care_icp/models/penitipan.dart';
import 'package:pet_care_icp/screens/detail_penitipan.dart';

class GridViewPenitipan extends StatelessWidget {
  const GridViewPenitipan({
    Key? key,
    required this.dataPenitipan,
  }) : super(key: key);

  final List<Penitipan> dataPenitipan;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: dataPenitipan.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return DetailPenitipan(idPenitipan: dataPenitipan[index].id);
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
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 1),
                  )
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: displayWidth(context) * 0.35,
                    height: displayWidth(context) * 0.35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(apiUrl +
                            '/storage/images/foto_layanan/' +
                            dataPenitipan[index].thumbnail),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  dataPenitipan[index].namaPenitipan,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w600),
                  maxLines: 2,
                  softWrap: true,
                ),
                const SizedBox(height: 5),
                Text(
                  dataPenitipan[index].deskripsi,
                  style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w300,
                      color: unselectedColor),
                  maxLines: 4,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      CurrencyFormat.convertToIdr(
                          dataPenitipan[index].harga, 0),
                      style: const TextStyle(
                        color: primaryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(2),
                      width: 47,
                      decoration: BoxDecoration(
                        color: accentColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        "Tersisa ${dataPenitipan[index].sisa}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 2 / 3.40,
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
    );
  }
}
