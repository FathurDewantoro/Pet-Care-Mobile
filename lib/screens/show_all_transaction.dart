import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pet_care_icp/components/colors.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              height: 100,
              child: Column(
                children: const [
                  Text(
                    "Sorry :(",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: primaryColor),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Halaman transaksi masih \ndalam masa pengembangan.",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          )),
    );
    ;
  }
}
