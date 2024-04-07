import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

bool isHTML(String str) {
  final RegExp htmlRegExp =
      RegExp('<[^>]*>', multiLine: true, caseSensitive: false);
  return htmlRegExp.hasMatch(str);
}

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

imgFromCamera(ImagePicker picker) async {
  final XFile? image =
      await picker.pickImage(source: ImageSource.camera, imageQuality: 50);

  if (image != null) {
    return cropImage(File(image.path));
  }
}

imgFromGallery(ImagePicker picker) async {
  final XFile? image =
      await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

  if (image != null) {
    return cropImage(File(image.path));
  }
}



cropImage(File image) async {
  final croppedFile = await ImageCropper().cropImage(
    sourcePath: image.path,
    aspectRatioPresets: Platform.isAndroid
        ? [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ]
        : [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio5x3,
            CropAspectRatioPreset.ratio5x4,
            CropAspectRatioPreset.ratio7x5,
            CropAspectRatioPreset.ratio16x9
          ],
    uiSettings: [
      AndroidUiSettings(
        toolbarTitle: 'Cắt ảnh',
        toolbarColor: Colors.deepOrange,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
      ),
      IOSUiSettings(
        title: 'Cắt ảnh',
        minimumAspectRatio: 1.0,
      )
    ],
    compressQuality: 100,
    compressFormat: ImageCompressFormat.png,
  );

  if (croppedFile != null) {
    imageCache.clear();

    return File(croppedFile.path);
  }
}
