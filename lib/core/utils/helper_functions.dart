import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path/path.dart';
import 'package:url_launcher/url_launcher.dart';

import 'constants.dart';

abstract class HelperFunctions {
  static Widget defaultImage({
    String url = '',
    String defaultUrl = '',
    bool isAsset = false,
    double? height,
    double? width,
    BoxFit fit = BoxFit.contain,
  }) {
    if (url.isEmpty && defaultUrl.isEmpty) {
      return Image.asset('assets/images/empty.png');
    }
    if (url.isEmpty) {
      return getImage(
        url: defaultUrl,
        height: height,
        width: width,
        fit: fit,
        isAsset: true,
      );
    }
    return getImage(
      url: url,
      height: height,
      width: width,
      fit: fit,
      isAsset: isAsset,
    );
  }

  static Widget getImage({
    required String url,
    bool isAsset = true,
    double? height,
    double? width,
    BoxFit fit = BoxFit.contain,
  }) {
    if (isAsset) {
      if (extension(url).contains('svg')) {
        return SvgPicture.asset(
          url,
          height: height,
          width: width,
          fit: fit,
        );
      }
      return Image.asset(
        url,
        height: height,
        width: width,
        fit: fit,
      );
    }
    if (extension(url).contains('svg')) {
      return SvgPicture.network(
        url,
        height: height,
        width: width,
        fit: fit,
      );
    }
    return CachedNetworkImage(
      imageUrl: url,
      height: height,
      width: width,
      fit: fit,
    );
  }

  /// Returns SvgPicture or Image based on the passed image url
  static Widget socialMediaImage({
    required String url,
    double? height,
    double? width,
    BoxFit fit = BoxFit.contain,
  }) {
    return defaultImage(
      url: url,
      height: height,
      width: width,
      fit: fit,
      defaultUrl: "assets/images/man2.png",
      isAsset: false,
    );
  }

  /// Returns SvgPicture or Image based on the passed image url
  static Widget profileImage({
    String imageUrl = '',
    String gender = "",
    double? height,
    double? width,
    BoxFit fit = BoxFit.cover,
  }) {
    return defaultImage(
      url: imageUrl,
      height: height,
      width: width,
      fit: fit,
      defaultUrl: gender == "female"
          ? "assets/images/woman.png"
          : "assets/images/man2.png",
      isAsset: false,
    );
  }

  static Widget notificationImage({
    String imageUrl = '',
    double? height,
    double? width,
    BoxFit fit = BoxFit.cover,
  }) {
    return defaultImage(
      url: imageUrl,
      height: height,
      width: width,
      fit: fit,
      defaultUrl: "assets/images/home/achievement.png",
      isAsset: false,
    );
  }

  /// Returns an event Image based on the passed image url
  static Widget eventImage({
    String? imageUrl,
    double? height,
    double? width,
    BoxFit fit = BoxFit.cover,
  }) {
    return defaultImage(
      url: imageUrl ?? '',
      height: height,
      width: width,
      fit: fit,
      defaultUrl: 'assets/images/events/temp-events-img.png',
      isAsset: false,
    );
  }

  static ImageProvider avatarImageProvider({
    String imageUrl = '',
    double height = 30,
    double width = 30,
    BoxFit fit = BoxFit.cover,
    String gender = "",
  }) {
    Widget p = profileImage(
      imageUrl: imageUrl,
      height: height,
      gender: gender,
      width: width,
      fit: fit,
    );
    if (p is Image) {
      return p.image;
    }
    if (p is CachedNetworkImage) {
      return CachedNetworkImageProvider(p.imageUrl);
    }
    return p as ImageProvider;
  }

  static getFileSize(String filepath, int decimals,
      {bool noSuffix = false}) async {
    var file = File(filepath);
    int bytes = await file.length();
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return noSuffix
        ? (bytes / pow(1024, i)).toStringAsFixed(decimals)
        : '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }

  static openUrl(String url) async {
    if (!url.startsWith(RegExp(r'(http|https)://'))) {
      url = 'https://$url';
    }
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      // can't launch url
    }
  }

  static Future<bool?> warningDialog(BuildContext context,
      {required String title,
      required String content,
      String confirmButtonText = 'حذف'}) async {
    final titleWidget = Text(
      title,
      style: Constants.mediumText.copyWith(fontWeight: FontWeight.bold),
    );
    final contentWidget = Text(
      content,
      style: Constants.smallText,
    );
    final actions = [
      TextButton(
        child: Text('الغاء', style: Constants.smallText),
        onPressed: () {
          Navigator.of(context).pop(false);
        },
      ),
      TextButton(
        child: Text(
          confirmButtonText,
          style: Constants.smallText.copyWith(color: Constants.negative),
        ),
        onPressed: () {
          Navigator.of(context).pop(true);
        },
      ),
    ];
    return await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          if (Platform.isIOS) {
            return CupertinoAlertDialog(
              title: titleWidget,
              content: contentWidget,
              actions: actions,
            );
          }
          return AlertDialog(
            title: titleWidget,
            content: contentWidget,
            actions: actions,
          );
        });
  }

  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }
}
