import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pet_care_icp/components/colors.dart';
import 'package:pet_care_icp/components/url_api.dart';
import 'package:pet_care_icp/models/login_response.dart';
import 'package:pet_care_icp/models/storage.dart';
import 'package:pet_care_icp/screens/auth/profile.dart';
import 'package:pet_care_icp/screens/auth/register.dart';
import 'package:pet_care_icp/services/storage_service.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool hiddenPassword = true;
  final SharedStorage _sharedStorage = SharedStorage();
  List<LoginResponseModel> loginResponse = [];
  bool isLogin = false;

  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();

  Future login() async {
    var response = await http.post(Uri.parse(apiUrl + '/api/login'), body: {
      "email": emailC.text,
      "password": passC.text,
    }, headers: <String, String>{
      'Accept': 'application/json',
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> data =
          Map<String, dynamic>.from(json.decode(response.body));
      loginResponse.add(LoginResponseModel.fromJson(data));
      _sharedStorage
          .addTokenKey(StorageItem('token', loginResponse.first.token));
      setState(() {
        isLogin = true;
      });

      _sharedStorage.addUserId('idUser', loginResponse.first.user.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    print(isLogin);
    if (isLogin == false) {
      return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Log in",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 250,
                      child: Text(
                        "Enter your credentials to access your account.",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color: unselectedColor),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Email address",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: emailC,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w400),
                      autocorrect: false,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 0),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: unselectedColor)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: primaryColor)),
                        hintText: "name@mail.com",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Password",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: passC,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w400),
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
                              borderSide:
                                  const BorderSide(color: primaryColor)),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Forgot password ?",
                              style:
                                  TextStyle(fontSize: 12, color: primaryColor),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                login();
                              });
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 14),
                            ),
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                primary: primaryColor,
                                padding: EdgeInsets.all(15)),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have account? ",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 13),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return PageDaftarAkun();
                                },
                              ));
                            },
                            child: const Text(
                              "Register",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600),
                            ))
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    } else {
      return ProfilePage(
        isLogin: isLogin,
      );
    }
  }
}
