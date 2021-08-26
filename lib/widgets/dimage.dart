
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:js_script/js_script.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../dwidget.dart';

class DImage extends StatelessWidget {

  final String src;
  final double? width;
  final double? height;

  DImage({
    Key? key,
    required this.src,
    this.width,
    this.height,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    var uri = Uri.parse(src);
    if (uri.hasScheme) {
      return CachedNetworkImage(
        imageUrl: src,
        width: width,
        height: height,
      );
    } else {
      var data = DWidget.of(context);
      return Image.file(File(data!.relativePath(src)),
        width: width,
        height: height,
      );
    }
  }
}