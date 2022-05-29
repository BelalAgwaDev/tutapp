import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tutapp/presentation/resources/color_manger.dart';
import 'package:tutapp/presentation/resources/fonts_manger.dart';
import 'package:tutapp/presentation/resources/styles_manger.dart';
import 'package:tutapp/presentation/resources/values_manger.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    //main color
    primaryColor: ColorManger.primary,
    primaryColorLight: ColorManger.lightGrey,
    primaryColorDark: ColorManger.darkGrey,
    disabledColor: ColorManger.grey1,
    scaffoldBackgroundColor: ColorManger.white,

    //card view
    cardTheme: CardTheme(
        color: ColorManger.white,
        shadowColor: ColorManger.grey,
        elevation: AppSizeMange.s4),

    //app bar theme
    appBarTheme: AppBarTheme(
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: ColorManger.primary,
            statusBarBrightness: Brightness.light),
        color: ColorManger.primary,
        elevation: AppSizeMange.s4,
        shadowColor: ColorManger.lightPrimary,
        titleTextStyle: getRegularStyle(
            fontSize: FontSizeManger.s16, color: ColorManger.white)),

    //button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularStyle(
            fontSize: FontSizeManger.s16, color: ColorManger.white),
        primary: ColorManger.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizeMange.s12),
        ),
      ),
    ),

//text theme
    textTheme: TextTheme(
        displayLarge: getSemiBoldStyle(
            fontSize: FontSizeManger.s16, color: ColorManger.darkGrey),
        headlineMedium: getMediumStyle(
            fontSize: FontSizeManger.s14, color: ColorManger.darkGrey),
        titleMedium: getMediumStyle(
            fontSize: FontSizeManger.s16, color: ColorManger.primary)),

//input decoration theme Text form field

    inputDecorationTheme: InputDecorationTheme(
        //Content padding
        contentPadding: const EdgeInsets.all(AppPaddingSizeMange.p16),

        //hint style
        hintStyle: getRegularStyle(
            fontSize: FontSizeManger.s14, color: ColorManger.grey),

        //label style
        labelStyle: getMediumStyle(
            fontSize: FontSizeManger.s14, color: ColorManger.grey),

        //error style
        errorStyle: getRegularStyle(
            fontSize: FontSizeManger.s12, color: ColorManger.error),

        //enabled border style
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: ColorManger.grey,),
          borderRadius:
              const BorderRadius.all(Radius.circular(AppSizeMange.s8)),
        ),

        //focuse border style
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: ColorManger.primary, ),
          borderRadius:
              const BorderRadius.all(Radius.circular(AppSizeMange.s8)),
        ),

        //error border style
        errorBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: ColorManger.error, ),
          borderRadius:
              const BorderRadius.all(Radius.circular(AppSizeMange.s8)),
        ),

        //focused error border style
        focusedErrorBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: ColorManger.primary, ),
          borderRadius:
              const BorderRadius.all(Radius.circular(AppSizeMange.s8)),
        )),
  );
}
