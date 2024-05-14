import 'package:flutter/material.dart';

class MyTheme {
  //---------------------------------------------------------------

  static Color primaryColor = const Color(0xff5D9CEC);
  static Color whiteColor = const Color(0xffFFFFFF);
  static Color blackColor = const Color(0xff363636);
  static Color greenColor = const Color(0xff61E757);
  static Color greyColor = const Color(0xffC8C9CB);
  static Color redColor = const Color(0xffEC4B4B);
  static Color backgroundColor = const Color(0xffDFECDB);
  static Color backgroundColorDark = const Color(0xff060E1E);
  static Color blackColorDark = const Color(0xff060E1E);

  //---------------------------------------------------------------------

  static ThemeData lightTheme = ThemeData(
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: whiteColor,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: primaryColor,
      unselectedItemColor: greyColor,
      elevation: 0,
      backgroundColor: Colors.transparent,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      // shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(
      //       50,
      //     ),
      //     side: BorderSide(
      //       color: whiteColor,
      //       width: 4,
      //       ) // Adjust the value to change the roundness
      //     ),
      // ممكن تستختدم StadiumBrder  او RoundedRectangleBorder  عشان تطلع Shape بتاع FAB
      shape: StadiumBorder(
        side: BorderSide(
          color: whiteColor,
          width: 4,
        ),
      ),
    ),
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      elevation: 0,
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        color: whiteColor,
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
      titleMedium: TextStyle(
        color: blackColor,
        fontWeight: FontWeight.w400,
        fontSize: 18,
      ),
    ),
  );

  //=============================================================

  static ThemeData darkTheme = ThemeData(
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: blackColor,
    ),
    primaryColor: blackColorDark,
    scaffoldBackgroundColor: backgroundColorDark,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      shape: StadiumBorder(
        side: BorderSide(
          color: blackColorDark,
          width: 4,
        ),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: blackColor,
      elevation: 0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: primaryColor,
      unselectedItemColor: whiteColor,
      elevation: 0,
      backgroundColor: Colors.transparent,
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        color: blackColorDark,
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
      titleMedium: TextStyle(
        color: whiteColor,
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
    ),
  );
}
