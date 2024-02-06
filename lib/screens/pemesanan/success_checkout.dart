import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pet_care_icp/components/colors.dart';
import 'package:pet_care_icp/components/money_format.dart';
import 'package:pet_care_icp/components/size_helper.dart';
import 'package:pet_care_icp/models/single_transaksi_penitipan.dart';
import 'package:pet_care_icp/models/transaksi_penitipan.dart';

class SuccessCheckout extends StatefulWidget {
  List<ModelSingleTransaksiPenitipan> dataTransaksi = [];
  SuccessCheckout({super.key, required this.dataTransaksi});

  @override
  State<SuccessCheckout> createState() => _SuccessCheckoutState();
}

class _SuccessCheckoutState extends State<SuccessCheckout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[50],
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.of(context)
              .pushNamedAndRemoveUntil('/', (route) => false),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
        children: [
          Center(
            child: Column(
              children: [
                FaIcon(
                  FontAwesomeIcons.solidCheckCircle,
                  color: Colors.green[400],
                  size: 40,
                ),
                SizedBox(
                  height: 10,
                ),
                const Text(
                  "Pemesanan Berhasil",
                  style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
                const SizedBox(
                  height: 7,
                ),
                Text(
                  CurrencyFormat.convertToIdr(
                      widget.dataTransaksi.first.totalPembayaran, 0),
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 28),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            width: displayWidth(context),
            height: 350,
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
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Detail Transaksi',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Metode Pembayaran",
                        style: TextStyle(color: unselectedColor),
                      ),
                      Text(
                        "Tunai",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 15),
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
                        "Tanggal Penitipan",
                        style: TextStyle(color: unselectedColor),
                      ),
                      SizedBox(
                        width: displayWidth(context) * 0.4,
                        child: Text(
                          DateFormat('EEE, dd MMM yyyy')
                              .format(widget.dataTransaksi.first.tanggalTitip),
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 14),
                          textAlign: TextAlign.end,
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
                        "Status Transaksi",
                        style: TextStyle(color: unselectedColor),
                      ),
                      SizedBox(
                        width: displayWidth(context) * 0.3,
                        child: Text(
                          widget.dataTransaksi.first.statusPenitipan,
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 15),
                          textAlign: TextAlign.end,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Jenis Layanan",
                        style: TextStyle(color: unselectedColor),
                      ),
                      SizedBox(
                        width: displayWidth(context) * 0.3,
                        child: Text(
                          widget
                              .dataTransaksi.first.infoPenitipan.namaPenitipan,
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 14),
                          textAlign: TextAlign.end,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  DottedLine(),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total",
                        style: TextStyle(color: unselectedColor, fontSize: 15),
                      ),
                      SizedBox(
                        width: displayWidth(context) * 0.3,
                        child: Text(
                          CurrencyFormat.convertToIdr(
                              widget.dataTransaksi.first.totalPembayaran, 0),
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Segera lakukan pembayaran maksimal 1 hari setelah melakukan pemesanan.",
            style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
          )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/', (route) => false);
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            primary: primaryColor,
            padding: EdgeInsets.all(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "Done",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
