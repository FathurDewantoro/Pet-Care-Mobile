import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pet_care_icp/components/colors.dart';
import 'package:pet_care_icp/components/money_format.dart';
import 'package:pet_care_icp/components/size_helper.dart';
import 'package:pet_care_icp/components/url_api.dart';
import 'package:pet_care_icp/models/transaksi_perawatan.dart';
import 'package:pet_care_icp/screens/list_transaksi/detail_transaksi_perawatan.dart';

class CardTransaksiPerawatan extends StatelessWidget {
  const CardTransaksiPerawatan({
    Key? key,
    required this.dataTransaksiPerawatanLength,
    required this.dataTransaksiPerawatan,
  }) : super(key: key);

  final int dataTransaksiPerawatanLength;
  final List<ModelTransaksiPerawatan> dataTransaksiPerawatan;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.all(5),
      itemCount: dataTransaksiPerawatanLength,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return DetailTransaksiPerawatan(
                  dataTransaksi: dataTransaksiPerawatan,
                  index: index,
                );
              },
            ));
          },
          child: Container(
            margin: EdgeInsets.only(top: 20),
            height: 120,
            width: displayWidth(context),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 14),
                  child: Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(apiUrl +
                            '/storage/images/foto_layanan/' +
                            dataTransaksiPerawatan[index]
                                .infoPerawatan
                                .thumbnail),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                SizedBox(
                  width: displayWidth(context) * 0.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '#' + dataTransaksiPerawatan[index].id,
                        style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        dataTransaksiPerawatan[index]
                            .infoPerawatan
                            .namaPerawatan,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                        maxLines: 1,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        DateFormat.yMMMd().format(
                            dataTransaksiPerawatan[index].tanggalDibuat),
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: unselectedColor),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            CurrencyFormat.convertToIdr(
                                dataTransaksiPerawatan[index].total, 0),
                            style: TextStyle(
                              color: dataTransaksiPerawatan[index].status ==
                                      'Dibatalkan'
                                  ? unselectedColor
                                  : primaryColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 3),
                            width: 65,
                            decoration: BoxDecoration(
                              color: dataTransaksiPerawatan[index]
                                          .statusPembayaran ==
                                      'Lunas'
                                  ? primaryColor
                                  : dataTransaksiPerawatan[index]
                                              .statusPembayaran ==
                                          'Dibatalkan'
                                      ? unselectedColor
                                      : secondaryColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              dataTransaksiPerawatan[index].statusPembayaran,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}


 