import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:pet_care_icp/screens/auth/login.dart';
import 'package:pet_care_icp/screens/page_home.dart';
import 'package:pet_care_icp/components/colors.dart';
import 'package:pet_care_icp/screens/auth/profile.dart';
import 'package:pet_care_icp/screens/show_all_transaction.dart';
import 'package:pet_care_icp/screens/list_transaksi/list_transaksi.dart';
import 'package:pet_care_icp/services/storage_service.dart';

class BaseScreen extends StatefulWidget {
  BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  late bool isLogin = false;
  final SharedStorage _sharedStorage = SharedStorage();

  @override
  void initState() {
    super.initState();
  }

  //index bottom navigation
  int _currentIndex = 0;

  late List<Widget> _widgetScreen = <Widget>[
    PageHome(),
    ListTransaksi(
      isLogin: isLogin,
    ),
    ProfilePage(isLogin: isLogin),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _widgetScreen[_currentIndex]),
      bottomNavigationBar: CustomNavigationBar(
        iconSize: 30.0,
        selectedColor: primaryColor,
        strokeColor: primaryColor,
        unSelectedColor: unselectedColor,
        backgroundColor: Colors.white,
        items: [
          CustomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            title: Text(
              "Home",
              style: TextStyle(
                  color: _currentIndex == 0 ? primaryColor : unselectedColor,
                  fontSize: 12,
                  height: 1.5,
                  fontWeight: FontWeight.w500),
            ),
          ),
          CustomNavigationBarItem(
            icon: const Icon(Icons.data_thresholding_outlined),
            title: Text(
              "Transaksi",
              style: TextStyle(
                  color: _currentIndex == 1 ? primaryColor : unselectedColor,
                  fontSize: 12,
                  height: 1.5,
                  fontWeight: FontWeight.w500),
            ),
          ),
          CustomNavigationBarItem(
            icon: const Icon(Icons.person_outline_rounded),
            title: Text(
              "Profile",
              style: TextStyle(
                  color: _currentIndex == 2 ? primaryColor : unselectedColor,
                  fontSize: 12,
                  height: 1.5,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
