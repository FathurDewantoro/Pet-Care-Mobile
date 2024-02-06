import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pet_care_icp/screens/base_screen.dart';
import 'package:pet_care_icp/screens/snap_web_view_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('id_ID,', null);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BaseScreen(),
      theme: ThemeData(fontFamily: 'Montserrat'),
      routes: {
        SnapWebViewScreen.routeName: (ctx) =>  SnapWebViewScreen(),
      },
    );
  }
}
