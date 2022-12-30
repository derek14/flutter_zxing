part of 'zxing.dart';

/// Reads barcode from String image path
Future<Code?> zxingReadBarcodeImagePathString(
  String path, {
  Params? params,
}) =>
    zxingReadBarcodeImagePath(
      XFile(path),
      params: params,
    );

/// Reads barcode from XFile image path
Future<Code?> zxingReadBarcodeImagePath(
  XFile path, {
  Params? params,
}) async {
  final Uint8List imageBytes = await path.readAsBytes();
  final imglib.Image? image = imglib.decodeImage(imageBytes);
  if (image == null) {
    return null;
  }
  return zxingReadBarcode(
    image.getBytes(format: imglib.Format.luminance),
    width: image.width,
    height: image.height,
    params: params,
  );
}

/// Reads barcode from image url
Future<Code?> zxingReadBarcodeImageUrl(
  String url, {
  Params? params,
}) async {
  final Uint8List imageBytes =
      (await NetworkAssetBundle(Uri.parse(url)).load(url)).buffer.asUint8List();
  final imglib.Image? image = imglib.decodeImage(imageBytes);
  if (image == null) {
    return null;
  }
  return zxingReadBarcode(
    image.getBytes(format: imglib.Format.luminance),
    width: image.width,
    height: image.height,
    params: params,
  );
}

// Reads barcode from Uint8List image bytes
Code zxingReadBarcode(
  Uint8List bytes, {
  required int width,
  required int height,
  Params? params,
}) {
  final Pointer<Int8> blob = malloc.allocate<Int8>(bytes.length);
  final Int8List blobBytes = blob.asTypedList(bytes.length);
  blobBytes.setAll(0, bytes);
  final Code result = bindings
      .readBarcode(
    blob.cast<Char>(),
    params?.format ?? Format.any,
    width,
    height,
    params?.cropWidth ?? 0,
    params?.cropHeight ?? 0,
    params?.tryHarder ?? false ? 1 : 0,
    params?.tryRotate ?? true ? 1 : 0,
  ).toCode();
  malloc.free(blob);
  return result;
}

