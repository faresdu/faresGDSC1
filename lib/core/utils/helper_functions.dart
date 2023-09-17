import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path/path.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class HelperFunctions {
  /// Returns SvgPicture or Image based on the passed image url
  static Widget socialMediaImage(
      {required String url,
      double? height,
      double? width,
      BoxFit fit = BoxFit.contain}) {
    if (extension(url).contains('svg')) {
      return SvgPicture.network(
        url,
        height: height,
        width: width,
        fit: fit,
      );
    } else {
      return CachedNetworkImage(
        imageUrl: url,
        height: height,
        width: width,
        fit: fit,
      );
    }
  }

  /// Returns SvgPicture or Image based on the passed image url
  static Widget profileImage(
      {String imageUrl = '',
      double? height,
      double? width,
      BoxFit fit = BoxFit.cover}) {
    if (imageUrl.isEmpty) {
      return Image.asset("assets/images/man.png",
          height: height, width: width, fit: fit);
    }
    if (extension(imageUrl).contains('svg')) {
      return SvgPicture.network(imageUrl,
          height: height, width: width, fit: fit);
    } else {
      return CachedNetworkImage(imageUrl: imageUrl, height: height, width: width, fit: fit);
    }
  }

  /// Returns an event Image based on the passed image url
  static Widget eventImage(
      {String? imageUrl,
      double? height,
      double? width,
      BoxFit fit = BoxFit.cover}) {
    if (imageUrl == null) {
      return Image.asset('assets/images/events/temp-events-img.png',
          height: height, width: width, fit: fit);
    }
    return CachedNetworkImage(imageUrl: imageUrl, height: height, width: width, fit: fit);
  }

  static ImageProvider avatarImageProvider(
      {String imageUrl = '',
      double height = 30,
      double width = 30,
      BoxFit fit = BoxFit.cover}) {
    Widget p = profileImage(
        imageUrl: imageUrl, height: height, width: width, fit: fit);
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
    if (!url.startsWith('https://')) {
      url = 'https://$url';
    }
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      // can't launch url
    }
  }
}
