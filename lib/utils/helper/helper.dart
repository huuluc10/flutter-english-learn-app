import 'package:flutter/material.dart';
import 'package:flutter_englearn/utils/const/api_url.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

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
  await Permission.camera.request();
  final XFile? image =
      await picker.pickImage(source: ImageSource.camera, imageQuality: 50);

  return image;
}

imgFromGallery(ImagePicker picker) async {
  await Permission.storage.request();
  await Permission.photos.request();

  try {
    final XFile? image =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    if (image != null) {
      return image;
    }
  } catch (e) {
    return null;
  }
}

String transformLocalURLAvatarToURL(String localURL) {
    String authority = APIUrl.baseUrl;
    String linkAvatar =
        Uri.http(authority, APIUrl.pathGetFile, {"path": localURL}).toString();

    return linkAvatar;
  }

  DateTime convertUTCtoLocal(DateTime dateTimeUTC) {
    DateTime dateTime = DateTime.parse(dateTimeUTC.toIso8601String()).toLocal();
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
    return DateTime.parse(formattedDate);
  }
