import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pet_care_icp/components/colors.dart';
import 'package:pet_care_icp/components/money_format.dart';
import 'package:pet_care_icp/components/url_api.dart';
import 'package:pet_care_icp/models/penitipan.dart';
import 'package:pet_care_icp/models/perawatan.dart';
import 'package:pet_care_icp/screens/detail_perawatan.dart';
import 'package:pet_care_icp/widgets/grid_view_perawatan.dart';

class ShowAllPerawatan extends StatefulWidget {
  String url;
  String namaKategori;
  ShowAllPerawatan({super.key, required this.url, required this.namaKategori});

  @override
  State<ShowAllPerawatan> createState() => _ShowAllPerawatanState();
}

class _ShowAllPerawatanState extends State<ShowAllPerawatan> {
  List<Perawatan> dataPerawatan = [];
  Future getPerawatan() async {
    try {
      var response = await http.get(Uri.parse(apiUrl + '/api' + widget.url));
      List data = json.decode(response.body);
      data.forEach((element) {
        dataPerawatan.add(Perawatan.fromJson(element));
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'Jasa Perawatan',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w600, fontSize: 17),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            FutureBuilder(
              future: getPerawatan(),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Text('Loading bentar cuy..'),
                  );
                } else {
                  return GridViewPerawatan(
                      dataPerawatan: dataPerawatan, widget: widget);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
