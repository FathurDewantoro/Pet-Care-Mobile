import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pet_care_icp/components/card_penitipan_favourite.dart';
import 'package:pet_care_icp/components/colors.dart';
import 'package:pet_care_icp/components/url_api.dart';
import 'package:pet_care_icp/models/category.dart';
import 'package:pet_care_icp/models/iklan.dart';
import 'package:http/http.dart' as http;
import 'package:pet_care_icp/widgets/category_card.dart';
import 'package:pet_care_icp/widgets/home_app_bar.dart';

class PageHome extends StatefulWidget {
  const PageHome({super.key});

  @override
  State<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            HomeAppBar(),
            Expanded(child: HomeContent()),
          ],
        ),
      ),
    );
  }
}

class HomeContent extends StatefulWidget {
  HomeContent({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  List<ModelIklan> dataIklan = [];

  Future getIklan() async {
    try {
      var response = await http.get(Uri.parse(apiUrl + '/api/iklan/'));
      List data = json.decode(response.body);
      data.forEach((element) {
        dataIklan.add(ModelIklan.fromJson(element));
      });

      print(dataIklan.first.foto);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.only(top: 0),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: [
        FutureBuilder(
          future: getIklan(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                height: 140,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              );
            } else {
              return CarouselSlider.builder(
                  itemCount: dataIklan.length,
                  itemBuilder: (context, index, realIndex) {
                    return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(apiUrl +
                              '/storage/images/foto_iklan/' +
                              dataIklan[index].foto),
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    height: 150,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 5),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.4,
                    scrollDirection: Axis.horizontal,
                  ));
            }
          },
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            "Kategori",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Row(
          children: [
            CardCategories(category: categoryList[0]),
            CardCategories(category: categoryList[1]),
          ],
        ),
        CardPenitipanFavourite(),
      ],
    );
  }
}
