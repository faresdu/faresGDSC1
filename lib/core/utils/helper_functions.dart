import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gdsc_app/core/utils/string_extensions.dart';

abstract class HelperFunctions {
  /// Returns SvgPicture or Image based on the passed image url
  static Widget socialMediaImage(
      {required String url,
      double height = 50.0,
      double width = 50.0,
      BoxFit fit = BoxFit.contain}) {
    if (url.lastChars(3) == 'svg') {
      return SvgPicture.network(url, height: height, width: width);
    } else {
      return Image.network(url, height: height, width: width);
    }
  }

  /// Returns SvgPicture or Image based on the passed image url
  static Widget profileImage(
      {required String imageUrl,
      double height = 65.0,
      double width = 65.0,
      BoxFit fit = BoxFit.cover}) {
    if (imageUrl.lastChars(3) == 'svg') {
      return SvgPicture.network(imageUrl,
          height: height, width: width, fit: BoxFit.cover);
    } else {
      return Image.network(imageUrl,
          height: height, width: width, fit: BoxFit.cover);
    }
  }
}
