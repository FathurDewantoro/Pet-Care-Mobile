import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_care_icp/components/colors.dart';
import 'package:pet_care_icp/components/size_helper.dart';

class TransaksiKosong extends StatelessWidget {
  const TransaksiKosong({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          height: displayHeight(context) * 0.2,
          child: Column(
            children: const [
              FaIcon(
                FontAwesomeIcons.sadCry,
                size: 50,
                color: primaryColor,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Yah transaksimu kosong.\nPesan yuk..",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
