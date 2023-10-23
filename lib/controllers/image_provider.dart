import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jobhub/constants/app_constants.dart';
import 'package:uuid/uuid.dart';


class ImageUploader extends ChangeNotifier {
  var uuid = Uuid();
  final ImagePicker _picker = ImagePicker();

  List<String> imageUrl = [];

  String? img;

  void pickImage() async {
    // ignore: no_leading_underscores_for_local_identifiers

    XFile? _imageFile = await _picker.pickImage(source: ImageSource.gallery);


    if (_imageFile != null) {
      // Crop the image

      _imageFile = await cropImage(_imageFile);
      if (_imageFile != null) {
        imageUrl.add(_imageFile.path);
        imageUpload(_imageFile);
      } else {
        return;
      }
    }
  }

  Future<XFile?> cropImage(XFile imageFile) async {
    // Crop the image using image_cropper package
    CroppedFile? croppedFile = await ImageCropper.platform.cropImage(
      sourcePath: imageFile.path,
      maxWidth: 1080,
      maxHeight: 1920,
      compressQuality: 80,
      aspectRatioPresets: [CropAspectRatioPreset.ratio4x3],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Jobhub Cropper',
            toolbarColor: Color(kLightBlue.value),
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.ratio4x3,
            lockAspectRatio: true),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );

    if (croppedFile != null) {
      notifyListeners();
      return XFile(croppedFile.path);
    } else {
      return null;
    }
  }

   Future<String?> imageUpload(XFile upload) async {
    File image = File(upload.path);
    final ref = FirebaseStorage.instance.ref().child("jobhub").child('${uuid.v1()}.jpg');
    await ref.putFile(image);
    img = await ref.getDownloadURL();
    print(img);
    return img;
  }
}
