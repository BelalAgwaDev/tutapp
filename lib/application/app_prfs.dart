import 'package:shared_preferences/shared_preferences.dart';

import '../data/network/languageManger.dart';


const String prefLang="prefLang";
class AppPreferences{
 final SharedPreferences _sharedPreferences;
 AppPreferences(this._sharedPreferences);



 Future<String>getAppLanguage()async{
   String? language =_sharedPreferences.getString(prefLang);
   if (language!=null &&language.isNotEmpty){
     return language;
   }else{
     return LanguageType.english.getValue();
   }
 }
}