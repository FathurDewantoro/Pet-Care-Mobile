import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_care_icp/components/colors.dart';
import 'package:pet_care_icp/components/size_helper.dart';

class CardMetodePembayaran extends StatelessWidget {
  const CardMetodePembayaran({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Metode Pembayaran",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          width: displayWidth(context),
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: primaryColor, width: 0.5),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 1),
              )
            ],
          ),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 15, bottom: 10),
                width: 45,
                height: 45,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/cash.png'),
                      fit: BoxFit.cover),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              const Text(
                'Pembayaran Tunai',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                width: 100,
              ),
              const Icon(
                FontAwesomeIcons.chevronRight,
                size: 16,
                color: primaryColor,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 35,
        ),
      ],
    );
  }
}
