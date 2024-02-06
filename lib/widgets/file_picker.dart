import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pet_care_icp/components/colors.dart';
import 'package:pet_care_icp/components/size_helper.dart';
import 'package:file_picker/file_picker.dart';

class ImportFoto extends StatefulWidget {
  const ImportFoto({super.key});

  @override
  State<ImportFoto> createState() => _ImportFotoState();
}

class _ImportFotoState extends State<ImportFoto> {
  TextEditingController txtFilePicker = TextEditingController();

  selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['jpg', 'jpeg', 'png']);
    if (result != null) {
      setState(() {
        txtFilePicker.text = result.files.single.name;
        var filePickerVal = File(result.files.single.path.toString());
      });
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                      borderSide: BorderSide(color: Colors.white, width: 2),
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
              label: const Text('Pilih File', style: TextStyle(fontSize: 14.0)),
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
    );
  }
}
