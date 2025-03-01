import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'src/models/models.dart';

import 'zxing_cross.dart'
    if (dart.library.io) 'zxing_mobile.dart'
    if (dart.library.html) 'zxing_web.dart';

export 'src/models/models.dart';
export 'src/ui/ui.dart';

final Zxing zx = Zxing();

abstract class Zxing {
  /// factory constructor to return the correct implementation.
  factory Zxing() => getZxing();

  String version() => '';
  void setLogEnabled(bool enabled) {}
  String barcodeFormatName(int format) => '';

  Encode encodeBarcode(
    String contents, {
    int format = Format.qrCode,
    int width = 300,
    int height = 300,
    int margin = 0,
    int eccLevel = 0,
  });

  /// Starts reading barcode from the camera
  Future<void> startCameraProcessing();

  /// Stops reading barcode from the camera
  void stopCameraProcessing();

  /// Reads barcode from the camera
  Future<Code> processCameraImage(
    CameraImage image, {
    Params? params,
  });

  /// Reads barcode from String image path
  Future<Code?> readBarcodeImagePathString(
    String path, {
    Params? params,
  });

  /// Reads barcode from XFile image path
  Future<Code?> readBarcodeImagePath(
    XFile path, {
    Params? params,
  });

  /// Reads barcode from image url
  Future<Code?> readBarcodeImageUrl(
    String url, {
    Params? params,
  });

// Reads barcode from Uint8List image bytes
  Code readBarcode(
    Uint8List bytes, {
    required int width,
    required int height,
    Params? params,
  });

  /// Reads barcodes from String image path
  Future<List<Code>> readBarcodesImagePathString(
    String path, {
    Params? params,
  });

  /// Reads barcodes from XFile image path
  Future<List<Code>> readBarcodesImagePath(
    XFile path, {
    Params? params,
  });

  /// Reads barcodes from image url
  Future<List<Code>> readBarcodesImageUrl(
    String url, {
    Params? params,
  });

  /// Reads barcodes from Uint8List image bytes
  List<Code> readBarcodes(
    Uint8List bytes, {
    required int width,
    required int height,
    Params? params,
  });
}
