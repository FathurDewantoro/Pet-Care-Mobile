import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pet_care_icp/components/colors.dart';
import 'package:http/http.dart' as http;
import 'package:pet_care_icp/components/money_format.dart';
import 'package:pet_care_icp/models/penitipan.dart';
import 'package:pet_care_icp/components/url_api.dart';
import 'package:pet_care_icp/screens/detail_penitipan.dart';

class CardPenitipanFavourite extends StatefulWidget {
  const CardPenitipanFavourite({super.key});

  @override
  State<CardPenitipanFavourite> createState() => _CardPenitipanFavouriteState();
}

class _CardPenitipanFavouriteState extends State<CardPenitipanFavourite> {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 0),
          child: Row(
            children: [
              const Text(
                "Penitipan Favorit",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Icon(
                Icons.favorite,
                color: Colors.pink[400],
                size: 20,
              )
            ],
          ),
        ),
        FutureBuilder(
          future: getPenitipan(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    height: 120,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 238, 238, 238),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  );
                },
              );
            } else {
              return ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 2,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return DetailPenitipan(
                            idPenitipan: dataPenitipan[index].id);
                      },
                    )),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      height: 130,
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 15),
                            width: 110,
                            height: 110,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              image: DecorationImage(
                                image: NetworkImage(apiUrl +
                                    '/storage/images/foto_layanan/' +
                                    dataPenitipan[index].thumbnail),
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.57,
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  dataPenitipan[index].namaPenitipan,
                                  style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  dataPenitipan[index].deskripsi,
                                  style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w300,
                                      color: unselectedColor),
                                  maxLines: 3,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                      width: 70,
                                      decoration: BoxDecoration(
                                        color: accentColor,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: const Text(
                                        "Paling Laris",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 9,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ],
    );
  }
    
}
