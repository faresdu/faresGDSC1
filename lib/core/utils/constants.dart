import 'package:flutter/material.dart';
import 'package:gdsc_app/core/utils/light_constants.dart';
import 'package:google_fonts/google_fonts.dart';

@immutable
class Constants {
  const Constants._();

  static Color get grey => const Color(0xFF666C74);
  static const Color greyDivider = Color(0xFFB7B3B3);
  static const Color lightGrey = Color(0xff94979B);
  static const Color darkGrey = Color(0xFF303030);

  static isDarkMode(BuildContext context) {
    return !(Theme.of(context).brightness == Brightness.dark);
  }

  // static const Color negative = Color(0xFFD93F37);
  static Color primary(BuildContext context) => Theme.of(context).primaryColor;

  static Color secondary(BuildContext context) =>
      Theme.of(context).colorScheme.secondary;

  static const Color info = Color(0xFF4285F4);
  static const Color infoLight = Color(0xFFBFDEF5);

  static const Color positive = Color(0xFF34A853);
  static const Color positiveLight = Color(0xFFA4D0A2);

  static const Color warning = Color(0xFFFBBC05);
  static const Color lightWarning = Color(0xFFFFC107);

  static const Color negative = Color(0xFFEA4335);
  static const Color lightNegative = Color(0xFFF4938F);

  // static Color get black => Colors.black;
  //
  // static Color get black2 => Color(0xFF9A9A9A);
  //
  // static Color get black3 => Color(0xFF4D4D4D);

  static Color black(BuildContext context) =>
      isDarkMode(context) ? DarkConstants.black : LightConstants.black;

  static Color black2(BuildContext context) =>
      isDarkMode(context) ? DarkConstants.black2 : LightConstants.black2;

  static Color black3(BuildContext context) =>
      isDarkMode(context) ? DarkConstants.black3 : LightConstants.black3;

  static Color background(BuildContext context) => isDarkMode(context)
      ? DarkConstants.background
      : LightConstants.background;

  static Color grayBackGround(BuildContext context) => isDarkMode(context)
      ? DarkConstants.grayBackGround
      : LightConstants.grayBackGround;

  static Color cardBackground(BuildContext context) => isDarkMode(context)
      ? DarkConstants.cardBackground
      : LightConstants.cardBackground;

  static const Color blue = Color(0xFF547DBF);
  static const Color white = Colors.white;

  static List<BoxShadow> shadow = [
    BoxShadow(color: Colors.black.withOpacity(.3), blurRadius: 8),
  ];
  static List<BoxShadow> cardShadow = [
    BoxShadow(
        color: Colors.black.withOpacity(.25),
        blurRadius: 4,
        offset: const Offset(0, 4)),
  ];
  static List<BoxShadow> inputShadow = [
    BoxShadow(
        color: Colors.black.withOpacity(.12),
        blurRadius: 8,
        offset: const Offset(0, 4))
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
        offset: const Offset(0, 9)),
  ];

  static List<BoxShadow> memberIconShadow = [
    BoxShadow(
        color: Colors.black.withOpacity(.25),
        blurRadius: 6,
        spreadRadius: -16,
        offset: Offset.zero),
  ];

  static List<BoxShadow> shadow7 = [
    BoxShadow(
      color: Colors.black.withOpacity(.25),
      blurRadius: 10,
      offset: const Offset(0, -7),
    ),
    BoxShadow(
      color: Colors.black.withOpacity(.25),
      blurRadius: 10,
      offset: const Offset(0, 5),
    ),
  ];

  static TextStyle superLargeText = GoogleFonts.cairo().copyWith(
    fontSize: 26,
  );

  static TextStyle extraLargeText = GoogleFonts.cairo().copyWith(
    fontSize: 24,
  );

  static TextStyle veryLargeText = GoogleFonts.cairo().copyWith(
    fontSize: 22,
  );

  static TextStyle largeText = GoogleFonts.cairo().copyWith(
    fontSize: 20,
  );
  static TextStyle mediumText = GoogleFonts.cairo().copyWith(
    fontSize: 17,
  );
  static TextStyle smallText = GoogleFonts.cairo().copyWith(
    fontSize: 15,
  );
  static TextStyle verySmallText = GoogleFonts.cairo().copyWith(
    fontSize: 14,
  );
  static TextStyle extraSmallText = GoogleFonts.cairo().copyWith(
    fontSize: 12,
  );
  static TextStyle superSmallText = GoogleFonts.cairo().copyWith(
    fontSize: 10,
  );
}
