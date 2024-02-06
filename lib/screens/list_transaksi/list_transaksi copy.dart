import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pet_care_icp/components/colors.dart';
import 'package:pet_care_icp/components/money_format.dart';
import 'package:pet_care_icp/components/size_helper.dart';
import 'package:pet_care_icp/components/url_api.dart';
import 'package:pet_care_icp/models/transaksi_penitipan.dart';
import 'package:pet_care_icp/models/transaksi_perawatan.dart';
import 'package:pet_care_icp/screens/list_transaksi/card_transaksi_penitipan.dart';
import 'package:pet_care_icp/services/storage_service.dart';
import 'package:http/http.dart' as http;

class ListTransaksi extends StatefulWidget {
  late bool isLogin = this.isLogin;
  ListTransaksi({super.key, required this.isLogin});

  @override
  State<ListTransaksi> createState() => _ListTransaksiState();
}

class _ListTransaksiState extends State<ListTransaksi> {
  final SharedStorage _sharedStorage = SharedStorage();
  late int dataTransaksiPenitipanLength;
  late int dataTransaksiPerawatanLength;
  List<ModelTransaksiPenitipan> dataTransaksiPenitipan = [];
  List<ModelTransaksiPerawatan> dataTransaksiPerawatan = [];

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    var getToken = await _sharedStorage.isToken();
    if (getToken) {
      setState(() {
        widget.isLogin = getToken;
      });
    }
  }

  Future getTransaksiPenitipan() async {
    var token = await _sharedStorage.getStringValuesSF();
    var idUser = await _sharedStorage.getUserId();

    try {
      var response = await http
          .get(Uri.parse("$apiUrl/api/transaksiPenitipan/$idUser"), headers: {
        'Authorization': 'Bearer $token',
      });
      List data = json.decode(response.body);
      dataTransaksiPenitipanLength = data.length;
      data.forEach((element) {
        dataTransaksiPenitipan.add(ModelTransaksiPenitipan.fromJson(element));
      });
    } catch (e) {
      print(e);
    }
  }

  Future getTransaksiPerawatan() async {
    var token = await _sharedStorage.getStringValuesSF();
    var idUser = await _sharedStorage.getUserId();

    try {
      var response = await http
          .get(Uri.parse("$apiUrl/api/transaksiPerawatan/$idUser"), headers: {
        'Authorization': 'Bearer $token',
      });
      List data = json.decode(response.body);
      dataTransaksiPerawatanLength = data.length;
      data.forEach((element) {
        dataTransaksiPerawatan.add(ModelTransaksiPerawatan.fromJson(element));
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Transaksi',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 10,
        ),
        child: ListView(
          children: [
            Text("Daftar transaksi yang sudah \npernah kamu lakukan."),
            SizedBox(
              height: 15,
            ),
            FutureBuilder(
              future: getTransaksiPenitipan(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Expanded(
                    child: Center(
                      child: LoadingAnimationWidget.waveDots(
                          color: primaryColor, size: 40),
                    ),
                  );
                } else {
                  return CardTransaksiPenitipan(
                      dataTransaksiLength: dataTransaksiPenitipanLength,
                      dataTransaksi: dataTransaksiPenitipan);
                }
              },
            ),
            FutureBuilder(
              future: getTransaksiPerawatan(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center();
                } else {
                  return Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.all(0),
                      itemCount: dataTransaksiPerawatanLength,
                      itemBuilder: (context, index) {
                        return Container(
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
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        dataTransaksiPerawatan[index]
                                            .infoPerawatan
                                            .namaPerawatan,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                        maxLines: 2,
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        DateFormat.yMMMd().format(
                                            dataTransaksiPerawatan[index]
                                                .tanggalDibuat),
                                        style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            color: unselectedColor),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            CurrencyFormat.convertToIdr(
                                                dataTransaksiPerawatan[index]
                                                    .total,
                                                0),
                                            style: TextStyle(
                                              color: dataTransaksiPerawatan[
                                                              index]
                                                          .statusPembayaran ==
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
                                              color: dataTransaksiPerawatan[
                                                              index]
                                                          .statusPembayaran ==
                                                      'Lunas'
                                                  ? primaryColor
                                                  : dataTransaksiPerawatan[
                                                                  index]
                                                              .statusPembayaran ==
                                                          'Dibatalkan'
                                                      ? unselectedColor
                                                      : secondaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Text(
                                              dataTransaksiPerawatan[index]
                                                  .statusPembayaran,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
