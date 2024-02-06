import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pet_care_icp/components/colors.dart';
import 'package:pet_care_icp/components/money_format.dart';
import 'package:pet_care_icp/components/url_api.dart';
import 'package:pet_care_icp/models/penitipan.dart';
import 'package:pet_care_icp/screens/pemesanan/checkout_penitipan.dart';
import 'package:pet_care_icp/services/storage_service.dart';

class DetailPenitipan extends StatefulWidget {
  int idPenitipan;
  DetailPenitipan({required this.idPenitipan, super.key});

  @override
  State<DetailPenitipan> createState() => _DetailPenitipanState();
}

class _DetailPenitipanState extends State<DetailPenitipan> {
  List<Penitipan> dataPenitipan = [];
  bool favourite = false;
  final SharedStorage _sharedStorage = SharedStorage();
  bool isLogin = false;

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    var isToken = await _sharedStorage.isToken();
    isLogin = isToken;
  }

  Future getPenitipan() async {
    try {
      var response = await http
          .get(Uri.parse('$apiUrl/api/penitipan/${widget.idPenitipan}'));
      var data = json.decode(response.body);
      dataPenitipan.add(Penitipan.fromJson(data[0]));
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
        title: const Text(
          'Detail Jasa Penitipan',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w600, fontSize: 17),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: FutureBuilder(
        future: getPenitipan(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Text("Loading.."),
            );
          } else {
            return ListView(
              padding: const EdgeInsets.only(left: 20, right: 20),
              children: [
                Container(
                  height: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(
                          '$apiUrl/storage/images/foto_layanan/${dataPenitipan.first.thumbnail}'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      width: 130,
                      decoration: BoxDecoration(
                        color: accentColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        "Tersisa " '${dataPenitipan.first.sisa} Kandang',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 0),
                  child: Text(
                    dataPenitipan.first.namaPenitipan,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600),
                    maxLines: 3,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      CurrencyFormat.convertToIdr(dataPenitipan[0].harga, 0),
                      style: const TextStyle(
                        color: primaryColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      '47 Transaksi Berhasil',
                      style: TextStyle(fontSize: 13),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  dataPenitipan.first.deskripsi,
                  style: const TextStyle(
                      fontSize: 14,
                      color: unselectedColor,
                      fontWeight: FontWeight.w500),
                  maxLines: 6,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  '*Penitipan dihitung sejak penginputan tanggal dimulai',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: unselectedColor,
                      fontStyle: FontStyle.italic),
                ),
                SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (dataPenitipan.first.sisa <= 0) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Stok kosong, tidak dapat di proses."),
                        duration: Duration(seconds: 1),
                        backgroundColor: Colors.red[400],
                        padding: EdgeInsets.only(top: 25, bottom: 25, left: 20),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ));
                    } else {
                      if (isLogin == true) {
                        print(isLogin);
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return CheckoutPenitipan(
                              dataPenitipan: dataPenitipan,
                            );
                          },
                        ));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              "Anda perlu login untu melakukan transaksi."),
                          duration: Duration(seconds: 1),
                          backgroundColor: Colors.red[400],
                          padding:
                              EdgeInsets.only(top: 25, bottom: 25, left: 20),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ));
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    primary: primaryColor,
                    padding: EdgeInsets.all(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Pesan",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      Icon(Icons.arrow_forward)
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
