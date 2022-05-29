import 'package:flutter/material.dart';

class Sliderobject {
  String title;
  String subTitle;
  String image;
  Sliderobject(
      {required this.title, required this.image, required this.subTitle});
}

//on boarding data varaiables
class SliderViewObject {
  int numberOfSlides;
  bool first;
  List<Sliderobject> list;
  PageController pageController;
  SliderViewObject(
      {required this.numberOfSlides,
      required this.list,
      required this.first,
      required this.pageController});
}

