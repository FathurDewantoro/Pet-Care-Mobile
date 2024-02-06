import 'dart:convert';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pet_care_icp/components/colors.dart';
import 'package:pet_care_icp/components/money_format.dart';
import 'package:pet_care_icp/components/size_helper.dart';
import 'package:pet_care_icp/components/url_api.dart';
import 'package:pet_care_icp/models/single_transaksi_penitipan.dart';
import 'package:pet_care_icp/models/transaksi_penitipan.dart';
import 'package:pet_care_icp/models/transaksi_perawatan.dart';
import 'package:pet_care_icp/screens/snap_web_view_screen.dart';
import 'package:pet_care_icp/services/storage_service.dart';
import 'package:http/http.dart' as http;

class DetailTransaksiPerawatan extends StatefulWidget {
  List<ModelTransaksiPerawatan> dataTransaksi = [];
  int index;
  DetailTransaksiPerawatan(
      {super.key, required this.dataTransaksi, required this.index});

  @override
  State<DetailTransaksiPerawatan> createState() =>
      _DetailTransaksiPerawatanState();
}

class _DetailTransaksiPerawatanState extends State<DetailTransaksiPerawatan> {
  final SharedStorage _sharedStorage = SharedStorage();
  void batalTransaksi() async {
    var token = await _sharedStorage.getStringValuesSF();
    try {
      var response = await http.post(
        Uri.parse(apiUrl + "/api/batalTransaksiPerawatan"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, String>{
          'id_transaksi': widget.dataTransaksi[widget.index].id,
        }),
      );

      Map<String, dynamic> data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Row(
            children: [
              Text("Transaksi berhasil dibatalkan !"),
              SizedBox(
                width: 10,
              ),
              FaIcon(
                FontAwesomeIcons.check,
                color: Colors.white,
              )
            ],
          ),
          duration: Duration(seconds: 2),
          backgroundColor: unselectedColor,
          padding: EdgeInsets.only(top: 25, bottom: 25, left: 20),
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ));
        Navigator.of(context).pop();
      }
    } catch (e) {
      print(e);
    }
  }

  late bool statusPembayaran =
      widget.dataTransaksi[widget.index].statusPembayaran == 'Lunas' ||
              widget.dataTransaksi.first.metodePembayaran == 'Tunai'
          ? false
          : true;
  late bool tomboBatal =
      widget.dataTransaksi[widget.index].statusPembayaran == 'Lunas'
          ? false
          : true;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: primaryColor,
        body: ListView(
          padding: EdgeInsets.only(left: 10, right: 10, top: 25),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Invoice ",
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Pet Care",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Center(
                child: Container(
              width: displayWidth(context) * 0.9,
              height: displayHeight(context) * 0.79,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Detail Transaksi",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "#" + widget.dataTransaksi[widget.index].id,
                      style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w800,
                          color: primaryColor),
                      textAlign: TextAlign.start,
                    ),
                    Dotted(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Jenis Layanan",
                          style: TextStyle(color: unselectedColor),
                        ),
                        SizedBox(
                          width: displayWidth(context) * 0.34,
                          child: Text(
                            widget.dataTransaksi[widget.index].infoPerawatan
                                .namaPerawatan,
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 14),
                            textAlign: TextAlign.start,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tanggal Perawatan",
                          style: TextStyle(color: unselectedColor),
                        ),
                        SizedBox(
                          width: displayWidth(context) * 0.34,
                          child: Text(
                            DateFormat('EEE, dd MMM yyyy').format(widget
                                .dataTransaksi[widget.index].tanggalPerawatan),
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 14),
                            textAlign: TextAlign.start,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Status Transaksi",
                          style: TextStyle(color: unselectedColor),
                        ),
                        SizedBox(
                          width: displayWidth(context) * 0.34,
                          child: Text(widget.dataTransaksi[widget.index].status,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 15),
                              textAlign: TextAlign.start),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Metode Pembayaran",
                          style: TextStyle(color: unselectedColor),
                        ),
                        SizedBox(
                          width: displayWidth(context) * 0.34,
                          child: Text(
                            widget.dataTransaksi.first.metodePembayaran,
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 15),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Status Pembayaran",
                          style: TextStyle(color: unselectedColor),
                        ),
                        SizedBox(
                          width: displayWidth(context) * 0.34,
                          child: Text(
                            widget.dataTransaksi[widget.index].statusPembayaran,
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 15),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Dotted(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          CurrencyFormat.convertToIdr(
                              widget.dataTransaksi[widget.index].total, 0),
                          style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 24),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Colors.black.withOpacity(0.3),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                content: Container(
                                  height: displayHeight(context) * 0.5,
                                  width: displayWidth(context) * 0.7,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.0),
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        image: NetworkImage(apiUrl +
                                            '/storage/images/foto_hewan/' +
                                            widget.dataTransaksi[widget.index]
                                                .fotoHewan),
                                        fit: BoxFit.fitWidth),
                                  ),
                                ),
                              );
                            });
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        side: const BorderSide(
                          width: 1,
                          color: primaryColor,
                        ),
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.all(15),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "Cek Foto Hewan",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: primaryColor),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: statusPembayaran,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            SnapWebViewScreen.routeName,
                            arguments: {
                              'url': apiUrl +
                                  '/webview/' +
                                  widget.dataTransaksi.first.snapToken,
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: primaryColor,
                          padding: EdgeInsets.all(15),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "Bayar",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Visibility(
                        visible: tomboBatal,
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              batalTransaksi();
                            },
                            child: Text(
                              'Batalkan Transaksi',
                              style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}

class Dotted extends StatelessWidget {
  const Dotted({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        DottedLine(
          dashColor: Colors.grey,
          lineThickness: 2,
          dashGapLength: 4.5,
        ),
        const SizedBox(
          height: 25,
        ),
      ],
    );
  }
}
