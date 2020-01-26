import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:async';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:image/image.dart' as imglib;
import 'package:image_gallery_saver/image_gallery_saver.dart';

/*
imglib.Image button = imglib.copyResizeCropSquare(croppedImage, 40);
Uint8List buttonPng = imglib.encodePng(button);
ui.Codec codec = await ui.instantiateImageCodec(buttonPng);
ui.FrameInfo fi = await codec.getNextFrame();
_buttonImage = fi.image;
await ImageGallerySaver.saveImage(_snapShot);

*/

class ImageProviderViewModel extends ChangeNotifier {
  Uint8List _pickedImage;
  ImageProviderViewModel() {
    PermissionHandler().requestPermissions(<PermissionGroup>[
      PermissionGroup.camera,
      PermissionGroup.storage, // 在这里添加需要的权限
    ]);
  }

  Uint8List get pickedImage => _pickedImage;
  set pickedImage(Uint8List image) {
    _pickedImage = image;
    notifyListeners();
  }

  Future pickCameraImage() async {
    ImagePicker.pickImage(source: ImageSource.camera)
        .then((File recordedImage) {
      if (recordedImage != null && recordedImage.path != null) {
        /*pickedImage =
            img.decodeImage(recordedImage.readAsBytesSync()).getBytes();*/
        pickedImage = recordedImage.readAsBytesSync();
      }
    });
  }

  Future pickGalleryImage() async {
    ImagePicker.pickImage(source: ImageSource.gallery)
        .then((File recordedImage) {
      if (recordedImage != null && recordedImage.path != null) {
        pickedImage = recordedImage.readAsBytesSync();
      }
    });
  }

  Future saveImage() async {
    if (pickedImage.isNotEmpty) {
      final result = await ImageGallerySaver.saveImage(pickedImage);
      print(result);
    }
  }
}
