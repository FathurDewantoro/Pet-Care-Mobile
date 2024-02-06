import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_care_icp/components/colors.dart';
import 'package:pet_care_icp/components/size_helper.dart';

class TransaksiUnauthorize extends StatelessWidget {
  const TransaksiUnauthorize({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        title: const Text(
          'Transaksi',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          height: displayHeight(context) * 0.2,
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              FaIcon(
                FontAwesomeIcons.signIn,
                size: 50,
                color: primaryColor,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Maaf nih.",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: primaryColor),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Kamu harus login dulu untuk\nmembuka menu transaksi ini..",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
