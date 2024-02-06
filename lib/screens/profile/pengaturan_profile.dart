import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_care_icp/components/colors.dart';
import 'package:pet_care_icp/screens/profile/update_foto_profile.dart';
import 'package:pet_care_icp/screens/profile/update_profile.dart';

class PengaturanProfileScreen extends StatefulWidget {
  const PengaturanProfileScreen({super.key});

  @override
  State<PengaturanProfileScreen> createState() =>
      _PengaturanProfileScreenState();
}

class _PengaturanProfileScreenState extends State<PengaturanProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[50],
        title: Text(
          'Pengaturan Akun',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 20, right: 20, top: 10),
        children: [
          Text(
            'Aktivitas Akun',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return UpdateProfileScreen();
                },
              ));
            },
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10),
                  width: 45,
                  child: FaIcon(
                    FontAwesomeIcons.fileInvoice,
                    size: 26,
                    color: unselectedColor,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Perbarui Data Diri",
                  style: TextStyle(
                      color: unselectedColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return PerbaruiFotoProfileScreen();
                },
              ));
            },
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10),
                  width: 45,
                  child: FaIcon(
                    FontAwesomeIcons.image,
                    size: 26,
                    color: unselectedColor,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Perbarui Foto Profile",
                  style: TextStyle(
                      color: unselectedColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
