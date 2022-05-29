import 'package:flutter/material.dart';
import 'package:tutapp/presentation/resources/routes_manger.dart';
import 'package:tutapp/presentation/resources/theme_manger.dart';

class MyApp extends StatelessWidget {
  const MyApp._internal();
  static const MyApp _instance = MyApp._internal();
  factory MyApp() => _instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Routes.splachRoute,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      theme: getApplicationTheme(),
    );
  }
}
