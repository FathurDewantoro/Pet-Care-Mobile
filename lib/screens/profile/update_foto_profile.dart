import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pet_care_icp/components/colors.dart';
import 'package:pet_care_icp/components/url_api.dart';
import 'package:pet_care_icp/models/user.dart';
import 'package:pet_care_icp/services/storage_service.dart';
import 'package:http/http.dart' as http;

class PerbaruiFotoProfileScreen extends StatefulWidget {
  const PerbaruiFotoProfileScreen({super.key});

  @override
  State<PerbaruiFotoProfileScreen> createState() =>
      _PerbaruiFotoProfileScreenState();
}

class _PerbaruiFotoProfileScreenState extends State<PerbaruiFotoProfileScreen> {
  TextEditingController txtFilePicker = TextEditingController();
  final SharedStorage _sharedStorage = SharedStorage();

  late File filePickerVal;

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
    } catch (e) {
      print(e);
    }
  }

  selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['jpg', 'jpeg', 'png']);
    if (result != null) {
      setState(() {
        txtFilePicker.text = result.files.single.name;
        filePickerVal = File(result.files.single.path.toString());
        print(filePickerVal);
      });
    } else {
      // User canceled the picker
    }
  }

  simpan() async {
    var token = await _sharedStorage.getStringValuesSF();
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse(apiUrl + "/api/updateFotoProfile"));

      request.headers.addAll({
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      request.files.add(http.MultipartFile('foto',
          filePickerVal.readAsBytes().asStream(), filePickerVal.lengthSync(),
          filename: filePickerVal.path.split("/").last));

      var res = await request.send();
      var responseBytes = await res.stream.toBytes();
      var responseString = utf8.decode(responseBytes);


      if (res.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Row(
            children: [
              Text("Foto berhasil diperbarui."),
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
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Periksa formulir anda, terdapat kesalahan !"),
          duration: Duration(seconds: 2),
          backgroundColor: primaryColor,
          padding: EdgeInsets.only(top: 25, bottom: 25, left: 20),
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ));
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
          'Perbarui Foto Profile',
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
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        children: [
          SizedBox(
            height: 7,
          ),
          Center(
            child: Column(
              children: [
                FutureBuilder(
                    future: getDataUser(),
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: SizedBox(
                            height: 55,
                            child: LoadingAnimationWidget.waveDots(
                                color: Colors.grey, size: 30),
                          ),
                        );
                      } else {
                        return Container(
                          width: 170,
                          height: 170,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(90),
                            image: DecorationImage(
                                image: NetworkImage(apiUrl +
                                    '/storage/images/foto_profile/' +
                                    dataUser.first.foto),
                                fit: BoxFit.cover),
                          ),
                        );
                      }
                    }),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Foto Profile",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: primaryColor),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "Foto Profile Baru",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 7,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                        controller: txtFilePicker,
                        readOnly: true,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'File harus diupload';
                          } else {
                            return null;
                          }
                        },
                        // controller: txtFilePicker,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: primaryColor,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.0),
                            ),
                            borderSide:
                                BorderSide(color: Colors.white, width: 2),
                          ),
                          hintText: 'Upload File',
                          contentPadding: EdgeInsets.all(10.0),
                        ),
                        style: const TextStyle(fontSize: 16.0)),
                  ),
                  const SizedBox(width: 5),
                  ElevatedButton.icon(
                    icon: const Icon(
                      Icons.upload_file,
                      color: Colors.white,
                      size: 24.0,
                    ),
                    label: const Text('Pilih File',
                        style: TextStyle(fontSize: 14.0)),
                    onPressed: () {
                      selectFile();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: primaryColor,
                      minimumSize: const Size(122, 48),
                      maximumSize: const Size(122, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                simpan();
              });
            },
            child: Text(
              "Simpan Perubahan",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            ),
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                primary: primaryColor,
                padding: EdgeInsets.all(15)),
          ),
        ],
      ),
    );
  }
}
