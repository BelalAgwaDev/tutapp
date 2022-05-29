import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tutapp/presentation/resources/assest_manger.dart';
import 'package:tutapp/presentation/resources/color_manger.dart';
import 'package:tutapp/presentation/resources/constant_time_manger.dart';
import 'package:tutapp/presentation/resources/routes_manger.dart';

class SplachView extends StatefulWidget {
  const SplachView({Key? key}) : super(key: key);

  @override
  State<SplachView> createState() => _SplachViewState();
}

class _SplachViewState extends State<SplachView> {
  Timer? _timer;
  _startDelay() {
    _timer = Timer(const Duration(seconds: AppTime.splachDelay), _goNext);
  }

  _goNext() {
    Navigator.pushReplacementNamed(context, Routes.onBordingRoute);
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: ColorManger.primary,
              statusBarBrightness: Brightness.dark)),
      backgroundColor: ColorManger.primary,
      body: const Center(child: Image(image: AssetImage(AppImage.splach))),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
