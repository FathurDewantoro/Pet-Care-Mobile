import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pet_care_icp/components/colors.dart';
import 'package:pet_care_icp/components/url_api.dart';
import 'package:pet_care_icp/models/transaksi_penitipan.dart';
import 'package:pet_care_icp/models/transaksi_perawatan.dart';
import 'package:pet_care_icp/screens/list_transaksi/card_transaksi_penitipan.dart';
import 'package:pet_care_icp/screens/list_transaksi/card_transaksi_perawatan.dart';
import 'package:pet_care_icp/screens/list_transaksi/transaksi_kosong.dart';
import 'package:pet_care_icp/screens/list_transaksi/unauthorize_page.dart';
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
    print('init list');
    var getToken = await _sharedStorage.isToken();
    if (getToken) {
      setState(() {
        widget.isLogin = getToken;
      });
    } else {
      setState(() {
        widget.isLogin = false;
      });
    }
    print(widget.isLogin);
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
      dataTransaksiPenitipan.clear();
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
          .get(Uri.parse("$apiUrl/api/transaksiPerawatan/"), headers: {
        'Authorization': 'Bearer $token',
      });
      dataTransaksiPerawatan.clear();
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
    if (widget.isLogin == true) {
      return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: const Text(
              'Transaksi',
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            bottom: const TabBar(
              tabs: [
                Tab(
                  text: "Penitipan",
                ),
                Tab(
                  text: "Perawatan",
                ),
              ],
              indicatorColor: primaryColor,
              labelColor: primaryColor,
            ),
          ),
          body: TabBarView(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: FutureBuilder(
                  future: getTransaksiPenitipan(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: LoadingAnimationWidget.waveDots(
                            color: primaryColor, size: 40),
                      );
                    } else {
                      if (dataTransaksiPenitipan.isEmpty) {
                        return TransaksiKosong();
                      } else {
                        return CardTransaksiPenitipan(
                            dataTransaksiLength: dataTransaksiPenitipanLength,
                            dataTransaksi: dataTransaksiPenitipan);
                      }
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: FutureBuilder(
                  future: getTransaksiPerawatan(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center();
                    } else {
                      if (dataTransaksiPerawatan.isEmpty) {
                        return TransaksiKosong();
                      } else {
                        return CardTransaksiPerawatan(
                            dataTransaksiPerawatanLength:
                                dataTransaksiPerawatanLength,
                            dataTransaksiPerawatan: dataTransaksiPerawatan);
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return TransaksiUnauthorize();
    }
  }
}
