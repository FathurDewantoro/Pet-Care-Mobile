import 'package:flutter/material.dart';
import 'package:pet_care_icp/components/colors.dart';
import 'package:pet_care_icp/components/size_helper.dart';
import 'package:pet_care_icp/screens/show_searching.dart';

class HomeAppBar extends StatefulWidget {
  HomeAppBar({super.key});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  TextEditingController searchController = TextEditingController();
  String key = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 115,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            Container(
              width: displayWidth(context) * 0.80,
              height: 40,
              margin: EdgeInsets.only(top: 30),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: TextField(
                  controller: searchController,
                  autocorrect: false,
                  decoration: InputDecoration(
                      prefix: const SizedBox(
                        width: 20,
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          key = searchController.text;
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return SearchScreen(kataKunci: key);
                            },
                          ));
                        },
                      ),
                      hintText: 'Search...',
                      border: InputBorder.none),
                ),
              ),
            ),
            Container(
              width: displayWidth(context) * 0.1,
              height: 45,
              margin: EdgeInsets.only(top: 30, left: 5),
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.person_outline_rounded,
                    color: Colors.white,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
