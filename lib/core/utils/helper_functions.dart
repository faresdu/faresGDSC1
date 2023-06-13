import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as flutter_svg;
import 'package:path/path.dart';

abstract class HelperFunctions {
  /// Returns SvgPicture or Image based on the passed image url
  static Widget socialMediaImage(
      {required String url,
      double height = 50.0,
      double width = 50.0,
      BoxFit fit = BoxFit.contain}) {
    if (extension(url).contains('svg')) {
      return SvgPicture.network(
        url,
        height: height,
        width: width,
        fit: fit,
      );
    } else {
      return Image.network(
        url,
        height: height,
        width: width,
        fit: fit,
      );
    }
  }

  /// Returns SvgPicture or Image based on the passed image url
  static Widget profileImage(
      {String imageUrl = '',
      double height = 65.0,
      double width = 65.0,
      BoxFit fit = BoxFit.cover}) {
    if (imageUrl.isEmpty) {
      return Image.asset("assets/images/man.png",
          height: height, width: width, fit: fit);
    }
    if (extension(imageUrl).contains('svg')) {
      return SvgPicture.network(imageUrl,
          height: height, width: width, fit: fit);
    } else {
      return Image.network(imageUrl, height: height, width: width, fit: fit);
    }
  }

  static ImageProvider avatarImageProvider(
      {String imageUrl = '',
      double height = 10,
      double width = 10,
      BoxFit fit = BoxFit.cover}) {
    if (imageUrl.isEmpty) {
      return Image.asset('assets/images/avatar.png',
              height: height, width: width, fit: fit)
          .image;
    } else if (extension(imageUrl).contains('svg')) {
      return Image(
              height: height,
              width: width,
              fit: fit,
              image: flutter_svg.Svg(imageUrl,
                  source: flutter_svg.SvgSource.network))
          .image;
    } else {
      return Image.network(imageUrl, height: height, width: width, fit: fit)
          .image;
    }
  }
}
