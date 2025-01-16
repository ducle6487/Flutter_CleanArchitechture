import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_clean_architechture/config/app_resources.dart';
import 'package:flutter_clean_architechture/core/api/service/http_service.dart';
import 'package:flutter_clean_architechture/core/dialog/dialog_service.dart';
import 'package:flutter_clean_architechture/core/localization/enum/text_type.dart';
import 'package:flutter_clean_architechture/core/localization/service/localization_service.dart';
import 'package:image_picker/image_picker.dart';

class PickImageService {
  final picker = ImagePicker();

  Future showOptions(
    BuildContext context,
    WidgetRef ref,
    void Function() onGalleryTap,
    void Function() onCameraTap,
  ) async {
    await showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: Text(
              LocalizationService.translateText(TextType.photoGallery),
            ),
            onPressed: () async {
              // close the options modal
              Navigator.of(context).pop();
              // get image from gallery
              onGalleryTap();
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
              LocalizationService.translateText(TextType.camera),
            ),
            onPressed: () async {
              // close the options modal
              Navigator.of(context).pop();
              // get image from camera
              onCameraTap();
            },
          ),
        ],
      ),
    );
  }

//Image Picker function to get image from gallery
  Future<String?> getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File file = File(pickedFile.path);
      return await uploadImage(file);
    }
    return null;
  }

//Image Picker function to get image from camera
  Future<String?> getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      File file = File(pickedFile.path);
      return await uploadImage(file);
    }
    return null;
  }

  Future<String?> uploadImage(File file) async {
    final HttpService httpService = await HttpService.createInstance();

    String fileName = file.path.split('/').last;
    var multipartFile = await MultipartFile.fromFile(
      file.path,
      filename: fileName,
    );

    FormData formData = FormData.fromMap({
      "files": multipartFile,
      "type": "USER",
    });

    try {
      Response<dynamic> response = await httpService.postRequest(
        url: '${AppResources.storageBaseUrl}/upload',
        data: formData,
      );
      return response.data?["data"]?[0]?["path"];
    } catch (error) {
      // Show error over size image
      DialogService().imageSizeTooBigErrorDialog();
      return null;
    }
  }
}
