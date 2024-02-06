import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pet_care_icp/components/colors.dart';
import 'package:pet_care_icp/components/url_api.dart';
import 'package:pet_care_icp/models/penitipan.dart';
import 'package:pet_care_icp/models/perawatan.dart';
import 'package:pet_care_icp/widgets/grid_view_penitipan.dart';
import 'package:pet_care_icp/widgets/grid_view_perawatan.dart';

class SearchScreen extends StatefulWidget {
  String kataKunci;
  SearchScreen({super.key, required this.kataKunci});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String statusCodePenitipan = '';
  String statusCodePerawatan = '';
  //List Penitipan
  List<Penitipan> dataPenitipan = [];
  List<Perawatan> dataPerawatan = [];

  //Future Get Data
  Future getPenitipan() async {
    try {
      var response = await http
          .get(Uri.parse(apiUrl + '/api/cariPenitipan/' + widget.kataKunci));
      statusCodePenitipan = response.statusCode.toString();
      List data = json.decode(response.body);

      data.forEach((element) {
        dataPenitipan.add(Penitipan.fromJson(element));
      });
    } catch (e) {
      print(e);
    }
  }

  Future getPerawatan() async {
    try {
      var response = await http
          .get(Uri.parse(apiUrl + '/api/cariPerawatan/' + widget.kataKunci));
      statusCodePerawatan = response.statusCode.toString();
      List data = json.decode(response.body);
      data.forEach((element) {
        dataPerawatan.add(Perawatan.fromJson(element));
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        title: Text(
          'Pencarian ' + widget.kataKunci + ' ?',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w600, fontSize: 17),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
        children: [
          FutureBuilder(
            future: getPenitipan(),
            builder: (BuildContext context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return GridView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      width: double.infinity,
                      height: 250,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10)),
                    );
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 2 / 3.30,
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                );
              } else if (statusCodePenitipan == "404" && statusCodePerawatan == "404") {
                return Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 300,
                      ),
                      const Text(
                        "Maaf :(",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: primaryColor),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Pencarian dengan kata kunci\n" +
                            widget.kataKunci +
                            " tidak ditemukan.",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              } else {
                if (dataPenitipan.isEmpty) {
                  return const SizedBox(
                    height: 1,
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Kategori Penitipan',
                        style: TextStyle(
                          fontSize: 16,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Text(
                        'Ditemukan dari kategori layanan penitipan.',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      GridViewPenitipan(dataPenitipan: dataPenitipan),
                    ],
                  );
                }
              }
            },
          ),
          FutureBuilder(
            future: getPerawatan(),
            builder: (BuildContext context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return GridView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      width: double.infinity,
                      height: 250,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10)),
                    );
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 2 / 3.30,
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                );
              } else {
                if (dataPerawatan.isEmpty) {
                  return const SizedBox(
                    height: 1,
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Kategori Perawatan',
                        style: TextStyle(
                          fontSize: 16,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Text(
                        'Ditemukan dari kategori layanan perawatan.',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      GridViewPerawatan(
                          dataPerawatan: dataPerawatan, widget: 'perawatan'),
                    ],
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
