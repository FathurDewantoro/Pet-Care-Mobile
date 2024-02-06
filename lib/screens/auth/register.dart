import 'dart:convert';

import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_care_icp/components/colors.dart';
import 'package:http/http.dart' as http;
import 'package:pet_care_icp/components/url_api.dart';

class PageDaftarAkun extends StatefulWidget {
  const PageDaftarAkun({super.key});

  @override
  State<PageDaftarAkun> createState() => _PageDaftarAkunState();
}

class _PageDaftarAkunState extends State<PageDaftarAkun> {
  TextEditingController namaC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  TextEditingController validasiPasswordC = TextEditingController();
  TextEditingController teleponC = TextEditingController();
  TextEditingController alamatC = TextEditingController();
  bool hiddenPassword = true;

  final List<String> items = [
    'Laki-Laki',
    'Perempuan',
  ];
  String selectedValue = "Laki-Laki";

  late Map<String, dynamic> errorHandler;

  Future registerUser() async {
    try {
      var response = await http.post(
        Uri.parse(apiUrl + "/api/registerUser/"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'nama': namaC.text,
          'email': emailC.text,
          'password': passwordC.text,
          'validasi_password': validasiPasswordC.text,
          'telepon': teleponC.text,
          'alamat': alamatC.text,
          'jenis_kelamin': selectedValue,
        }),
      );

      Map<String, dynamic> data = jsonDecode(response.body);

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
              Text("Selamat, akun berhasil dibuat. Silahkan login !"),
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
        Navigator.of(context).pop();
      }
    } catch (e) {
      print("eror");
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey[50],
          leading: IconButton(
            icon: Icon(Icons.close, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: ListView(
          physics: BouncingScrollPhysics(),
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          children: [
            Text(
              "Buat Akun Baru",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: primaryColor),
            ),
            SizedBox(
              height: 7,
            ),
            SizedBox(
              width: 250,
              child: Text(
                "Buatlah akun baru dan dapatkan semua kemudan bertransaksi menggunakan Pet Care.",
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
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              autocorrect: false,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: unselectedColor)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: primaryColor)),
                hintText: "Nama Lengkap",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            const Text(
              "Email",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
            ),
            const SizedBox(
              height: 5,
            ),
            TextField(
              controller: emailC,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              autocorrect: false,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: unselectedColor)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: primaryColor)),
                hintText: "name@mail.com",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Password",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
            ),
            const SizedBox(
              height: 5,
            ),
            TextField(
              controller: passwordC,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              autocorrect: false,
              textInputAction: TextInputAction.done,
              obscureText: hiddenPassword,
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: unselectedColor)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: primaryColor)),
                  hintText: "Password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  suffixIcon: IconButton(
                      onPressed: () {
                        if (hiddenPassword == true) {
                          hiddenPassword = false;
                        } else {
                          hiddenPassword = true;
                        }
                        setState(() {});
                      },
                      icon: Icon(
                        hiddenPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: unselectedColor,
                      ))),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Ulangi Password",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
            ),
            const SizedBox(
              height: 5,
            ),
            TextField(
              controller: validasiPasswordC,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              autocorrect: false,
              textInputAction: TextInputAction.done,
              obscureText: hiddenPassword,
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: unselectedColor)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: primaryColor)),
                  hintText: "Password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  suffixIcon: IconButton(
                      onPressed: () {
                        if (hiddenPassword == true) {
                          hiddenPassword = false;
                        } else {
                          hiddenPassword = true;
                        }
                        setState(() {});
                      },
                      icon: Icon(
                        hiddenPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: unselectedColor,
                      ))),
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
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              autocorrect: false,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: unselectedColor)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: primaryColor)),
                hintText: "Telepon",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              autocorrect: false,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: unselectedColor)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: primaryColor)),
                hintText: "Alamat",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            const Text(
              "Jenis Kelamin",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
            ),
            const SizedBox(
              height: 5,
            ),
            CustomDropdownButton2(
              buttonHeight: 45,
              hint: 'Select Item',
              dropdownItems: items,
              value: selectedValue,
              onChanged: (value) {
                setState(() {
                  selectedValue = value.toString();
                  print(selectedValue);
                });
              },
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  registerUser();
                });
              },
              child: Text(
                "Daftar",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
              ),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  primary: primaryColor,
                  padding: EdgeInsets.all(15)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Sudah punya akun ? ",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                          fontWeight: FontWeight.w600),
                    ))
              ],
            ),
            SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}
