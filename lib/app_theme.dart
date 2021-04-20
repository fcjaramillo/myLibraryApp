import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'commons/lib_colors.dart';

class AppTheme{

  static final textTheme = TextTheme(
      bodyText1: GoogleFonts.roboto(
          textStyle: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              color: Color(0xff212121)
          )
      )
  );

  static ThemeData build() => ThemeData(
    //appBarTheme: , agregar color
      primaryColor:  LibColors.blue,
      primaryColorDark: LibColors.blueDark,
      accentColor: LibColors.blueAccent,
      backgroundColor: LibColors.white,
      brightness: Brightness.light,

      textTheme: GoogleFonts.robotoTextTheme().copyWith(
          bodyText2: textTheme.bodyText1!.copyWith(
              fontSize: 12
          )
      )
  );
}

extension GFilesAttributes on TextTheme{

  TextStyle get bodyTextSmall => bodyText1!.copyWith(fontSize: 12);
  TextStyle get titleWhite => bodyText1!.copyWith(
      color: LibColors.white,
      fontSize: 45,
      fontWeight: FontWeight.bold
  );
  TextStyle get titleBlack => bodyText1!.copyWith(
      color: LibColors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold
  );
  TextStyle get titleGray  => bodyText1!.copyWith(
      color: LibColors.gray,
      fontSize: 16
  );
  TextStyle get subtitleBlack => bodyText1!.copyWith(
      color: LibColors.black,
      fontSize: 16
  );
  TextStyle get textDetail => bodyText1!.copyWith(
      color: LibColors.black,
      fontSize: 12
  );
  TextStyle get grayDetail => bodyText1!.copyWith(
      color: LibColors.gray,
      fontSize: 12
  );
  TextStyle get blueDetail => bodyText1!.copyWith(
      color: LibColors.blue,
      fontSize: 14
  );
  TextStyle get textButtomWhite => bodyText1!.copyWith(
      color: LibColors.white,
      fontSize: 14,
      fontWeight: FontWeight.w600
  );
  TextStyle get textButtomBlue => bodyText1!.copyWith(
      color: LibColors.blue,
      fontSize: 14,
      fontWeight: FontWeight.w600
  );

}