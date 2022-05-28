import 'package:eekie/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(5.0),
  borderSide: const BorderSide(width: 0.3, color: Color(0xff979191)),
);
ThemeData theme = ThemeData(
  //primarySwatch: ,
  //fontFamily: 'Montserrat',
  appBarTheme: const AppBarTheme(
    elevation: 0.0,
    backgroundColor: primaryColor,
    iconTheme: IconThemeData(
      color: iconColor,
    ),
    titleTextStyle: TextStyle(
      color: iconColor,
      overflow: TextOverflow.ellipsis,
      fontSize: 18.0,
      fontWeight: FontWeight.w900,
    ),
    centerTitle: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: primaryColor,

    ),
    backwardsCompatibility: false,
    actionsIconTheme: IconThemeData(
      color: iconColor,
    ),
  ),
  inputDecorationTheme:   InputDecorationTheme(
    hoverColor: primaryColor,
    focusColor: primaryColor,
    hintStyle: const TextStyle(fontSize: 14),
    enabledBorder: outlineInputBorder,
    errorBorder: outlineInputBorder,
    focusedErrorBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    prefixStyle: const TextStyle(
      color: primaryColor,
    ),
  ),
  textTheme: textTheme,
);
TextTheme textTheme = const TextTheme(
  bodyText1: TextStyle(
    color: textButtonColor,
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
  ),
  bodyText2: TextStyle(
    color: textFieldColor,
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
  ),
  subtitle1: TextStyle(
    fontSize: 14.0,
  ),
);
