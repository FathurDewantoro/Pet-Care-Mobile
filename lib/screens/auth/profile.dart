import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pet_care_icp/components/colors.dart';
import 'package:pet_care_icp/components/url_api.dart';
import 'package:pet_care_icp/models/user.dart';
import 'package:pet_care_icp/screens/auth/login.dart';
import 'package:pet_care_icp/screens/profile/pengaturan_profile.dart';
import 'package:pet_care_icp/screens/snap_web_view_screen.dart';
import 'package:pet_care_icp/services/storage_service.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ProfilePage extends StatefulWidget {
  late bool isLogin = this.isLogin;
  ProfilePage({super.key, required this.isLogin});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final SharedStorage _sharedStorage = SharedStorage();

  List<UserModel> dataUser = [];

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    var getToken = await _sharedStorage.isToken();
    var isUser = await _sharedStorage.isUser();
    if (getToken) {
      setState(() {
        widget.isLogin = getToken;
        print("Is user ${isUser}");
      });
    }
  }

  Future logout() async {
    var token = await _sharedStorage.getStringValuesSF();
    try {
      var response =
          await http.get(Uri.parse(apiUrl + '/api/logout'), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token}',
      });

      if (response.statusCode == 200) {
        _sharedStorage.deleteToken();
        widget.isLogin = false;
        setState(() {});
      }
    } catch (e) {
      print(e);
      widget.isLogin = false;
    }
  }

  Future getUserByToken() async {
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
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLogin) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          padding: EdgeInsets.only(left: 20, right: 20, top: 50),
          children: [
            Text(
              'Profil saya',
              style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 18),
            ),
            SizedBox(
              height: 30,
            ),
            FutureBuilder(
                future: getUserByToken(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Column(
                      children: [
                        Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(60),
                          ),
                        ),
                        SizedBox(
                          height: 55,
                          child: LoadingAnimationWidget.waveDots(
                              color: Colors.grey, size: 30),
                        )
                      ],
                    );
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(60),
                            image: DecorationImage(
                                image: NetworkImage(apiUrl +
                                    '/storage/images/foto_profile/' +
                                    dataUser.first.foto),
                                fit: BoxFit.cover),
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          dataUser.first.name,
                          style: TextStyle(
                              color: primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          dataUser.first.email,
                          style: TextStyle(
                            color: unselectedColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    );
                  }
                }),
            SizedBox(
              height: 30,
            ),
            Text(
              'Aktivtas saya',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  Container(
                    width: 35,
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
                    "Transaksi Pemesanan",
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
                    return PengaturanProfileScreen();
                  },
                ));
              },
              child: Row(
                children: [
                  Container(
                    width: 35,
                    child: FaIcon(
                      FontAwesomeIcons.userGear,
                      size: 26,
                      color: unselectedColor,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Pengaturan Profile",
                    style: TextStyle(
                        color: unselectedColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),

            // Bagian 2
            SizedBox(
              height: 50,
            ),
            Text(
              'Pusat Bantuan',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(
                  SnapWebViewScreen.routeName,
                  arguments: {
                    'url': apiUrl +
                        '/webview/dcff21eb-5999-43b1-8749-ad0aaed9c55d',
                  },
                );
              },
              child: Row(
                children: [
                  Container(
                    width: 35,
                    child: FaIcon(
                      FontAwesomeIcons.headset,
                      size: 26,
                      color: unselectedColor,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Cara Pemesanan",
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
              onTap: () {},
              child: Row(
                children: [
                  Container(
                    width: 35,
                    child: FaIcon(
                      FontAwesomeIcons.key,
                      size: 26,
                      color: unselectedColor,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Aturan dan Kondisi",
                    style: TextStyle(
                        color: unselectedColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),

            //Logout
            SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  logout();
                });
              },
              child: Row(
                children: [
                  Container(
                    width: 35,
                    child: FaIcon(
                      FontAwesomeIcons.arrowRightFromBracket,
                      size: 26,
                      color: unselectedColor,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Keluar",
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
    } else {
      return LoginPage();
    }
  }
}
