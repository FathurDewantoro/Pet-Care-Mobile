import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pet_care_icp/components/colors.dart';
import 'package:pet_care_icp/components/url_api.dart';
import 'package:pet_care_icp/models/user.dart';
import 'package:pet_care_icp/services/storage_service.dart';
import 'package:http/http.dart' as http;

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  TextEditingController namaC = TextEditingController();
  TextEditingController teleponC = TextEditingController();
  TextEditingController alamatC = TextEditingController();
  final SharedStorage _sharedStorage = SharedStorage();

  List<UserModel> dataUser = [];

  Future getDataUser() async {
    var token = await _sharedStorage.getStringValuesSF();
    try {
      var response =
          await http.get(Uri.parse(apiUrl + "/api/getUser/"), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      Map<String, dynamic> data = json.decode(response.body);
      dataUser.add(UserModel.fromJson(data));

      print(token);

      namaC.text = dataUser.first.name;
      alamatC.text = dataUser.first.alamat;
      teleponC.text = dataUser.first.telepon.toString();
      
    } catch (e) {
      print(e);
    }
  }

  Future perbaruiDataDiri() async {
    var token = await _sharedStorage.getStringValuesSF();
    try {
      var response = await http.post(
        Uri.parse(apiUrl + '/api/updateProfile'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, String>{
          'nama': namaC.text,
          'alamat': alamatC.text,
          'telepon': teleponC.text,
        }),
      );

      Map<String, dynamic> data = jsonDecode(response.body);

      print(data);

      if (data['errors'] != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Periksa formulir anda, terdapat kesalahan !"),
          duration: Duration(seconds: 2),
          backgroundColor: primaryColor,
          padding: EdgeInsets.only(top: 25, bottom: 25, left: 20),
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Row(
            children: [
              Text("Data berhasil diperbarui."),
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
          backgroundColor: primaryColor,
          padding: EdgeInsets.only(top: 25, bottom: 25, left: 20),
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ));
        Navigator.pop(context);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey[50],
          title: Text(
            'Perbarui Data Diri',
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
        body: FutureBuilder(
          future: getDataUser(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: SizedBox(
                  height: 55,
                  child: LoadingAnimationWidget.waveDots(
                      color: primaryColor, size: 45),
                ),
              );
            } else {
              return ListView(
                physics: BouncingScrollPhysics(),
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                children: [
                  SizedBox(
                    width: 250,
                    child: Text(
                      "Data yang anda rubah akan diperbarui di dalam sistem dan transaksi berikutnya.",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          color: Colors.grey),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Nama Lengkap",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextField(
                    controller: namaC,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w400),
                    autocorrect: false,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 0),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: unselectedColor)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: primaryColor)),
                      hintText: "Nama Lengkap",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Telepon",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextField(
                    controller: teleponC,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w400),
                    autocorrect: false,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 0),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: unselectedColor)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: primaryColor)),
                      hintText: "Telepon",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Alamat",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextField(
                    controller: alamatC,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w400),
                    autocorrect: false,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 0),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: unselectedColor)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: primaryColor)),
                      hintText: "Alamat",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        perbaruiDataDiri();
                      });
                    },
                    child: Text(
                      "Simpan Perubahan",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        primary: primaryColor,
                        padding: EdgeInsets.all(15)),
                  ),
                ],
              );
            }
          },
        ));
  }
}
