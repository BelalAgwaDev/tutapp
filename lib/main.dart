import 'package:flutter/material.dart';
import 'package:tutapp/application/di.dart';

import 'application/app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  runApp( MyApp());
}



