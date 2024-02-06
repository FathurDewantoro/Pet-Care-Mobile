import 'dart:convert';
import 'dart:io';

import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pet_care_icp/components/colors.dart';
import 'package:pet_care_icp/components/money_format.dart';
import 'package:pet_care_icp/components/size_helper.dart';
import 'package:pet_care_icp/components/url_api.dart';
import 'package:pet_care_icp/models/perawatan.dart';
import 'package:pet_care_icp/models/single_transaksi_perawatan.dart';
import 'package:pet_care_icp/screens/pemesanan/success_checkout_perawatan.dart';
import 'package:pet_care_icp/screens/snap_web_view_screen.dart';
import 'package:pet_care_icp/services/storage_service.dart';
import 'package:http/http.dart' as http;

class CheckoutPerawatan extends StatefulWidget {
  List<Perawatan> dataPerawatan = [];
  CheckoutPerawatan({super.key, required this.dataPerawatan});

  @override
  State<CheckoutPerawatan> createState() => _CheckoutPerawatanState();
}

class _CheckoutPerawatanState extends State<CheckoutPerawatan> {
  TextEditingController dateInput = TextEditingController();
  TextEditingController txtFilePicker = TextEditingController();
  final SharedStorage _sharedStorage = SharedStorage();

  late File filePickerVal;
  late String tanggalTitip;

  final List<String> items = [
    'Tunai',
    'Transfer',
  ];

  String selectedValue = "Tunai";

  List<ModelSingleTransaksiPerawatan> dataTransaksiPerawatan = [];

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
          'POST', Uri.parse(apiUrl + "/api/transaksiPerawatan/"));

      request.headers.addAll({
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      request.fields['id_perawatan'] = widget.dataPerawatan.first.id.toString();
      request.fields['tanggal_perawatan'] = tanggalTitip.toString();
      request.fields['metode_pembayaran'] = selectedValue;

      request.files.add(http.MultipartFile('foto_hewan',
          filePickerVal.readAsBytes().asStream(), filePickerVal.lengthSync(),
          filename: filePickerVal.path.split("/").last));

      var res = await request.send();
      var responseBytes = await res.stream.toBytes();
      var responseString = utf8.decode(responseBytes);

      if (res.statusCode == 406) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Row(
            children: [
              Text("Gagal ! Transaksi melebihi batas harian perawatan."),
            ],
          ),
          duration: Duration(seconds: 4),
          backgroundColor: Colors.red[400],
          padding: EdgeInsets.only(top: 25, bottom: 25, left: 20),
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ));
        Navigator.pop(context);
      }

      Map<String, dynamic> data = json.decode(responseString);
      dataTransaksiPerawatan.add(ModelSingleTransaksiPerawatan.fromJson(data));

      // debugPrint(data.toString());
      debugPrint(res.statusCode.toString());
      // //debug
      // // debugPrint("response code: " + res.statusCode.toString());
      // // debugPrint("response: " + responseString);

      // final dataDecode = jsonDecode(responseString);
      // debugPrint(dataDecode.toString());

      if (res.statusCode == 200) {
        if (selectedValue == 'Tunai') {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return SuccessCheckoutPerawatan(
                  dataTransaksi: dataTransaksiPerawatan);
            },
          ));
        } else {
          print(dataTransaksiPerawatan.first.snapToken);
          Navigator.of(context).pushNamed(
            SnapWebViewScreen.routeName,
            arguments: {
              'url':
                  apiUrl + '/webview/' + dataTransaksiPerawatan.first.snapToken,
            },
          );
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Detail Pemesanan',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14),
        ),
        backgroundColor: Colors.grey[50],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
        ),
        children: [
          const Text(
            "Jasa Dipilih",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            width: displayWidth(context),
            height: 150,
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
                ]),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 15),
                  width: 125,
                  height: 125,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    image: DecorationImage(
                      image: NetworkImage(apiUrl +
                          '/storage/images/foto_layanan/' +
                          widget.dataPerawatan[0].thumbnail),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  padding: EdgeInsets.only(top: 15),
                  width: displayWidth(context) * 0.45,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.dataPerawatan.first.nama,
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.dataPerawatan.first.deskripsi,
                        style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: unselectedColor),
                        maxLines: 3,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        CurrencyFormat.convertToIdr(
                            widget.dataPerawatan.first.harga, 0),
                        style: const TextStyle(
                          color: primaryColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 35,
          ),
          const Text(
            "Formulir Pemesanan",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Text(
            "Pastikan data pemesanan benar sebelum anda melakukan checkout.",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 13,
            ),
          ),

          //Tanggal Penitipan
          Padding(
            padding: EdgeInsets.only(top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tanggal Perawatan",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 7,
                ),
                TextField(
                  controller: dateInput,
                  readOnly: true,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  autocorrect: false,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 0,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: primaryColor,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: primaryColor,
                      ),
                    ),
                    hintText: "Pilih tanggal perawatan",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                    suffixIcon: Icon(
                      Icons.date_range_outlined,
                      color: primaryColor,
                    ),
                  ),
                  onTap: () async {
                    DateTime? pickDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(
                          2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101),
                    );

                    if (pickDate != null) {
                      print(pickDate);
                      String formattedDate =
                          DateFormat('EEEE, dd MMM yyyy').format(pickDate);
                      print(formattedDate);

                      setState(() {
                        tanggalTitip = DateFormat('yyy-MM-dd').format(pickDate);
                        dateInput.text =
                            formattedDate; //set output date to TextField value.
                      });
                    } else {
                      print("Date is not selected");
                    }
                  },
                ),
              ],
            ),
          ),

          //Foto Hewan
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "Foto Hewan",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 7,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                        readOnly: true,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'File harus diupload';
                          } else {
                            return null;
                          }
                        },
                        controller: txtFilePicker,
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
              // Text(
              //   "Foto akan digunakan sebagai identitas hewan.",
              //   style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
              // ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Metode Pembayaran",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 7,
          ),
          CustomDropdownButton2(
            buttonDecoration: BoxDecoration(
                border: Border.all(
                  color: primaryColor,
                ),
                borderRadius: BorderRadius.circular(10)),
            buttonHeight: 45,
            buttonWidth: displayWidth(context),
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
            height: 35,
          ),
          const Text(
            "Total Pesanan",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: displayWidth(context) * 0.4,
                child: Text(widget.dataPerawatan.first.nama + " x1"),
              ),
              Text(
                CurrencyFormat.convertToIdr(
                    widget.dataPerawatan.first.harga, 0),
                style: const TextStyle(
                  color: primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 35,
          ),
          SizedBox(
            height: 60,
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: () {
            simpan();
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            primary: primaryColor,
            padding: EdgeInsets.all(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Checkout",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              Icon(Icons.arrow_forward)
            ],
          ),
        ),
      ),
    );
  }
}
