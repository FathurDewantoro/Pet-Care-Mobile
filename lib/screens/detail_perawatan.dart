import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pet_care_icp/components/colors.dart';
import 'package:pet_care_icp/components/money_format.dart';
import 'package:pet_care_icp/components/url_api.dart';
import 'package:pet_care_icp/models/perawatan.dart';
import 'package:pet_care_icp/screens/pemesanan/checkout_perawatan.dart';
import 'package:pet_care_icp/services/storage_service.dart';

class DetailPerawatan extends StatefulWidget {
  int idPerawatan;
  DetailPerawatan({
    super.key,
    required this.idPerawatan,
  });

  @override
  State<DetailPerawatan> createState() => _DetailPerawatanState();
}

class _DetailPerawatanState extends State<DetailPerawatan> {
  List<Perawatan> dataPerawatan = [];

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

  Future getPerawatan() async {
    try {
      var response = await http
          .get(Uri.parse('$apiUrl/api/perawatan/${widget.idPerawatan}'));
      List data = json.decode(response.body);
      dataPerawatan.add(Perawatan.fromJson(data[0]));
      print(data);
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
        future: getPerawatan(),
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
                          '$apiUrl/storage/images/foto_layanan/${dataPerawatan.first.thumbnail}'),
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
                      width: 80,
                      decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Text(
                        "Tersedia",
                        textAlign: TextAlign.center,
                        style: TextStyle(
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
                    dataPerawatan.first.nama,
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
                      CurrencyFormat.convertToIdr(dataPerawatan[0].harga, 0),
                      style: const TextStyle(
                        color: primaryColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    // const Text(
                    //   '47 Transaksi Berhasil',
                    //   style: TextStyle(fontSize: 13),
                    // )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  dataPerawatan.first.deskripsi,
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
                  '*Hewan harus diantar sesuai dengan tanggal yang dipilih.',
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
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return CheckoutPerawatan(dataPerawatan: dataPerawatan);
                      },
                    ));
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
