import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Utils {
  static Future<Uint8List> capture(GlobalKey key) async {
    RenderRepaintBoundary boundary =
        key.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image? image = await boundary.toImage(pixelRatio: 3.0);

    if (image == null) {
      throw Exception('Failed to capture image');
    }

    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData == null) {
      throw Exception('Failed to convert image to byte data');
    }

    return byteData.buffer.asUint8List();
  }
}
