import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

@immutable
class Constants {
  const Constants._();

  static const Color grey = Color(0xFF666C74);
  static const Color darkGrey = Color(0xFF303030);
  static const Color red = Color(0xFFD93F37);
  static const Color pink = Color(0xFFF15C55);
  static const Color green = Color(0xFF30AB51);
  static const Color lightGreen = Color(0xFF7CD678);
  static const Color yellow = Color(0xFFF8BC18);
  static const Color lightYellow = Color(0xFFFADC86);
  static const Color lightBlue = Color(0xFF0682BC);
  static const Color blue = Color(0xFF547DBF);
  static const Color darkBlue = Color(0xFF212A40);
  static const Color cyan = Color(0xFF7CB9E5);
  static const Color white = Colors.white;
  static const Color black = Colors.black;

  static const Color navigationBackground = Color(0xFFF5FCFF);

  static List<BoxShadow> shadow = [
    BoxShadow(color: Colors.black.withOpacity(.3), blurRadius: 8),
  ];
  static List<BoxShadow> shadow2 = [
    BoxShadow(
        color: Colors.black.withOpacity(.25),
        blurRadius: 4,
        offset: const Offset(0, 4)),
  ];
  static List<BoxShadow> shadow3 = [
    BoxShadow(
        color: Colors.black.withOpacity(.25),
        blurRadius: 10,
        offset: const Offset(0, 2)),
  ];
  static List<BoxShadow> shadow4 = [
    BoxShadow(
        color: Colors.black.withOpacity(.25),
        blurRadius: 6,
        offset: const Offset(3, 7)),
  ];
  static List<BoxShadow> shadow5 = [
    BoxShadow(
        color: Colors.black.withOpacity(.25),
        blurRadius: 20,
        offset: const Offset(0, 10)),
  ];

  static TextStyle veryLargeText = GoogleFonts.cairo().copyWith(
    fontSize: 24,
  );

  static TextStyle largeText = GoogleFonts.cairo().copyWith(
    fontSize: 22,
  );
  static TextStyle mediumText = GoogleFonts.cairo().copyWith(
    fontSize: 19,
  );
  static TextStyle smallText = GoogleFonts.cairo().copyWith(
    fontSize: 17,
  );
  static TextStyle verySmallText = GoogleFonts.cairo().copyWith(
    fontSize: 15,
  );

}
