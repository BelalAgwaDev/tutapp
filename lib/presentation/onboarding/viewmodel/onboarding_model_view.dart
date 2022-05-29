import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tutapp/presentation/base/base_view_model.dart';
import 'package:tutapp/presentation/resources/routes_manger.dart';
import '../../../domain/model/onboarding_model.dart';
import '../../resources/assest_manger.dart';
import '../../resources/constant_time_manger.dart';
import '../../resources/strings_manger.dart';

class OnboardingViewModel extends BaseViewModel
    with OnboardingModelViewInput, OnboardingModelViewOutput {
  // stream controller
  final StreamController _streamController =
      StreamController<SliderViewObject>();

  late final List<Sliderobject> _list;
  final PageController _pageController = PageController();
  bool isfirstpage = true;
  bool isLast = false;

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    //view model start your job
    _list = _getSliderData();
    _postDataToView();
  }

  @override
  void goNext(context) {
    if (isLast == true) {
      skip(context);
    } else {
      _pageController.nextPage(
          duration: const Duration(milliseconds: AppTime.pageViewDelay),
          curve: Curves.fastLinearToSlowEaseIn);
    }
  }

  @override
  void goPrevious() {
    if (isfirstpage == true) {
    } else {
      _pageController.previousPage(
          duration: const Duration(milliseconds: AppTime.pageViewDelay),
          curve: Curves.fastLinearToSlowEaseIn);
    }
  }

  @override
  void onPageChanged(index) {
    if (index == _list.length - 4) {
      isfirstpage = true;
      isLast = false;
      _postDataToView();
    } else if (index == _list.length - 1) {
      isLast = true;
      isfirstpage = false;
      _postDataToView();
    } else {
      isLast = false;
      isfirstpage = false;
      _postDataToView();
    }
  }

  @override
  void skip(context) {
    Navigator.pushReplacementNamed(context, Routes.loginRoute);
  }

  //on boarding private function
  void _postDataToView() {
    inputSliderViewObject.add(SliderViewObject(
        list: _list,
        numberOfSlides: _list.length,
        first: isfirstpage,
        pageController: _pageController));
  }

  List<Sliderobject> _getSliderData() => [
        Sliderobject(
            title: AppStringsManger.onboardingTitle1,
            subTitle: AppStringsManger.onboardingSubTitle1,
            image: AppImage.onboardingIcon1),
        Sliderobject(
            title: AppStringsManger.onboardingTitle2,
            subTitle: AppStringsManger.onboardingSubTitle2,
            image: AppImage.onboardingIcon2),
        Sliderobject(
            title: AppStringsManger.onboardingTitle3,
            subTitle: AppStringsManger.onboardingSubTitle3,
            image: AppImage.onboardingIcon3),
        Sliderobject(
            title: AppStringsManger.onboardingTitle4,
            subTitle: AppStringsManger.onboardingSubTitle4,
            image: AppImage.onboardingIcon4)
      ];

  @override
  Sink get inputSliderViewObject => _streamController.sink;

  @override
  Stream<SliderViewObject> get outputSliderViewObject =>
      _streamController.stream.map((sliderViewObject) => sliderViewObject);
}

abstract class OnboardingModelViewInput {
  void goNext(context); //user click  on right arrow or swipe left
  void goPrevious(); //user click  on left arrow or swipe right
  void skip(context); // go to login
  void onPageChanged(int index); // on page change
  //stream controller input
  Sink get inputSliderViewObject;
}

abstract class OnboardingModelViewOutput {
  Stream<SliderViewObject> get outputSliderViewObject;
}
