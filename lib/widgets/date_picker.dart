import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pet_care_icp/components/colors.dart';

class InputTanggalPenitipan extends StatefulWidget {
  InputTanggalPenitipan({
    Key? key,
  }) : super(key: key);

  @override
  State<InputTanggalPenitipan> createState() => _InputTanggalPenitipanState();
}

class _InputTanggalPenitipanState extends State<InputTanggalPenitipan> {
  TextEditingController dateInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tanggal Penitipan",
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
              hintText: "Pilih tanggal penitipan",
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
    );
  }
}
