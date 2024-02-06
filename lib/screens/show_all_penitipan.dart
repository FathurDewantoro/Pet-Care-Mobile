import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pet_care_icp/components/colors.dart';
import 'package:pet_care_icp/components/money_format.dart';
import 'package:pet_care_icp/components/url_api.dart';
import 'package:pet_care_icp/models/penitipan.dart';
import 'package:http/http.dart' as http;
import 'package:pet_care_icp/screens/detail_penitipan.dart';
import 'package:pet_care_icp/widgets/grid_view_penitipan.dart';

class ShowAllPenitipan extends StatefulWidget {
  String url;
  String namaKategori;
  ShowAllPenitipan({required this.url, required this.namaKategori, super.key});

  @override
  State<ShowAllPenitipan> createState() => _ShowAllPenitipanState();
}

class _ShowAllPenitipanState extends State<ShowAllPenitipan> {
  //List Penitipan
  List<Penitipan> dataPenitipan = [];

  //Future Get Data
  Future getPenitipan() async {
    try {
      var response = await http.get(Uri.parse(apiUrl + '/api/penitipan/'));
      List data = json.decode(response.body);
      data.forEach((element) {
        dataPenitipan.add(Penitipan.fromJson(element));
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
        centerTitle: false,
        title: Text(
          'Jasa Penitipan',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w600, fontSize: 17),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          physics: BouncingScrollPhysics(),
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
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 2 / 3.30,
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                  );
                } else {
                  return GridViewPenitipan(dataPenitipan: dataPenitipan);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
